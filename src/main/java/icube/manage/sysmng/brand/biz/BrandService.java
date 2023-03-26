package icube.manage.sysmng.brand.biz;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("brandService")
public class BrandService extends CommonAbstractServiceImpl {

	@Resource(name="brandDAO")
	private BrandDAO brandDAO;

	public CommonListVO brandListVO(CommonListVO listVO) throws Exception {
		return brandDAO.brandListVO(listVO);
	}

	public BrandVO selectBrand(int brandNo) throws Exception {
		return brandDAO.selectBrand(brandNo);
	}

	public BrandVO selectBrandNm(String brandNm) throws Exception{
		return brandDAO.selectBrandNm(brandNm);
	}

	public void insertBrand(BrandVO brandVO) throws Exception {
		brandDAO.insertBrand(brandVO);
	}

	public void updateBrand(BrandVO brandVO) throws Exception {
		brandDAO.updateBrand(brandVO);
	}

	public List<BrandVO> selectBrandListAll() throws Exception {
		return brandDAO.selectBrandListAll();
	}

}