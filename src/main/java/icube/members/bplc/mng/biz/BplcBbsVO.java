package icube.members.bplc.mng.biz;

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
@Alias("bplcBbsVO")
public class BplcBbsVO extends CommonBaseVO {
	private String bplcUniqueId;
	private int nttNo;
	private String ttl;
	private String cn;
	private String wrtr;
	private String wrtId;
	private String wrtYmd;
	private int inqcnt;
	private String ntcYn = "N";
	private String useYn = "Y";
	private String ip;

	// file
	private List<FileVO> bplcFileList;
}