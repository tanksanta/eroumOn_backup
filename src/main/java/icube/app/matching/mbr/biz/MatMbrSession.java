package icube.app.matching.mbr.biz;

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
}
