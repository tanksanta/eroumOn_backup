package icube.manage.exhibit.recommend.biz;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("gdsRcmdVO")
public class GdsRcmdVO {

	public int rcmdGdsNo;
	public int gdsNo;
	public int rcmdSortNo;

	//gdsVO
	private String gdsCd;
	private String gdsNm; //상품 명
	private String ntslSttsCd;
	private String useYn;
	private Date regDt;

	//ctgryVO
	private String upCtgryNm;
	private String ctgryNm;
}
