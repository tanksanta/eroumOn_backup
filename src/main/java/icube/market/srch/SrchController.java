package icube.market.srch;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.ArrayUtil;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.gds.ctgry.biz.GdsCtgryService;
import icube.manage.gds.ctgry.biz.GdsCtgryVO;
import icube.manage.gds.gds.biz.GdsService;
import icube.manage.gds.gds.biz.GdsVO;
import icube.market.mbr.biz.MbrSession;
import icube.market.srch.biz.SrchLogService;

/**
 * 마켓 > 상품 검색
 * @author kkm
 *
 */
@Controller
@RequestMapping(value = "#{props['Globals.Market.path']}/search")
public class SrchController extends CommonAbstractController {

	@Resource(name = "gdsService")
	private GdsService gdsService;

	@Resource(name = "srchLogService")
	private SrchLogService srchLogService;

	@Resource(name = "gdsCtgryService")
	private GdsCtgryService gdsCtgryService;
	
	@Autowired
	private MbrSession mbrSession;

	// 검색 컨테이너 호출
	@RequestMapping(value = {"index", "total"})
	public String search(
			@RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, Model model) throws Exception {

		//TODO : 카테고리 그룹핑 결과
		String[] srchKwd = {};
		String kwd = "";
		if (EgovStringUtil.isNotEmpty((String) reqMap.get("srchKwd"))) {
			kwd = (String) reqMap.get("srchKwd");
		}
		if (EgovStringUtil.isNotEmpty((String) reqMap.get("srchNonKwd"))) {
			kwd = (String) reqMap.get("srchNonKwd");
		}
		srchKwd = EgovStringUtil.getStringArray(kwd.split("\\?")[0], " ");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUseYn", "Y"); // 사용중
		paramMap.put("srchDspyYn", "Y"); // 전시중
		paramMap.put("srchTempYn", "N"); // 임시저장 여부
		paramMap.put("srchKwd", srchKwd);
		List<String> resultCtgryGrpList = gdsService.selectGdsCtgryGrp(paramMap);
		List<String> resultGdsTyGrpList = gdsService.selectGdsTyGrp(paramMap);

		// 검색 로그 기록
		String referer = (String)request.getHeader("REFERER");
		if(EgovStringUtil.isNotEmpty(kwd.split("\\?")[0])) {
			Map<String, Object> logMap = new HashMap<String, Object>();
			logMap.put("referer", referer.split("\\?")[0]);
			logMap.put("kwd", kwd.split("\\?")[0]);
			srchLogService.registSrchLog(logMap);
		}

		model.addAttribute("resultCtgryGrpList", resultCtgryGrpList);
		model.addAttribute("resultGdsTyGrpList", resultGdsTyGrpList);
		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);

		return "/market/srch/total";
	}

	// 상품 리스트
	@RequestMapping(value = "srchList")
	public String srchList(
			@RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model)throws Exception {

		int curPage = EgovStringUtil.string2integer((String) reqMap.get("curPage"), 1);
		int cntPerPage = EgovStringUtil.string2integer((String) reqMap.get("cntPerPage"), 12);
		String sortBy = EgovStringUtil.null2string((String) reqMap.get("sortBy"), "");

		String[] srchCtgryNos = {};
		if(EgovStringUtil.isNotEmpty((String) reqMap.get("srchCtgryNos"))) {
			srchCtgryNos = EgovStringUtil.getStringArray((String) reqMap.get("srchCtgryNos"), "|");
		}

		String[] srchGdsTys = {};
		if(EgovStringUtil.isNotEmpty((String) reqMap.get("srchGdsTys"))) {
			srchGdsTys = EgovStringUtil.getStringArray((String) reqMap.get("srchGdsTys"), "|");
		}

		String[] srchKwd = {};
		if (EgovStringUtil.isNotEmpty((String) reqMap.get("srchKwd"))) {
			String kwd = (String) reqMap.get("srchKwd");
			srchKwd = EgovStringUtil.getStringArray(kwd.split("\\?")[0], " ");
			
			//키워드와 카테고리명이 일치하는 카테고리가 있다면 검색 추가
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("srchCtgryNmLike", kwd);
			List<GdsCtgryVO> gdsCtgryVOLists = gdsCtgryService.selectGdsCtgryNoList(paramMap);
			
			List<String> srchCtgryList = new ArrayList<>();
			while (gdsCtgryVOLists.size() > 0) {
				List<String> ctgryNos = gdsCtgryVOLists.stream().map(m -> String.valueOf(m.getCtgryNo())).collect(Collectors.toList());
				srchCtgryList.addAll(ctgryNos);
				
				//하위 카테고리 검색
				paramMap.clear();
				paramMap.put("srchUpCtgryNoList", ctgryNos);
				gdsCtgryVOLists = gdsCtgryService.selectGdsCtgryNoList(paramMap);
			}
			srchCtgryNos = srchCtgryList.toArray(new String[srchCtgryList.size()]);
			
			//검색될 카테고리가 있다면 키워드 검색은 제거
			if (srchCtgryNos.length > 0) {
				srchKwd = null;
			}
		}

		CommonListVO listVO = new CommonListVO(request, curPage, cntPerPage);
		listVO.setParam("srchUseYn", "Y"); // 사용중
		listVO.setParam("srchDspyYn", "Y"); // 전시중
		listVO.setParam("srchTempYn", "N"); // 임시저장 여부
		listVO.setParam("srchCtgryNos", srchCtgryNos); // LAST 카테고리
		listVO.setParam("srchGdsTys", srchGdsTys); //gds_ty
		listVO.setParam("sortBy", sortBy);  // 정렬 순서

		listVO.setParam("srchKwd", srchKwd); // 키워드

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
		model.addAttribute("isSrchPage", true); // 검색페이지
		model.addAttribute("srchOrdr", sortBy);


		return "/market/gds/include/srch_list";
	}

}
