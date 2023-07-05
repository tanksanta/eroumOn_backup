package icube.common.util;

/**
 * 유니코드 변환
 * @author ogy
 *
 */
public class UnicodeUtil {

	public static String codeToString(String str) throws Exception {

		StringBuffer result = new StringBuffer();

	    for(int i=0; i<str.length(); i++){
	        if(str.charAt(i) == '\\' &&  str.charAt(i+1) == 'u'){
	            Character c = (char)Integer.parseInt(str.substring(i+2, i+6), 16);
	            result.append(c);
	            i+=5;
	        }else{
	            result.append(str.charAt(i));
	        }
	    }
	    return result.toString();
	}

	public static String StringToCode(String str) throws Exception {

	  StringBuffer result = new StringBuffer();

	    for(int i=0; i<str.length(); i++){
	        int cd = str.codePointAt(i);
	        if (cd < 128){
	            result.append(String.format("%c", cd));
	        }else{
	            result.append(String.format("\\u%04x", cd));
	        }
	    }
	    return result.toString();
	}

}
