package icube.manage.mbr.recipter.biz;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@Alias("recipterInfoVO")
public class RecipterInfoVO extends CommonBaseVO {

	private String uniqueId;	// 유니크 아이디
	private String rcperRcognNo;	// 요양인정번호
	private String rcognGrad;	// 등급
	private int selfBndRt;		// 본인부담율
	private String selfBndMemo;		// 본인부담율 설명
	private Date vldBgngYmd;	// 인정유효기간 시작일
	private Date vldEndYmd;		// 인정유효기간 종료일
	private Date aplcnBgngYmd;	// 적용기간 시작일
	private Date aplcnEndYmd;	// 적용기간 종료일
	private int sprtAmt;		// 지원금액
	private int bnefBlce;		// 급여잔액 BALANCE

	private String testName;

	// 선택된 수급자 추가 정보 (TOP)
	private String mbrNm;
	private String mbrId;
	private String proflImg;
	private String mberSttus = "NORMAL";
	private String mberGrade = "R";
	private String mblTelno;
	private String gender;
	private String zip;
	private String addr;
	private String daddr;
}