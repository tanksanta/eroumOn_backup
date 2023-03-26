package icube.common.util;

import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.List;

/**
 * ArrayUtil
 */
public class ArrayUtil {

	/**
	 * Array > String
	 * @param strArray
	 * @param delimeter
	 * @return
	 */
	public static String arrayToString(String[] strArray, String delimeter) {
		return Arrays.toString(strArray).replace("[", "").replace("]", "");
	}

	/**
	 * String > Array
	 * @param str
	 * @return
	 */
	public static String[] stringToArray(String str) {
		return str.split(", ");
	}
	
	/**
	 * String > Array
	 * @param str
	 * @return
	 */
	public static String[] stringToArrayNotSpace(String str) {
		return str.split(",");
	}


	/**
	 * 배열에 특정값이 있는지 찾는 함수
	 * @param arr
	 * @param s
	 * @return boolean
	 */
	public static <T> boolean isContainsInArray(final T[] array, final T findValue) {
		for (final T e : array){
			if (e == findValue || (findValue != null && findValue.equals(e))) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 리스트에 특정값이 있는지 찾는 함수
	 * @param arr
	 * @param s
	 * @return boolean
	 */
	@SuppressWarnings("rawtypes")
	public static boolean isContainsInList(final List list, final Object findValue) {
		return list.contains(findValue);
	}

	/**
	 * 두개의 배열을 더하는 함수
	 * @param arr1
	 * @param arr2
	 * @return array
	 */
	public static Field[] mergeArray(Field[] arr1, Field[] arr2){
		int sumLength = arr1.length+arr2.length;
		Field[] arrSum = new Field[sumLength];

		for(int i=0; i<sumLength; i++) {
			if(i<arr1.length)
				arrSum[i] = arr1[i];
			else
				arrSum[i] = arr2[i-arr1.length];
		}
		return arrSum;
	}

}
