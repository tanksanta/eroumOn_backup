package icube.manage.mbr.itrst.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("cartDAO")
public class CartDAO extends CommonAbstractMapper {

	public CommonListVO selectMbrCartListVO(CommonListVO listVO) throws Exception {
		return selectListVO("mbr.cart.selectMbrCartCount","mbr.cart.selectMbrCartListVO",listVO);
	}

	public List<CartVO> selectCartListAll(Map<String, Object> paramMap) throws Exception {
		return selectList("mbr.cart.selectCartListAll", paramMap);
	}

	public int selectCartCount(Map<String, Object> paramMap) throws Exception {
		return selectOne("mbr.cart.selectCartCount", paramMap);
	}

	public CartVO selectCartByFilter(Map<String, Object> paramMap) throws Exception {
		return selectOne("mbr.cart.selectCartByFilter", paramMap);
	}

	public int insertCart(CartVO cartVO) throws Exception {
		return insert("mbr.cart.insertCart", cartVO);
	}

	public void updateCart(CartVO cartVO) throws Exception {
		update("mbr.cart.updateCart", cartVO);
	}

	public void deleteCart(Map<String, Object> paramMap) throws Exception {
		delete("mbr.cart.deleteCart", paramMap);
	}

}
