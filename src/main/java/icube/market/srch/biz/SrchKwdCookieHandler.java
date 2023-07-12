package icube.market.srch.biz;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.fdl.string.EgovStringUtil;

import icube.common.util.StringUtil;

public class SrchKwdCookieHandler {


	public static List<String> getKwdListByCookie(
			HttpServletRequest request
			, HttpServletResponse response)
			throws UnsupportedEncodingException, Exception {

		String cookieKwd = getCookie(request, "keywords");
		List<String> resultCookieKwd = new ArrayList<String>();
		if(EgovStringUtil.isNotEmpty(cookieKwd)){
			String arrKwd[] = cookieKwd.split("__");
			for(String kwd : arrKwd) {
				if(EgovStringUtil.isNotEmpty(kwd)) {
					resultCookieKwd.add(URLDecoder.decode(kwd, "UTF-8"));
				}
			}
		}
		return resultCookieKwd;

	}


	public static void setKwdList(
			HttpServletRequest request
			, HttpServletResponse response
			, String srchKwd)
			throws UnsupportedEncodingException, Exception {

		if(EgovStringUtil.isNotEmpty(srchKwd)) {
			String encodeKwd = URLEncoder.encode(srchKwd, "UTF-8");
			String cookieKwd = getCookie(request, "keywords");
			if(EgovStringUtil.isNotEmpty(cookieKwd)){
				if(cookieKwd.indexOf(encodeKwd) < 0) {
					cookieKwd += "__" + encodeKwd;
				}
			}else {
				cookieKwd = "__" + encodeKwd;
			}
			setCookie(response, "keywords", cookieKwd);
		}

	}


	// 검색어 쿠키 처리
	public static void setCookie(HttpServletResponse response, String name, String value) throws Exception {
		Cookie cookie = new Cookie(name, StringUtil.nvl(value));
		cookie.setMaxAge(60*60*24*7);
		cookie.setPath("/");
		response.addCookie(cookie);
	}

	public static String getCookie(HttpServletRequest request, String name) throws Exception {
		Cookie[] cookies = request.getCookies();
		String cookie = null;
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals(name))
					cookie = cookies[i].getValue();
			}
		}
		return cookie;
	}
}
