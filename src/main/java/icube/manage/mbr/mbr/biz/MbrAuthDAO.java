package icube.manage.mbr.mbr.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("mbrAuthDAO")
public class MbrAuthDAO extends CommonAbstractMapper {
	
	public List<MbrAuthVO> selectMbrAuthListAll(Map<String, Object> paramMap) throws Exception {
		return selectList("mbr.auth.selectMbrAuth", paramMap);
	}
	
	public MbrAuthVO selectMbrAuthByMbrUniqueId(String uniqueId) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("srchMbrUniqueId", uniqueId);
		return selectOne("mbr.auth.selectMbrAuth", paramMap);
	}
	
	public void insertMbrAuth(MbrAuthVO mbrAuthVO) throws Exception {
		insert("mbr.auth.insertMbrAuth", mbrAuthVO);
	}
}
