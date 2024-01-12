package icube.manage.mbr.mbr.biz;

import java.util.HashMap;
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
	
	public List<MbrAuthVO> selectMbrAuthByMbrUniqueId(String uniqueId) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("srchMbrUniqueId", uniqueId);
		return selectMbrAuthListAll(paramMap);
	}
	
	public MbrAuthVO selectMbrAuthByMbrId(String mbrId) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("srchMbrId", mbrId);
		return mbrAuthDAO.selectMbrAuthOne(paramMap);
	}
	
	public void insertMbrAuth(MbrAuthVO mbrAuthVO) throws Exception {
		mbrAuthDAO.insertMbrAuth(mbrAuthVO);
	}
}
