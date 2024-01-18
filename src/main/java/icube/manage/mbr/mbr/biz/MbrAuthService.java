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
	
	public MbrAuthVO selectMbrAuthByKakaoAppId(String kakaoAppId) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("srchKakaoAppId", kakaoAppId);
		return mbrAuthDAO.selectMbrAuthOne(paramMap);
	}
	
	public MbrAuthVO selectMbrAuthByNaverAppId(String naverAppId) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("srchNaverAppId", naverAppId);
		return mbrAuthDAO.selectMbrAuthOne(paramMap);
	}
	
	public void insertMbrAuth(MbrAuthVO mbrAuthVO) throws Exception {
		mbrAuthDAO.insertMbrAuth(mbrAuthVO);
	}
	
	public void insertMbrAuthWithMbrVO(MbrVO mbrVO) throws Exception {
		//회원 인증정보 등록
		MbrAuthVO mbrAuthVO = new MbrAuthVO();
		mbrAuthVO.setMbrUniqueId(mbrVO.getUniqueId());
		mbrAuthVO.setJoinTy(mbrVO.getJoinTy());
		mbrAuthVO.setMbrId(mbrVO.getMbrId());
		mbrAuthVO.setPswd(mbrVO.getPswd());
		mbrAuthVO.setNaverAppId(mbrVO.getNaverAppId());
		mbrAuthVO.setKakaoAppId(mbrVO.getKakaoAppId());
		mbrAuthVO.setEml(mbrVO.getEml());
		mbrAuthVO.setMblTelno(mbrVO.getMblTelno());
		mbrAuthVO.setCiKey(mbrVO.getCiKey());
		insertMbrAuth(mbrAuthVO);
	}
	
	public void deleteMbrAuthByNo(int authNo) throws Exception {
		mbrAuthDAO.deleteMbrAuthByNo(authNo);
	}
	public void deleteMbrAuthByUniqueId(String mbrUniqueId) throws Exception {
		mbrAuthDAO.deleteMbrAuthByUniqueId(mbrUniqueId);
	}
}
