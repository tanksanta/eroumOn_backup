package icube.app.matching.membership.mbr.biz;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;

import icube.common.framework.request.RequestHolder;
import icube.manage.mbr.mbr.biz.MbrVO;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MatMbrSession extends MbrVO {
	
	@Setter(AccessLevel.NONE)
	@Value("#{props['Globals.Matching.session.key']}")
	private String MAT_MEMBER_SESSION_KEY;
	
	private boolean loginCheck = false; // 로그인 여부
	private boolean autoLoginCheck = false; // 자동로그인 최초 확인 여부
	
	public void setRequest(RequestHolder requestHolder) {
		HttpSession session = requestHolder.getSession();
		session.setAttribute(MAT_MEMBER_SESSION_KEY, this);
	}
	
	public void login(HttpSession session, MbrVO mbrVO) {
		session.setAttribute(MAT_MEMBER_SESSION_KEY, this);
		session.setMaxInactiveInterval(60 * 60 * 24 * 365 * 10); // 10년
		
		setLoginCheck(true);
		setAutoLoginCheck(true);
		setProperty(mbrVO);
	}
	
	public void logout() {
		setLoginCheck(false);
		setAutoLoginCheck(false);
		setProperty(new MbrVO());
	}
	
	public void setProperty(MbrVO mbrVO) {
		setUniqueId(mbrVO.getUniqueId());
		setMbrId(mbrVO.getMbrId());
		setMbrNm(mbrVO.getMbrNm());
		setMblTelno(mbrVO.getMblTelno());
		setTelno(mbrVO.getTelno());
		setEml(mbrVO.getEml());
		setZip(mbrVO.getZip());
		setAddr(mbrVO.getAddr());
		setDaddr(mbrVO.getDaddr());

		setCiKey(mbrVO.getCiKey()); // ci
		setDiKey(mbrVO.getDiKey()); // di
		setKakaoAppId(mbrVO.getKakaoAppId());
		setNaverAppId(mbrVO.getNaverAppId());
		
		setGender(mbrVO.getGender());
		setBrdt(mbrVO.getBrdt());
		setProflImg(mbrVO.getProflImg());
		setMberGrade(mbrVO.getMberGrade());
		setItrstField(mbrVO.getItrstField());
		setJoinTy(mbrVO.getJoinTy());
		setLgnTy(mbrVO.getLgnTy());
		setSnsRegistDt(mbrVO.getSnsRegistDt());

		setAccessToken(mbrVO.getAccessToken());
		setRefreshToken(mbrVO.getRefreshToken());
		
		setRecipterYn(mbrVO.getRecipterYn()); // 수급자 여부
		setRecipterInfo(mbrVO.getRecipterInfo()); // 수급자 정보
		
		setMbrAuthList(mbrVO.getMbrAuthList());
	}
}
