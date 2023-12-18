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

@Service("entrpsDlvygrpService")
public class EntrpsDlvygrpService extends CommonAbstractServiceImpl {

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

	public void deleteEntrpsDlvyGrp(int entrpsNo, int entrpsDlvygrpNo) throws Exception {
		entrpsDlvygrpDAO.deleteEntrpsDlvyGrp(entrpsNo, entrpsDlvygrpNo);

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("entrpsNo", entrpsNo);
		paramMap.put("entrpsDlvygrpNo", entrpsDlvygrpNo);

		gdsDAO.updateGdsDlvygrpReset(paramMap);
	}

}