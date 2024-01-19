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
	
	/*
	 * 삭제된 인증까지 포함 조회용
	 */
	public List<MbrAuthVO> selectMbrAuthListAllWithDelete(Map<String, Object> paramMap) throws Exception {
		return selectList("mbr.auth.selectMbrAuthWithDelete", paramMap);
	}
	
	/**
	 * 삭제 여부를 업데이트만 진행
	 */
	public void deleteMbrAuthByNo(int authNo) throws Exception {
		MbrAuthVO paramAuthVO = new MbrAuthVO();
		paramAuthVO.setAuthNo(authNo);
		update("mbr.auth.deleteMbrAuth", paramAuthVO);
	}
	public void deleteMbrAuthByUniqueId(String mbrUniqueId) throws Exception {
		MbrAuthVO paramAuthVO = new MbrAuthVO();
		paramAuthVO.setMbrUniqueId(mbrUniqueId);
		update("mbr.auth.deleteMbrAuth", paramAuthVO);
	}
}
