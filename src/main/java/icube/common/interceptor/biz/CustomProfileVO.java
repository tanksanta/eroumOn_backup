package icube.common.interceptor.biz;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CustomProfileVO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String memberId;                     //회원 아이디
	private String memberHash;                   //회원 아이디 해시값
	private String mbrNm;                        //회원 이름
	private String mblTelno;                     //회원 휴대폰 번호
	private String eml;                          //회원 이메일
	private boolean unsubscribeTexting = false;  //마케팅 문자 수신비동의 여부
	private boolean unsubscribeEmail = false;    //마케팅 이메일 수신비동의 여부
	private Integer mbrConsltCnt;                //회원 누적 상담 신청 건수
	
	private boolean registerRecipient = false;   //수급자 등록 여부
	private String existTestResult;              //인정등급예상 테스트 결과값 유무
	private String existLNumber;                 //L넘버 값 유무
	private String existConslt;                  //상담 신청 기록 유무
	
	private boolean coupon = false;              //마켓 쿠폰 보유 여부
}
