package icube.manage.sysmng.entrps.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;
import icube.manage.gds.gds.biz.GdsDAO;
import icube.manage.gds.gds.biz.GdsVO;

@Service("entrpsDlvyGrpService")
public class EntrpsDlvyGrpService extends CommonAbstractServiceImpl {


	@Resource(name="gdsDAO")
	private GdsDAO gdsDAO;

	@Resource(name="entrpsDlvyGrpDAO")
	private EntrpsDlvyGrpDAO entrpsDlvyGrpDAO;

	public CommonListVO entrpsDlvyGrpListVO(CommonListVO listVO) throws Exception {
		return entrpsDlvyGrpDAO.entrpsDlvyGrpListVO(listVO);
	}

	public EntrpsVO selectEntrpsDlvyGrp(int entrpsNo) throws Exception {
		return entrpsDlvyGrpDAO.selectEntrpsDlvyGrp(entrpsNo);
	}
	
	public EntrpsDlvyGrpVO selectEntrpsDlvyGrpByNo(int entrpsDlvygrpNo) throws Exception {
		return entrpsDlvyGrpDAO.selectEntrpsDlvyGrpByNo(entrpsDlvygrpNo);
	}

	public void insertEntrpsDlvyGrp(EntrpsDlvyGrpVO entrpsDlvygrpVO) throws Exception {
		entrpsDlvyGrpDAO.insertEntrpsDlvyGrp(entrpsDlvygrpVO);
	}

	public void updateEntrpsDlvyGrp(EntrpsDlvyGrpVO entrpsDlvygrpVO) throws Exception {
		entrpsDlvyGrpDAO.updateEntrpsDlvyGrp(entrpsDlvygrpVO);
	}

	public void deleteEntrpsDlvyGrp(EntrpsDlvyGrpVO entrpsDlvygrpVO) throws Exception {
		

		entrpsDlvyGrpDAO.deleteEntrpsDlvyGrp(entrpsDlvygrpVO);

		GdsVO gdsVO = new GdsVO();

		gdsVO.setEntrpsNo(entrpsDlvygrpVO.getEntrpsNo());
		gdsVO.setEntrpsDlvygrpNo(entrpsDlvygrpVO.getEntrpsDlvygrpNo());
		gdsVO.setMdfcnUniqueId(entrpsDlvygrpVO.getMdfcnUniqueId());
		gdsVO.setMdfcnId(entrpsDlvygrpVO.getMdfcnId());
		gdsVO.setMdfr(entrpsDlvygrpVO.getMdfr());

		gdsDAO.updateGdsByDlvygrpResetAll(gdsVO);
	}

}