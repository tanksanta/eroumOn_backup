package icube.manage.ordr.ordr.biz;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import icube.manage.ordr.dtl.biz.OrdrDtlVO;
import icube.manage.ordr.rebill.biz.OrdrRebillVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@Alias("ordrVO")
public class OrdrVO extends CommonBaseVO {
    private int ordrNo;
    private String ordrCd; // o+22092523450000 > 15자리
    private String uniqueId;
    private String ordrTy; // R:급여/N:비급여
    private Date ordrDt;
    private String ordrrId;
    private String ordrrNm;
    private String ordrrEml;
    private String ordrrTelno;
    private String ordrrMblTelno;
    private String ordrrZip;
    private String ordrrAddr;
    private String ordrrDaddr;
    private String ordrrMemo;

    private String recptrNm; // 수령인
    private String recptrTelno;
    private String recptrMblTelno;
    private String recptrZip;
    private String recptrAddr;
    private String recptrDaddr;

	private int useMlg = 0; // 사용 마일리지
	private int usePoint = 0; // 사용 포인트

    private String stlmDevice; // PC/MOBILE
    private String stlmKnd; // BASS_STLM_TY 코드 참고 //method_symbol //card, bank, vbank만 존재
    private String stlmTy; // BASS_STLM_TY 코드 참고 //method_origin_symbol//card, naverpay, kakaopay, bank, vbank등등 존재
    private int stlmAmt; // 총 결제 금액 ((상품가격(옵션)*수량)+배송비)
    private String stlmYn = "N"; // Y/N
    //private Date stlmDt; // 결제 일시
    private String stlmDt; // 결제 일시 > Date->String
    private String sendSttus; // 주문정보 송신 상태


    // 결제 결과
    private String delngNo; // 거래번호 -> TID
    private String cardCoNm; // 카드 회사명
    private String cardNo; // 카드번호 (전체 불가능)
    private String cardAprvno; // 카드 승인번호
    private String cardPrtcYn = "N"; // 카드 부분취소 가능여부
    private String vrActno; // 가상계좌번호
    private String dpstBankCd; // 입금은행코드
    private String dpstBankNm; // 입금은행명
    private String dpstr; // 예금주
    private String pyrNm; // 입금자명
    private String dpstTermDt; // 입금기한일시 > Date->String

    private String cashrciptYn;
    private String cashrciptNo;

    private List<OrdrDtlVO> ordrDtlList;
    private List<OrdrRebillVO> ordrRebillList;

    private String cartGrpNos;

    private String billingYn = "N";
    private String billingKey;
    private String billingDay; // 정기결제일
}