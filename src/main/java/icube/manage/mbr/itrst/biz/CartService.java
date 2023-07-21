package icube.manage.mbr.itrst.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("cartService")
public class CartService extends CommonAbstractServiceImpl {

	@Resource(name="cartDAO")
	private CartDAO cartDAO;

	public CommonListVO selectMbrCartListVO(CommonListVO listVO) throws Exception {
		return cartDAO.selectMbrCartListVO(listVO);
	}

	public List<CartVO> selectCartListAll(Map<String, Object> paramMap) throws Exception {
		return cartDAO.selectCartListAll(paramMap);
	}

	public CartVO selectCartByFilter(Map<String, Object> paramMap) throws Exception {
		return cartDAO.selectCartByFilter(paramMap);
	}

	public int insertCart(CartVO cartVO) throws Exception {
		return cartDAO.insertCart(cartVO);
	}

	public void deleteCart(Map<String, Object> paramMap) throws Exception {
		cartDAO.deleteCart(paramMap);
	}

	public Integer modifyOptnChg(CartVO cartVO) throws Exception{
		return cartDAO.modifyOptnChg(cartVO);
	}

	public void deleteCartlByNos(String[] arrDelCartNo) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("cartNos", arrDelCartNo);

		cartDAO.deleteCartlByNos(paramMap);
	}

	/*@SuppressWarnings("unchecked")
	public void updateMbrCart(Map<String, Object> cartMap) throws Exception {
		GdsVO gdsVO = (GdsVO) cartMap.get("gdsVO");
		List<GdsOptnVO> optnItemList = (List<GdsOptnVO>) cartMap.get("optnItemList");
		List<GdsOptnVO> aditOptnItemList = (List<GdsOptnVO>) cartMap.get("aditOptnItemList");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchGdsCode", gdsVO.getGdsCd());

		List<CartVO> cartList = selectCartListAll(paramMap);

		for(CartVO cartVO : cartList) {
			int optnPc = 0;
			int optnAditPc = 0;

			// 옵션 가격 계산 (BASE)
			for(GdsOptnVO gdsOptnVO : optnItemList) {
					optnPc += gdsOptnVO.getOptnPc();
			}

			// 옵션 가격 계산 (ADIT)
			for(GdsOptnVO gdsOptnVO : aditOptnItemList) {
					optnAditPc += gdsOptnVO.getOptnPc();
			}

			cartVO.setBnefCd(gdsVO.getBnefCd());
			cartVO.setGdsNm(gdsVO.getGdsNm());
			cartVO.setGdsPc(gdsVO.getPc());

			// 주문 가격
			if(cartVO.getOrdrOptnTy().equals("BASE")) {
				cartVO.setOrdrOptnPc(optnPc);
				cartVO.setOrdrPc((gdsVO.getPc() +  optnPc) * cartVO.getOrdrQy());
			}else {
				cartVO.setOrdrOptnPc(optnAditPc);
				cartVO.setOrdrPc((gdsVO.getPc() +  optnAditPc) * cartVO.getOrdrQy());
			}

			updateCart(cartVO);

		}
	}

	public void updateCart(CartVO cartVO) throws Exception {
		cartDAO.updateCart(cartVO);
	}*/

}
