package icube.common.framework.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.ptl.mvc.filter.HTMLTagFilterRequestWrapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HTMLTagFilter implements Filter {

	private static Logger log = LoggerFactory.getLogger(HTMLTagFilter.class);

	@SuppressWarnings("unused")
	private FilterConfig config;

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		String servletPath = ((HttpServletRequest) request).getServletPath();

		HttpServletResponse res = (HttpServletResponse) response;
        res.setHeader("X-UA-Compatible", "IE=Edge");

		log.info("####### servletPath : " + servletPath);
        log.info("####### request.getContentType : " + request.getContentType());
		log.info("################################## In XSS filter: " + servletPath);
		if (!servletPath.equals("/")
				&& servletPath.indexOf("#{props['Globals.Manager.path']}") == -1				//관리자 제외
				&& request.getContentType() != null // form이면
				&& request.getContentType().toLowerCase().indexOf("multipart/form-data") == -1 // 파일업로드가 아니면
				&& request.getContentType().toLowerCase().indexOf("application/x-www-form-urlencoded") == -1 // ajax 통신 아니면

		) {
			log.info("################################## In XSS filter: Yes ");
			chain.doFilter(new HTMLTagFilterRequestWrapper((HttpServletRequest) request), response);
		} else {
			log.info("################################## In XSS filter: No ");
			chain.doFilter(request, response);
		}

	}

	public void init(FilterConfig config) throws ServletException {
		this.config = config;
	}

	public void destroy() {

	}

}
