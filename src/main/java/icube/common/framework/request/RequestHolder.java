package icube.common.framework.request;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

public class RequestHolder {

	@Autowired
	private HttpServletRequest request;

	@Autowired
	private HttpSession session;

	public HttpServletRequest getRequest() {
		return request;
	}

	public HttpSession getSession() {
		return session;
	}
}
