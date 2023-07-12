package icube.manage.sysmng.entrps.biz;

import java.util.List;
import java.util.Map;

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
	
	public EntrpsVO selectEntrpsByGdsNo(int gdsNo) throws Exception {
		return entrpsDAO.selectEntrpsByGdsNo(gdsNo);
	}

	public void insertEntrps(EntrpsVO entrpsVO) throws Exception {
		entrpsDAO.insertEntrps(entrpsVO);
	}

	public void updateEntrps(EntrpsVO entrpsVO) throws Exception {
		entrpsDAO.updateEntrps(entrpsVO);
	}

	public List<EntrpsVO> selectEntrpsListAll(Map<String, Object> paramMap) throws Exception{
		return entrpsDAO.selectEntrpsListAll(paramMap);
	}

}