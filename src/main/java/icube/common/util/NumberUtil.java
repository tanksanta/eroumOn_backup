package icube.common.util;

public class NumberUtil {


	/**
	 * null to int
	 * @param obj
	 * @param defaultNum
	 * @return
	 */
	public static int nullToInt(Object obj, int defaultNum) {
		if( obj == null ) {
			return defaultNum;
		} else {
			try {
				return Integer.parseInt(obj.toString());
			} catch (NumberFormatException e) {
				return defaultNum;
			}
		}
	}

}

