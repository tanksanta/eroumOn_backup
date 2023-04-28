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

}
