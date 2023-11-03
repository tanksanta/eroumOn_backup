package icube.market.mbr.biz;

import java.io.Serializable;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;

import icube.common.framework.request.RequestHolder;
import icube.common.interceptor.biz.CustomProfileVO;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.mbr.recipter.biz.RecipterInfoVO;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class MbrSession extends MbrVO implements Serializable {

	private static final long serialVersionUID = 1122298133272109714L;

	private boolean loginCheck = false; // 로그인 여부
	private boolean registCheck = false; // 회원가입 체크(채널톡 때문에)

	/*마켓에서 오류가 나서 다시 추가함. 더이상 사용하지 말자 2023-11-03*/
	private String prtcrRecipterYn = "N";
	private RecipterInfoVO prtcrRecipterInfo;

	

	//채널톡 연동 데이터
	private CustomProfileVO customProfileVO;
	
	

	@Setter(AccessLevel.NONE)
	@Value("#{props['Globals.Member.session.key']}")
	private String MEMBER_SESSION_KEY;

	public void setRequest(RequestHolder requestHolder) {
		HttpSession session = requestHolder.getSession();
		session.setAttribute(MEMBER_SESSION_KEY, this);
	}


	public void setMbrInfo(HttpSession session, MbrSession mbrSession) {
		session.setAttribute(MEMBER_SESSION_KEY, mbrSession);
		session.setMaxInactiveInterval(60 * 60 * 4); // 4h
	}


	public void setParms(MbrVO mbrVO, Boolean loginCheck) {
		setUniqueId(mbrVO.getUniqueId());
		setMbrId(mbrVO.getMbrId());
		setMbrNm(mbrVO.getMbrNm());
		setMblTelno(mbrVO.getMblTelno());
		setTelno(mbrVO.getTelno());
		setEml(mbrVO.getEml());
		setZip(mbrVO.getZip());
		setAddr(mbrVO.getAddr());
		setDaddr(mbrVO.getDaddr());

		setDiKey(mbrVO.getDiKey()); // di
		setKakaoAppId(mbrVO.getKakaoAppId());
		setNaverAppId(mbrVO.getNaverAppId());
		
		setGender(mbrVO.getGender());
		setBrdt(mbrVO.getBrdt());
		setProflImg(mbrVO.getProflImg());
		setMberGrade(mbrVO.getMberGrade());
		setItrstField(mbrVO.getItrstField());
		setJoinTy(mbrVO.getJoinTy());
		setSnsRegistDt(mbrVO.getSnsRegistDt());

		setRecipterYn(mbrVO.getRecipterYn()); // 수급자 여부
		setRecipterInfo(mbrVO.getRecipterInfo()); // 수급자 정보

		setLoginCheck(loginCheck);
	}
}