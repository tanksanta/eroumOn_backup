package icube.common.interceptor.biz;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CustomProfileVO {
	private String mbrId;           //회원 아이디
	private String mbrNm;           //회원 이름
	private String mblTelno;        //회원 휴대폰 번호
	private String eml;             //회원 이메일
	private String smsRcptnYn ="N"; //마케팅 문자 수신동의 여부
	private String emlRcptnYn ="N"; //마케팅 이메일 수신동의 여부
	
	private Integer mbrConsltCnt;    //회원 누적 상담 신청 건수
}
