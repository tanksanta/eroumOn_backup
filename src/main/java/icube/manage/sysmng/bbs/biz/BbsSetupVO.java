package icube.manage.sysmng.bbs.biz;

import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("bbsSetupVO")
public class BbsSetupVO extends CommonBaseVO {

	private int bbsNo;
	private String srvcCd;
	private String bbsCd;
	private String bbsNm;
	private String bbsTy = "1";
	private String secretUseYn = "N";
	private String editrUseYn = "Y";
	private String mbrAuthrtYn = "N";
	private int otptCo = 10;
	private String ctgryUseYn = "N";

	private String atchfileUseYn = "N";
	private int atchfileCnt = 0;
	private int atchfileSz = 0;
	private String[] atchfilePermExtn;
	private String atchfilePermExtnVal; //DB저장용

	private String thumbUseYn = "N";
	private String picSmsYn = "N";
	private String picSms;
	private String picEmlYn = "N";
	private String picEml;

	private String[] ctgry;
	private List<BbsCtgryVO> ctgryList;
	private String[] ctgryValues;
	private String[] ctgryTexts;

	private int nttCnt = 0;	//게시물 건수

}
