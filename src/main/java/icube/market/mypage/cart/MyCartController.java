package icube.market.mypage.cart;

import java.util.HashMap;
import java.util.List;
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
import icube.common.util.WebUtil;
import icube.common.values.CodeMap;
import icube.manage.mbr.itrst.biz.CartService;
import icube.manage.mbr.itrst.biz.CartVO;
import icube.manage.ordr.ordr.biz.OrdrVO;
import icube.market.mbr.biz.MbrSession;

@Controller
@RequestMapping(value = "#{props['Globals.Market.path']}/mypage/cart")
public class MyCartController extends CommonAbstractController  {

	@Resource(name = "cartService")
	private CartService cartService;

	@Autowired
	private MbrSession mbrSession;

	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchCartTy", "R"); // 급여주문 상품
		paramMap.put("srchRecipterUniqueId", mbrSession.getUniqueId());

		List<CartVO> rResultList = cartService.selectCartListAll(paramMap);
		model.addAttribute("rResultList", rResultList);

		paramMap.clear();
		paramMap.put("srchCartTy", "N"); // 비급여주문 상품
		paramMap.put("srchRecipterUniqueId", mbrSession.getUniqueId());
		List<CartVO> nResultList = cartService.selectCartListAll(paramMap);
		model.addAttribute("nResultList", nResultList);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("gdsTagCode", CodeMap.GDS_TAG);

		return "/market/mypage/cart/list";
	}




	@ResponseBody
	@RequestMapping(value="putCart.json")
	public Map<String, Object> putCart(
			OrdrVO ordrVO
			, @RequestParam(value="ordrTy", required=true) String ordrTy
			, @RequestParam(value="gdsNo", required=true) String gdsNo
			, @RequestParam(value="gdsCd", required=true) String gdsCd
			, @RequestParam(value="bnefCd", required=true) String bnefCd
			, @RequestParam(value="gdsNm", required=true) String gdsNm
			, @RequestParam(value="gdsPc", required=true) String gdsPc

			, @RequestParam(value="gdsOptnNo", required=false) String gdsOptnNo
			, @RequestParam(value="ordrOptnTy", required=true) String ordrOptnTy
			, @RequestParam(value="ordrOptn", required=true) String ordrOptn
			, @RequestParam(value="ordrOptnPc", required=true) String ordrOptnPc
			, @RequestParam(value="ordrQy", required=true) String ordrQy

			, @RequestParam(value="recipterUniqueId", required=false) String recipterUniqueId
			, @RequestParam(value="bplcUniqueId", required=false) String bplcUniqueId
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;
		String resultMsg = "SUCCESS";
		int totalCnt = 0;

		// STEP.1 선택된 보호자 장바구니 > 동일상품 + 동일옵션이 있는지 체크 (추가옵션 제외)
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchCartTy", ordrTy);
		paramMap.put("srchGdsNo", gdsNo.split(",")[0]);
		paramMap.put("srchOrdrOptn", ordrOptn.split(",")[0]);
		paramMap.put("srchRecipterUniqueId", mbrSession.getUniqueId());
		//paramMap.put("srchUniqueId", mbrSession.getUniqueId());

		CartVO chkCartVO = cartService.selectCartByFilter(paramMap);
		if(chkCartVO != null) {
			result = true;
			resultMsg = "ALREADY";

		} else {
			// STEP.2 저장
			int cartGrpNo = 0;
			String[] spGdsNo = gdsNo.split(",");
			for(int i=0;i < spGdsNo.length;i++) {
				CartVO cartVO = new CartVO();
				cartVO.setCartGrpNo(cartGrpNo);
				cartVO.setCartTy(ordrTy); //유형 (R/N)
				cartVO.setGdsNo(EgovStringUtil.string2integer(gdsNo.split(",")[i].trim()));
				cartVO.setGdsCd(gdsCd.split(",")[i].trim());
				if(bnefCd.split(",").length > 0) { // bnefCd null일수 있음 > 비급여 주문
					cartVO.setBnefCd(bnefCd.split(",")[i].trim());
				}else {
					cartVO.setBnefCd("");
				}
				cartVO.setGdsNm(gdsNm.split(",")[i].trim());
				cartVO.setGdsPc(EgovStringUtil.string2integer(gdsPc.split(",")[i].trim()));
				cartVO.setGdsOptnNo(EgovStringUtil.string2integer(gdsOptnNo.split(",")[0].trim()));
				cartVO.setOrdrOptnTy(ordrOptnTy.split(",")[i].trim());
				cartVO.setOrdrOptn(ordrOptn.split(",")[i].trim());
				cartVO.setOrdrOptnPc(EgovStringUtil.string2integer(ordrOptnPc.split(",")[i].trim()));
				cartVO.setOrdrQy(EgovStringUtil.string2integer(ordrQy.split(",")[i].trim()));

				cartVO.setRecipterUniqueId(mbrSession.getUniqueId());
				cartVO.setBplcUniqueId(EgovStringUtil.isEmpty(bplcUniqueId)?null:bplcUniqueId);

				int ordrPc = (cartVO.getGdsPc() +  cartVO.getOrdrOptnPc()) * cartVO.getOrdrQy();
				cartVO.setOrdrPc(ordrPc);

				cartVO.setRegUniqueId(mbrSession.getUniqueId());
				cartVO.setRegId(mbrSession.getMbrId());
				cartVO.setRgtr(mbrSession.getMbrNm());

				//System.out.println("cartVO: " + cartVO.toString());

				Integer resultCnt = cartService.insertCart(cartVO);
				if("BASE".equals(cartVO.getOrdrOptnTy())) {
					cartGrpNo = cartVO.getCartNo();
				}

				totalCnt = totalCnt + resultCnt;

			}

			if(totalCnt == spGdsNo.length){
				result = true;
			}
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("totalCnt", totalCnt);
		return resultMap;
	}


	/**
	 * 장바구니 삭제
	 */
	@ResponseBody
	@RequestMapping(value="removeCart.json")
	public Map<String, Object> putCart(
			@RequestParam(value="cartGrpNos[]", required=true) String[] cartGrpNos
			, @RequestParam(value="cartTy", required=true) String cartTy
			, @RequestParam(value="recipterUniqueId", required=true) String recipterUniqueId
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {
		boolean result = false;

		try {
			// 장바구니 삭제
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("srchCartGrpNos", cartGrpNos);
			paramMap.put("srchCartTy", cartTy);
			paramMap.put("srchRecipterUniqueId", recipterUniqueId);
			cartService.deleteCart(paramMap);

			result = true;
		} catch (Exception e) {
			// TODO: handle exception
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}

	// 장바구니 옵션변경 모달
	@RequestMapping(value="cartOptnModal")
	public String cartOptnModal(
			@RequestParam(value="cartGrpNo", required=true) String cartGrpNo
			, Model model
			)throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchCartGrpNo", EgovStringUtil.string2integer(cartGrpNo));
		List<CartVO> cartList = cartService.selectCartListAll(paramMap);

		model.addAttribute("cartList", cartList);
		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);

		return "/market/mypage/cart/include/modal_optn_chg";
	}

	/**
	 * 옵션 항목/수량 변경
	 */
	@ResponseBody
	@RequestMapping(value="optnChgSave.json")
	public Map<String, Object> optnChgSave(
			@RequestParam(value="cartNo", required=true) String cartNo
			, @RequestParam(value="cartGrpNo", required=true) String cartGrpNo
			, @RequestParam(value="cartTy", required=true) String cartTy
			, @RequestParam(value="gdsNo", required=true) String gdsNo
			, @RequestParam(value="gdsCd", required=true) String gdsCd
			, @RequestParam(value="bnefCd", required=true) String bnefCd
			, @RequestParam(value="gdsNm", required=true) String gdsNm
			, @RequestParam(value="gdsPc", required=true) String gdsPc

			, @RequestParam(value="gdsOptnNo", required=true) String gdsOptnNo
			, @RequestParam(value="ordrOptnTy", required=true) String ordrOptnTy
			, @RequestParam(value="ordrOptn", required=true) String ordrOptn
			, @RequestParam(value="ordrOptnPc", required=true) String ordrOptnPc
			, @RequestParam(value="ordrQy", required=true) String ordrQy

			, @RequestParam(value="recipterUniqueId", required=false) String recipterUniqueId
			, @RequestParam(value="bplcUniqueId", required=false) String bplcUniqueId

			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request) throws Exception {

		boolean result = false;
		Integer resultCnt = 0;

		try {
			for(int i=0;i < cartNo.split(",").length;i++) {
				CartVO cartVO = new CartVO();
				cartVO.setCartNo(EgovStringUtil.string2integer(cartNo.split(",")[i]));
				cartVO.setCartGrpNo(EgovStringUtil.string2integer(cartGrpNo));
				cartVO.setCartTy(cartTy);
				cartVO.setGdsNo(EgovStringUtil.string2integer(gdsNo));
				cartVO.setGdsCd(gdsCd);
				cartVO.setGdsNm(gdsNm);
				cartVO.setGdsPc(EgovStringUtil.string2integer(gdsPc));
				cartVO.setOrdrOptnTy(ordrOptnTy.split(",")[i]);
				cartVO.setOrdrOptn(ordrOptn.split(",")[i]);
				cartVO.setGdsOptnNo(EgovStringUtil.string2integer(gdsOptnNo.split(",")[i].trim()));
				cartVO.setOrdrOptnPc(EgovStringUtil.string2integer(ordrOptnPc.split(",")[i]));
				cartVO.setOrdrQy(EgovStringUtil.string2integer(ordrQy.split(",")[i]));

				// 급여코드
				if(bnefCd.split(",").length > 0) { // bnefCd null일수 있음
					cartVO.setBnefCd(bnefCd.split(",")[i]);
				}else {
					cartVO.setBnefCd("");
				}

				// 수혜자
				if(recipterUniqueId.split(",").length > 0) {
					cartVO.setRecipterUniqueId(recipterUniqueId.split(",")[i]);
				} else {
					cartVO.setRecipterUniqueId(null);
				}

				// 사업소
				if(bplcUniqueId.split(",").length > 0) {
					cartVO.setBplcUniqueId(bplcUniqueId.split(",")[i]);
				} else {
					cartVO.setBplcUniqueId("");
				}

				int ordrPc = 0;
				if(cartVO.getOrdrOptnTy().equals("BASE")) {
					ordrPc = (cartVO.getGdsPc() +  cartVO.getOrdrOptnPc()) * cartVO.getOrdrQy();
				}else {
					ordrPc = cartVO.getOrdrOptnPc() * cartVO.getOrdrQy();
				}
				cartVO.setOrdrPc(ordrPc);

				cartVO.setRegUniqueId(mbrSession.getUniqueId());
				cartVO.setRegId(mbrSession.getMbrId());
				cartVO.setRgtr(mbrSession.getMbrNm());

				resultCnt += cartService.modifyOptnChg(cartVO);

			}

			// 삭제
			String delCartNos = WebUtil.clearSqlInjection((String) reqMap.get("delCartNos"));
			String[] arrDelCartNo = delCartNos.split(",");
			if(arrDelCartNo.length > 0) {
				cartService.deleteCartlByNos(arrDelCartNo);
			}

			result = true;

		} catch (Exception e) {
			result = false;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}

}
