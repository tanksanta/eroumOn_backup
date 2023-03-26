package icube.manage.mbr.itrst.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("wishDAO")
public class WishDAO extends CommonAbstractMapper {

	public CommonListVO selectWishListVO(CommonListVO listVO) throws Exception {
		return selectListVO("mbr.wish.selectWishCount", "mbr.wish.selectWishListVO", listVO);
	}

	public WishVO selectWish(Map<String, Object> paramMap) throws Exception {
		return selectOne("mbr.wish.selectWish", paramMap);
	}

	public void insertWish(WishVO wishVO) throws Exception {
		insert("mbr.wish.insertWish", wishVO);
	}

	public void deleteWish(Map<String, Object> paramMap) throws Exception {
		delete("mbr.wish.deleteWish", paramMap);
	}

	public void deleteWishByGdsNo(WishVO wishVO) throws Exception {
		delete("mbr.wish.deleteWishByGdsNo", wishVO);
	}

	public List<WishVO> selectWishListAll(Map<String, Object> paramMap) throws Exception {
		return selectList("mbr.wish.selectWishListAll",paramMap);
	}


}
