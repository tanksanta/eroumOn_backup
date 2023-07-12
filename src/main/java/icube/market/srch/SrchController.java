package icube.market.srch;

import java.util.HashMap;
import java.util.Map;

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
import icube.common.vo.CommonListVO;
import icube.manage.gds.gds.biz.GdsService;
import icube.manage.gds.gds.biz.GdsVO;
import icube.market.mbr.biz.MbrSession;

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

	@Autowired
	private MbrSession mbrSession;

	// 검색 컨테이너 호출
	@RequestMapping(value = {"index", "total"})
	public String search(
			@RequestParam(required=false, value="srchKwd") String srchKwd
			, HttpServletRequest request
			, HttpServletResponse response
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("curPage", "1");
		paramMap.put("cntPerPage", "12");
		paramMap.put("srchKwd", srchKwd);
		listVO = srchListVO(request, paramMap);
		
		model.addAttribute("listVO", listVO);

		return "/market/srch/total";
	}



	// 상품 검색
	public CommonListVO srchListVO(
			HttpServletRequest request
			, Map<String, Object> reqMap
			)throws Exception {
		
		CommonListVO listVO = new CommonListVO(request);

		int curPage = EgovStringUtil.string2integer((String) reqMap.get("curPage"), 1);
		int cntPerPage = EgovStringUtil.string2integer((String) reqMap.get("cntPerPage"), 12);
		
		listVO.setParam("curPage", curPage);
		listVO.setParam("cntPerPage", cntPerPage);
		listVO.setParam("srchUseYn", "Y");
		listVO.setParam("srchDspyYn", "Y");
		listVO.setParam("srchTempYn", "N");
		
		if(mbrSession.isLoginCheck()){ // 로그인 > 위시리스트 여부
			listVO.setParam("uniqueId", mbrSession.getPrtcrRecipterInfo().getUniqueId());
		}
		
		String [] srchKwd = {};
		if(EgovStringUtil.isNotEmpty((String)reqMap.get("srchKwd"))) {
			String kwd = (String)reqMap.get("srchKwd");
			srchKwd = EgovStringUtil.getStringArray(kwd, " ");
			listVO.setParam("srchKwd", srchKwd);
		}
		
		listVO = gdsService.gdsListVO(listVO);

		for(Object o : listVO.getListObject()) { // 상품태그 처리
			GdsVO temp = (GdsVO) o;
			if(EgovStringUtil.isNotEmpty(temp.getGdsTagVal())) {
				temp.setGdsTag(ArrayUtil.stringToArray(temp.getGdsTagVal()));
			}
		}
		
		return listVO;
	}
	
	// 상품 리스트
	@RequestMapping(value = "srchList")
	public String srchList(
			HttpServletRequest request
			, Model model
			, @RequestParam Map<String, Object>reqMap
			)throws Exception {
	
		CommonListVO listVO = srchListVO(request, reqMap);
		
		model.addAttribute("listVO", listVO);
		
		return "/market/gds/include/srch_list";
	}


}
