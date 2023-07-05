package icube.manage.exhibit.banner.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("bnnrMngService")
public class BnnrMngService extends CommonAbstractServiceImpl {

	@Resource(name="bnnrMngDAO")
	private BnnrMngDAO bnnrMngDAO;

	public CommonListVO bnnrMngListVO(CommonListVO listVO) throws Exception {
		return bnnrMngDAO.bnnrMngListVO(listVO);
	}

	public BnnrMngVO selectBnnrMng(int bnnrMngNo) throws Exception {
		return bnnrMngDAO.selectBnnrMng(bnnrMngNo);
	}

	public void insertBnnrMng(BnnrMngVO bnnrMngVO) throws Exception {
		bnnrMngDAO.insertBnnrMng(bnnrMngVO);
	}

	public void updateBnnrMng(BnnrMngVO bnnrMngVO) throws Exception {
		bnnrMngDAO.updateBnnrMng(bnnrMngVO);
	}

	public Integer updateBnnrUseYn(int bannerNo)  throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("useYn", "N");
		paramMap.put("srchBannerNo", bannerNo);
		return bnnrMngDAO.updateBnnrUseYn(paramMap);
	}

	public Integer updateSortNo(Map<String, Object> paramMap) throws Exception {
		return bnnrMngDAO.updateSortNo(paramMap);
	}

	public List<BnnrMngVO> selectBnnrMngList(Map<String, Object> paramMap) throws Exception {
		return bnnrMngDAO.selectBnnrMngList(paramMap);
	}
}