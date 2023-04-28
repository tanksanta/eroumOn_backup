package icube.manage.ordr.dtl.biz;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.manage.gds.gds.biz.GdsVO;
import icube.manage.mbr.recipter.biz.RecipterInfoVO;
import icube.manage.members.bplc.biz.BplcVO;
import icube.manage.ordr.chghist.biz.OrdrChgHistVO;
import icube.manage.ordr.ordr.biz.OrdrVO;
import icube.manage.ordr.rebill.biz.OrdrRebillVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@Alias("ordrDtlVO")
public class OrdrDtlVO extends OrdrVO {

	private int ordrDtlNo;
	private int ordrNo;
	private String ordrDtlCd;
	private String ordrCd;
	private int gdsNo;
	private String gdsCd;
	private String bnefCd;
	private String gdsNm;
	private int gdsPc = 0; // 상품가격 (주문시점)
	private int ordrPc = 0; // 주문가격 (상품가격 + 옵션가격)
	private String ordrOptnTy;
	private String ordrOptn;
	private int ordrOptnPc = 0;
	private int ordrQy = 0;

	private int accmlMlg = 0; // 적립 마일리지

	private int couponNo = 0;
	private String couponCd;
	private int couponAmt = 0;

	private String refundAprvno; // 승인번호

	private String recipterUniqueId; // 수급자 유니크
	private RecipterInfoVO recipterInfo; //수급자정보

	private String bplcUniqueId; // 사업소 유니크
	private String bplcNm;
	private BplcVO bplcInfo; // 사업소정보

	private String sttsTy;

    private Date sndngDt;
    private String dlvyTy;
    private String dlvyHopeYmd;
    private String dlvyStlmTy;
    private int dlvyBassAmt;
    private int dlvyAditAmt;
    private String dlvyStts;
    private int dlvyCoNo;
    private String dlvyCoNm;
    private Date dlvyDt;
    private String dlvyInvcNo; // 송장번호

    // 환불정보
    private String rfndYn;
    private String rfndBank;
    private String rfndActno;
    private int rfndAmt;
    private Date rfndDt;
    private String rfndDpstr;

    private String[] ordrDtlNos; //일괄 처리용
    private String gdsTy; //상품 유형

    private GdsVO gdsInfo;

    // 처리이력
    private String resnTy;
    private String resn;

    // 전체 적립 마일리지 처리
    private int totalAccmlMlg;

    // 버튼 제어
    private int cancelBtn; // 취소건수
    private int returnBtn; // 반품건수
    private int buyBtn; // 결제 버튼 전체가 OR04일때만

    // 변경 히스토리
    // 조인으로 날짜 비교를 해야하므로 Collection의 VO로 가져올 수 없어서 만듬.
    private int chgNo;
    private String chgStts;

    private List<OrdrChgHistVO> ordrChgHist;

    private OrdrRebillVO rebillInfo;
}
