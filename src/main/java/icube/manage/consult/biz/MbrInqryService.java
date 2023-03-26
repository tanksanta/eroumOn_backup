package icube.manage.consult.biz;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("mbrInqryService")
public class MbrInqryService extends CommonAbstractServiceImpl {

	@Resource(name="mbrInqryDAO")
	private MbrInqryDAO mbrInqryDAO;

	public CommonListVO mbrInqryListVO(CommonListVO listVO) throws Exception {
		return mbrInqryDAO.mbrInqryListVO(listVO);
	}

	public MbrInqryVO selectMbrInqry(int mbrInqryNo) throws Exception {
		return mbrInqryDAO.selectMbrInqry(mbrInqryNo);
	}

	public void insertMbrInqry(MbrInqryVO mbrInqryVO) throws Exception {
		mbrInqryDAO.insertMbrInqry(mbrInqryVO);
	}

	public void updateMbrInqry(MbrInqryVO mbrInqryVO) throws Exception {
		mbrInqryDAO.updateMbrInqry(mbrInqryVO);
	}

	public void updateAnsInqry(MbrInqryVO mbrInqryVO) throws Exception {
		mbrInqryDAO.updateAnsInqry(mbrInqryVO);
	}

	public void deleteInqry(int inqryNo) throws Exception {
		mbrInqryDAO.deleteInqry(inqryNo);
	}

}