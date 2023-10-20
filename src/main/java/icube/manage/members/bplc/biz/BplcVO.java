package icube.manage.members.bplc.biz;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.common.file.biz.FileVO;
import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;



@Setter
@Getter
@Alias("bplcVO")
public class BplcVO extends CommonBaseVO {
    private String uniqueId; // 유일 아이디
    private String bplcId; // 사업장 아이디
    private String bplcPswd; // 사업장 비밀번호
    private String bplcNm; // 사업장 명
    private String telno; // 전화번호
    private String fxno; // 팩스번호
    private String eml;	// 이메일

    private String rprsvNm; // 대표자명
    private String brno; // 사업자번호
    private String rcperInstNo; // 요양기관번호
    private String bizcnd; // 업테
    private String iem; // 종목
    private String zip; // 우편번호
    private String addr; // 주소
    private String daddr; // 상세주소
    private String lat; // 위도
    private String lot; // 경도
    private String loc; // 공간좌표
    private String bplcUrl; // 사업장 URL

    private String dlvyZip; // 배송 우편번호
    private String dlvyAddr; // 배송 주소
    private String dlvyDaddr; // 배송 상세주소

    private String picNm; // 담당자 명
    private String picTelno; // 담당자 전화번호
    private String picEml; // 담당자 이메일

    private String clclnBank; // 정산 은행
    private String clclnActno; // 정산 계좌번호
    private String clclnDpstr; // 정산 예금주

    private String bsnPic; // 영업 담당자
    private String cnptCd; // 거래처 코드
    private String taxbilEml; // 세금계산서 이메일

    // 추가정보
    private String bsnHrBgng;
    private String bsnHrEnd;
    private String hldy;
    private String hldyEtc;
    private String parkngYn="N";
    private String intrcn;
    private String busDrc;
    private String subwayDrc;
    private String carDrc;

    private String aprvTy = "W"; //승인타입 (대기:W,승인:C,미승인:R)
    private Date aprvDt;
    private String rejectResn;// 거부 사유


    private String rcmdtnYn = "N"; // 추천 여부
    private Date trmsAgreDt; // 약관 동의 일시
    private Date joinDt; //가입 일시
    private int lgnFailrCnt; //로그인 실패 수
    private Date recentCntnDt; //최근 접속 일시
    private String tmprPswdYn="N"; // 임시 비밀번호 여부
    private Date pswdChgDt; // 비밀번호 변경 일시
    private String joinCours; // 가입 경로


    //사업자등록증
    private String bsnmCeregrt;
    private String delBsnmCeregrt;
    //사업자 직인
    private String bsnmOffcs;
    private String delBsnmOffcs;

    //대표 이미지
    private String proflImg;
    private String delProflImg;

    private String dist;

    private int rcmdCnt = 0;// 사용자 추천수

    private String mbGiupMatching;//이로움온 매칭서비스 사용

}