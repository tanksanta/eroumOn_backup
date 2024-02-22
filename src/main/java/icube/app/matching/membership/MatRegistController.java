package icube.app.matching.membership;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.app.matching.membership.mbr.biz.MatMbrSession;
import icube.common.framework.abst.CommonAbstractController;
import icube.manage.mbr.mbr.biz.MbrAgreementVO;
import icube.manage.mbr.mbr.biz.MbrAuthVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 매칭앱 - 일반 회원가입
 */
@Controller
@RequestMapping(value="#{props['Globals.Matching.path']}/membership")
public class MatRegistController extends CommonAbstractController {
	
	@Resource(name = "mbrService")
	private MbrService mbrService;
	
	@Autowired
	private MbrSession mbrSession;
	
	@Autowired
	private MatMbrSession matMbrSession;
	
	@Value("#{props['Globals.Matching.path']}")
	private String matchingPath;
	
	@Value("#{props['Bootpay.Script.Key']}")
	private String bootpayScriptKey;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;
	
	
	@ResponseBody
	@RequestMapping(value="regist.json")
	public Map<String, Object> regist(
			@RequestBody MbrAgreementVO mbrAgreementVO
			, HttpServletRequest request
			, HttpSession session) throws Exception {
		
		Map <String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", false);
		
		//SNS 정보
		MbrVO tempMbrVO = (MbrVO)mbrSession;
		
		//본인인증 정보
		MbrVO certMbrInfoVO = (MbrVO)session.getAttribute("certMbrInfoVO");
		
		if (tempMbrVO == null || certMbrInfoVO == null) {
			resultMap.put("msg", "잘못된 요청입니다.");
			return resultMap;
		}
		
		
		//바인딩 회원 체크
		MbrAuthVO checkAuthVO = new MbrAuthVO();
		checkAuthVO.setJoinTy(tempMbrVO.getJoinTy());
		checkAuthVO.setNaverAppId(tempMbrVO.getNaverAppId());
		checkAuthVO.setKakaoAppId(tempMbrVO.getKakaoAppId());
		checkAuthVO.setCiKey(certMbrInfoVO.getCiKey());
		Map<String, Object> checkMap = mbrService.checkDuplicateMbrForRegist(checkAuthVO, certMbrInfoVO.getDiKey());
		
		if ((boolean)checkMap.get("valid") == false) {
			//계정 연결 안내 페이지 이동
			if (checkMap.containsKey("bindingMbr")) {
				MbrVO bindingMbr = (MbrVO) checkMap.get("bindingMbr");
				certMbrInfoVO.setUniqueId(bindingMbr.getUniqueId());
				certMbrInfoVO.setJoinTy(tempMbrVO.getJoinTy());
				certMbrInfoVO.setNaverAppId(tempMbrVO.getNaverAppId());
				certMbrInfoVO.setKakaoAppId(tempMbrVO.getKakaoAppId());
				certMbrInfoVO.setEml(tempMbrVO.getEml());
				
				matMbrSession.setProperty(certMbrInfoVO);
				matMbrSession.setLoginCheck(false);
				
				resultMap.put("success", true);
				resultMap.put("location", "/matching/membership/binding");
				return resultMap;
			}
			
			resultMap.put("msg", (String)checkMap.get("msg"));
			return resultMap;
		}
		
		
		//회원가입 처리
		Date now = new Date();
		tempMbrVO.setCiKey(certMbrInfoVO.getCiKey());
		tempMbrVO.setDiKey(certMbrInfoVO.getDiKey());
		tempMbrVO.setMbrNm(certMbrInfoVO.getMbrNm());
		tempMbrVO.setMblTelno(certMbrInfoVO.getMblTelno());
		tempMbrVO.setGender(certMbrInfoVO.getGender());
		tempMbrVO.setBrdt(certMbrInfoVO.getBrdt());
		tempMbrVO.setSnsRegistDt(new Date());
		
		//마켓팅 약관 수신동의 일시 sms, 이메일, 전화, 푸시 수신허용
		if ("Y".equals(mbrAgreementVO.getMarketingReceptionYn())) {
			tempMbrVO.setSmsRcptnYn("Y");
			tempMbrVO.setSmsRcptnDt(now);
			tempMbrVO.setEmlRcptnYn("Y");
			tempMbrVO.setEmlRcptnDt(now);
			tempMbrVO.setTelRecptnYn("Y");
			tempMbrVO.setTelRecptnDt(now);
			tempMbrVO.setPushRecptnYn("Y");
			tempMbrVO.setPushRecptnDt(now);
		}
		
		tempMbrVO.setMbrId("");
		mbrService.insertMbr(tempMbrVO);
		
		
		//회원가입 후 부가정보 등록
		mbrAgreementVO.setTermsDt(now);
		mbrAgreementVO.setPrivacyDt(now);
		mbrAgreementVO.setMarketingReceptionDt(now);
		mbrAgreementVO.setNightReceptionDt(now);
		mbrService.workAfterMbrRegist(tempMbrVO, mbrAgreementVO);
		

		// 최근 접속 일시 업데이트
		mbrService.updateRecentDtAndLgnTy(tempMbrVO.getUniqueId(), tempMbrVO, tempMbrVO.getJoinTy());
		
		//로그인처리
		matMbrSession.login(session, tempMbrVO);
		
		
		resultMap.put("success", true);
		session.setAttribute("returnUrl", "/matching/common/complete?msg=회원가입이<br>완료되었어요&redirectUrl=/matching");
		resultMap.put("location", "/matching/membership/loginAfterAction");
		return resultMap;
	}
}
