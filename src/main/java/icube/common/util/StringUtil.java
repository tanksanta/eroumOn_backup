package icube.common.util;

import java.lang.reflect.Array;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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


	// 이름 가운데 글자 마스킹
	public static String nameMasking(String name) throws Exception {
		if (EgovStringUtil.isEmpty(name)) {
			return name;
		}
		
		// 한글만 (영어, 숫자 포함 이름은 제외)
		String regex = "(^[가-힣]+)$";
		
		Matcher matcher = Pattern.compile(regex).matcher(name);
		if(matcher.find()) {
			int length = name.length();
			
			String middleMask = "";
			if(length > 2) {
				middleMask = name.substring(1, length - 1);
			} else {	// 이름이 외자
				middleMask = name.substring(1, length);
			}
			
			String dot = "";
			for(int i = 0; i<middleMask.length(); i++) {
				dot += "*";
			}
			
			if(length > 2) {
				return name.substring(0, 1)
						+ middleMask.replace(middleMask, dot)
						+ name.substring(length-1, length);
			} else { // 이름이 외자 마스킹 리턴
				return name.substring(0, 1)
						+ middleMask.replace(middleMask, dot);
			}
		}
		return name;
	}

	// 휴대폰번호 마스킹(가운데 숫자 4자리 마스킹)
	public static String phoneMasking(String phoneNo) throws Exception {
		if (EgovStringUtil.isEmpty(phoneNo)) {
			return phoneNo;
		}
		
		String regex = "(\\d{2,3})-?(\\d{3,4})-?(\\d{4})$";
		
		Matcher matcher = Pattern.compile(regex).matcher(phoneNo);
		if(matcher.find()) {
			String target = matcher.group(2);
			int length = target.length();
			char[] c = new char[length];
			Arrays.fill(c, '*');
			
			return phoneNo.replace(target, String.valueOf(c));
		}
		return phoneNo;
	}

	// 계좌번호 마스킹(뒤 5자리)
	public static String accountNoMasking(String accountNo) throws Exception {
		if (EgovStringUtil.isEmpty(accountNo)) {
			return accountNo;
		}
		
		// 계좌번호는 숫자만 파악하므로
		String regex = "(^[0-9]+)$";
		
		Matcher matcher = Pattern.compile(regex).matcher(accountNo);
		if(matcher.find()) {
			int length = accountNo.length();
			if(length > 5) {
				char[] c = new char[5];
				Arrays.fill(c, '*');
				
				return accountNo.replace(accountNo, accountNo.substring(0, length-5) + String.valueOf(c));
			}
		}
		return accountNo;
	}

	// 생년월일 마스킹(8자리)
	public static String birthMasking(String birthday) throws Exception {
		if (EgovStringUtil.isEmpty(birthday)) {
			return birthday;
		}
		
		String regex = "^((19|20)\\d\\d)?([-/.])?(0[1-9]|1[012])([-/.])?(0[1-9]|[12][0-9]|3[01])$";
		
		Matcher matcher = Pattern.compile(regex).matcher(birthday);
		if(matcher.find()) {
			return birthday.replace("[0-9]", "*");
		}
		return birthday;
	}

	// 카드번호 가운데 8자리 마스킹
	public static String cardMasking(String cardNo) throws Exception {
		if (EgovStringUtil.isEmpty(cardNo)) {
			return cardNo;
		}
		
		// 카드번호 16자리 또는 15자리 '-'포함/미포함 상관없음
		String regex = "(\\d{4})-?(\\d{4})-?(\\d{4})-?(\\d{3,4})$";
		
		Matcher matcher = Pattern.compile(regex).matcher(cardNo);
		if(matcher.find()) {
			String target = matcher.group(2) + matcher.group(3);
			int length = target.length();
			char[] c = new char[length];
			Arrays.fill(c, '*');
			
			return cardNo.replace(target, String.valueOf(c));
		}
		return cardNo;
	}
	
	// 이메일 마스킹 골뱅이 앞에 문자열 뒤 3자리 마스킹 ex) tes***@naver.com
	public static String emlMasking(String eml) throws Exception {
		if (EgovStringUtil.isEmpty(eml)) {
			return eml;
		}
		
		String[] split = eml.split("@");
		if (split.length < 2) {
			return eml;
		}
		
		String frontStr = split[0];
		if (frontStr.length() > 3) {
			frontStr = frontStr.substring(0, 3);  //앞에는 3자만 노출
			frontStr += "***";
		} else {
			frontStr = "***";
		}
		return frontStr + "@" + split[1];
	}
	
	// ID 문자열 뒤 3자리 마스킹 ex) tes***
	public static String idMasking(String id) throws Exception {
		if (EgovStringUtil.isEmpty(id)) {
			return id;
		}
		
		if (id.length() > 3) {
			id = id.substring(0, 3);
			id += "***";
		} else {
			id = "***";
		}
		return id;
	}
}

