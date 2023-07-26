package icube.manage.sysmng.entrps.biz;

import lombok.Getter;

@Getter
public class EntrpsDlvyBaseCtVO {
	private int entrpsNo;
	private int dlvyCtCnd;
	private int dlvyBaseCt; //기본 배송료
	
	public EntrpsDlvyBaseCtVO(int entrpsNo, int dlvyCtCnd, int dlvyBaseCt) {
		this.entrpsNo = entrpsNo;
		this.dlvyCtCnd = dlvyCtCnd;
		this.dlvyBaseCt = dlvyBaseCt;
	}
}
