package icube.manage.consult.biz;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import icube.manage.mbr.mbr.biz.MbrVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@Alias("mbrConsltVO")
public class MbrConsltVO extends CommonBaseVO {

	private int consltNo;
	private String mbrNm;    //회원에서 수급자명
	private String mbrTelno; //회원에서 수급자번호
	private String brdt;     //회원에서 수급자생년월일
	private String gender;   //회원에서 수급자성별
	private int age;
	private String zip;      //시/도
	private String addr;     //시/구/군
	private String daddr;    //동/읍/면
	private String useYn = "Y";

	// 20230807 kkm : 상담 상태값 추가
	private String mngMemo; //관리 메모
	private Date memoMdfcnDt;
	private String mngrUniqueId;
	private String mngrId;
	private String mngrNm;

	private String consltSttus = "CS01"; // 상담접수(상담신청완료)
	private Date sttusChgDt;
	private String canclResn;
	private Date canclDt;

	private List<MbrConsltResultVO> consltResultList;

	private Date reConsltDt; // 재접수 일시 (CS07)
	
	private Integer recipientsNo;
	private String relationCd;
	private String rcperRcognNo;
	private String prevPath;

	private String regId;
	private String regUniqueId;
}