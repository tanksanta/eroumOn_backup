package icube.market.mbr.biz;

import java.io.Serializable;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;

import icube.common.framework.request.RequestHolder;
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

	// 선택 보호자 수급자 정보
	private String prtcrRecipterYn = "N";
	private int prtcrRecipterIndex = 0;
	private RecipterInfoVO prtcrRecipterInfo;


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

		setGender(mbrVO.getGender());
		setBrdt(mbrVO.getBrdt());
		setProflImg(mbrVO.getProflImg());
		setMberGrade(mbrVO.getMberGrade());
		setItrstField(mbrVO.getItrstField());

		setRecipterYn(mbrVO.getRecipterYn()); // 수급자 여부
		setRecipterInfo(mbrVO.getRecipterInfo()); // 수급자 정보

		setPrtcrList(mbrVO.getPrtcrList()); // 보호자 정보

		setLoginCheck(loginCheck);
	}

	// 보호자 수급자정보 set
	public void setPrtcrRecipter(RecipterInfoVO recipterInfoVO, String recipterYn, int index) {
		setPrtcrRecipterYn(recipterYn);
		setPrtcrRecipterInfo(recipterInfoVO);
		setPrtcrRecipterIndex(index);
	}



}
