package icube.app.matching.membership.info;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import icube.app.matching.membership.mbr.biz.MatMbrService;
import icube.app.matching.membership.mbr.biz.MatMbrSession;
import icube.common.api.biz.BootpayApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.manage.mbr.mbr.biz.MbrAppSettingVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.sysmng.terms.TermsService;
import icube.manage.sysmng.terms.TermsVO;

/**
 * 회원정보 수정
 */
@Controller
@RequestMapping(value="#{props['Globals.Matching.path']}/membership/info")
public class MatMbrInfoController extends CommonAbstractController{
	
	@Resource(name = "mbrService")
	private MbrService mbrService;
	
	@Resource(name = "matMbrService")
	private MatMbrService matMbrService;
	
	@Resource(name = "bootpayApiService")
	private BootpayApiService bootpayApiService;
	
	@Resource(name = "termsService")
	private TermsService termsService;
	
	@Autowired
	private MatMbrSession matMbrSession;
	
	
	/**
	 * 회원 본인인증 페이지 이동
	 */
	@RequestMapping(value = "identityVerification")
	public String identityVerification(
			@RequestParam String type //본인인증 후 해야할 작업타입
			, Model model) throws Exception {
		//이용약관 history List
		List<TermsVO> termsHisList = termsService.selectListMemberVO("TERMS");
		
		//개인정보 history List
		List<TermsVO> privacyHisList = termsService.selectListMemberVO("PRIVACY");
		
		model.addAttribute("type", type);
		model.addAttribute("termsHisList", termsHisList);
		model.addAttribute("privacyHisList", privacyHisList);
		
		return "/app/matching/membership/info/identityVerification";
	}
	
	/**
	 * 본인인증 요청
	 */
	@ResponseBody
	@RequestMapping("requestVerification")
	public Map<String, Object> requestVerification(
			@RequestParam String name, 
			@RequestParam String identityNo, 
			@RequestParam String carrier,
			@RequestParam String phone) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		String receiptId = "aaa";
		//String receiptId = bootpayApiService.requestAuthentication("홍길동", "9901091", "LGT_MVNO", "01011112222");
		if (EgovStringUtil.isNotEmpty(receiptId)) {
			resultMap.put("success", true);
			resultMap.put("receiptId", receiptId);
		}
		else {
			resultMap.put("success", false);
		}
		return resultMap;
	}
	
	/**
	 * 본인인증 OTP 재전송
	 */
	@ResponseBody
	@RequestMapping("realarmVerification")
	public Map<String, Object> realarmVerification(
			@RequestParam String receiptId) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		boolean success = true;
		//boolean success = bootpayApiService.realarmAuthentication(receiptId);
		resultMap.put("success", success);
		return resultMap;
	}
	
	/**
	 * 본인인증 확인
	 */
	@ResponseBody
	@RequestMapping("confirmVerification")
	public Map<String, Object> confirmVerification(
		@RequestParam String receiptId,
		@RequestParam String otpNum,
		HttpSession session) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		MbrVO certMbrInfoVO = new MbrVO();
		certMbrInfoVO.setCiKey("a");
		certMbrInfoVO.setDiKey("b");
		certMbrInfoVO.setMbrNm("홍길동");
		certMbrInfoVO.setBrdt(new Date(2001, 1, 2));
		certMbrInfoVO.setGender("W");
		certMbrInfoVO.setMblTelno("010-1234-2134");
		
		//MbrVO certMbrInfoVO = bootpayApiService.confirmAuthentication(receiptId, otpNum);
		if (certMbrInfoVO != null) {
			session.setAttribute("certMbrInfoVO", certMbrInfoVO);
			resultMap.put("success", true);
		}
		else {
			resultMap.put("success", false);
		}
		
		return resultMap;
	}
	
	/**
	 * 앱에서 받은 지도 및 푸시 알림 정보 저장
	 */
	@ResponseBody
	@RequestMapping("updatePermissionInfo")
	public Map<String, Object> updatePermissionInfo(
		@RequestParam String permissionInfoJson
	) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", true);
		
		try {
			
			if (matMbrSession.isLoginCheck() == false) {
				return resultMap;
			}
			
			boolean isInsert = false;
			MbrAppSettingVO appSetting = matMbrService.selectMbrAppSettingByMbrUniqueId(matMbrSession.getUniqueId());
			if (appSetting == null) {
				isInsert = true;
				appSetting = new MbrAppSettingVO();
				appSetting.setMbrUniqueId(matMbrSession.getUniqueId());
			}
			
			
			String jsonStr = HtmlUtils.htmlUnescape(permissionInfoJson);
			JsonElement element = JsonParser.parseString(jsonStr);
			
			JsonElement pushPermission = element.getAsJsonObject().get("pushPermission");
			if (pushPermission != null && pushPermission.isJsonNull() == false) {
				boolean isAllow = pushPermission.getAsJsonObject().get("allow").getAsBoolean();
				
				//push 토큰 정보 저장
				if (isAllow) {
					String pushToken = pushPermission.getAsJsonObject().get("pushToken").getAsString();
					appSetting.setPushToken(pushToken);
				}
				
				appSetting.setAllowPushYn(isAllow ? "Y" : "N");
				appSetting.setAllowPushDt(new Date());
			}
			
			JsonElement locationPermission = element.getAsJsonObject().get("locationPermission");
			if (locationPermission != null && locationPermission.isJsonNull() == false) {
				boolean isAllow = locationPermission.getAsJsonObject().get("allow").getAsBoolean();
				
				//위치 정보 저장
				if (isAllow) {
					String latitude = locationPermission.getAsJsonObject().get("latitude").getAsString();
					String longitude = locationPermission.getAsJsonObject().get("longitude").getAsString();
					mbrService.updateMbrLocation(matMbrSession.getUniqueId(), latitude, longitude);
				}
				
				appSetting.setAllowLocationYn(isAllow ? "Y" : "N");
				appSetting.setAllowLocationDt(new Date());
			}
			
			//앱 설정 회원에 반영하기
			if (isInsert) {
				appSetting.setAutoLgnYn("Y");
				appSetting.setAutoLgnDt(new Date());
				matMbrService.insertMbrAppSetting(appSetting);
			} else {
				matMbrService.updateMbrAppSetting(appSetting);
			}
			
		} catch (Exception ex) {
			log.error("========앱 접근 권한 정보 업데이트 오류 : ", ex);
		}
		
		return resultMap;
	}
}
