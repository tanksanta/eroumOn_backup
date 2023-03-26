package icube.manage.sysmng.brand.biz;

import java.util.List;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("brandDAO")
public class BrandDAO extends CommonAbstractMapper {

	public CommonListVO brandListVO(CommonListVO listVO) throws Exception {
		return selectListVO("brand.selectBrandCount", "brand.selectBrandListVO", listVO);
	}

	public BrandVO selectBrand(int brandNo) throws Exception {
		return (BrandVO)selectOne("brand.selectBrand", brandNo);
	}

	public BrandVO selectBrandNm(String brandNm) throws Exception {
		return selectOne("brand.selectBrandNm",brandNm);
	}

	public void insertBrand(BrandVO brandVO) throws Exception {
		insert("brand.insertBrand", brandVO);
	}

	public void updateBrand(BrandVO brandVO) throws Exception {
		update("brand.updateBrand", brandVO);
	}

	public List<BrandVO> selectBrandListAll() throws Exception {
		return selectList("brand.selectBrandListAll");
	}

}