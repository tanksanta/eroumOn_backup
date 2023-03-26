package icube.manage.mbr.itrst.biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("wishService")
public class WishService extends CommonAbstractServiceImpl {

	@Resource(name="wishDAO")
	private WishDAO wishDAO;

	public CommonListVO selectWishListVO(CommonListVO listVO) throws Exception {
		return wishDAO.selectWishListVO(listVO);
	}

	public WishVO selectWish(Map<String, Object> paramMap) throws Exception {
		return wishDAO.selectWish(paramMap);
	}

	public void insertWish(WishVO wishVO) throws Exception {
		wishDAO.insertWish(wishVO);
	}

	public void deleteWish(Map<String, Object> paramMap) throws Exception {
		wishDAO.deleteWish(paramMap);
	}

	public void deleteWishByGdsNo(WishVO wishVO) throws Exception {
		wishDAO.deleteWishByGdsNo(wishVO);
	}

	public List<WishVO> selectWishListAll(Map<String, Object> paramMap) throws Exception {
		return wishDAO.selectWishListAll(paramMap);
	}

}
