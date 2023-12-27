package icube.manage.mbr.itrst.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import icube.manage.gds.gds.biz.GdsVO;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.mbr.recipter.biz.RecipterInfoVO;
import icube.manage.members.bplc.biz.BplcVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@Alias("cartVO")
public class CartVO extends CommonBaseVO {

	private int cartNo;
	private int cartGrpNo;
	private String cartTy; // R:급여/N:비급여

	private int gdsNo;
	private String gdsCd;
	private String bnefCd;
	private String gdsNm;
	private int gdsPc = 0;
	private int ordrPc = 0;
	private int gdsOptnNo = 0;
	private String ordrOptnTy;
	private String ordrOptn;
	private int ordrOptnPc = 0;
	private int ordrQy = 0;

	private String viewYn;

	private String recipterUniqueId;
	private String bplcUniqueId;

	private GdsVO gdsInfo; // 상품정보
	private BplcVO bplcInfo; // 사업소정보
	private RecipterInfoVO recipterInfo; //수급자정보
	private MbrVO mbrVO;

}
