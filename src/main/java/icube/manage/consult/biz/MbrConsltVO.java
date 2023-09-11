package icube.manage.consult.biz;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@Alias("mbrConsltVO")
public class MbrConsltVO extends CommonBaseVO {

	private int consltNo;
	private String mbrNm;
	private String mbrTelno;
	private String brdt;
	private String gender;
	private int age;
	private String zip;
	private String addr;
	private String daddr;
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
}