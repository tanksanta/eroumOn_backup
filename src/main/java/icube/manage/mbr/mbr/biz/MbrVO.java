package icube.manage.mbr.mbr.biz;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import icube.common.file.biz.FileVO;
import icube.common.vo.CommonBaseVO;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;
import icube.manage.mbr.recipter.biz.RecipterInfoVO;
import icube.membership.info.biz.DlvyVO;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@NoArgsConstructor
@Setter
@Getter
@Alias("mbrVO")
public class MbrVO extends CommonBaseVO {
	private String uniqueId;
	private String mbrId;
	private String mbrNm;
	private String pswd;
	private String gender = "M";
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date brdt;
	private String telno;
	private String mblTelno;
	private String eml;
	private String zip;
	private String addr;
	private String daddr;
	private String recipterYn = "N";
	private String bassStlmTy;
	private int pointAcmtl;
	private int mlgAcmtl;
	private String mberSttus = "NORMAL";
	private String mberGrade = "N";
	private String rcmdtnId;
	private String rcmdtnMbrsId;
	private String prvcVldPd = "1Y";
	private String smsRcptnYn ="N";
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date smsRcptnDt;
	private String emlRcptnYn ="N";
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date emlRcptnDt;
	private String telRecptnYn ="N";
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date telRecptnDt;
	private String pushRecptnYn ="N";
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date pushRecptnDt;
	private String eventRecptnYn;
	private String proflImg; // 프로필이미지
	private Date trmsAgreDt;
	private String itrstField;
	private String joinCours = "PC";
	private Date joinDt;
	private int lgnFailrCnt;
	private Date recentCntnDt;
	private String tmprPswdYn = "N";
	private Date pswdChgDt;
	private String whdwlYn = "N";
	private Date whdwlDt;
	private String whdwlResn;
	private String whdwlTy;
	private String whdwlEtc;
	private Date snsRegistDt;
	private String appMatToken;
	private Date appMatExpiredDt;
	private String lat;
	private String lot;

	private String ciKey; //ci값 => 휴대폰 본인인증(고유키 리턴)
	private String diKey; //di값 => 휴대폰 본인인증(고유키 리턴)

	private String reqTy;
	private String delProflImg;

	private String naverAppId;
	private String kakaoAppId;

	private String joinTy = "E"; // 가입 구분
	private String lgnTy;        // 로그인 시 인증타입
	private String joinTyList;   // 관리자 > 회원관리에서 다중 가입유형 표시용 속성

	//sns 로그인 시 임시 저장 속성
	private String accessToken;  
	private String refreshToken;
	
	// 첨부파일 체크
	private List<FileVO> fileList;

	private RecipterInfoVO recipterInfo; //RecipterInfoVO 이제 사용 안함
	private DlvyVO dlvyInfo;
	
	private List<MbrAuthVO> mbrAuthList;
	private List<MbrRecipientsVO> mbrRecipientsList;

	private int existsTestYn;
	private int existsSimpleTestYn;
	private int existsSimpleCareYn;
}