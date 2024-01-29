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
	
	public MbrAuthVO selectMbrAuthOne(Map<String, Object> paramMap) throws Exception {
		return selectOne("mbr.auth.selectMbrAuth", paramMap);
	}
	
	public void insertMbrAuth(MbrAuthVO mbrAuthVO) throws Exception {
		insert("mbr.auth.insertMbrAuth", mbrAuthVO);
	}
	
	public void updatePswd(int authNo, String pswd) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("authNo", authNo);
		paramMap.put("pswd", pswd);
		update("mbr.auth.updatePswd", paramMap);
	}
	
	public void updateSnsInfo(int authNo, String eml, String mblTelno, String ciKey, String accessToken, String refreshToken) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("authNo", authNo);
		paramMap.put("eml", eml);
		paramMap.put("mblTelno", mblTelno);
		paramMap.put("ciKey", ciKey);
		paramMap.put("accessToken", accessToken);
		paramMap.put("refreshToken", refreshToken);
		update("mbr.auth.updateSnsInfo", paramMap);
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
