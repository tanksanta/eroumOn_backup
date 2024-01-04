package icube.app.matching;

import java.security.PrivateKey;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.app.matching.mbr.biz.MatMbrSession;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.RSA;
import icube.common.util.WebUtil;
import icube.manage.mbr.mbr.biz.MbrMngInfoService;
import icube.manage.mbr.mbr.biz.MbrMngInfoVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;

@Controller
@RequestMapping(value="#{props['Globals.Matching.path']}")
public class MatLoginController extends CommonAbstractController {
	
	@Resource(name = "mbrService")
	private MbrService mbrService;
	
	@Resource(name = "mbrMngInfoService")
	private MbrMngInfoService mbrMngInfoService;
	
	@Autowired
	private MatMbrSession matMbrSession;
	
	@Value("#{props['Globals.Matching.path']}")
	private String matchingPath;
	
	private static final String RSA_MEMBERSHIP_KEY = "__rsaMembersKey__";
	
	
	@RequestMapping(value="login")
	public String login(
			HttpServletRequest request
			, HttpSession session) {
		
		//로그인되어 있다면 main으로 redirect
		if (matMbrSession.isLoginCheck()) {
			return "redirect:/" + matchingPath;
		}

		//암호화
		RSA rsa = RSA.getEncKey();
		request.setAttribute("publicKeyModulus", rsa.getPublicKeyModulus());
		request.setAttribute("publicKeyExponent", rsa.getPublicKeyExponent());
		session.setAttribute(RSA_MEMBERSHIP_KEY, rsa.getPrivateKey());
		
		return "/app/matching/login";
	}
	
	@ResponseBody
	@RequestMapping("loginAction")
	public Map<String, Object> action(
			@RequestParam String mbrId
			, @RequestParam String encPw  //RSA 암호화된 패스워드
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
	) throws Exception {
		Map <String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", false);
		
		try {
			PrivateKey rsaKey = (PrivateKey) session.getAttribute(RSA_MEMBERSHIP_KEY);
			String decPw = RSA.decryptRsa(rsaKey, encPw);
			if (EgovStringUtil.isEmpty(decPw)) {
				resultMap.put("msg", "패스워드 복호화에 실패하였습니다.");
				return resultMap;
			}
			
			mbrId = WebUtil.clearSqlInjection(mbrId);
			decPw = WebUtil.clearSqlInjection(decPw);
			
			MbrVO srchMbrVO = mbrService.selectMbrIdByOne(mbrId.toLowerCase());
			if (srchMbrVO == null) {
				resultMap.put("msg", "존재하지 않는 회원입니다.");
				return resultMap;
			}
			
			if ("EXIT".equals(srchMbrVO.getMberSttus())) {
				resultMap.put("msg", "탈퇴한 회원입니다.");
				return resultMap;
			}
			
			if ("HUMAN".equals(srchMbrVO.getMberSttus())) {
				resultMap.put("msg", "휴면 회원입니다.");
				return resultMap;
			}
			
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("srchUniqueId", srchMbrVO.getUniqueId());
			MbrMngInfoVO mbrMngInfoVO = mbrMngInfoService.selectMbrMngInfo(paramMap);
			if (mbrMngInfoVO != null && "BLACK".equals(mbrMngInfoVO.getMngTy()) && !"NONE".equals(mbrMngInfoVO.getMngSe())) {
				if ("PAUSE".equals(mbrMngInfoVO.getMngSe())) {
					resultMap.put("msg", "일시정지된 회원입니다.");
					return resultMap;
				}
				else if ("UNLIMIT".equals(mbrMngInfoVO.getMngSe())) {
					resultMap.put("msg", "영구정지된 회원입니다.");
					return resultMap;
				}
			}
			
			int failCount = srchMbrVO.getLgnFailrCnt();
			if (failCount > 4) {
				resultMap.put("msg", "비밀번호를 5회 이상 틀렸습니다.");
				return resultMap;
			}
			
			boolean passwordCheck = BCrypt.checkpw(decPw, srchMbrVO.getPswd());
			if (!passwordCheck) {
				int passCount = mbrService.getFailedLoginCountWithCountUp(srchMbrVO);
				resultMap.put("msg", "비밀번호가 일치 하지 않습니다.");
				return resultMap;
			}
			
			// 최근 접속 일시 업데이트
			mbrService.updateRecentDt(srchMbrVO.getUniqueId());
			
			//로그인 성공 시 실패 횟를 초기화
			mbrService.updateFailedLoginCountReset(srchMbrVO);
			
			//로그인 처리
			matMbrSession.login(session, srchMbrVO);
			resultMap.put("success", true);
		} catch (Exception ex) {
			resultMap.put("msg", "로그인 중 오류가 발생하였습니다.");
		}
		
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping("logoutAction")
	public Map<String, Object> logoutAction() {
		
		matMbrSession.logout();
		
		Map <String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", true);
		return resultMap;
	}
}
