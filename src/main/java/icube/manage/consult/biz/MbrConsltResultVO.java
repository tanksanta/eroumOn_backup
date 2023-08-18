package icube.manage.consult.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@Alias("mbrConsltResultVO")
public class MbrConsltResultVO extends CommonBaseVO {

	private int bplcConsltNo;
	private int consltNo;

	private String bplcUniqueId;
	private String bplcId;
	private String bplcNm;

	private String consltDtls;
	private String consltSttus = "CS01";
	private String consltDt;
	private String reconsltResn;
	private String reconsltDt;

	private MbrConsltVO mbrConsltInfo; // right join

	private int itrstCnt = 0; // 관심멤버스 체크용
	private int rcmdCnt = 0; // 좋아요 체크용
}