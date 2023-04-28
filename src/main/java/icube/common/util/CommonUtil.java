package icube.common.util;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;

public class CommonUtil {

	// CommonListVO의 getPageParam 별도로
	// Map에서 Param추출하기 위함
	public static String getPageParam(String[] targetParams, Map<String, Object> paramMap) {
		Iterator<String> keys = paramMap.keySet().iterator();
		StringBuffer sbParam = new StringBuffer();
		String parameter = "";

		while(keys.hasNext()){
			String key = keys.next();
			if (Arrays.asList(targetParams).contains(key)) {
				sbParam.append(key + "=" + paramMap.get(key) + "&");
			}
		}
		parameter = sbParam.toString();

		if (parameter.length() > 0) {
			parameter = parameter.substring(0, parameter.length() - 1);
		}

		return parameter;
	}


	/**
	 * 나이계산
	 * birthday = 2000-01-01
	 */
	public static String getAge(Date birthday) {
		 //현재 년도 구하기
		 Calendar now = Calendar.getInstance(); //년월일시분초
		 Integer currentYear = now.get(Calendar.YEAR);

		 //태어난년도를 위한 세팅
		 SimpleDateFormat format = new SimpleDateFormat("yyyy");
		 String stringBirthYear = format.format(birthday); //년도만받기
		 //태어난 년도
		 Integer birthYear = Integer.parseInt(stringBirthYear);

		 // 현재 년도 - 태어난 년도 => 나이 (만나이)
	     int age = (currentYear - birthYear);
	     String outputAge = Integer.toString(age);

	 	 return outputAge;
	}

}
