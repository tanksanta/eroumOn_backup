package icube.common.util;

import java.util.Map;

public class MapUtil {


    /**
	 * Map 에서 해당 key 값을 String  반환
	 * @param map - Map
	 * @param key - key
	 * @return String
	 * @exception Exception
	 */
	public static String getString(Map map, String key) {
		if (map == null) {
		      return "";
		}
	    if (map.get(key) == null) {
	      return "";
	    }

	    return map.get(key).toString();
	}

	/**
	 * Map 에서 해당 key 값을 int 형태로 반환
	 * @param map - Map
	 * @param key - key
	 * @return int
	 * @exception Exception
	 */
	public static int getInt(Map map, String key) {
		String result = null;

	    if (map.get(key) == null) {
	    	result = "0";
	    } else if (map.get(key).toString().equals("")) {
        	result = "0";
	    } else {
        	result = map.get(key).toString();
	    }

	    return Integer.parseInt(result);
	}
}
