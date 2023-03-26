package icube.common.util;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.regex.Pattern;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * EgovWebUtil 확장
 */
public class WebUtil  {

	public static String getParameters(ServletRequest request ) {
		return getParameters(request, null);
	}

	@SuppressWarnings("rawtypes")
	public static String getParameters(ServletRequest request, String exclude[]) {
		Enumeration paramNames = request.getParameterNames();
		StringBuffer buf = new StringBuffer();
		while(paramNames.hasMoreElements()) {
			String name = (String)paramNames.nextElement();
			if( exclude == null || !ArrayUtil.isContainsInArray(exclude, name) ) {
				String value = request.getParameter(name);
				if( buf.length() > 0 )
					buf.append("&");

				try{
					buf.append(name + "=" + URLEncoder.encode(value, "UTF-8"));
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		}
		return buf.toString();
	}

	public static String clearXSSMinimum(String value) {
		if (value == null || value.trim().equals("")) {
			return "";
		}

		String returnValue = value;

		returnValue = returnValue.replaceAll("&", "&amp;");
		returnValue = returnValue.replaceAll("<", "&lt;");
		returnValue = returnValue.replaceAll(">", "&gt;");
		returnValue = returnValue.replaceAll("\"", "&#34;");
		returnValue = returnValue.replaceAll("\'", "&#39;");
		returnValue = returnValue.replaceAll("\\.", "&#46;");
		returnValue = returnValue.replaceAll("%2E", "&#46;");
		returnValue = returnValue.replaceAll("%2F", "&#47;");
		return returnValue;
	}

	public static String clearXSSMaximum(String value) {
		String returnValue = value;
		returnValue = clearXSSMinimum(returnValue);

		returnValue = returnValue.replaceAll("%00", null);

		returnValue = returnValue.replaceAll("%", "&#37;");

		// \\. => .

		returnValue = returnValue.replaceAll("\\.\\./", ""); // ../
		returnValue = returnValue.replaceAll("\\.\\.\\\\", ""); // ..\
		returnValue = returnValue.replaceAll("\\./", ""); // ./
		returnValue = returnValue.replaceAll("%2F", "");

		return returnValue;
	}

	public static String filePathBlackList(String value) {
		String returnValue = value;
		if (returnValue == null || returnValue.trim().equals("")) {
			return "";
		}

		returnValue = returnValue.replaceAll("\\.\\.", "");

		return returnValue;
	}

	/**
	 * 행안부 보안취약점 점검 조치 방안.
	 *
	 * @param value
	 * @return
	 */
	public static String filePathReplaceAll(String value) {
		String returnValue = value;
		if (returnValue == null || returnValue.trim().equals("")) {
			return "";
		}

		returnValue = returnValue.replaceAll("\\/", "");
		returnValue = returnValue.replaceAll("\\", "");
		returnValue = returnValue.replaceAll("\\.\\.", ""); // ..
		returnValue = returnValue.replaceAll("&", "");

		return returnValue;
	}

	public static String fileInjectPathReplaceAll(String value) {
		String returnValue = value;
		if (returnValue == null || returnValue.trim().equals("")) {
			return "";
		}


		returnValue = returnValue.replaceAll("/", "");
		returnValue = returnValue.replaceAll("\\..", ""); // ..
		returnValue = returnValue.replaceAll("\\\\", "");// \
		returnValue = returnValue.replaceAll("&", "");

		return returnValue;
	}

	public static String filePathWhiteList(String value) {
		return value;
	}

	public static boolean isIPAddress(String str) {
		Pattern ipPattern = Pattern.compile("\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}");

		return ipPattern.matcher(str).matches();
    }

	public static String removeCRLF(String parameter) {
		return parameter.replaceAll("\r", "").replaceAll("\n", "");
	}

	public static String removeSQLInjectionRisk(String parameter) {
		return parameter.replaceAll("\\p{Space}", "").replaceAll("\\*", "").replaceAll("%", "").replaceAll(";", "").replaceAll("-", "").replaceAll("\\+", "").replaceAll(",", "");
	}

	public static String removeOSCmdRisk(String parameter) {
		return parameter.replaceAll("\\p{Space}", "").replaceAll("\\*", "").replaceAll("|", "").replaceAll(";", "");
	}

	/** BROWSER 구분 **/
	public static String getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent").toUpperCase();

		if (header.indexOf("EDGE") > -1) return "EDGE(HTML)";
		else if (header.indexOf("EDG") > -1) return "EDGE(CHROMIUM)";
		else if (header.indexOf("MSIE") > -1) return "MSIE";
		else if (header.indexOf("TRIDENT") > -1) return "MSIE"; // IE11 문자열 깨짐 방지
		else if (header.indexOf("WHALE") > -1) return "WHALE"; // 네이버
		else if (header.indexOf("FIREFOX") > -1) return "FIREFOX";
		else if (header.indexOf("CHROME") > -1) return "CHROME";
		else if (header.indexOf("OPERA") > -1) return "OPERA";
		else if (header.indexOf("SAFARI") > -1) return "SAFARI";
		return "OTHER";
	}

	/** OS 구분 **/
	public static String getOs(HttpServletRequest request) {
		String header = request.getHeader("User-Agent").toUpperCase();

		if(header.indexOf("NT 6.4") != -1 || header.indexOf("NT 10") != -1) return "Windows 10";
		else if(header.indexOf("NT 6.3") != -1) return "Windows 8.1";
		else if(header.indexOf("NT 6.2") != -1) return "Windows 8";
		else if(header.indexOf("NT 6.1") != -1) return "Windows 7";
		else if(header.indexOf("NT 6.0") != -1) return "Windows Vista/Server 2008";
		else if(header.indexOf("NT 5.2") != -1) return "Windows Server 2003";
		else if(header.indexOf("NT 5.1") != -1) return "Windows XP";
		else if(header.indexOf("NT 5.0") != -1) return "Windows 2000";
		else if(header.indexOf("NT") != -1) return "Windows NT";
		else if(header.indexOf("9X 4.90") != -1) return "Windows Me";
		else if(header.indexOf("98") != -1) return "Windows 98";
		else if(header.indexOf("95") != -1) return "Windows 95";
		else if(header.indexOf("WIN16") != -1) return "Windows 3.x";

		// window 외
		else if(header.indexOf("LINUX") != -1) return "Linux";
		else if(header.indexOf("MAC") != -1) return "Mac";

		else if(header.indexOf("IPHONE") != -1) return "iPhone";
		else if(header.indexOf("IPAD") != -1) return "iPad";
		else if(header.indexOf("IPOD") != -1) return "iPod";
		else if(header.indexOf("ANDROID") != -1) return "android";
		else if(header.indexOf("BLACKBERRY") != -1) return "BlackBerry";
		else if(header.indexOf("WINDOWS PHONE") != -1) return "Windows Phone";
		else if(header.indexOf("BADA") != -1) return "Bada";

		else if(header.indexOf("CROS") != -1) return "Chrome OS";
		else if(header.indexOf("GOOGLETV") != -1) return "Google TV";
		else if(header.indexOf("PALM") != -1) return "PalmOS";
		else if(header.indexOf("WII") != -1) return "Nintendo Wii";
		else if(header.indexOf("PLAYSTATION") != -1) return "Playstation";

		// bot
		else if(header.indexOf("GOOGLEBOT") != -1) return "Google Bot";
		else if(header.indexOf("SLURP") != -1) return "Yahoo Bot";
		else if(header.indexOf("YETI") != -1) return "Naver Bot";
		else if(header.indexOf("DAUMOA") != -1) return "Daum Bot";
		else if(header.indexOf("BINGBOT") != -1) return "Bing Bot";
		else if(header.indexOf("BOT") != -1) return "Etc Bot";

		return "OTHER";
	}


	/* 디바이스 체크 > 태블릿,폰 등 제외 */
	public static String getDevice(HttpServletRequest request) {
	    String userAgent = request.getHeader("User-Agent").toUpperCase();
	    if(userAgent.indexOf("MOBI") > -1) {
	         return "MOBILE";
	    } else {
	        return "PC";
	    }
	}


	/** Content-Disposition **/
	public static void setContentDisposition(String fileName, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String browser = getBrowser(request);
		String dispositionPrefix = "attachment; filename=";
		String encodedFileName = "";

		if ("MSIE".equals(browser)) {
			encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
		} else if ("FIREFOX".equals(browser)) {
			encodedFileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1") + "\"";
		} else if ("OPERA".equals(browser)) {
			encodedFileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1") + "\"";
		} else if ("CHROME".equals(browser)) {
			StringBuffer sb = new StringBuffer();

			for (int i = 0; i < fileName.length(); i++) {
				char c = fileName.charAt(i);

				if (c > '~') {
					sb.append(URLEncoder.encode("" + c, "UTF-8"));
				} else {
					sb.append(c);
				}
			}

			encodedFileName = sb.toString();
		} else throw new IOException("Not supported browser");

		response.setHeader("Content-Disposition", dispositionPrefix + encodedFileName);

		if ("OPERA".equals(browser)) response.setContentType("application/octet-stream;charset=UTF-8");
	}

	public static boolean isImageFile(String orginlFileNm) {
		if(orginlFileNm.contains(".")){
			orginlFileNm = orginlFileNm.substring(orginlFileNm.lastIndexOf(".")+1);
		}
		String[] imgFileTypes = {"jpg", "gif", "bmp", "jpeg", "png"};

		if( ArrayUtil.isContainsInArray(imgFileTypes, orginlFileNm.toLowerCase()) ) {
			return true;
		} else {
			return false;
		}
	}
	/**
	 * 크로스 스크립트 패턴 검사
	 * @param value
	 * @param
 	 * @return
	 * @throws Exception
	 */
/*	".*src[\r\n]*=[\r\n]*\\\'(.*?)\\\'.*",
	".*src[\r\n]*=[\r\n]*\\\"(.*?)\\\".*",
*/
	public static Boolean isValidateInput(String value){
		String[] pattern= {
			".*<script>(.*?)</script>.*",
			".*</script>.*",
			".*<script(.*?)>.*",
			".*eval\\((.*?)\\).*",
			".*expression\\((.*?)\\).*",
			".*javascript:.*",
			".*vbscript:.*",
			".*onload(.*?)=.*",
			".*<iframe(.*?)>.*",
			".*<object(.*?)>.*",
			".*<applet(.*?)>.*",
			".*<embed(.*?)>.*",
			".*<form(.*?)>.*",

			".*onclick.*",
			".*ondbclick.*",
			".*onmousedown.*",
			".*onmouseup.*",
			".*onmouseout.*",
			".*onmousemove.*",
			".*onmouseover.*",

			".*onkeydown.*",
			".*onkeyup.*",
			".*onkeypress.*",
			".*onkeydown.*",

			".*ontimeout.*",
			".*onresize.*",
			".*onscroll.*"
		};
		for(String ptn : pattern){
			value = value.toLowerCase();
			if(value.matches(ptn)){
				return false;
			}
		}
		return true;
	}


	public static String clearSqlInjection(String str) {
		String result = "";

		if (str != null) {
			result = str.replaceAll("'", "");
			result = result.replaceAll(";", "");
			result = result.replaceAll("--" , "" );
			result = result.replaceAll("--, #" , "");
			result = result.replaceAll("\\|", "");
			result = result.replaceAll(":", "");
			result = result.replaceAll("\\+", "");
			result = result.replaceAll("\\\\", "");
			result = result.replaceAll("/", "");
			result = result.replaceAll("' or 1=1--" , "" );
			result = result.replaceAll("union" , " " );
			result = result.replaceAll("(?i)select", "");
			result = result.replaceAll("(?i)update", "");
			result = result.replaceAll("(?i)delete", "");
			result = result.replaceAll("(?i)drop", "");
			result = result.replaceAll("(?i)insert", "");
			result = result.replaceAll("(?i)alter", "");
			result = result.replaceAll("-1 or" , " " );
			result = result.replaceAll("-1' or" , " " );
			result = result.replaceAll("../" , " " );
			result = result.replaceAll("unexisting" , " " );
		}

		return result;
	}


	public static String getIp(HttpServletRequest request) {
		String remoteIp = ((ServletRequestAttributes) RequestContextHolder
				.currentRequestAttributes()).getRequest().getRemoteAddr();
		if (EgovStringUtil.isEmpty(remoteIp)) {
			remoteIp = ((ServletRequestAttributes) RequestContextHolder
					.currentRequestAttributes()).getRequest().getHeader(
					"X-Forwarded-For");
		}
		if (EgovStringUtil.equals(remoteIp, "0:0:0:0:0:0:0:1")) {
			remoteIp = "127.0.0.1";
		}
		return remoteIp;
	}

}
