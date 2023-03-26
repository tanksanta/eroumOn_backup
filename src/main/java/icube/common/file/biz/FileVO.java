package icube.common.file.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("fileVO")
public class FileVO extends CommonBaseVO {

	/** 서비스 구분 ID */
	private String srvcId;
	/** 파일 첨부 서비스 No */
	private long upNo;
	/** 파일 종류 */
	private String fileTy;
	/** 파일 번호 */
	private int    fileNo;
	/** 파일 저장 경로 */
	private String flpth;
	/** 원본 파일 이름 */
	private String orgnlFileNm;
	/** 저장된 파일 이름 */
	private String strgFileNm;
	/** 파일 확장자 */
	private String fileExtn;
	/** 파일 크기 */
	private int    fileSz;
	/** 파일 설명글 */
	private String fileDc;
	/** 파일 다운로드 횟수 */
	private int dwnldCnt = 0;

}
