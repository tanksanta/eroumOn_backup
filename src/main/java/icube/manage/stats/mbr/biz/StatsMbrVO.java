package icube.manage.stats.mbr.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Alias("statsMbrVO")
@ToString
public class StatsMbrVO extends CommonBaseVO {

	private String date;

	// 가입/탈퇴
	private int rexit;
	private int rjoin;
	private int nexit;
	private int njoin;
	private int jtotal;
	private int etotal;

	// 휴면
	private int drmc;
	private int wdrmc;

	// 성별
	private int mnChild;
	private int mnTwenty;
	private int mnThirty;
	private int mnForty;
	private int mnFifty;
	private int mnSixty;
	private int mnSeventy;
	private int mnTotal;

	private int wmChild;
	private int wmTwenty;
	private int wmThirty;
	private int wmForty;
	private int wmFifty;
	private int wmSixty;
	private int wmSeventy;
	private int wmTotal;

	private int nTotal;
	private int total;

	// 가입경로
	private String joinCours;

	// 등급별
	private String mberGrade;
}
