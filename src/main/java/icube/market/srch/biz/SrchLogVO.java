package icube.market.srch.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@Alias("srchLogVO")
@ToString
public class SrchLogVO extends CommonBaseVO {
	private String srchwrd;			// 검색어
	private String yy;					// 년
	private String mt;					// 월
	private String dd;					// 일
	private String lc;					// 위치
	private String mberSe;			// 회원_구분
	private String sexdstn;			// 성별

}
