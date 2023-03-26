package icube.manage.sysmng.wrd.biz;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("mngWrdService")
public class MngWrdService extends CommonAbstractServiceImpl {

	@Resource(name="mngWrdDAO")
	private MngWrdDAO mngWrdDAO;

	public CommonListVO selectMngWrdListVO(CommonListVO listVO) throws Exception {
		return mngWrdDAO.selectMngWrdListVO(listVO);
	}

	public MngWrdVO selectMngWrd(int wrdNo) throws Exception{
		return mngWrdDAO.selectMngWrd(wrdNo);
	}

	public MngWrdVO selectMngWrdNm(String wrdNm) throws Exception {
		return mngWrdDAO.selectMngWrdNm(wrdNm);
	}

	public void insertMngWrd(MngWrdVO mngWrdVO) throws Exception {
		mngWrdDAO.insertMngWrd(mngWrdVO);
	}

	public void updateMngWrd(MngWrdVO mngWrdVO) throws Exception {
		mngWrdDAO.updateMngWrd(mngWrdVO);
	}

}