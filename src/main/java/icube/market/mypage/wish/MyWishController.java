package icube.market.mypage.wish;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.vo.CommonListVO;
import icube.manage.mbr.itrst.biz.WishService;
import icube.manage.mbr.itrst.biz.WishVO;
import icube.market.mbr.biz.MbrSession;

@Controller
@RequestMapping(value = "#{props['Globals.Market.path']}/mypage/wish")
public class MyWishController extends CommonAbstractController {

	@Resource(name = "wishService")
	private WishService wishService;

	@Autowired
	private MbrSession mbrSession;

	/**
	 * 위시리스트 목록
	 */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		//listVO.setParam("srchUniqueId", mbrSession.getUniqueId());
		listVO.setParam("srchUniqueId", mbrSession.getPrtcrRecipterInfo().getUniqueId()); //가족계정
		listVO = wishService.selectWishListVO(listVO);

		model.addAttribute("listVO", listVO);

		return "/market/mypage/wish/list";
	}

	/**
	 * 위시리스트 저장
	 */
	@ResponseBody
	@RequestMapping(value="putWish.json")
	public Map<String, Object> putWish(
			@RequestParam(value="gdsNo", required=true) int gdsNo
			, @RequestParam(value="wishYn", required=true) String wishYn
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;
		String resultMsg = "FAIL";

		if(mbrSession.isLoginCheck()){
			WishVO wishVO = new WishVO();
			wishVO.setGdsNo(gdsNo);

			//wishVO.setUniqueId(mbrSession.getUniqueId());
			wishVO.setUniqueId(mbrSession.getPrtcrRecipterInfo().getUniqueId()); //가족계정

			wishVO.setRegUniqueId(mbrSession.getUniqueId());
			wishVO.setRegId(mbrSession.getMbrId());
			wishVO.setRgtr(mbrSession.getMbrNm());

			try {
				if(EgovStringUtil.equals("N", wishYn)) {
					wishService.insertWish(wishVO);

					result = true;
					resultMsg = "PUT";
				} else {
					wishService.deleteWishByGdsNo(wishVO);

					result = true;
					resultMsg = "REMOVE";
				}
			} catch (Exception e) {
				// TODO: handle exception
			}
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		return resultMap;
	}


	/**
	 * 위시리스트 선택/전체 삭제
	 */
	@ResponseBody
	@RequestMapping(value="removeWish.json")
	public Map<String, Object> putCart(
			@RequestParam(value="wishlistNos[]", required=true) String[] wishlistNos
			, @RequestParam(value="selTy", required=true) String selTy
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {

		boolean result = false;

		try {
			// 장바구니 삭제
			Map<String, Object> paramMap = new HashMap<String, Object>();
			if(!EgovStringUtil.equals("ALL", selTy)) {
				paramMap.put("srchWishlistNos", wishlistNos);
			}
			//paramMap.put("srchUniqueId", mbrSession.getUniqueId());
			paramMap.put("srchUniqueId", mbrSession.getPrtcrRecipterInfo().getUniqueId()); //가족계정

			wishService.deleteWish(paramMap);

			result = true;
		} catch (Exception e) {
			// TODO: handle exception
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}

}
