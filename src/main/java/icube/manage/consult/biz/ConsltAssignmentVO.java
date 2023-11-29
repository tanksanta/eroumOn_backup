package icube.manage.consult.biz;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ConsltAssignmentVO implements Comparable<ConsltAssignmentVO> {
	private boolean isReject;  //거부 사업소 여부
	private int consltCnt;     //몇 차 상담
	private String bplcUniqueId;   //사업소 UNIQUE ID
	private String bplcNm;     //사업소명
	private String bplcTelno;  //사업소 번호
	private int rcmdCnt;       //사업소 추천 수
	private Date regDt;	       //배정일
	
	@Override
    public int compareTo(ConsltAssignmentVO consltAssignment) {
		return regDt.compareTo(consltAssignment.getRegDt());
	}
}
