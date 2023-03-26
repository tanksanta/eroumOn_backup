package icube.manage.exhibit.ad.biz;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("adverMngService")
public class AdverMngService extends CommonAbstractServiceImpl {

	@Resource(name="adverMngDAO")
	private AdverMngDAO adverMngDAO;

	public CommonListVO adverMngListVO(CommonListVO listVO) throws Exception {
		return adverMngDAO.adverMngListVO(listVO);
	}

	public AdverMngVO selectAdverMng(int adverMngNo) throws Exception {
		return adverMngDAO.selectAdverMng(adverMngNo);
	}

	public void insertAdverMng(AdverMngVO adverMngVO) throws Exception {
		adverMngDAO.insertAdverMng(adverMngVO);
	}

	public void updateAdverMng(AdverMngVO adverMngVO) throws Exception {
		adverMngDAO.updateAdverMng(adverMngVO);
	}
}