package icube.manage.sysmng.entrps.biz;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("entrpsService")
public class EntrpsService extends CommonAbstractServiceImpl {

	@Resource(name="entrpsDAO")
	private EntrpsDAO entrpsDAO;

	public CommonListVO entrpsListVO(CommonListVO listVO) throws Exception {
		return entrpsDAO.entrpsListVO(listVO);
	}

	public EntrpsVO selectEntrps(int entrpsNo) throws Exception {
		return entrpsDAO.selectEntrps(entrpsNo);
	}

	public void insertEntrps(EntrpsVO entrpsVO) throws Exception {
		entrpsDAO.insertEntrps(entrpsVO);
	}

	public void updateEntrps(EntrpsVO entrpsVO) throws Exception {
		entrpsDAO.updateEntrps(entrpsVO);
	}

}