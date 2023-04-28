package icube.market.mypage.itrst;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.gds.ctgry.biz.GdsCtgryVO;
import icube.manage.members.bplc.biz.BplcService;
import icube.market.mbr.biz.MbrSession;
import icube.market.mypage.itrst.biz.ItrstService;
import icube.market.mypage.itrst.biz.ItrstVO;
import icube.members.stdg.biz.StdgCdService;
import icube.members.stdg.biz.StdgCdVO;

/**
 * 관심 사업소, 관심 카테고리
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/mypage/itrst")
public class MyItrstController extends CommonAbstractController{

	@Resource(name = "bplcService")
	private BplcService bplcService;

	@Resource(name = "itrstService")
	private ItrstService itrstService;

	@Resource(name = "stdgCdService")
	private StdgCdService stdgCdService;

	@Autowired
	private MbrSession mbrSession;

	/**
	 * 관심 사업소
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="bplc")
	@SuppressWarnings({"rawtypes","unchecked"})
	public String bplc(
			HttpServletRequest request
			, Model model
			) throws Exception {

		Map<String, Object> paramMap = new HashMap();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());
		paramMap.put("srchItrstTy", "B");
		List<ItrstVO> bplcList = itrstService.selectItrstListAll(paramMap);


		model.addAttribute("bplcList", bplcList);
		model.addAttribute("bplcRstdeCode", CodeMap.BPLC_RSTDE);

		return "/market/mypage/itrst/bplc";
	}

	/**
	 * 관심 카테고리
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="ctgry")
	@SuppressWarnings({"unchecked","rawtypes"})
	public String ctgry(
			HttpServletRequest request
			, Model model
			) throws Exception {

		// 카테고리 정보
		List<GdsCtgryVO> gdsCtgry = itrstService.selectGdsCtgryList();

		// 관심 카테고리
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());
		paramMap.put("srchItrstTy", "C");
		List<ItrstVO> itemList = itrstService.selectItrstListAll(paramMap);


		model.addAttribute("gdsCtgry", gdsCtgry);
		model.addAttribute("itemList", itemList);

		return "/market/mypage/itrst/ctgry";
	}

	/**
	 * 사업소 찾기 모달
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="searchBplcModal")
	public String searchBplcModal(
			HttpServletRequest request
			, Model model) throws Exception {

		List<StdgCdVO> stdgCdList = stdgCdService.selectStdgCdListAll(1);


		model.addAttribute("stdgCdList", stdgCdList);
		model.addAttribute("bplcRstdeCode", CodeMap.BPLC_RSTDE);

		return "/market/mypage/itrst/include/search-bplc-modal";
	}

	/**
	 * 사업소 모달 내부 리스트
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="bplcListModal")
	@SuppressWarnings({"unchecked","rawtypes"})
	public String bplcListModal(
			@RequestParam(value="sido", required=false) String sido
			, @RequestParam(value="gugun", required=false) String gugun
			, @RequestParam(value="srchText", required=false) String srchText
			, HttpServletRequest request
			, Model model
			) throws Exception {
		// 내 관심 사업소
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());

		List<ItrstVO> itemList = itrstService.selectItrstListAll(paramMap);


		// 전체 사업소 리스트
		CommonListVO listVO = new CommonListVO(request);

		if(EgovStringUtil.isNotEmpty(sido)) {
			paramMap.put("stdgCode", sido);
			StdgCdVO stdgCdVO = stdgCdService.selectStdgCd(paramMap);
			listVO.setParam("srchSido", stdgCdVO.getCtpvNm().substring(0, 2));
		}

		listVO.setParam("srchGugun", gugun);
		listVO.setParam("srchBplcNm", srchText);
		listVO.setParam("srchAprvTy", "C");
		listVO.setParam("srchUseYn", "Y");
		listVO = bplcService.bplcListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("itemList", itemList);
		model.addAttribute("bplcRstdeCode", CodeMap.BPLC_RSTDE);


		return "/market/mypage/itrst/include/bplc-list-modal";
	}

	/**
	 * 관심 사업소 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="insertItrstBplc.json")
	@SuppressWarnings({"unchecked","rawtypes"})
	@ResponseBody
	public Map<String, Object> insertItrstBplc(
			HttpServletRequest request
			, Model model
			, @RequestParam(value="arrUniqueId", required=true) String[] uniqueIds
			)throws Exception {

		Map<String, Object> resultMap = new HashMap();
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());
		paramMap.put("srchItrstTy", "B");
		int result = 0; // 실패


		List <ItrstVO> itemList = itrstService.selectItrstListAll(paramMap);
		if((5 - itemList.size()) >= uniqueIds.length ) {

				ItrstVO itrstVO = new ItrstVO();
				itrstVO.setRegId(mbrSession.getMbrId());
				itrstVO.setRegUniqueId(mbrSession.getUniqueId());
				itrstVO.setRgtr(mbrSession.getMbrNm());

				for(int i=0; i<uniqueIds.length; i++) {
					if(itemList.size() > 0) {
						// 중복 검사
						if(!uniqueIds[i].equals(itemList.get(i))) {
							itrstVO.setBplcUniqueId(uniqueIds[i]);
							itrstVO.setItrstTy("B"); //사업소 : B, 카테고리 : C
							itrstService.insertItrst(itrstVO);
						}
					}else {
						itrstVO.setBplcUniqueId(uniqueIds[i]);
						itrstVO.setItrstTy("B"); //사업소 : B, 카테고리 : C
						itrstService.insertItrst(itrstVO);
					}
				}

				result = 1; // 성공

		}else {
			result = 2; // 개수 실패
		}

		resultMap.put("result", result);

		return resultMap;
	}

	/**
	 * 관심 사업소 삭제
	 * @return resultMap
	 */
	@RequestMapping(value="deleteItrstBplc.json")
	@ResponseBody
	@SuppressWarnings({"rawtypes","unchecked"})
	public Map<String, Object> resultMap(
			HttpServletRequest request
			, Model model
			, @RequestParam(value="uniqueId", required=true) String uniqueId
			)throws Exception{

		Map<String, Object> resultMap = new HashMap();

		Map<String, Object> paramMap = new HashMap();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());
		paramMap.put("srchBplcUniqueId", uniqueId);
		paramMap.put("srchItrstTy", "B");


		boolean result = false;

		try {
			itrstService.deleteItrst(paramMap);

			result = true;
		}catch(Exception e) {
			e.printStackTrace();
			log.debug("DELETE ITRST BPLC ERROR");
		}

		resultMap.put("result", result);
		return resultMap;
	}

	/**
	 * 관심 카테고리 등록, 삭제
	 * @param ctgryNo
	 * @param type
	 * @return resultMap
	 */
	@RequestMapping(value="itrstCategory.json")
	@ResponseBody
	@SuppressWarnings({"rawtypes","unchecked"})
	public Map<String, Object> categoryMap(
			HttpServletRequest request
			, Model model
			, @RequestParam(value="ctgryNo", required=true) int ctgryNo
			, @RequestParam(value="type", required=true) String type
			)throws Exception{

		Map<String, Object> resultMap = new HashMap();

		boolean result = false;

		ItrstVO itrstVO = new ItrstVO();

		// 사용자 정보
		itrstVO.setRegId(mbrSession.getMbrId());
		itrstVO.setRegUniqueId(mbrSession.getUniqueId());
		itrstVO.setRgtr(mbrSession.getMbrNm());
		itrstVO.setCtgryNo(ctgryNo);
		itrstVO.setItrstTy("C"); // B: 사업소 , C:카테고리


		switch(type) {

			case "INSERT" :

				itrstService.insertItrst(itrstVO);
				result = true;

			break;

			case "DELETE" :

				Map<String, Object> paramMap = new HashMap();
				paramMap.put("srchUniqueId", mbrSession.getUniqueId());
				paramMap.put("srchItrstTy", "C");
				paramMap.put("srchCtgryNo", ctgryNo);

				itrstService.deleteItrst(paramMap);
				result = true;

			break;


			default:
				break;
		}

		resultMap.put("result", result);
		return resultMap;
	}
}
