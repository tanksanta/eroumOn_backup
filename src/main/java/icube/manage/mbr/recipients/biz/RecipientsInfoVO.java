package icube.manage.mbr.recipients.biz;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class RecipientsInfoVO {
	//수급자 기본정보
	private String recipientsNm;
	private int recipientsNo;
	private String relationText;
	private String recipientsYn;
	private String tel;
	private String address; //실거주지 주소 (시 + 군 + 동)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private String brdt;
	private String regDt;
	private String gender;
	private String mdfcnDt;
	private String mainYn;
	
	//수급자 요양정보
	private String rcperRcognNo;   //요양인정 번호
	private String ltcRcgtGradeCd; //등급
	private String rcgtEdaDt;      //인정유효기간
	private String penPayRate;     //본인부담율
	private String bgngApdt;       //적용기간
	private String remindAmt;      //급여잔액
	private String useAmt;         //사용금액
	private String searchDt;       //최근조회일시
	
	//수급자 상담정보
	private String prevPath;           //상담신청경로
	private String recentConsltSttus;  //최근상담진행상태
	private String recentConsltRegDt;    //최근상담신청일시
	
	//인정등급예상테스트 정보
	private String testResultYn;   //테스트결과저장여부
	private String testRegDt;        //최근테스트결과일시
}