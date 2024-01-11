package icube.manage.mbr.mbr.biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;

@Service("mbrAuthService")
public class MbrAuthService extends CommonAbstractServiceImpl {
	
	@Resource(name="mbrAuthDAO")
	private MbrAuthDAO mbrAuthDAO;
	
	public List<MbrAuthVO> selectMbrAuthListAll(Map<String, Object> paramMap) throws Exception {
		return mbrAuthDAO.selectMbrAuthListAll(paramMap);
	}
	
	public MbrAuthVO selectMbrAuthByMbrUniqueId(String uniqueId) throws Exception {
		return mbrAuthDAO.selectMbrAuthByMbrUniqueId(uniqueId);
	}
	
	public void insertMbrAuth(MbrAuthVO mbrAuthVO) throws Exception {
		mbrAuthDAO.insertMbrAuth(mbrAuthVO);
	}
}
