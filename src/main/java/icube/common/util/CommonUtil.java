package icube.common.util;

import java.util.Arrays;
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

}
