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
	
	public void setRequest(RequestHolder requestHolder) {
		HttpSession session = requestHolder.getSession();
		session.setAttribute(MAT_MEMBER_SESSION_KEY, this);
	}
	
	public void login(HttpSession session, MbrVO mbrVO) {
		session.setAttribute(MAT_MEMBER_SESSION_KEY, this);
		session.setMaxInactiveInterval(60 * 60 * 4); // 4h
		
		setLoginCheck(true);
		setProperty(mbrVO);
	}
	
	public void logout() {
		setLoginCheck(false);
		setProperty(new MbrVO());
	}
	
	private void setProperty(MbrVO mbrVO) {
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
	}
}
