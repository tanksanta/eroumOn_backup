package icube.manage.gds.gds;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.StringJoiner;
import java.util.function.Function;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
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
import icube.common.util.ExcelExporter;
import icube.common.util.HtmlUtil;
import icube.common.util.MapUtil;
import icube.common.util.WebUtil;
import icube.common.util.egov.EgovDoubleSubmitHelper;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.values.StaticValues;
import icube.common.vo.CommonListVO;
import icube.common.vo.DataTablesVO;
import icube.manage.gds.ctgry.biz.GdsCtgryService;
import icube.manage.gds.ctgry.biz.GdsCtgryVO;
import icube.manage.gds.gds.biz.GdsService;
import icube.manage.gds.gds.biz.GdsVO;
import icube.manage.gds.optn.biz.GdsOptnService;
import icube.manage.gds.optn.biz.GdsOptnVO;
import icube.manage.mbr.itrst.biz.CartService;
import icube.manage.sysmng.brand.biz.BrandService;
import icube.manage.sysmng.brand.biz.BrandVO;
import icube.manage.sysmng.entrps.biz.EntrpsDlvyGrpService;
import icube.manage.sysmng.entrps.biz.EntrpsDlvyGrpVO;
import icube.manage.sysmng.entrps.biz.EntrpsService;
import icube.manage.sysmng.entrps.biz.EntrpsVO;
import icube.manage.sysmng.mkr.biz.MkrService;
import icube.manage.sysmng.mkr.biz.MkrVO;
import icube.manage.sysmng.mngr.biz.MngrSession;
import icube.manage.sysmng.mngr.biz.MngrVO;

/**
 * 관리자 > 상품관리 > 상품관리
 */
@Controller
@RequestMapping(value="/_mng/gds/gds")
public class MGdsController extends CommonAbstractController {

	@Resource(name = "gdsService")
	private GdsService gdsService;

	@Resource(name = "cartService")
	private CartService cartService;

	@Resource(name = "gdsCtgryService")
	private GdsCtgryService gdsCtgryService;

	@Resource(name = "gdsOptnService")
	private GdsOptnService gdsOptnService;

	@Resource(name = "entrpsService")
	private EntrpsService entrpsService;

	@Resource(name = "entrpsDlvyGrpService")
	private EntrpsDlvyGrpService entrpsDlvyGrpService;

	@Resource(name = "mkrService")
	private MkrService mkrService;

	@Resource(name = "brandService")
	private BrandService brandService;

	@Resource(name = "fileService")
	private FileService fileService;

	@Autowired
	private MngrSession mngrSession;

	// Page Parameter Keys
	private static String[] targetParams = {"curPage", "cntPerPage", "srchTarget", "srchText", "sortBy"
			, "srchUpCtgryNo", "srchCtgryNo", "srchGdsCd", "srchBnefCd", "srchGdsNm", "srchGdsTy", "srchGdsTag", "srchItemCd"};

	@RequestMapping(value="list")
	public String list(
			@RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		String srchUseYn = EgovStringUtil.null2string((String) reqMap.get("srchUseYn"), "Y");
		listVO.setParam("srchUseYn", srchUseYn);

		int upCtgryNo = 0;
		HashSet<String> ctgryNos = new HashSet<>();

		//카테고리 호출
		List<GdsCtgryVO> gdsCtgryList = gdsCtgryService.selectGdsCtgryList(-1, "Y");

		for(int i=1; i<4; i++) {
			if(EgovStringUtil.isNotEmpty((String)reqMap.get("ctgryNo"+i))) {
				if(EgovStringUtil.string2integer((String)reqMap.get("ctgryNo"+i)) > 0) {
					upCtgryNo = EgovStringUtil.string2integer((String)reqMap.get("ctgryNo"+i));
				}
			}
		}

		GdsCtgryVO currentCategory = gdsCtgryService.findChildCategory(gdsCtgryList, upCtgryNo);

		if(currentCategory != null) {
			if(currentCategory.getChildList().size() > 0) {
				for(GdsCtgryVO gdsCtgryVO : currentCategory.getChildList()) {
					for(GdsCtgryVO gdsCtgryChildVO : gdsCtgryVO.getChildList()) {
							for(GdsCtgryVO gdsCtgryChild2VO : gdsCtgryChildVO.getChildList()) {
								ctgryNos.add(EgovStringUtil.integer2string(gdsCtgryChild2VO.getCtgryNo()));
							}
							ctgryNos.add(EgovStringUtil.integer2string(gdsCtgryChildVO.getCtgryNo()));
					}
					ctgryNos.add(EgovStringUtil.integer2string(gdsCtgryVO.getCtgryNo()));
				}
			}else{
				ctgryNos.add(EgovStringUtil.integer2string(upCtgryNo));
			}
			listVO.setParam("srchCtgryNos", ArrayUtil.stringToArray(ctgryNos.toString().replace("[", "").replace("]", "")));
		}

		listVO = gdsService.gdsListVO(listVO);

		model.addAttribute("gdsCtgryList", gdsCtgryList);

		model.addAttribute("dspyYnCode", CodeMap.DSPY_YN);
		model.addAttribute("useYnCode", CodeMap.USE_YN);
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

			// 설명
			gdsVO.setDlvyDc(StaticValues.DLVY_DC);
			gdsVO.setDcCmmn(StaticValues.DC_CMMN);
			gdsVO.setDcFreeSalary(StaticValues.DC_FREE_SALARY);
			gdsVO.setDcPchrgSalary(StaticValues.DC_PCHRG_SALARY);
			gdsVO.setDcPchrgSalaryGnrl(StaticValues.DC_PCHRG_SALARY_GNRL);
			gdsVO.setDcPchrgGnrl(StaticValues.DC_PCHRG_GNRL);
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

		//입점업체 호출
		List<EntrpsVO> entrpsList = entrpsService.selectEntrpsListAll(new HashMap<String, Object>());
		model.addAttribute("entrpsList", entrpsList);

		List<EntrpsDlvyGrpVO> entrpsDlvyGrpList = entrpsDlvyGrpService.selectEntrpsDlvyGrpListAll(0);
		model.addAttribute("entrpsDlvyGrpList", entrpsDlvyGrpList);

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
			gdsVO.setTempYn((String)reqMap.get("tempYn"));

			Map<String, MultipartFile> fileMap = multiReq.getFileMap();

			switch (gdsVO.getCrud()) {
				case CREATE:

					gdsService.insertGdsAndBplc(gdsVO, fileMap);

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
				String optnItemCd = (String) reqMap.get("optnItemCd" + optnRow);
				String soldOutYn = (String) reqMap.get("soldOutYn" + optnRow);

				if(EgovStringUtil.isNotEmpty(optnNm)) {
					GdsOptnVO optnVO = new GdsOptnVO();
					optnVO.setGdsNo(gdsVO.getGdsNo());
					optnVO.setGdsOptnNo(optnNo);
					optnVO.setOptnTy("BASE"); //기본옵션
					optnVO.setOptnNm(optnNm);
					optnVO.setOptnPc(optnPc);
					optnVO.setOptnStockQy(optnStockQy);
					optnVO.setOptnItemCd(optnItemCd);
					optnVO.setUseYn(useYn);
					optnVO.setSoldOutYn(soldOutYn);

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
				String optnItemCd = (String) reqMap.get("aditOptnItemCd" + optnRow);
				String soldOutYn = (String) reqMap.get("aditSoldOutYn" + optnRow);

				if(EgovStringUtil.isNotEmpty(optnNm)) {
					GdsOptnVO optnVO = new GdsOptnVO();
					optnVO.setGdsNo(gdsVO.getGdsNo());
					optnVO.setGdsOptnNo(optnNo);
					optnVO.setOptnTy("ADIT"); //추가
					optnVO.setOptnNm(optnNm);
					optnVO.setOptnPc(optnPc);
					optnVO.setOptnStockQy(optnStockQy);
					optnVO.setOptnItemCd(optnItemCd);
					optnVO.setUseYn(useYn);
					optnVO.setSoldOutYn(soldOutYn);

					aditOptnItemList.add(optnVO);
				}
			}
			gdsOptnService.registerGdsOptn(aditOptnItemList);

			// 장바구니 업데이트
			// TODO 옵션이 없다가 생겼을 경우, 옵션이 있다가 없어질 경우 장바구니에 있는 상품은?
			if(gdsVO.getCrud().equals(CRUD.UPDATE)) {
				cartService.updateMbrCart(gdsVO);
			}

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
	public void excelDownload(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception{
				
		if (reqMap.get("ctgryNo4") != null && !EgovStringUtil.isEmpty(reqMap.get("ctgryNo4").toString())&& !EgovStringUtil.equals("0", reqMap.get("ctgryNo4").toString())){
			reqMap.put("srchRecsCtgryNo", reqMap.get("ctgryNo4").toString());
		}else if (reqMap.get("ctgryNo3") != null && !EgovStringUtil.isEmpty(reqMap.get("ctgryNo3").toString())&& !EgovStringUtil.equals("0", reqMap.get("ctgryNo3").toString())){
			reqMap.put("srchRecsCtgryNo", reqMap.get("ctgryNo3").toString());
		}else if (reqMap.get("ctgryNo2") != null && !EgovStringUtil.isEmpty(reqMap.get("ctgryNo2").toString())&& !EgovStringUtil.equals("0", reqMap.get("ctgryNo2").toString())){
			reqMap.put("srchRecsCtgryNo", reqMap.get("ctgryNo2").toString());
		}else if (reqMap.get("ctgryNo1") != null && !EgovStringUtil.isEmpty(reqMap.get("ctgryNo1").toString())&& !EgovStringUtil.equals("0", reqMap.get("ctgryNo1").toString())){
			reqMap.put("srchRecsCtgryNo", reqMap.get("ctgryNo1").toString());
		}
		
		reqMap.put("srchUseYn", "Y");
		List<GdsVO> resultList = gdsService.selectGdsWithOptnListAll(reqMap);
		for(GdsVO gdsVo : resultList) {
			//옵션 상품은 경우
			if (gdsVo.getGdsOptnNo() > 0) {
				gdsVo.setItemCd(gdsVo.getOptnItemCd());
				gdsVo.setGdsNm(gdsVo.getGdsNm() + "(" + gdsVo.getOptnNm() + ")");
				gdsVo.setStockQy(gdsVo.getOptnStockQy());

				//옵션의 사용여부 구하기
				String useYn = "";
				if ("BASE".equalsIgnoreCase(gdsVo.getOptnTy())) {
					List<GdsOptnVO> optnList = gdsVo.getOptnList();
					Optional<GdsOptnVO> result = optnList.stream().filter(f -> f.getGdsOptnNo() == gdsVo.getGdsOptnNo()).findAny();
					GdsOptnVO optn = result.orElse(null);
					if (optn != null) {
						useYn = optn.getUseYn();
					}
				} else {
					List<GdsOptnVO> aditOptnList = gdsVo.getAditOptnList();
					Optional<GdsOptnVO> result = aditOptnList.stream().filter(f -> f.getGdsOptnNo() == gdsVo.getGdsOptnNo()).findAny();
					GdsOptnVO optn = result.orElse(null);
					if (optn != null) {
						useYn = optn.getUseYn();
					}
				}
				gdsVo.setUseYn(useYn);
			}


		}

		// Excel Data 1번
		/* TODO: 아래의 소스는 참고용으로 지우지 않았습니다. 확인 후 지우시기 바랍니다.
		 * headers를 배열로 분리하여 가독성이 더 좋아보이나 배열에 추가/삭제, 순서 변경이 있으면 전체적으로 수정을 해야함
		 *
		String[] headers = {
				"상품구분", "카테고리1", "카테고리2", "카테고리3", "상품코드", "급여코드", "품목코드", "상품명", "상품태그", "관리자메모"
				, "기본설명", "재질", "중량", "사이즈상세", "규격", "제조사", "원산지", "브랜드", "입점업체", "모델"
				, "검색 키워드", "노출여부", "공급가", "판매가", "할인율", "할인가", "급여가", "대여가능", "재고수량", "옵션사용여부"
				, "배송비유형", "배송비결제", "기본배송료", "추가배송비", "등록일"
		};

		for(GdsVO gdsVo : resultList) { // 위의 loop에서 처리해도 상관 없으나.. 사용법 확인을 위해 분리함
			LinkedHashMap<String, Object> tempMap = new LinkedHashMap<String, Object>();
			tempMap.put(headers[0], CodeMap.GDS_TY.get(gdsVo.getGdsTy()));
		}
		*/

		// Excel Data 2번
		/* 소스의 길이는 조금 길어지나 header와 추출 함수를 같이 관리할수 있게 해줌
		 *
		 */
		Map<String, Function<Object, Object>> mapping = new LinkedHashMap<>();
		mapping.put("상품구분", obj -> CodeMap.GDS_TY.get(((GdsVO)obj).getGdsTy()));
		mapping.put("카테고리1", obj -> {
		    String path = ((GdsVO)obj).getGdsCtgryPath();
		    return path != null && path.split(" > ").length > 1 ? path.split(" > ")[1] : "";
		});

		mapping.put("카테고리2", obj -> {
		    String path = ((GdsVO)obj).getGdsCtgryPath();
		    return path != null && path.split(" > ").length > 2 ? path.split(" > ")[2] : "";
		});

		mapping.put("카테고리3", obj -> {
		    String path = ((GdsVO)obj).getGdsCtgryPath();
		    return path != null && path.split(" > ").length > 3 ? path.split(" > ")[3] : "";
		});

		// 기본 정보
		mapping.put("상품코드", obj -> ((GdsVO)obj).getGdsCd());
		mapping.put("급여코드", obj -> ((GdsVO)obj).getBnefCd());
		mapping.put("품목코드", obj -> ((GdsVO)obj).getItemCd());
		mapping.put("상품명", obj -> ((GdsVO)obj).getGdsNm());

		// 상품태그
		mapping.put("상품태그", obj -> {
		    String tagValues = ((GdsVO)obj).getGdsTagVal();
		    if (tagValues == null || tagValues.trim().isEmpty()) {
		        return "-";
		    }
		    String[] tags = tagValues.replace(" ", "").split(",");
		    return Arrays.stream(tags)
		            .map(tag -> CodeMap.GDS_TAG.get(tag))
		            .collect(Collectors.joining(", "));
		});

		// 그 외의 필드들
		mapping.put("관리자메모", obj -> ((GdsVO)obj).getMngrMemo());
		mapping.put("기본설명", obj -> ((GdsVO)obj).getBassDc());
		mapping.put("재질", obj -> ((GdsVO)obj).getMtrqlt());
		mapping.put("중량", obj -> ((GdsVO)obj).getWt());
		mapping.put("사이즈상세", obj -> ((GdsVO)obj).getSize());
		mapping.put("규격", obj -> ((GdsVO)obj).getStndrd());
		mapping.put("제조사", obj -> ((GdsVO)obj).getMkr());
		mapping.put("원산지", obj -> ((GdsVO)obj).getPlor());
		mapping.put("브랜드", obj -> ((GdsVO)obj).getBrand());
		mapping.put("입점업체", obj -> ((GdsVO)obj).getEntrpsNm());
		mapping.put("모델", obj -> ((GdsVO)obj).getModl());
		mapping.put("검색 키워드", obj -> ((GdsVO)obj).getKeyword());
		mapping.put("노출여부", obj -> CodeMap.DSPY_YN.get(((GdsVO)obj).getDspyYn()));
		mapping.put("공급가", obj -> String.format("%,d", ((GdsVO)obj).getSupPc()));
		mapping.put("판매가", obj -> String.format("%,d", ((GdsVO)obj).getPc()));
		mapping.put("할인율", obj -> ((GdsVO)obj).getDscntRt() + "%");
		mapping.put("할인가", obj -> String.format("%,d", ((GdsVO)obj).getDscntPc()));
		mapping.put("급여가", obj -> String.format("%,d", ((GdsVO)obj).getBnefPc()));
		mapping.put("대여가능", obj -> "Y".equals(((GdsVO)obj).getLendDuraYn()) ? "사용" : "미사용");
		mapping.put("재고수량", obj -> String.format("%,d", ((GdsVO)obj).getStockQy()));
		mapping.put("옵션사용여부", obj -> ((GdsVO)obj).getUseYn());

		// 배송 정보
		mapping.put("배송비유형", obj -> CodeMap.DLVY_COST_TY.get(((GdsVO)obj).getDlvyCtTy()));
		mapping.put("배송비결제", obj -> CodeMap.DLVY_PAY_TY.get(((GdsVO)obj).getDlvyCtStlm()));
		mapping.put("기본배송료", obj -> String.format("%,d", ((GdsVO)obj).getDlvyBassAmt()));
		mapping.put("추가배송비", obj -> String.format("%,d", ((GdsVO)obj).getDlvyAditAmt()));

		// 등록일
		mapping.put("등록일", obj -> new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(((GdsVO)obj).getRegDt()));

		List<LinkedHashMap<String, Object>> dataList = new ArrayList<>();
		for (GdsVO gdsVo : resultList) {
		    LinkedHashMap<String, Object> tempMap = new LinkedHashMap<>();
		    for (String header : mapping.keySet()) {
		        Function<Object, Object> extractor = mapping.get(header);
		        if (extractor != null) {
		            tempMap.put(header, extractor.apply(gdsVo));
		        }
		    }
		    dataList.add(tempMap);
		}

		ExcelExporter exporter = new ExcelExporter();
		try {
			exporter.export(response, "상품목록", dataList, mapping);
		} catch (IOException e) {
		    e.printStackTrace();
		}

	}


	/**
	 * 미리보기
	 * @param upCtgryNo
	 * @param ctgryNo
	 * @param gdsCd
	 * @return preview
	 */
	@RequestMapping(value = "{upCtgryNo}/{ctgryNo}/{gdsCd}")
	public String preview(
		@PathVariable int upCtgryNo // 카테고리 1
		, @PathVariable int ctgryNo // 카테고리 2
		, @PathVariable String gdsCd // 상품 코드
		, @RequestParam Map<String,Object> reqMap
		, HttpServletRequest request
		, HttpServletResponse response
		, HttpSession session
		, Model model
			)throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchTempYn", "Y"); //임시저장 고정
		paramMap.put("srchGdsCd", gdsCd); //상품 코드

		GdsVO gdsVO = gdsService.selectGdsByFilter(paramMap);

		if(gdsVO != null) {

			// 조회수 증가
			gdsService.updateInqcnt(gdsVO);

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

			// checkbox
			if(EgovStringUtil.isNotEmpty(gdsVO.getGdsTagVal())) {
				gdsVO.setGdsTag(ArrayUtil.stringToArray(gdsVO.getGdsTagVal()));
			}

			// youtube image
			gdsVO.setYoutubeImg(HtmlUtil.getYoutubeId(gdsVO.getYoutubeUrl()));

			//제조사 호출
			List<MkrVO> mkrList = mkrService.selectMkrListAll();
			model.addAttribute("mkrList", mkrList);

			//브랜드 호출
			List<BrandVO> brandList = brandService.selectBrandListAll();
			model.addAttribute("brandList", brandList);

			List<GdsCtgryVO> gdsCtgryList = gdsCtgryService.selectGdsCtgryList(-1, "Y");
			Map<Integer, String> gdsCtgryListMap = gdsCtgryService.selectGdsCtgryListToMap(-1);
			model.addAttribute("_gdsCtgryList", gdsCtgryList);
			model.addAttribute("_gdsCtgryListMap", gdsCtgryListMap);

			model.addAttribute("gdsVO", gdsVO);

			model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
			model.addAttribute("gdsTagCode", CodeMap.GDS_TAG);
			model.addAttribute("dlvyCostTyCode", CodeMap.DLVY_COST_TY);
			model.addAttribute("dlvyPayTyCode", CodeMap.DLVY_PAY_TY);
			model.addAttribute("gdsAncmntTyCode", CodeMap.GDS_ANCMNT_TY);

			model.addAttribute("upCtgryNo", upCtgryNo);
			model.addAttribute("ctgryNo", ctgryNo);
			model.addAttribute("param", reqMap);

		}else {
			model.addAttribute("alertMsg", "임시저장 하지 않은 상품입니다.");
			return "/common/msg";
		}

		return "/manage/gds/gds/include/view";
	}


	/**
	 * 상품 일괄 품절 처리
	 * @param arrGdsNo
	 * @return resultMap
	 * @throws Exception
	 */
	@RequestMapping(value = "modifyAllSold.json")
	@ResponseBody
	private Map<String, Object> modifyAllSold(
			@RequestParam(value="arrGdsNo", required=true) List<Integer> arrGdsNo
			, HttpServletRequest request
			, Model model
			)throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		int resultCnt = 0;

		try {
			resultCnt = gdsService.updateGdsTagAll(arrGdsNo);
		}catch(Exception e) {
			e.printStackTrace();
			log.debug("modifyAllSold Error : " + e.toString());
		}

		resultMap.put("resultCnt", resultCnt);
		return resultMap ;
	}

	/**
	 * 상품 일괄 등록
	 * @param gdsList
	 * @return resultMap
	 * @throws Exception
	 */
	@RequestMapping(value = "insertBatchGds.json")
	@ResponseBody
	public Map<String, Object> insertBatchGds(
			@RequestParam(value = "gdsList", required=true) String gdsList
			, HttpServletRequest request
			, Model model
			)throws Exception {

		Map<String, Object> msgMap = new HashMap<String, Object>();

		JSONParser jsonParser = new JSONParser();
		Object obj = jsonParser.parse(gdsList);
		JSONArray jsonArr = (JSONArray)obj;
		int resultCnt = 0;

		for(Object data : jsonArr) {
			JSONObject jsonObj = (JSONObject)data;
			log.debug("###  jsonObj  ### : " + jsonObj.toJSONString());

			// 중복검사
			Map<String, Object> paramMap = new HashMap<String, Object>();
			String gdsNm = String.valueOf(jsonObj.get("상품_명"));
			paramMap.put("srchTrimGdsNm", gdsNm.trim());
			int dupCnt = gdsService.selectGdsCnt(paramMap);

			if(dupCnt > 0) {
				msgMap.put(String.valueOf(jsonObj.get("상품_명")), "중복 상품");
			}else {
				try {
					Map<String, Object> returnMap = gdsService.setParamAndInsert(jsonObj);
					resultCnt += (Integer)returnMap.get("resultCnt");
				}catch(Exception e) {
					e.printStackTrace();
					msgMap.put(String.valueOf(jsonObj.get("상품_명")), e.getMessage());
				}
			}
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("msgMap", msgMap.toString());
		resultMap.put("resultCnt", resultCnt);
		resultMap.put("totalCnt", jsonArr.size());
		return resultMap;
	}
}