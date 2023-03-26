package icube.manage.gds.gds;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringJoiner;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.util.HtmlUtils;

import icube.common.file.biz.FileService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.ArrayUtil;
import icube.common.util.CommonUtil;
import icube.common.util.MapUtil;
import icube.common.util.WebUtil;
import icube.common.util.egov.EgovDoubleSubmitHelper;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.common.vo.DataTablesVO;
import icube.manage.gds.ctgry.biz.GdsCtgryService;
import icube.manage.gds.ctgry.biz.GdsCtgryVO;
import icube.manage.gds.gds.biz.GdsService;
import icube.manage.gds.gds.biz.GdsVO;
import icube.manage.gds.optn.biz.GdsOptnService;
import icube.manage.gds.optn.biz.GdsOptnVO;
import icube.manage.members.bplc.biz.BplcService;
import icube.manage.sysmng.brand.biz.BrandService;
import icube.manage.sysmng.brand.biz.BrandVO;
import icube.manage.sysmng.mkr.biz.MkrService;
import icube.manage.sysmng.mkr.biz.MkrVO;
import icube.manage.sysmng.mngr.biz.MngrSession;
import icube.manage.sysmng.mngr.biz.MngrVO;
import icube.members.bplc.mng.biz.BplcGdsService;

/**
 * 관리자 > 상품관리 > 상품관리
 */
@Controller
@RequestMapping(value="/_mng/gds/gds")
public class MGdsController extends CommonAbstractController {

	@Resource(name = "gdsService")
	private GdsService gdsService;

	@Resource(name = "gdsCtgryService")
	private GdsCtgryService gdsCtgryService;

	@Resource(name = "gdsOptnService")
	private GdsOptnService gdsOptnService;

	@Resource(name = "mkrService")
	private MkrService mkrService;

	@Resource(name = "brandService")
	private BrandService brandService;

	@Resource(name = "fileService")
	private FileService fileService;

	@Resource(name = "bplcGdsService")
	private BplcGdsService bplcGdsService;

	@Resource(name = "bplcService")
	private BplcService bplcService;

	@Autowired
	private MngrSession mngrSession;

	// Page Parameter Keys
	private static String[] targetParams = {"curPage", "cntPerPage", "srchTarget", "srchText", "sortBy"
			, "srchUpCtgryNo", "srchCtgryNo", "srchGdsCd", "srchBnefCd", "srchGdsNm", "srchGdsTy", "srchGdsTag"};

	@RequestMapping(value="list")
	public String list(
			@RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		String srchUseYn = EgovStringUtil.null2string((String) reqMap.get("srchUseYn"), "Y");
		listVO.setParam("srchUseYn", srchUseYn);
		listVO = gdsService.gdsListVO(listVO);


		//카테고리 호출
		List<GdsCtgryVO> gdsCtgryList = gdsCtgryService.selectGdsCtgryList(1);
		model.addAttribute("gdsCtgryList", gdsCtgryList);

		model.addAttribute("dspyYnCode", CodeMap.DSPY_YN);
		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("gdsTagCode", CodeMap.GDS_TAG);

		model.addAttribute("listVO", listVO);

		return "/manage/gds/gds/list";
	}


	@RequestMapping(value="form")
	public String form(
			GdsVO gdsVO
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception{

		int gdsNo = EgovStringUtil.string2integer((String) reqMap.get("gdsNo"));

		if(gdsNo == 0){
			gdsVO.setCrud(CRUD.CREATE);
		}else{
			gdsVO = gdsService.selectGds(gdsNo);

			// 상품옵션 set
			List<String> optnVal1 = new ArrayList<String>()
					, optnVal2 = new ArrayList<String>()
					, optnVal3 = new ArrayList<String>();
			for(GdsOptnVO gdsoOtnVO : gdsVO.getOptnList()) {
				String[] optnVal = gdsoOtnVO.getOptnNm().split("[*]");
				//log.debug("optnVal.length" + optnVal.length);
				if(optnVal.length > 0 && !ArrayUtil.isContainsInList(optnVal1, optnVal[0].trim())) {
					optnVal1.add(optnVal[0].trim());
				}
				if(optnVal.length > 1 && !ArrayUtil.isContainsInList(optnVal2, optnVal[1].trim())) {
					optnVal2.add(optnVal[1].trim());
				}
				if(optnVal.length > 2 && !ArrayUtil.isContainsInList(optnVal3, optnVal[2].trim())) {
					optnVal3.add(optnVal[2].trim());
				}
			}
			String optnVal1Str = optnVal1.toString().replace("[", "").replace("]", "").replace(", ", ",");
			String optnVal2Str = optnVal2.toString().replace("[", "").replace("]", "").replace(", ", ",");
			String optnVal3Str = optnVal3.toString().replace("[", "").replace("]", "").replace(", ", ",");

			StringJoiner joiner = new StringJoiner("|");
			if(EgovStringUtil.isNotEmpty(optnVal1Str)) {
				joiner.add(optnVal1Str); }
			if(EgovStringUtil.isNotEmpty(optnVal2Str)) {
				joiner.add(optnVal2Str); }
			if(EgovStringUtil.isNotEmpty(optnVal3Str)) {
				joiner.add(optnVal3Str); }
			gdsVO.setOptnVal(joiner.toString());

			gdsVO.setCrud(CRUD.UPDATE);

			// checkbox
			if(EgovStringUtil.isNotEmpty(gdsVO.getGdsTagVal())) {
				gdsVO.setGdsTag(ArrayUtil.stringToArray(gdsVO.getGdsTagVal()));
			}
		}

		//카테고리 호출
		List<GdsCtgryVO> gdsCtgryList = gdsCtgryService.selectGdsCtgryList(1);
		model.addAttribute("gdsCtgryList", gdsCtgryList);

		//제조사 호출
		List<MkrVO> mkrList = mkrService.selectMkrListAll();
		model.addAttribute("mkrList", mkrList);

		//브랜드 호출
		List<BrandVO> brandList = brandService.selectBrandListAll();
		model.addAttribute("brandList", brandList);

		//return value
		model.addAttribute("ynCode", CodeMap.YN);
		model.addAttribute("useYnCode", CodeMap.USE_YN);
		model.addAttribute("dspyYnCode", CodeMap.DSPY_YN);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("gdsTagCode", CodeMap.GDS_TAG);
		model.addAttribute("dlvyCostTyCode", CodeMap.DLVY_COST_TY);
		model.addAttribute("dlvyPayTyCode", CodeMap.DLVY_PAY_TY);
		model.addAttribute("gdsAncmntTyCode", CodeMap.GDS_ANCMNT_TY);

		model.addAttribute("gdsVO", gdsVO);
		model.addAttribute("param", reqMap);

		return "/manage/gds/gds/form";
	}


	@RequestMapping(value="action")
	public View action(
			GdsVO gdsVO
			, @RequestParam Map<String,Object> reqMap
			, MultipartHttpServletRequest multiReq
			, HttpSession session
			, HttpServletRequest request) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));

		// doubleSubmit check
		if (EgovDoubleSubmitHelper.checkAndSaveToken("preventTokenKey", request)) {
			// 상품태그
			gdsVO.setGdsTagVal( ArrayUtil.arrayToString(gdsVO.getGdsTag(), ",") );

			// 상품옵션명
			String optnTtl1 = (String) reqMap.get("optnTtl1");
			String optnTtl2 = (String) reqMap.get("optnTtl2");
			String optnTtl3 = (String) reqMap.get("optnTtl3");
			StringJoiner joiner = new StringJoiner("|");
			if(EgovStringUtil.isNotEmpty(optnTtl1)) { joiner.add(optnTtl1); }
			if(EgovStringUtil.isNotEmpty(optnTtl2)) { joiner.add(optnTtl2); }
			if(EgovStringUtil.isNotEmpty(optnTtl3)) { joiner.add(optnTtl3); }
			gdsVO.setOptnTtl(joiner.toString());

			// 관리자정보
			gdsVO.setRegUniqueId(mngrSession.getUniqueId());
			gdsVO.setRegId(mngrSession.getMngrId());
			gdsVO.setRgtr(mngrSession.getMngrNm());
			gdsVO.setMdfcnUniqueId(mngrSession.getUniqueId());
			gdsVO.setMdfcnId(mngrSession.getMngrId());
			gdsVO.setMdfr(mngrSession.getMngrNm());

			Map<String, MultipartFile> fileMap = multiReq.getFileMap();

			switch (gdsVO.getCrud()) {
				case CREATE:
					gdsService.insertGds(gdsVO);

					fileService.creatFileInfo(fileMap, gdsVO.getGdsNo(), "GDS");

					//사업소 상품 등록
					int resultCnt = 0;
					if(!gdsVO.getGdsTy().equals("N")) {
						Map<String, Object> paramMap = new HashMap<String, Object>();
						paramMap.put("srchAprvTy", "C");
						//paramMap.put("srchUseYn", "Y");
						paramMap.put("srchGdsNo", gdsVO.getGdsNo());

						// select insert query
						resultCnt += bplcGdsService.selectInsertBplcGds(paramMap);

						System.out.println("###### " + resultCnt + " 개의 사업소에 등록 완료 ########");
					}

					javaScript.setMessage(getMsg("action.complete.insert"));
					javaScript.setLocation("./list?" + pageParam);
					break;

				case UPDATE:
					gdsService.updateGds(gdsVO);

					// 썸네일 삭제
					String delThumbFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delThumbFileNo"));
					String[] arrDelThumbFile = delThumbFileNo.split(",");
					if (!EgovStringUtil.isEmpty(arrDelThumbFile[0])) {
						fileService.deleteFilebyNo(arrDelThumbFile, gdsVO.getGdsNo(), "GDS", "THUMB");
					}

					// 첨부파일 삭제
					String delImageFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delImageFileNo"));
					String[] arrDelImageFile = delImageFileNo.split(",");
					if (!EgovStringUtil.isEmpty(arrDelImageFile[0])) {
						fileService.deleteFilebyNo(arrDelImageFile, gdsVO.getGdsNo(), "GDS", "IMAGE");
					}

					fileService.creatFileInfo(fileMap, gdsVO.getGdsNo(), "GDS");

					// 옵션 삭제
					String delOptnNo = WebUtil.clearSqlInjection((String) reqMap.get("delOptnNo"));
					String[] arrDelOptnNo = delOptnNo.split(",");
					if (!EgovStringUtil.isEmpty(arrDelOptnNo[0])) {
						gdsOptnService.deleteGdsOptn(gdsVO.getGdsNo(), arrDelOptnNo);
					}

					// 추가 옵션 삭제
					String delAditOptnNo = WebUtil.clearSqlInjection((String) reqMap.get("delAditOptnNo"));
					String[] arrAditDelOptnNo = delAditOptnNo.split(",");
					if (!EgovStringUtil.isEmpty(arrAditDelOptnNo[0])) {
						gdsOptnService.deleteGdsOptn(gdsVO.getGdsNo(), arrAditDelOptnNo);
					}

					javaScript.setMessage(getMsg("action.complete.update"));
					javaScript.setLocation(
						"./form?gdsNo=" + gdsVO.getGdsNo() + ("".equals(pageParam) ? "" : "&" + pageParam));
					break;

				case DELETE:
					//gdsService.deleteGds(gdsVO.getGdsNo());

					javaScript.setMessage(getMsg("action.complete.delete"));
					javaScript.setLocation("./list?" + pageParam);
					break;

				default:
					break;
			}

			// 상품 옵션 저장 START
			List<GdsOptnVO> optnItemList = new ArrayList<GdsOptnVO>();
			int optnTotalRow = EgovStringUtil.string2integer((String) reqMap.get("optnTotalRow"));

			for(int optnRow = 0; optnRow < optnTotalRow ; optnRow++){

				int optnNo = EgovStringUtil.string2integer((String) reqMap.get("optnNo" + optnRow), 0);
				String optnNm = (String) reqMap.get("optnNm" + optnRow);
				int optnPc = EgovStringUtil.string2integer((String) reqMap.get("optnPc" + optnRow), 0);
				int optnStockQy = EgovStringUtil.string2integer((String) reqMap.get("optnStockQy" + optnRow), 0);
				String useYn = (String) reqMap.get("optUseYn" + optnRow);

				if(EgovStringUtil.isNotEmpty(optnNm)) {
					GdsOptnVO optnVO = new GdsOptnVO();
					optnVO.setGdsNo(gdsVO.getGdsNo());
					optnVO.setGdsOptnNo(optnNo);
					optnVO.setOptnTy("BASE"); //기본옵션
					optnVO.setOptnNm(optnNm);
					optnVO.setOptnPc(optnPc);
					optnVO.setOptnStockQy(optnStockQy);
					optnVO.setUseYn(useYn);

					optnItemList.add(optnVO);
				}
			}
			gdsOptnService.registerGdsOptn(optnItemList);

			List<GdsOptnVO> aditOptnItemList = new ArrayList<GdsOptnVO>();
			int aditOptnListCnt = EgovStringUtil.string2integer((String) reqMap.get("aditOptnListCnt"));

			for(int optnRow = 0; optnRow < aditOptnListCnt ; optnRow++){

				int optnNo = EgovStringUtil.string2integer((String) reqMap.get("aditOptnNo" + optnRow), 0);
				String optnNm = (String) reqMap.get("aditOptnNm" + optnRow);
				int optnPc = EgovStringUtil.string2integer((String) reqMap.get("aditOptnPc" + optnRow), 0);
				int optnStockQy = EgovStringUtil.string2integer((String) reqMap.get("aditOptnStockQy" + optnRow), 0);
				String useYn = (String) reqMap.get("aditOptUseYn" + optnRow);

				if(EgovStringUtil.isNotEmpty(optnNm)) {
					GdsOptnVO optnVO = new GdsOptnVO();
					optnVO.setGdsNo(gdsVO.getGdsNo());
					optnVO.setGdsOptnNo(optnNo);
					optnVO.setOptnTy("ADIT"); //추가
					optnVO.setOptnNm(optnNm);
					optnVO.setOptnPc(optnPc);
					optnVO.setOptnStockQy(optnStockQy);
					optnVO.setUseYn(useYn);

					aditOptnItemList.add(optnVO);
				}
			}
			gdsOptnService.registerGdsOptn(aditOptnItemList);
			// END 관련상품
		}else {
			javaScript.setMessage(getMsg("alert.author.common"));
			javaScript.setMethod("window.history.back()");
		}

		return new JavaScriptView(javaScript);
	}


	@RequestMapping("modalGdsSearch")
	public String gdsSearchModal(
			HttpServletRequest request
			, Model model) throws Exception{

		//카테고리 호출
		List<GdsCtgryVO> gdsCtgryList = gdsCtgryService.selectGdsCtgryList(1);
		model.addAttribute("gdsCtgryList", gdsCtgryList);

		return "/manage/gds/gds/include/modal-gds-search";
	}


	//상품검색 datatable
	@SuppressWarnings("unchecked")
	@RequestMapping("gdsSearchList.json")
	@ResponseBody
	public DataTablesVO<MngrVO> gdsSearchList(
			@RequestParam Map<String, Object> reqMap,
			HttpServletRequest request) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		String srchUseYn = EgovStringUtil.null2string((String) reqMap.get("srchUseYn"), "Y");
		listVO.setParam("srchUseYn", srchUseYn);
		listVO = gdsService.gdsListVO(listVO);

		// DataTable
		DataTablesVO<MngrVO> dataTableVO = new DataTablesVO<MngrVO>();
		dataTableVO.setsEcho(MapUtil.getString(reqMap, "sEcho"));
		dataTableVO.setiTotalRecords(listVO.getTotalCount());
		dataTableVO.setiTotalDisplayRecords(listVO.getTotalCount());
		dataTableVO.setAaData(listVO.getListObject());

		return dataTableVO;
	}


	@ResponseBody
	@RequestMapping("listAction.json")
	public Map<String, Object> listAction(
			@RequestParam(value="arrGdsNo[]", required=false) String[] arrGdsNo
			, @RequestParam(value="useYn", required=true) String useYn
			, @RequestParam Map<String, Object> reqMap) throws Exception {

		boolean result = false;

		GdsVO gdsVO = new GdsVO();
		gdsVO.setArrGdsNo(arrGdsNo);
		gdsVO.setUseYn(useYn);
		gdsVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		gdsVO.setMdfcnId(mngrSession.getMngrId());
		gdsVO.setMdfr(mngrSession.getMngrNm());

		int resultCnt = gdsService.updateGdsListUseYn(gdsVO);
		if (resultCnt > 0) {
			result = true;
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);

		return resultMap;
	}


	@RequestMapping("excel")
	public String excelDownload(
			HttpServletRequest request
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception{

		List<GdsVO> resultList = gdsService.selectGdsListAll(reqMap);

		model.addAttribute("dspyYnCode", CodeMap.DSPY_YN);
		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("gdsTagCode", CodeMap.GDS_TAG);

		model.addAttribute("dlvyCostTyCode", CodeMap.DLVY_COST_TY);
		model.addAttribute("dlvyPayTyCode", CodeMap.DLVY_PAY_TY);

		model.addAttribute("resultList", resultList);

		return "/manage/gds/gds/excel";
	}
}