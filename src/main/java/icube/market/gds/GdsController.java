package icube.market.gds;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.StringJoiner;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.ArrayUtil;
import icube.common.util.HtmlUtil;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.gds.ctgry.biz.GdsCtgryService;
import icube.manage.gds.ctgry.biz.GdsCtgryVO;
import icube.manage.gds.gds.biz.GdsService;
import icube.manage.gds.gds.biz.GdsVO;
import icube.manage.gds.optn.biz.GdsOptnVO;
import icube.manage.mbr.itrst.biz.CartVO;
import icube.manage.members.bplc.biz.BplcService;
import icube.manage.members.bplc.biz.BplcVO;
import icube.manage.ordr.dtl.biz.OrdrDtlService;
import icube.manage.ordr.ordr.biz.OrdrService;
import icube.manage.sysmng.brand.biz.BrandService;
import icube.manage.sysmng.brand.biz.BrandVO;
import icube.manage.sysmng.mkr.biz.MkrService;
import icube.manage.sysmng.mkr.biz.MkrVO;
import icube.market.mbr.biz.MbrSession;
import icube.members.stdg.biz.StdgCdService;
import icube.members.stdg.biz.StdgCdVO;
import icube.membership.conslt.biz.ItrstService;
import icube.membership.conslt.biz.ItrstVO;

/**
 * 마켓 > 상품 정보
 */

@SuppressWarnings("unchecked")
@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/gds")
public class GdsController extends CommonAbstractController {

	@Resource(name = "gdsService")
	private GdsService gdsService;

	@Resource(name = "mkrService")
	private MkrService mkrService;

	@Resource(name = "brandService")
	private BrandService brandService;

	@Resource(name = "itrstService")
	private ItrstService itrstService;

	@Resource(name = "bplcService")
	private BplcService bplcService;

	@Resource(name = "ordrService")
	private OrdrService ordrService;

	@Resource(name = "ordrDtlService")
	private OrdrDtlService ordrDtlService;

	@Resource(name = "stdgCdService")
	private StdgCdService stdgCdService;

	@Resource(name = "gdsCtgryService")
	private GdsCtgryService gdsCtgryService;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	@Autowired
	private MbrSession mbrSession;


	/**
	 * default 접속 URL > 첫번째 등록된 카테고리로 리다이렉트
	 */
	@RequestMapping(value = "list")
	public String defaultList(
			@RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {

		List<GdsCtgryVO> gdsCtgryList = (List<GdsCtgryVO>) request.getAttribute("_gdsCtgryList");
		String rtnUrl = "/" + marketPath;

		for(GdsCtgryVO gdsCtgryVO : gdsCtgryList) {
			if(gdsCtgryVO.getUpCtgryNo() == 1) {
				rtnUrl = "/" + marketPath + "/gds/" + gdsCtgryVO.getCtgryNo() + "/list";
				break;
			}
		}

		return "redirect:"+ rtnUrl;
	}


	/**
	 * 상품 목록 컨테이너
	 * @param upCtgryNo
	 * @param ctgryNo
	 */
	@RequestMapping(value = {"{upCtgryNo}/list", "{upCtgryNo}/{ctgryNo1}/list"
			, "{upCtgryNo}/{ctgryNo1}/{ctgryNo2}/list", "{upCtgryNo}/{ctgryNo1}/{ctgryNo2}/{ctgryNo3}/list"})
	public String list(
			@PathVariable int upCtgryNo // 카테고리 1
			, @PathVariable(required = false) Optional<Integer> ctgryNo1 // 카테고리 2
			, @PathVariable(required = false) Optional<Integer> ctgryNo2 // 카테고리 3
			, @PathVariable(required = false) Optional<Integer> ctgryNo3 // 카테고리 4
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {

		List<GdsCtgryVO> gdsCtgryList = (List<GdsCtgryVO>) request.getAttribute("_gdsCtgryList");
		GdsCtgryVO currentCategory = new GdsCtgryVO();
		int ctgryNo = 0;

		if(ctgryNo3.orElse(0) > 0) {
			ctgryNo = ctgryNo3.orElse(0);
		}else if(ctgryNo2.orElse(0) > 0) {
			ctgryNo = ctgryNo2.orElse(0);
		}else if(ctgryNo1.orElse(0) > 0) {
			ctgryNo = ctgryNo1.orElse(0);
		}else {
			ctgryNo = upCtgryNo;
		}

		currentCategory = gdsCtgryService.findChildCategory(gdsCtgryList, ctgryNo);

		model.addAttribute("curCtgryVO", currentCategory);

		model.addAttribute("upCtgryNo", upCtgryNo);
		model.addAttribute("ctgryNo1", ctgryNo1.orElse(0));
		model.addAttribute("ctgryNo2", ctgryNo2.orElse(0));
		model.addAttribute("ctgryNo3", ctgryNo3.orElse(0));

		return "/market/gds/list";
	}

	/**
	 * 상품 목록
	 * @param upCtgryNo : 카테고리
	 */
	@RequestMapping(value = {"{upCtgryNo}/srchList"})
	public String srchList(
			@PathVariable int upCtgryNo // 카테고리
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {

				int curPage = EgovStringUtil.string2integer((String) reqMap.get("curPage"), 1);
				int cntPerPage = EgovStringUtil.string2integer((String) reqMap.get("cntPerPage"), 12);
		
				for(int i=1; i<4; i++) {
					if(EgovStringUtil.isNotEmpty((String)reqMap.get("ctgryNo"+i))) {
						if(EgovStringUtil.string2integer((String)reqMap.get("ctgryNo"+i)) > 0) {
							upCtgryNo = EgovStringUtil.string2integer((String)reqMap.get("ctgryNo"+i));
						}
					}
				}
		
				String[] srchGdsTys = {};
				if(EgovStringUtil.isNotEmpty((String) reqMap.get("srchGdsTys"))) {
					srchGdsTys = EgovStringUtil.getStringArray((String) reqMap.get("srchGdsTys"), "|");
				}
		
				CommonListVO listVO = new CommonListVO(request, curPage, cntPerPage);
				listVO.setParam("srchUseYn", "Y"); // 사용중
				listVO.setParam("srchDspyYn", "Y"); // 전시중
		//		listVO.setParam("srchCtgryNos", ArrayUtil.stringToArray(ctgryNos.toString().replace("[", "").replace("]", "")));
				listVO.setParam("srchGdsTys", srchGdsTys); //gds_ty
				listVO.setParam("srchTempYn", "N"); // 임시저장 여부
				listVO.setParam("srchRecsCtgryNo", upCtgryNo); // 카테고리 하위 재귀 호출
		
				if(mbrSession.isLoginCheck()){ // 로그인 > 위시리스트 여부
					listVO.setParam("uniqueId", mbrSession.getUniqueId());
				}
		
				listVO = gdsService.gdsListVO(listVO);
		
				for(Object o : listVO.getListObject()) { // 상품태그 처리
					GdsVO temp = (GdsVO) o;
					if(EgovStringUtil.isNotEmpty(temp.getGdsTagVal())) {
						temp.setGdsTag(ArrayUtil.stringToArray(temp.getGdsTagVal()));
					}
				}
		
				model.addAttribute("listVO", listVO);
				model.addAttribute("upCtgryNo", upCtgryNo);
		
				return "/market/gds/include/srch_list";
	}

	@RequestMapping(value = "srchCtrgy")
	public String srchCtgry(
			@RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model
			)throws Exception {

		String ctgryNo = "";
		GdsCtgryVO gdsCtgryVO = new GdsCtgryVO();
		List<GdsCtgryVO> gdsCtgryList = (List<GdsCtgryVO>) request.getAttribute("_gdsCtgryList");

		if(EgovStringUtil.isNotEmpty((String)reqMap.get("ctgryNo"))) {
			ctgryNo = (String)reqMap.get("ctgryNo");
		}

		if(EgovStringUtil.string2integer(ctgryNo) > 0) {
			gdsCtgryVO = gdsCtgryService.findChildCategory(gdsCtgryList, EgovStringUtil.string2integer(ctgryNo));
		}

		model.addAttribute("childList", gdsCtgryVO.getChildList());
		model.addAttribute("paramMap", reqMap);

		return "/market/gds/include/srch_ctgry";
	}


	/**
	 * 상품 상세
	 */
	@RequestMapping(value = "{ctgryNo}/{gdsCd}")
	public String view(
			@PathVariable int ctgryNo // 해당 상품의 카테고리 번호
			, @PathVariable String gdsCd // 상품 코드
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {

		if(EgovStringUtil.isNotEmpty(gdsCd)) {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("srchUseYn", "Y"); //사용중 고정
			paramMap.put("srchDspyYn", "Y"); // 전시중 고정
			paramMap.put("srchGdsCd", gdsCd); //상품 코드
			if(mbrSession.isLoginCheck()){ // 로그인 > 위시리스트 여부
				paramMap.put("uniqueId", mbrSession.getUniqueId());
			}

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

				//이전 구매내역 사업소 정보
				/*Map<String, Object> dtlMap = new HashMap();
				dtlMap.put("srchRegUniqueId", mbrSession.getUniqueId());
				// dtlMap.put("srchGdsCd", gdsCd);
				OrdrDtlVO ordrDtlVO = ordrDtlService.selectOrdrDtlHistory(dtlMap);
				model.addAttribute("ordrDtlVO",ordrDtlVO);*/

				//2023-03-29 아리아케어 고정으로 변경 이후 변경 예정(임시임)
				Map<String, Object> bplcMap = new HashMap<String, Object>();
				bplcMap.put("srchBrno", "466-87-00410");
				BplcVO bplcVO = bplcService.selectBplc(bplcMap);
				model.addAttribute("bplcVO", bplcVO);

				Map<String, Object> pathMap = new HashMap<String, Object>();
				pathMap.put("srchCtgryNo", ctgryNo);
				String noPath = gdsCtgryService.selectGdsCtgryNoPath(pathMap);
				model.addAttribute("noPath", noPath); 


				model.addAttribute("gdsVO", gdsVO);

				model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
				model.addAttribute("gdsTagCode", CodeMap.GDS_TAG);
				model.addAttribute("dlvyCostTyCode", CodeMap.DLVY_COST_TY);
				model.addAttribute("dlvyPayTyCode", CodeMap.DLVY_PAY_TY);
				model.addAttribute("dlvyPayTyCode2", CodeMap.DLVY_PAY_TY2);
				model.addAttribute("gdsAncmntTyCode", CodeMap.GDS_ANCMNT_TY);

				model.addAttribute("ctgryNo", ctgryNo);
				model.addAttribute("param", reqMap);


				List<GdsCtgryVO> gdsCtgryList = (List<GdsCtgryVO>) request.getAttribute("_gdsCtgryList");
				GdsCtgryVO currentCategory = gdsCtgryService.findChildCategory(gdsCtgryList, ctgryNo);
				model.addAttribute("curCtgryVO", currentCategory);

				ObjectMapper mapper  = new ObjectMapper();
				String gdsVOJson =  mapper.writeValueAsString(gdsVO);
				model.addAttribute("gdsVOJson", gdsVOJson);
				
			} else {
				model.addAttribute("alertMsg", getMsg("goods.sale.stop"));
				return "/common/msg";
			}
		} else {
			model.addAttribute("alertMsg", getMsg("alert.author.common"));
			return "/common/msg";
		}

		return "/market/gds/view2";
	}



	//상품비교
	@RequestMapping(value = {"compare"})
	public String compare(
			@RequestParam(value="ctgryNo", required=true) int ctgryNo
			, @RequestParam(value="gdsCds[]", required=true) String[] gdsCds
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchCtgryNo", ctgryNo);
		paramMap.put("srchGdsCds", gdsCds);


		CommonListVO listVO = new CommonListVO(request, 1, 4);
		listVO.setParam("srchUseYn", "Y"); // 사용중
		listVO.setParam("srchDspyYn", "Y"); // 전시중
		listVO.setParam("srchCtgryNo", ctgryNo);
		listVO.setParam("srchGdsCds", gdsCds);
		listVO.setParam("sortBy", "FI"); //First In

		if(mbrSession.isLoginCheck()){ // 로그인 > 위시리스트 여부
			listVO.setParam("uniqueId", mbrSession.getUniqueId());
		}

		listVO = gdsService.gdsListVO(listVO);

		model.addAttribute("ctgryNo", ctgryNo);
		model.addAttribute("listVO", listVO);

		return "/market/gds/include/gds_compare_layer";
	}

	// 사업소 선택 모달
	@RequestMapping(value="choicePartners")
	public String choicePartners(
			@RequestParam(value="params", required=true) String pageType
			, HttpServletRequest request
			, Model model
			) throws Exception {

		model.addAttribute("pageType", pageType);
		model.addAttribute("bplcRstdeCode", CodeMap.BPLC_RSTDE);

		return "/market/gds/include/modal_partner";
	}

	// 사업소 내부 모달 리스트
	@RequestMapping(value="choicePartnersList")
	public String choicePartnersList(
			@RequestParam(value="params", required=true) String pageType

			, @RequestParam(value="srchMode", required=false) String srchMode
			, @RequestParam(value="isAllow", required=false) boolean isAllow
			, @RequestParam(value="lat", required=false) String lat
			, @RequestParam(value="lot", required=false) String lot
			, @RequestParam(value="dist", required=false) String dist

			, HttpServletRequest request
			, Model model
			) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		CommonListVO listVO = new CommonListVO(request);


		// 관심 사업소
		if(pageType.equals("itrst")) {
			paramMap.put("srchPageType", pageType);
			paramMap.put("srchUniqueId", mbrSession.getUniqueId());
			paramMap.put("srchItrstTy", "B");

			List<ItrstVO> itrstList = itrstService.selectItrstListAll(paramMap);

			model.addAttribute("itrstList", itrstList);
		}

		// 추천 사업소
		if(pageType.equals("recommend")) {
			listVO.setParam("rcmdtnYn", "Y");
			listVO = bplcService.bplcListVO(listVO);
		}

		// 내 주위 사업소
		if(pageType.equals("around")) {
			paramMap.clear();
			paramMap.put("srchAprvTy","C"); // 승인
			paramMap.put("srchUseYn","Y"); // 사용중
			paramMap.put("srchMode",srchMode.toUpperCase()); // 검색모드

			if(isAllow) {
				paramMap.put("isAllow", isAllow);
				paramMap.put("lat", lat); // 위도
				paramMap.put("lot", lot); // 경도
				paramMap.put("dist", dist); // 검색범위
			}

			List<BplcVO> resultList = bplcService.selectBplcListAll(paramMap);
			model.addAttribute("resultList", resultList);
		}


		// 최근 구매
		if(pageType.equals("recent")) {
			listVO.setParam("srchRegUniqueId", mbrSession.getUniqueId());

			listVO = bplcService.recentBplcListVO(listVO);
		}

		// 사업소 찾기
		if(pageType.equals("search")) {

			List<StdgCdVO> stdgCdList = stdgCdService.selectStdgCdListAll(1);


			listVO.setParam("srchAprvTy", "C");
			listVO = bplcService.bplcListVO(listVO);

			model.addAttribute("stdgCdList", stdgCdList);
		}

		model.addAttribute("pageType", pageType);
		model.addAttribute("listVO", listVO);
		model.addAttribute("bplcRstdeCode", CodeMap.BPLC_RSTDE);


		return "/market/gds/include/modal_partner_list";
	}

	/**
	 * 상품 주문 > 사업소 찾기용 리스트 페이지
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="partnersDtlList")
	@SuppressWarnings({"rawtypes"})
	public String partnersDtlList(
			@RequestParam(value="params[pageType]", required=true) String pageType
			, @RequestParam(value="params[sido]", required=false) String sido
			, @RequestParam(value="params[gugun]", required=false) String gugun
			, @RequestParam(value="params[text]", required=false) String srchText
			, HttpServletRequest request
			, Model model
			) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		Map<String, Object> paramMap = new HashMap();

		if(EgovStringUtil.isNotEmpty(sido)) {
			paramMap.put("stdgCode", sido);
			StdgCdVO stdgCdVO = stdgCdService.selectStdgCd(paramMap);
			listVO.setParam("srchSido", stdgCdVO.getCtpvNm().substring(0, 2));
		}

		listVO.setParam("srchGugun", gugun);
		listVO.setParam("srchBplcNm", srchText);

		listVO = bplcService.bplcListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("pageType", pageType);
		model.addAttribute("bplcRstdeCode", CodeMap.BPLC_RSTDE);

		return "/market/gds/include/modal_partner_dtlList";
	}



	/**
	 * 장바구니 옵션 선택 모달
	 * @param gdsNo
	 */
	@RequestMapping(value="optnModal")
	public String optnModal(
			@RequestParam(value="gdsNo", required=true) String gdsNo
			, Model model
			)throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUseYn", "Y"); //사용중 고정
		paramMap.put("srchDspyYn", "Y"); // 전시중 고정
		paramMap.put("gdsNo", EgovStringUtil.string2integer(gdsNo));

		GdsVO gdsVO = gdsService.selectGdsByFilter(paramMap);
		if(gdsVO != null) {

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



			model.addAttribute("gdsVO", gdsVO);
		}


		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);

		return "/market/gds/include/modal_gds_optn";
	}
}
