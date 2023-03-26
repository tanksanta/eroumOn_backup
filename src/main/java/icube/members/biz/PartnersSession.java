package icube.members.biz;

import java.io.Serializable;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;

import icube.common.framework.request.RequestHolder;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;

/**
 * 파트너스(사업소, 입점업체) 세션
 * desc : 오픈시점에서는 사업소 정책만 존재함, 입점업체는 추가 예정
 */

@Getter
@Setter
public class PartnersSession implements Serializable {

	private static final long serialVersionUID = 987303267249944531L;

	private String uniqueId;
	private String partnersId;
	private String partnersNm;

	private String proflImg;

	private boolean loginCheck = false;

	@Setter(AccessLevel.NONE)
	@Value("#{props['Globals.Members.session.key']}")
	private String MEMBERS_SESSION_KEY;

	public void setRequest(RequestHolder requestHolder) {
		HttpSession session = requestHolder.getSession();
		session.setAttribute(MEMBERS_SESSION_KEY, this);
	}

}
