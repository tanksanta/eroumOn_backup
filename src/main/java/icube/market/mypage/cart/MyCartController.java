package icube.market.mypage.cart;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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

import com.fasterxml.jackson.databind.ObjectMapper;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.DateUtil;
import icube.common.util.WebUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.manage.mbr.itrst.biz.CartService;
import icube.manage.mbr.itrst.biz.CartVO;
import icube.manage.ordr.ordr.biz.OrdrVO;
import icube.manage.sysmng.entrps.biz.EntrpsDlvyBaseCtVO;
import icube.manage.sysmng.entrps.biz.EntrpsDlvyGrpVO;
import icube.manage.sysmng.entrps.biz.EntrpsService;
import icube.manage.sysmng.entrps.biz.EntrpsVO;
import icube.market.mbr.biz.MbrSession;

@Controller
@RequestMapping(value = "#{props['Globals.Market.path']}/mypage/cart")
public class MyCartController extends CommonAbstractController  {

	@Resource(name = "cartService")
	private CartService cartService;

	@Resource(name = "entrpsService")
	private EntrpsService entrpsService;
	
	@Autowired
	private MbrSession mbrSession;
	
	ObjectMapper objectMapper = new ObjectMapper();
	

	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		Map<String, Object> paramMap;
		
		paramMap = new HashMap<String, Object>();
		paramMap.put("srchViewYn", "N");
		paramMap.put("srchEndDt", DateUtil.formatDate(DateUtil.getDateAdd(new Date(), "date", -5), "yyyy-MM-dd")); 
		paramMap.put("srchRecipterUniqueId", mbrSession.getUniqueId());
		List<CartVO> list = cartService.selectCartListAll(paramMap);
		if (list.size() > 0){
			String[] arrCartGrpNo = new String[list.size()];
			int ifor, ilen = list.size();
			for(ifor=0 ; ifor<ilen ; ifor++){
				arrCartGrpNo[ifor] = String.valueOf(list.get(ifor).getCartGrpNo());
			}
			paramMap = new HashMap<String, Object>();
			paramMap.put("srchCartGrpNos", arrCartGrpNo);/*사용자 한테 안 보이는 항목 삭제*/
			paramMap.put("srchRecipterUniqueId", mbrSession.getUniqueId());
			cartService.deleteCart(paramMap);
		}

		paramMap = new HashMap<String, Object>();
		paramMap.put("srchCartTy", "R"); // 급여주문 상품
		paramMap.put("srchViewYn", "Y");
		paramMap.put("srchRecipterUniqueId", mbrSession.getUniqueId());

		List<CartVO> rResultList = cartService.selectCartListAll(paramMap);
		model.addAttribute("rResultList", rResultList);

		paramMap.clear();
		paramMap.put("srchCartTy", "N"); // 비급여주문 상품
		paramMap.put("srchViewYn", "Y");
		paramMap.put("reCalcPcYn", "Y");
		paramMap.put("srchRecipterUniqueId", mbrSession.getUniqueId());
		List<CartVO> nResultList = cartService.selectCartListAll(paramMap);
		model.addAttribute("nResultList", nResultList);

		//입점업체 배송 정보(기본 배송료를 알기 위해 사용)
		paramMap.clear();
		List<Integer> entrpsNoList = nResultList.stream()
				.map(g -> g.getGdsInfo().getEntrpsNo())
				.distinct()
				.collect(Collectors.toList());
		paramMap.put("srchEntrpsNos", entrpsNoList);
		List<EntrpsVO> entrpsList = entrpsService.selectEntrpsListAll(paramMap);
		
		List<EntrpsDlvyBaseCtVO> entrpsDlvyList = entrpsList.stream()
				.filter(e -> entrpsNoList.contains(e.getEntrpsNo()))
				.map(e -> new EntrpsDlvyBaseCtVO(e.getEntrpsNo(), e.getDlvyCtCnd(), e.getDlvyBaseCt()))
				.collect(Collectors.toList());
		String json = objectMapper.writeValueAsString(entrpsDlvyList);
		model.addAttribute("entrpsDlvyList", json);
		
		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("gdsTagCode", CodeMap.GDS_TAG);

		
		paramMap.clear();
		paramMap.put("srchViewYn", "Y");
		paramMap.put("srchRecipterUniqueId", mbrSession.getUniqueId());
		List<EntrpsDlvyGrpVO> entrpsDlvyGrpVOList = cartService.selectCartDlvygrpListAll(paramMap);
		List<EntrpsVO> entrpsVOList = cartService.selectCartEntrpsListAll(paramMap);

		ObjectMapper mapper  = new ObjectMapper();
		String tempString;
		tempString =  mapper.writeValueAsString(rResultList);
		model.addAttribute("cartListWelfareJson", tempString);

		tempString =  mapper.writeValueAsString(nResultList);
		model.addAttribute("cartListOrdrJson", tempString);

		tempString =  mapper.writeValueAsString(entrpsVOList);
		model.addAttribute("entrpsVOListJson", tempString);

		tempString =  mapper.writeValueAsString(entrpsDlvyGrpVOList);
		model.addAttribute("entrpsDlvyGrpVOListJson", tempString);

		Map<String, Object> codeMap = new HashMap<String, Object>();
		codeMap.put("gdsTyCode", CodeMap.GDS_TY);
		tempString =  mapper.writeValueAsString(codeMap);
		model.addAttribute("codeMapJson", tempString);

		return "/market/mypage/cart/list2";
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

			, @RequestParam(value="viewYn", required=false) String viewYn

			, @RequestParam(value="recipterUniqueId", required=false) String recipterUniqueId
			, @RequestParam(value="bplcUniqueId", required=false) String bplcUniqueId
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;
		String resultMsg = "SUCCESS";
		int totalCnt = 0;
		List<Integer> cartNos = new ArrayList<Integer>();

		// STEP.1 선택된 보호자 장바구니 > 동일상품 + 동일옵션이 있는지 체크 (추가옵션 제외)
		
		//paramMap.put("srchUniqueId", mbrSession.getUniqueId());

		List<CartVO> chkCartVO = null;

		if (EgovStringUtil.isEmpty(viewYn)){
			viewYn = "Y";
		}

		if (EgovStringUtil.equals(viewYn, "Y")){
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("srchCartTy", ordrTy);
			paramMap.put("srchViewYn", viewYn);
			paramMap.put("srchGdsNo", gdsNo.split(",")[0]);
			paramMap.put("srchRecipterUniqueId", mbrSession.getUniqueId());
			
			chkCartVO = cartService.selectCartByFilter2(paramMap);
		}
		
		int cartGrpNo = 0;
		if (chkCartVO != null && chkCartVO.size() > 0) cartGrpNo = chkCartVO.get(0).getCartGrpNo();
		
		// STEP.2 저장
		String[] spGdsNo = gdsNo.split(",");
		for(int i=0;i < spGdsNo.length;i++) {
			CartVO cartVO;
			int tempGdsOptnNo;

			tempGdsOptnNo = EgovStringUtil.string2integer(gdsOptnNo.split(",")[i].trim());

			List<CartVO> cartSearchedList = null;
			if (chkCartVO != null){
				cartSearchedList = chkCartVO.stream()
				.filter(t -> EgovStringUtil.equals(ordrTy, t.getCartTy()) 
							&& tempGdsOptnNo == t.getGdsOptnNo()
						)
				.collect(Collectors.toList());
			}
			
			
			if (cartSearchedList != null && cartSearchedList.size() > 0){
				cartVO = cartSearchedList.get(0);
				cartVO.setCrud(CRUD.UPDATE);
			}else{
				cartVO = new CartVO();
				cartVO.setCrud(CRUD.CREATE);

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
				
				cartVO.setGdsOptnNo(tempGdsOptnNo);
				cartVO.setOrdrOptnTy(ordrOptnTy.split(",")[i].trim());
				cartVO.setOrdrOptn(ordrOptn.split(",")[i].trim());
				cartVO.setGdsPc(EgovStringUtil.string2integer(gdsPc.split(",")[i].trim()));

					
				cartVO.setViewYn(viewYn);

				cartVO.setRecipterUniqueId(mbrSession.getUniqueId());
				
				cartVO.setBplcUniqueId(EgovStringUtil.isEmpty(bplcUniqueId)?null:bplcUniqueId);
				cartVO.setOrdrOptnPc(EgovStringUtil.string2integer(ordrOptnPc.split(",")[i].trim()));
			}

			
			cartVO.setOrdrQy(cartVO.getOrdrQy() + EgovStringUtil.string2integer(ordrQy.split(",")[i].trim()));

			int ordrPc = (cartVO.getGdsPc() +  cartVO.getOrdrOptnPc()) * cartVO.getOrdrQy();
			cartVO.setOrdrPc(ordrPc);

			cartVO.setRegUniqueId(mbrSession.getUniqueId());
			cartVO.setRegId(mbrSession.getMbrId());
			cartVO.setRgtr(mbrSession.getMbrNm());

			//System.out.println("cartVO: " + cartVO.toString());
			Integer resultCnt;
			if (cartVO.getCrud() == CRUD.CREATE){
				resultCnt = cartService.insertCart(cartVO);
			}else{
				resultCnt = 1;
				cartService.updateCartQy(cartVO);
			}
			
			if("BASE".equals(cartVO.getOrdrOptnTy()) && cartGrpNo == 0) {
				cartGrpNo = cartVO.getCartNo();
			}
			cartNos.add(cartVO.getCartNo());

			totalCnt = totalCnt + resultCnt;

		}

		if(totalCnt == spGdsNo.length){
			result = true;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("totalCnt", totalCnt);
		resultMap.put("cartNos", cartNos);
		resultMap.put("cartGrpNo", cartGrpNo);
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

	/**
	 * 장바구니 삭제
	 */
	@ResponseBody
	@RequestMapping(value="removeCartOptn.json")
	public Map<String, Object> removeCartOptn(
			@RequestParam(value="cartTy", required=true) String cartTy
			, @RequestParam(value="cartGrpNo", required=true) String cartGrpNo
			, @RequestParam(value="cartNo", required=true) String cartNo
			, @RequestParam(value="gdsOptnNo", required=true) String gdsOptnNo
			, @RequestParam(value="recipterUniqueId", required=true) String recipterUniqueId
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {
		boolean result = false;

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchCartNo", cartNo);
		paramMap.put("srchCartGrpNo", cartGrpNo);
		paramMap.put("srchCartTy", cartTy);
		paramMap.put("gdsOptnNo", gdsOptnNo);
		paramMap.put("srchRecipterUniqueId", recipterUniqueId);
		
		try {
			// 장바구니 옵션 삭제
			cartService.deleteCartOptn(paramMap);

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
		model.addAttribute("dlvyPayTyCode2", CodeMap.DLVY_PAY_TY2); 
		
		ObjectMapper mapper  = new ObjectMapper();
		String tempString;
		tempString =  mapper.writeValueAsString(cartList);
		model.addAttribute("cartListJson", tempString);

		return "/market/mypage/cart/include/modal_optn_chg2";
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
			, @RequestParam(value="bnefCd", required=false) String bnefCd//==>bnefCds으로 변경(공백인 경우 오류가 생겨서)
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
		
		String[] saBnefCds ;
		if (reqMap.get("bnefCds") != null){
			saBnefCds = reqMap.get("bnefCds").toString().split("!@#()");
		}else{
			saBnefCds = new String []{};
		}
		
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
				if(saBnefCds.length > 0) { // bnefCd null일수 있음
					cartVO.setBnefCd(saBnefCds[i]);
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
