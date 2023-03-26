package icube.common.util;

import java.lang.reflect.Array;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;

public class StringUtil {


	/**
	 * 문자열 Byte길이로 자르기
	 * @param str
	 * @param cuttingBytes
	 * @return
	 * @throws Exception
	 */
	public static String cutString(String str, int cuttingBytes) throws Exception{
		if(str == null) str = "";
		int maxLength = str.length();
		StringBuffer sb = new StringBuffer("");

		for(int i = 0; i < maxLength; i++) {
			if(sb.toString().getBytes("UTF-8").length + str.substring(i, i+1).getBytes("UTF-8").length > cuttingBytes) break;
			sb.append(str.substring(i, i+1));
		}
		return sb.toString();
	}

	/**
	 * isEmpty의 경우 전자정부에서는 EgovStringUtil에 포함되어 마찮가지로 StringUtil에 임시 추가함
	 */
	public static boolean isEmpty(Object obj) {
		if (obj instanceof String) return obj == null || "".equals(obj.toString().trim());
		else if (obj instanceof List) return obj == null || ((List<?>) obj).isEmpty();
		else if (obj instanceof Map) return obj == null || ((Map<?, ?>) obj).isEmpty();
		else if (obj instanceof Object[]) return obj == null || Array.getLength(obj) == 0;
		else return obj == null;
	}

	public static boolean isNotEmpty(Object obj) {
		return !isEmpty(obj);
	}


	public static String lpad(String str, int len, String addStr) throws Exception {
        String result = str;
        int templen   = len - result.length();
        if (templen > 0) {
        	for (int i = 0; i < templen; i++){
                result = addStr + result;
          }
        }
        if (templen < 0) {
        	result = result.substring(0, len);
        }
        return result;
    }

	public static String nvl(Object obj) {
		return nvl(obj, "");
	}

	public static String nvl(String strVal, String strDefaultVal) {
		if (EgovStringUtil.isEmpty(strVal) || strVal == null || strVal.equals("null") || strVal == "") {
			strVal = strDefaultVal;
		}

		strVal = strVal.trim();

		return strVal;
	}

	public static String nvl(Object obj, String strDefaultValue) {
		String strVal = strDefaultValue;

		if (obj != null) {
			strVal = nvl(obj.toString().replace(" ",""), strDefaultValue);
		}

		strVal = strVal.trim();

		return strVal;
	}

	public static int nvl(Object obj, int defaultValue) {
		int iVal = defaultValue;

		if (obj != null) {
			iVal = nvl(obj.toString(), defaultValue);
		}

		return iVal;
	}

	public static int nvl(String strVal, int strDefaultVal) {
		int result = 0;

		try {
			if (strVal == null || strVal.equals("null")) {
				result = strDefaultVal;
			} else {
				result = Integer.parseInt(strVal.trim());
			}
		} catch (Exception e) {
			result = strDefaultVal;
		}

		return result;
	}

	public static String[] paramToStringArray(Map<String, Object> param, String key) {
		String[] result = null;
		if(!StringUtil.nvl(param.get(key),"").equals("")){
			if(param.get(key) instanceof String []){
				result = (String[])param.get(key);
			}else{
				result = new String[1];
				result[0]= StringUtil.nvl(param.get(key),"");
			}
		}
		return result;
	}

	public static String[] paramToStringArray(HttpServletRequest request, String key) {
		String[] result = null;
		if(!StringUtil.nvl(request.getParameterValues(key),"").equals("")){
			if(request.getParameterValues(key) instanceof String []){
				result = request.getParameterValues(key);
			}else{
				result = new String[1];
				result[0]= StringUtil.nvl(request.getParameterValues(key),"");
			}
		}
		return result;
	}

	/**
	 * <p>문자열 내부의 마이너스 character(-)를 모두 제거한다.</p>
	 *
	 * <pre>
	 * StringUtil.removeMinusChar(null)       = null
	 * StringUtil.removeMinusChar("")         = ""
	 * StringUtil.removeMinusChar("a-sdfg-qweqe") = "asdfgqweqe"
	 * </pre>
	 *
	 * @param str  입력받는 기준 문자열
	 * @return " - "가 제거된 입력문자열
	 *  입력문자열이 null인 경우 출력문자열은 null
	 */
	public static String removeMinusChar(String str) {
		return remove(str, '-');
	}

	/**
	 * <p>기준 문자열에 포함된 모든 대상 문자(char)를 제거한다.</p>
	 *
	 * <pre>
	 * StringUtil.remove(null, *)       = null
	 * StringUtil.remove("", *)         = ""
	 * StringUtil.remove("queued", 'u') = "qeed"
	 * StringUtil.remove("queued", 'z') = "queued"
	 * </pre>
	 *
	 * @param str  입력받는 기준 문자열
	 * @param remove  입력받는 문자열에서 제거할 대상 문자열
	 * @return 제거대상 문자열이 제거된 입력문자열. 입력문자열이 null인 경우 출력문자열은 null
	 */
	public static String remove(String str, char remove) {
		if (isEmpty(str) || str.indexOf(remove) == -1) {
			return str;
		}
		char[] chars = str.toCharArray();
		int pos = 0;
		for (int i = 0; i < chars.length; i++) {
			if (chars[i] != remove) {
				chars[pos++] = chars[i];
			}
		}
		return new String(chars, 0, pos);
	}

	public static int arraySearchIndex(String [] obj, String key) {
		int result = -1;
		if (isEmpty(obj) || obj.length < 1) {
			return result;
		}

		for (int i = 0; i < obj.length; i++) {
			if (key.equals(obj[i].trim())) {
				result = i;
			}
		}
		return result;
	}

	public static List<String> setDateList(String startDate, String endDate, String format) {
	    List<String> dateList = new ArrayList<String>();
	    SimpleDateFormat formatter = new SimpleDateFormat(format);
	    try {
	        Calendar beginDate = Calendar.getInstance();
	        Calendar stopDate = Calendar.getInstance();
	        beginDate.setTime(formatter.parse(startDate));
	        stopDate.setTime(formatter.parse(endDate));
	        while (beginDate.compareTo(stopDate) != 1) {
	            dateList.add(formatter.format(beginDate.getTime()));
	            beginDate.add(Calendar.DATE, 1);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return dateList;
	}

	public static String arrayToStringGubun(Map<String, Object> map, String key , String gubun) {
		String[] param = null;
		String result = "";
		if(!StringUtil.nvl(map.get(key),"").equals("")){
			if(map.get(key) instanceof String []){
				param = (String[])map.get(key);
				for(int i = 0 ; i < param.length ; i++) {
					if(i != 0)result = gubun;
					result += param[i];
				}
			}else if(StringUtil.nvl(map.get(key),"").indexOf(",") > (-1)){
				result= StringUtil.nvl(map.get(key),"").replace(",", gubun);
			}else{
				result= StringUtil.nvl(map.get(key),"");
			}
		}
		return result;
	}

}

