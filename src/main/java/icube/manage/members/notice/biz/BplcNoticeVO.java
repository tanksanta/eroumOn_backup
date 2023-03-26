package icube.manage.members.notice.biz;

import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.common.file.biz.FileVO;
import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("bplcNoticeVO")
public class BplcNoticeVO extends CommonBaseVO {
	private int noticeNo;
	private String ttl;
	private String cn;
	private int inqcnt;

	private List<FileVO> fileList;

}