package icube.app.matching.common.api;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.google.gson.internal.LinkedTreeMap;

import icube.common.util.DateUtil;
import icube.manage.mbr.mbr.biz.MbrVO;
import kr.co.bootpay.Bootpay;
import kr.co.bootpay.model.request.Authentication;

/**
 * 다날인증 소켓형 전용 서비스
 */
@Service("bootpaySocketService")
public class BootpaySocketService {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Value("#{props['Bootpay.Socket.Private.Key']}")
	private String bootpayPrivateKey;

	@Value("#{props['Bootpay.Socket.Rest.Key']}")
	private String bootpayRestKey;
	
	
	/**
	 * API 방식으로 본인인증(다날) 요청
	 */
	public String requestAuthentication(String name, String identityNo, String carrier, String phone) {
		Bootpay bootpay = new Bootpay(bootpayRestKey, bootpayPrivateKey);
		
		try {
			Authentication authentication = new Authentication();
			authentication.pg = "다날";
			authentication.method = "본인인증";
			authentication.username = name;
			authentication.identityNo = identityNo;  //생년월일 + 주민번호 뒷 1자리
			authentication.carrier = carrier;  //SKT, KT, LGT, SKT_MVNO, KT_MVNO, LGT_MVNO
			authentication.phone = phone;
			authentication.siteUrl = "https://eroum.co.kr";
			authentication.authenticationId = "CERT00000000001";
			authentication.orderName = "본인인증";
			
			bootpay.getAccessToken();
			
			HashMap<String, Object> res = bootpay.requestAuthentication(authentication);
			if (res.get("error_code") == null) {
				return (String)res.get("receipt_id");
			}
		} catch (Exception ex) {
			log.debug("====== API 다날 인증 오류", ex);
		}
		return null;
	}
	
	/**
	 * API 방식으로 본인인증 OTP 재전송 요청
	 */
	public boolean realarmAuthentication(String receiptId) {
		Bootpay bootpay = new Bootpay(bootpayRestKey, bootpayPrivateKey);
		
		try {
			bootpay.getAccessToken();
			
			HashMap<String, Object> res = bootpay.realarmAuthentication(receiptId);
			if(res.get("error_code") == null) {
		        return true;
		    }
		} catch (Exception ex) {
			log.debug("====== 본인인증 OPT 재전송 오류", ex);
		}
		return false;
	}
	
	/**
	 * API 방식으로 본인인증 확인
	 */
	@SuppressWarnings("unchecked")
	public MbrVO confirmAuthentication(String receiptId, String otp) {
		Bootpay bootpay = new Bootpay(bootpayRestKey, bootpayPrivateKey);
		
		try {
			bootpay.getAccessToken();
			
			HashMap<String, Object> res = bootpay.confirmAuthentication(receiptId, otp);
			if(res.get("error_code") == null) {
				MbrVO certMbrInfoVO = new MbrVO();
				
				HashMap<String, Object> authInfo = (HashMap<String, Object>) res.get("authenticate_data");
				
	            String ciKey = (String) authInfo.get("unique");
	            certMbrInfoVO.setCiKey(ciKey);
	            
	            String diKey = (String) authInfo.get("di");
	            certMbrInfoVO.setDiKey(diKey);
	            
	            String Name = (String) authInfo.get("name");
	            certMbrInfoVO.setMbrNm(Name);
	            
	            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	            String birth = (String) authInfo.get("birth");
	            Date brdt = formatter.parse(DateUtil.formatDate(birth, "yyyy-MM-dd")); //생년월일
	            certMbrInfoVO.setBrdt(brdt);
	            
	            Integer gender = (Integer) authInfo.get("gender");
	            String genderText;
	            if(gender == 1) {
	            	genderText = "M";
	            }else {
	            	genderText = "W";
	            }
	            certMbrInfoVO.setGender(genderText);
	            
	            String phone = (String) authInfo.get("phone");
	            String mblTelno = phone.substring(0, 3) + "-" + phone.substring(3, 7) + "-" + phone.substring(7, 11);
	            certMbrInfoVO.setMblTelno(mblTelno);
	            
	            return certMbrInfoVO;
		    }
		} catch (Exception ex) {
			log.debug("====== 본인인증 확인 오류", ex);
		}
		return null;
	}
}
