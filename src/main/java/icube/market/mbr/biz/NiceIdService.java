package icube.market.mbr.biz;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.util.WebUtils;

import NiceID.Check.CPClient;
import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.util.DateUtil;
import icube.manage.mbr.mbr.biz.MbrVO;

//@Service("niceIdService")
public class NiceIdService extends CommonAbstractServiceImpl {
	/*
	@Value("#{props['Niceid.reqNumKey']}")
	private String reqNumKey;

	@Value("#{props['Niceid.siteCode']}")
	private String nSiteCode;

	@Value("#{props['Niceid.sitePassword']}")
	private String nSitePassword;

	@Value("#{props['Niceid.returnUrl']}")
	private String nReturnUrl;
	*/


	public Map<String, String> getReqData(HttpServletRequest request) throws Exception {

		/*
		CPClient niceCheck = new CPClient();

		String sSiteCode = nSiteCode;				// NICE로부터 부여받은 사이트 코드
	    String sSitePassword = nSitePassword;		// NICE로부터 부여받은 사이트 패스워드
	    String sRequestNumber = "REQ0000000001";        	// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로
	                                                    	// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
	    sRequestNumber = niceCheck.getRequestNO(sSiteCode);
	    WebUtils.setSessionAttribute(request, reqNumKey, sRequestNumber);

	   	String sAuthType = "";      	// 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서
	   	String popgubun 	= "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
		String customize 	= "";		//없으면 기본 웹페이지 / Mobile : 모바일페이지

	    // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
	    String sReturnUrl = nReturnUrl;      // 성공시 이동될 URL
	    String sErrorUrl = nReturnUrl;

	    // 입력될 plain 데이타를 만든다.
	    String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
	                        "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
	                        "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
	                        "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
	                        "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
	                        "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
	                        "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize;

	    String sMessage = "";
	    String sEncData = "";

	    int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
	    if( iReturn == 0 ) {
	        sEncData = niceCheck.getCipherData();
	    }else {
	    	sEncData = null;
	    	sMessage = "NiceId Error : " + iReturn;
	    }
		 */
		String sMessage = "";
	    String sEncData = "";
		Map<String, String> reqParamMap = new HashMap<String, String>();

		reqParamMap.put("sMessage", sMessage);
		reqParamMap.put("sEncData", sEncData);

		return reqParamMap;
	}


	public MbrVO callback(HttpServletRequest request) throws Exception {
		/*
		CPClient niceCheck = new CPClient();

		String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");

	    String sSiteCode = nSiteCode;				   // NICE로부터 부여받은 사이트 코드
	    String sSitePassword = nSitePassword;			 // NICE로부터 부여받은 사이트 패스워드

	    String sCipherTime = "";			 // 복호화한 시간
	    String sRequestNumber = "";			 // 요청 번호
	    String sResponseNumber = "";		 // 인증 고유번호
	    String sAuthType = "";				 // 인증 수단
	    String sName = "";					 // 성명
	    String sDupInfo = "";				 // 중복가입 확인값 (DI_64 byte)
	    String sConnInfo = "";				 // 연계정보 확인값 (CI_88 byte)
	    String sBirthDate = "";				 // 생일
	    String sGender = "";				 // 성별
	    String sNationalInfo = "";       	 // 내/외국인정보 (개발가이드 참조)
		String sMobileNo = "";				// 휴대폰번호
		String sMobileCo = "";				// 통신사
	    String sMessage = "";
	    String sPlainData = "";

	    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

	    if( iReturn == 0 ) {
	        sPlainData = niceCheck.getPlainData();
	        sCipherTime = niceCheck.getCipherDateTime();

	        // 데이타를 추출합니다.
	        HashMap mapresult = niceCheck.fnParse(sPlainData);

			sRequestNumber 	= (String) mapresult.get("REQ_SEQ");
			sResponseNumber = (String) mapresult.get("RES_SEQ");
			sAuthType		= (String) mapresult.get("AUTH_TYPE");
			sName 			= (String) mapresult.get("NAME");
			sBirthDate 		= (String) mapresult.get("BIRTHDATE");
			sGender 		= (String) mapresult.get("GENDER");
			sNationalInfo 	= (String) mapresult.get("NATIONALINFO");
			sDupInfo 		= (String) mapresult.get("DI");
			sConnInfo 		= (String) mapresult.get("CI");

			//추가작업
			sMobileNo		= (String) mapresult.get("MOBILE_NO");
	        sMobileCo		= (String) mapresult.get("MOBILE_CO");

	        System.out.println("sRequestNumber:::::" + sRequestNumber);
	        System.out.println("sDupInfo:::::" + sDupInfo);
	        System.out.println("sName:::::" + sName);
	        System.out.println("sMobileNo:::::" + sMobileNo);
	        System.out.println("sMobileCo:::::" + sMobileCo);
	        System.out.println("sGender:::::" + sGender);
	        System.out.println("sBirthDate:::::" + sBirthDate);

	        String session_sRequestNumber   = EgovStringUtil.null2string((String) WebUtils.getSessionAttribute(request, reqNumKey), "").trim();
	        if(!sRequestNumber.equals(session_sRequestNumber)) {
	            sMessage = "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.";
	            sResponseNumber = "";
	            sAuthType = "";
	        } else {

	        	System.out.println("NICEID CALLBACK OK:::::" + sMobileCo);

	        	//생년월일
	        	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	            Date brdt = formatter.parse(DateUtil.convertDate(sBirthDate, "yyyy-MM-dd"));

	            //휴대전화
	            String mblTelno = sMobileNo.substring(0, 3) +"-"+ sMobileNo.substring(3, 7) +"-"+ sMobileNo.substring(7);

				MbrVO mbrVO = new MbrVO();
				mbrVO.setUniqueId(sRequestNumber);
				mbrVO.setMbrNm(sName);
				mbrVO.setMblTelno(mblTelno);
				mbrVO.setGender(sGender.equals(0)?"W":"M");
				mbrVO.setBrdt(brdt);

				System.out.println("mbrVO.toString():::: " + mbrVO.toString());

				return mbrVO;
	        }
		} else {
			sMessage = "NiceId Error : " + iReturn;
	    }
		 */
		return null;
	}

	public static String requestReplace (String paramValue, String gubun) {
        String result = "";

        if (paramValue != null) {

        	paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

        	paramValue = paramValue.replaceAll("\\*", "");
        	paramValue = paramValue.replaceAll("\\?", "");
        	paramValue = paramValue.replaceAll("\\[", "");
        	paramValue = paramValue.replaceAll("\\{", "");
        	paramValue = paramValue.replaceAll("\\(", "");
        	paramValue = paramValue.replaceAll("\\)", "");
        	paramValue = paramValue.replaceAll("\\^", "");
        	paramValue = paramValue.replaceAll("\\$", "");
        	paramValue = paramValue.replaceAll("'", "");
        	paramValue = paramValue.replaceAll("@", "");
        	paramValue = paramValue.replaceAll("%", "");
        	paramValue = paramValue.replaceAll(";", "");
        	paramValue = paramValue.replaceAll(":", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll("#", "");
        	paramValue = paramValue.replaceAll("--", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll(",", "");

        	if(gubun != "encodeData"){
        		paramValue = paramValue.replaceAll("\\+", "");
        		paramValue = paramValue.replaceAll("/", "");
            paramValue = paramValue.replaceAll("=", "");
        	}

        	result = paramValue;

        }
        return result;
  }

}
