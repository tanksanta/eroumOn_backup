package icube.members.bplc.mng.biz;

import org.apache.ibatis.type.Alias;

import icube.common.file.biz.FileVO;
import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@Alias("bplcGdsVO")
public class BplcGdsVO extends CommonBaseVO {

	private String uniqueId; // pk
	private int gdsNo; // pk

	// 상품정보
	private String gdsNm; //상품 명
	private String gdsTy; //상품 구분
	private String gdsCd; //상품 코드
	private int pc; //판매가
	private int bnefPc; //급여가
	private int lendPc; //대여가(월)
	private int stockQy = 0;

	private String dspyYn = "Y";

	private int upCtgryNo = 0; //상위카테고리
	private String upCtgryNm;
	private int ctgryNo = 0; //카테고리
	private String ctgryNm;

	private FileVO thumbnailFile; //대표(썸네일) 이미지

	// 일괄 처리용
	private String[] arrGdsNo;
}
