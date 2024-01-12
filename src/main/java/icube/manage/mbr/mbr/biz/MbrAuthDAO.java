package icube.manage.mbr.mbr.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("mbrAuthDAO")
public class MbrAuthDAO extends CommonAbstractMapper {
	
	public List<MbrAuthVO> selectMbrAuthListAll(Map<String, Object> paramMap) throws Exception {
		return selectList("mbr.auth.selectMbrAuth", paramMap);
	}
	
	public MbrAuthVO selectMbrAuthOne(Map<String, Object> paramMap) throws Exception {
		return selectOne("mbr.auth.selectMbrAuth", paramMap);
	}
	
	public void insertMbrAuth(MbrAuthVO mbrAuthVO) throws Exception {
		insert("mbr.auth.insertMbrAuth", mbrAuthVO);
	}
}
