package icube.common.util;

import java.util.Arrays;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ValidatorUtil {

	enum ValidatePattern {
		pattern_alpha(1, "^[A-Za-z]*$"),
		pattern_numeric(2, "^[0-9]*$"),
		pattern_korean(3, "^[ㄱ-ㅎ|가-힣]*$"),
		pattern_special(4, "^[~!@#\\$\\%\\^\\&\\*`\\(\\)\\+\\-_=\\\\:;<>,\\.\\?/\\|\\[\\]\\{\\}'\"]*$"),
		pattern_email(5, "^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{2,5}$"),
		pattern_url(6, "^(https?)://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]"),
		pattern_gis(7, "^[0-9]+\\.[0-9]+$"),
		pattern_valid_seo(8, "^[0-9|A-Z|a-z|\\/|\\-]*$"),
		pattern_invalid_seo(9, ".*?[\\s~!@#\\$\\%\\^\\&\\*`\\(\\)\\+_=\\\\:;<>,\\.\\?\\|\\[\\]\\{\\}'\"].*?"),
		pattern_valid_id(10, "[a-z0-9]{4,25}$"),
		pattern_valid_password(11, "^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,25}$");

		private int    key;
		private String pattern;

		private ValidatePattern(int key, String pattern) {
			this.key = key;
			this.pattern = pattern;
		}

		public int getKey() {
			return this.key;
		}

		public String getPattern() {
			return this.pattern;
		}

//		public ValidatePattern valueOf(int key) {
//			for(ValidatePattern vp : values()) {
//				if(vp.key == key) {
//					return vp;
//				}
//			}
//			return null;
//		}

		static ValidatePattern of(int key) {
			return Arrays.stream(values())
					.filter(v -> v.key == key)
					.findFirst()
					.orElseThrow(() -> new IllegalArgumentException(String.format("Unsupported type %d.", key)));
		}

	}

	/**
	 * Check Regular Expression
	 * @param validatePattern pattern enum
	 * @param value
	 * @return
	 */
	private static boolean patternChecker(ValidatePattern validatePattern, String value) {
		Pattern p = Pattern.compile(validatePattern.pattern);
		Matcher m = p.matcher(value);
		return m.matches();
	}

	/**
	 * Check Regular Expression
	 * @param patternIndex	pattern index
	 * @param value			value
	 * @return
	 */
	private static boolean patternChecker(int patternIndex, String value) {
		Integer pi = new Integer(patternIndex);
		if ((pi == null) || (pi < 1)) {
			return false;
		}
		return patternChecker(ValidatePattern.of(pi), value);
	}

	/**
	 * check NULL
	 * @param value
	 * @return
	 */
	private static boolean nullChecker(String value) {
		return StringUtil.isEmpty(value);
	}

	/**
	 * check NULL
	 * @param ValidatePattern
	 * @param value
	 * @return
	 */
	private static boolean nullChecker(ValidatePattern validatePattern, String value) {
		if (!nullChecker(value)) {
			return patternChecker(validatePattern, value);
		} else {
			return false;
		}
	}

	/**
	 * check NULL
	 * @param patternIndex
	 * @param value
	 * @return
	 */
	private static boolean nullChecker(int patternIndex, String value) {
		if (!nullChecker(value)) {
			return patternChecker(patternIndex, value);
		} else {
			return false;
		}
	}

	/**
	 * check minimum string length
	 * @param min
	 * @param value
	 * @return
	 */
	public static boolean isMin(int min, String value) {
		Integer m = new Integer(min);
		if ((m == null) || (m < 1)) {
			return false;
		}

		if (nullChecker(value)) {
			return false;
		}

		return (value.length() < min) ? false : true;
	}

	/**
	 * check maximum string length
	 * @param max
	 * @param value
	 * @return
	 */
	public static boolean isMax(int max, String value) {
		Integer m = new Integer(max);
		if ((m == null) || (m < 1)) {
			return false;
		}

		if (nullChecker(value)) {
			return false;
		}

		return (value.length() > max) ? false : true;
	}

	/**
	 * check minimum/maximum string length
	 * @param min
	 * @param max
	 * @param value
	 * @return
	 */
	public static boolean isMinMax(int min, int max, String value) {
		return (isMin(min, value) && isMax(max, value));
	}

	/**
	 * check alphabet
	 * @param value
	 * @return
	 */
	public static boolean isAlpha(String value) {
		return nullChecker(ValidatePattern.pattern_alpha, value);
	}

	/**
	 * check numeric
	 * @param value
	 * @return
	 */
	public static boolean isNumeric(String value) {
		return nullChecker(ValidatePattern.pattern_numeric, value);
	}

	/**
	 * check korean character
	 * @param value
	 * @return
	 */
	public static boolean isKorean(String value) {
		return nullChecker(ValidatePattern.pattern_korean, value);
	}

	/**
	 * check special character
	 * @param value
	 * @return
	 */
	public static boolean isSpecial(String value) {
		return nullChecker(ValidatePattern.pattern_special, value);
	}

	/**
	 * check alphabet & numeric
	 * @param value
	 * @return
	 */
	public static boolean isAlphaNumeric(String value) {
		if (!nullChecker(value)) {
			boolean bReturn = true;
			char[] cArr = value.toCharArray();
			int alphaLen = 0;
			int numericLen = 0;
			for (char c : cArr) {
				if (isAlpha(String.valueOf(c))) {
					alphaLen++;
				}
				if (isNumeric(String.valueOf(c))) {
					numericLen++;
				}
			}

			if ((alphaLen == 0) || (numericLen == 0) || (cArr.length != (alphaLen + numericLen))){
				bReturn = false;
			}

			return bReturn;
		} else {
			return false;
		}
	}

	/**
	 * check alphabet & numeric & special character
	 * @param value
	 * @return
	 */
	public static boolean isAlphaNumericSpecial(String value) {
		if (!nullChecker(value)) {
			boolean bReturn = true;
			char[] cArr = value.toCharArray();
			int alphaLen = 0;
			int numericLen = 0;
			int specialLen = 0;
			for (char c : cArr) {
				if (isAlpha(String.valueOf(c))) {
					alphaLen++;
				}
				if (isNumeric(String.valueOf(c))) {
					numericLen++;
				}
				if (isSpecial(String.valueOf(c))) {
					specialLen++;
				}
			}

			if ((alphaLen == 0) || (numericLen == 0) || (specialLen == 0) || (cArr.length != (alphaLen + numericLen + specialLen))){
				bReturn = false;
			}

			return bReturn;
		} else {
			return false;
		}
	}

	/**
	 * check Email
	 * @param value
	 * @return
	 */
	public static boolean isEmail(String value) {
		return nullChecker(ValidatePattern.pattern_email, value);
	}

	/**
	 * check URL
	 * @param value
	 * @return
	 */
	public static boolean isUrl(String value) {
		return nullChecker(ValidatePattern.pattern_url, value);
	}

	/**
	 * check GIS
	 * @param value
	 * @return
	 */
	public static boolean isGis(String value) {
		return nullChecker(ValidatePattern.pattern_gis, value);
	}

	/**
	 * check Seo
	 * @param value
	 * @return
	 */
	public static boolean isValidSeo(String value) {
		return nullChecker(ValidatePattern.pattern_valid_seo, value);
	}

	/**
	 * check invalid Seo
	 * @param value
	 * @return
	 */
	public static boolean isInValidSeo(String value) {
		return nullChecker(ValidatePattern.pattern_invalid_seo, value);
	}

	/**
	 * check  id check
	 * 5~25자리, 영문소문자, 숫자, 특수문자만 가능
	 * @param value
	 * @return
	 */
	public static boolean isValidId(String value){
		return nullChecker(ValidatePattern.pattern_valid_id, value);
	}

	/**
	 * check  password check
	 * 8~25자리, 알파벳, 숫자, 특수문자로 구성된 문자열
	 * @param value
	 * @return
	 */
	public static boolean isValidPassword(String value){
		return nullChecker(ValidatePattern.pattern_valid_password, value);
	}
}