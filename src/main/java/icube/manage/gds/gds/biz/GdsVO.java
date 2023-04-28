package icube.manage.gds.gds.biz;

import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.common.file.biz.FileVO;
import icube.common.vo.CommonBaseVO;
import icube.manage.gds.optn.biz.GdsOptnVO;
import icube.manage.gds.rel.biz.GdsRelVO;
import icube.manage.promotion.dspy.biz.PlanngDspyGrpGdsVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@Alias("gdsVO")
public class GdsVO extends CommonBaseVO {
	//기본정보
	private int gdsNo;
	private String gdsTy; //상품 유형
	private String gdsNm; //상품 명
	private String gdsCd; //상품 코드
	private String bnefCd; //급여 코드
	private String itemCd; //품목 코드
	private String wrhsYmdNtcn; //입고예정일 알림
	private String mngrMemo; //관리자 메모
	private String bassDc; //기본설명
	private String mtrqlt; //재질
	private String wt; //중량
	private String size; //사이즈상세정보
	private String stndrd; //규격
	private int sortNo = 100;
	private String[] gdsTag;
	private String gdsTagVal; //DB저장용
	private String mkr; //제조사
	private String plor; //원산지
	private String brand; //브랜드
	private String modl; //모델
	private String mlgUseYn = "Y"; //마일리지 사용여부 (상품가격의 5%)
	private String mlgPvsnYn = "Y"; //마일리지 제공여부
	private String couponUseYn = "Y"; //쿠폰 사용여부
	private String pointUseYn = "Y"; //포인트 사용여부
	private String gdsDc;
	private String tempYn = "N";

	//가격/재고
	private int pc; //판매가
	private int dscntRt; //할인율
	private int dscntPc; //할인가
	private int bnefPc; //급여가
	private int bnefPc15; //15%
	private int bnefPc9; //9%
	private int bnefPc6; //6%
	private int lendPc; //대여가(월)
	private String lendDuraYn = "N";
	private int usePsbltyTrm;
	private int extnLendTrm;
	private int extnLendPc;
	private int stockQy = 99999;
	private int stockNtcnQy;
	private String soldoutYn = "N";
	private String ntslSttsCd;

	//상품요약정보(고시정보)
	private String ancmntTy;
	private String ancmntInfo;
	private String[] article_ttl;
	private String[] article_val;

	//배송비 정보
	private int dlvyQy;
	private int dlvyAmt;
	private int dlvyMummQy;
	private int dlvyMummAmt;
	private String dlvyCtTy = "FREE";
	private String dlvyCtStlm;
	private int dlvyBassAmt = 0;
	private int dlvyAditAmt = 0;

	//상품 이미지
	private FileVO thumbnailFile; //대표(썸네일) 이미지
	private List<FileVO> imageFileList; //추가 이미지
	private String youtubeUrl;
	private String youtubeImg;

	//기타사항
	private String aditGdsDc;
	private String seoAuthor;
	private String seoDesc;
	private String seoKeyword;
	private String memo;

	private String dspyYn = "Y";
	private int inqcnt = 0;

	//관련상품
	private List<GdsRelVO> gdsRelList;
	private String[] relGdsNo;
	private String relGdsNoVal; //DB저장용
	private int relGdsSortNo = 1;

	//상품카테고리
	private int upCtgryNo = 0; //상위카테고리
	private String upCtgryNm;
	private int ctgryNo = 0; //카테고리
	private String ctgryNm;

	//옵션
	private String optnTtl;//옵션제목
	private String optnVal;
	private String aditOptnTtl;//추가옵션제목
	private String aditOptnVal;
	private String optnNm;
	private String optnTy;
	private String optnStockQy;
	private int gdsOptnNo;

	private List<GdsOptnVO> optnList;
	private List<GdsOptnVO> aditOptnList;

	//일괄 처리용
	private String[] arrGdsNo;

	//등록 기획전 수
	private List<PlanngDspyGrpGdsVO> regCount;

	//위시리스트
	private int wishYn = 0; // Y/N -> 1/0 카운트로 조회
}