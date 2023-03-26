package icube.market.mypage.itrst.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import icube.manage.members.bplc.biz.BplcVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("itrstVO")
public class ItrstVO extends CommonBaseVO {
	private int itrstNo;				//관심 번호
	private String itrstTy;			//유형 타입
	private int ctgryNo;				//카테고리 번호
	private String bplcUniqueId;	//사업소 유니크 아이디

	//bplcInfo
	private BplcVO bplcInfo;

	//gdsCtgry
	private int upCtgryNo;
	private String ctgryNm;
	private String ctgryImg;
	private String tag;
	private int levelNo;
	private int sortNo;
	private String useYn;

	private int gdsNo;
	private int fileNo;

}
