package icube.app.matching.membership.mbr.biz;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.manage.mbr.mbr.biz.MbrAppSettingDAO;
import icube.manage.mbr.mbr.biz.MbrAppSettingVO;
import icube.manage.mbr.mbr.biz.MbrAuthService;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;

@Service("matMbrService")
public class MatMbrService extends CommonAbstractServiceImpl {
	
	@Resource(name = "mbrService")
	private MbrService mbrService;
	
	@Resource(name = "mbrAuthService")
	private MbrAuthService mbrAuthService;
	
	@Resource(name = "mbrAppSettingDAO")
	private MbrAppSettingDAO mbrAppSettingDAO;
	
	@Autowired
	private MatMbrSession matMbrSession;
	
	/**
	 * 매칭앱 설정값 가져오기
	 */
	public MbrAppSettingVO selectMbrAppSettingByMbrUniqueId(String uniqueId) throws Exception {
		return mbrAppSettingDAO.selectMbrAppSettingByMbrUniqueId(uniqueId);
	}
	
	/**
	 * 매칭앱 설정 등록
	 */
	public void insertMbrAppSetting(MbrAppSettingVO mbrAppSettingVO) throws Exception {
		mbrAppSettingDAO.insertMbrAppSetting(mbrAppSettingVO);
	}
	
	/**
	 * 매칭앱 설정 수정
	 */
	public void updateMbrAppSetting(MbrAppSettingVO mbrAppSettingVO) throws Exception {
		mbrAppSettingDAO.updateMbrAppSetting(mbrAppSettingVO);
	}
	
	/**
	 * sns 회원정보와 회원 바인딩 처리(세션에 저장된 임시 회원을 바인딩 처리)
	 */
	public Map<String, Object> bindMbrWithTempMbr(HttpSession session) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", false);
		
		//비정상적인 요청 차단
		if (matMbrSession == null || EgovStringUtil.isEmpty(matMbrSession.getUniqueId()) || matMbrSession.isLoginCheck() == true) {
			resultMap.put("msg", "잘못된 접근입니다.");
			return resultMap;
		}
		
		//회원 조회
		try {
			MbrVO srchMbrVO = mbrService.selectMbrByUniqueId(matMbrSession.getUniqueId());
			if (srchMbrVO == null) {
				resultMap.put("msg", "연결할 계정이 존재하지 않습니다.");
				return resultMap;
			}
			
			//로그인할 때 외부에서 받은 회원 정보(임시 세션)
			MbrVO tempMbrVO = matMbrSession;
			
			//회원 인증정보 등록
			mbrAuthService.insertMbrAuthWithMbrVO(tempMbrVO);
			
			//최근 접속일 갱신
			mbrService.updateRecentDtAndLgnTy(srchMbrVO.getUniqueId(), srchMbrVO, tempMbrVO.getJoinTy());
			
			//로그인 처리
			matMbrSession.login(session, srchMbrVO);
			
		} catch (Exception ex) {
			log.error("------- 앱 계정연결 오류 ---------", ex);
			resultMap.put("msg", "계정 연결중 오류가 발생하였습니다.");
			return resultMap;
		}
		
		resultMap.put("success", true);
		return resultMap;
	}
}
