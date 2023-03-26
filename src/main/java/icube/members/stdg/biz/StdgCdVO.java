package icube.members.stdg.biz;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

/**
 * 법정동 코드
 */

@Setter
@Getter
@Alias("stdgCdVO")
public class StdgCdVO {
	private String stdgCd;
	private String ctpvNm;
	private String sggNm;
	private int levelNo;
}
