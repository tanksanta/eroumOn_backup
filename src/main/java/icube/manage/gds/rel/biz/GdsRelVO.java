package icube.manage.gds.rel.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("gdsRelVO")
public class GdsRelVO {

	private int gdsNo;
	private int relGdsNo;
	private String relGdsNm;
	private int sortNo;

	private String gdsTy;
	private String gdsCd;
	private String gdsNm;
	private int pc;
	private int bnefPc;
	private int bnefPc15; //15%
	private int bnefPc9; //9%
	private int bnefPc6; //6%
	private int lendPc; //대여가(월)
	private int fileNo;

	//상품카테고리
	private int upCtgryNo = 0; //상위카테고리
	private String upCtgryNm;
	private int ctgryNo = 0; //카테고리
	private String ctgryNm;
}
