package icube.manage.sysmng.bbs.biz;

import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.common.file.biz.FileVO;
import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("bbsVO")
public class BbsVO  extends CommonBaseVO {
	private int nttNo;
	private int bbsNo;
	private int ctgryNo;
	private int nttGrp;
	private int nttOrdr;
	private int nttLevel;
	private String ttl;
	private String cn;
	private String pswd;
	private String wrtr;
	private String wrtId;
	private String wrtYmd;
	private int inqcnt = 0;
	private String ntcYn = "N";
	private String secretYn = "N";
	private String ip;
	private String ansTtl;
	private String ansCn;
	private String answr;
	private String ansId;
	private String ansYmd;
	private String sttsTy = "P"; //T:작성중, P:출판(사용), C:관리자 강제 비공개

	private FileVO bbsThumbFile; // 썸네일
	private List<FileVO> bbsFileList; // 첨부파일

	private String ctgryNm; //카테고리명

	private String bbsTy; //게시판 타입
	private String bbsTyNm; //게시판 명

	private String[] nttNos; //일괄 처리용
}
