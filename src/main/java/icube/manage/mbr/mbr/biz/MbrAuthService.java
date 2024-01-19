package icube.manage.mbr.mbr.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.security.crypto.bcrypt.BCrypt;
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
	
	/*
	 * 삭제된 인증까지 포함 조회용
	 */
	public List<MbrAuthVO> selectMbrAuthListAllWithDelete(Map<String, Object> paramMap) throws Exception {
		return mbrAuthDAO.selectMbrAuthListAllWithDelete(paramMap);
	}
	public List<MbrAuthVO> selectMbrAuthWithDelete(String uniqueId) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("srchMbrUniqueId", uniqueId);
		return selectMbrAuthListAllWithDelete(paramMap);
	}
	
	public void deleteMbrAuthByNo(int authNo) throws Exception {
		mbrAuthDAO.deleteMbrAuthByNo(authNo);
	}
	public void deleteMbrAuthByUniqueId(String mbrUniqueId) throws Exception {
		mbrAuthDAO.deleteMbrAuthByUniqueId(mbrUniqueId);
	}
	
	/**
	 * 이로움 인증 수단 생성 함수
	 */
	public Map<String, Object> registEroumAuth(MbrVO mbrVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", false);
		
		String idChk = "^[a-zA-Z][A-Za-z0-9]{5,14}$";
		String pswdChk = "^.*(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+*=*]).*$";
		
		try {
			mbrVO.setJoinTy("E");
			
			String id = mbrVO.getMbrId();
			String pswd = mbrVO.getPswd();
			
			if (EgovStringUtil.isEmpty(id) || EgovStringUtil.isEmpty(pswd)) {
				resultMap.put("msg", "아이디 또는 패스워드가 입력되지 않았습니다");
				return resultMap;
			}
			
			if (id.length() >= 6 && id.length() <= 15 && !id.matches(idChk)) {
				resultMap.put("msg", "6~15자 영문,숫자를 조합해 주세요");
				return resultMap;
			}
			if (pswd.length() >= 8 && pswd.length() <= 16 && !pswd.matches(pswdChk)) {
				resultMap.put("msg", "8~16자 영문,숫자,특수문자를 조합해 주세요");
				return resultMap;
			}
			
			MbrAuthVO eroumAuth = selectMbrAuthByMbrId(id);
			if (eroumAuth != null) {
				resultMap.put("msg", "이미 사용 중인 아이디입니다");
				resultMap.put("existId", true);
				return resultMap;
			}
			
			List<MbrAuthVO> authList = selectMbrAuthByMbrUniqueId(mbrVO.getUniqueId());
			MbrAuthVO eroumAuthInfo = authList.stream().filter(f -> "E".equals(f.getJoinTy())).findAny().orElse(null);
			if (eroumAuthInfo != null) {
				resultMap.put("msg", "이미 이로움 계정이 등록되었습니다");
				return resultMap;
			}
			
			//패스워드 암호화
			String encPswd = BCrypt.hashpw(mbrVO.getPswd(), BCrypt.gensalt());
			mbrVO.setPswd(encPswd);
			
			//인증 수단 추가
			insertMbrAuthWithMbrVO(mbrVO);
			
		} catch (Exception ex) {
			resultMap.put("msg", "이로움 인증정보 등록중 오류가 발생하였습니다");
			return resultMap;
		}
		
		resultMap.put("success", true);
		return resultMap;
	}
	
}
