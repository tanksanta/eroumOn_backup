package icube.manage.sysmng.entrps.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;
import icube.manage.gds.gds.biz.GdsDAO;
import icube.manage.gds.gds.biz.GdsVO;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Service("entrpsDlvygrpService")
public class EntrpsDlvygrpService extends CommonAbstractServiceImpl {

	@Autowired
	private MngrSession mngrSession;

	@Resource(name="gdsDAO")
	private GdsDAO gdsDAO;

	@Resource(name="entrpsDlvygrpDAO")
	private EntrpsDlvygrpDAO entrpsDlvygrpDAO;

	public CommonListVO entrpsDlvyGrpListVO(CommonListVO listVO) throws Exception {
		return entrpsDlvygrpDAO.entrpsDlvyGrpListVO(listVO);
	}

	public EntrpsVO selectEntrpsDlvyGrp(int entrpsNo) throws Exception {
		return entrpsDlvygrpDAO.selectEntrpsDlvyGrp(entrpsNo);
	}
	
	public EntrpsDlvygrpVO selectEntrpsDlvyGrpByNo(int entrpsDlvygrpNo) throws Exception {
		return entrpsDlvygrpDAO.selectEntrpsDlvyGrpByNo(entrpsDlvygrpNo);
	}

	public void insertEntrpsDlvyGrp(EntrpsDlvygrpVO entrpsDlvygrpVO) throws Exception {
		entrpsDlvygrpDAO.insertEntrpsDlvyGrp(entrpsDlvygrpVO);
	}

	public void updateEntrpsDlvyGrp(EntrpsDlvygrpVO entrpsDlvygrpVO) throws Exception {
		entrpsDlvygrpDAO.updateEntrpsDlvyGrp(entrpsDlvygrpVO);
	}

	public void deleteEntrpsDlvyGrp(EntrpsDlvygrpVO entrpsDlvygrpVO) throws Exception {
		

		entrpsDlvygrpDAO.deleteEntrpsDlvyGrp(entrpsDlvygrpVO);

		GdsVO gdsVO = new GdsVO();

		gdsVO.setEntrpsNo(entrpsDlvygrpVO.getEntrpsNo());
		gdsVO.setEntrpsDlvygrpNo(entrpsDlvygrpVO.getEntrpsDlvygrpNo());
		gdsVO.setMdfcnUniqueId(entrpsDlvygrpVO.getMdfcnUniqueId());
		gdsVO.setMdfcnId(entrpsDlvygrpVO.getMdfcnId());
		gdsVO.setMdfr(entrpsDlvygrpVO.getMdfr());

		gdsDAO.updateGdsByDlvygrpResetAll(gdsVO);
	}

}