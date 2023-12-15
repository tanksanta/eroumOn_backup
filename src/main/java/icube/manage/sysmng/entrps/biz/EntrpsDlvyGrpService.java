package icube.manage.sysmng.entrps.biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("entrpsDlvyGrpService")
public class EntrpsDlvyGrpService extends CommonAbstractServiceImpl {

	@Resource(name="entrpsDlvyGrpDAO")
	private EntrpsDlvyGrpDAO entrpsDlvyGrpDAO;

	public CommonListVO entrpsDlvyGrpListVO(CommonListVO listVO) throws Exception {
		return entrpsDlvyGrpDAO.entrpsDlvyGrpListVO(listVO);
	}

	public EntrpsVO selectEntrpsDlvyGrp(int entrpsNo) throws Exception {
		return entrpsDlvyGrpDAO.selectEntrpsDlvyGrp(entrpsNo);
	}
	
	// public EntrpsVO selectEntrpsDlvyGrpByGdsNo(int gdsNo) throws Exception {
	// 	return entrpsDlvyGrpDAO.selectEntrpsDlvyGrpByGdsNo(gdsNo);
	// }

	// public void insertEntrpsDlvyGrp(EntrpsVO entrpsVO) throws Exception {
	// 	entrpsDlvyGrpDAO.insertEntrpsDlvyGrp(entrpsVO);
	// }

	// public void updateEntrps(EntrpsVO entrpsVO) throws Exception {
	// 	entrpsDlvyGrpDAO.updateEntrps(entrpsVO);
	// }

	public List<EntrpsVO> selectEntrpsDlvyGrpListAll(Map<String, Object> paramMap) throws Exception{
		return entrpsDlvyGrpDAO.selectEntrpsDlvyGrpListAll(paramMap);
	}

}