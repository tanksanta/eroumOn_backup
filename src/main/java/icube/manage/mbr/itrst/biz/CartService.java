package icube.manage.mbr.itrst.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;
import icube.manage.gds.gds.biz.GdsVO;
import icube.manage.gds.optn.biz.GdsOptnService;
import icube.manage.gds.optn.biz.GdsOptnVO;

@Service("cartService")
public class CartService extends CommonAbstractServiceImpl {

	@Resource(name="cartDAO")
	private CartDAO cartDAO;

	@Resource(name = "gdsOptnService")
	private GdsOptnService gdsOptnService;

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

	public void updateMbrCart(GdsVO gdsVO) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchGdsCode", gdsVO.getGdsCd());

		List<CartVO> cartList = selectCartListAll(paramMap);

		for(CartVO cartVO : cartList) {
			int optnPc = 0;
			int optnAditPc = 0;

			paramMap.clear();
			paramMap.put("srchGdsOptnNo", cartVO.getGdsOptnNo());
			paramMap.put("srchUseYn", "Y");
			GdsOptnVO gdsOptnVO = gdsOptnService.selectGdsOptn(paramMap);


			//TODO 옵션 세팅
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
	}

}
