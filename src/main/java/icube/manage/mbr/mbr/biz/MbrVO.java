package icube.manage.mbr.mbr.biz;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import icube.common.file.biz.FileVO;
import icube.common.vo.CommonBaseVO;
import icube.manage.mbr.recipter.biz.RecipterInfoVO;
import icube.market.mypage.info.biz.DlvyVO;
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
	private String emlRcptnYn ="N";
	private String telRecptnYn ="N";
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

	private String diKey; //ci값 => 휴대폰 본인인증(고유키 리턴)

	private String reqTy;
	private String delProflImg;

	private String naverAppId;
	private String kakaoAppId;
	private String kakaoAccessToken;

	// 첨부파일 체크
	private List<FileVO> fileList;

	//RecipterInfoVO
	private RecipterInfoVO recipterInfo;
	private List<DlvyVO> dlvyList;
	private boolean easyCheck;

}