package icube.manage.consult.biz;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.common.file.biz.FileVO;
import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@Alias("mbrInqryVO")
public class MbrInqryVO extends CommonBaseVO {
	private int inqryNo;
	private String inqryTy;
	private String inqryDtlTy;
	private String ttl;
	private String cn;
	private String ordrCd;
	private String smsAnsYn="N";
	private String mblTelno;
	private String emlAnsYn="N";
	private String eml;

	private String ansYn = "N";
	private String ansCn;
	private String ansUniqueId;
	private Date ansDt;
	private String ansId;
	private String answr;
	private String useYn = "Y";

	private String mbrNm;

	//fileVO
	private List<FileVO> fileList;

}