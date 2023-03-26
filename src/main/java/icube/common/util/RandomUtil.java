package icube.common.util;

import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.Random;

public class RandomUtil {

	// Method to generate a random alphanumeric password of a specific length
	public static String getRandomPassword(int len)
	{
		// ASCII range – alphanumeric (0-9, a-z, A-Z)
		//final String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
		final String chars = "ABCDEFGHIJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"; //대문자 O, 소문자 l 삭제
		final String num = "0123456789";
		final String special = "!@#$%^&*";

		SecureRandom random = new SecureRandom();
		StringBuilder sb = new StringBuilder();

		for (int i = 0; i < Math.ceil(len / 3); i++)
		{
			int randomIndex = random.nextInt(chars.length());
			int randomIndex2 = random.nextInt(num.length());
			int randomIndex3 = random.nextInt(special.length());
			sb.append(chars.charAt(randomIndex));
			sb.append(num.charAt(randomIndex2));
			sb.append(special.charAt(randomIndex3));
		}

		return sb.toString();
	}

	/**
	 * getRandomNum(100000000, 9999999999)
	 * @param startNum
	 * @param endNum
	 * @return
	 */
    public static int getRandomNum(int startNum, int endNum) {
		int randomNum = 0;

		// 랜덤 객체 생성
		SecureRandom rnd = new SecureRandom();

		do {
			// 종료숫자내에서 랜덤 숫자를 발생시킨다.
			randomNum = rnd.nextInt(endNum + 1);
		} while (randomNum < startNum); // 랜덤 숫자가 시작숫자보다 작을경우 다시 랜덤숫자를 발생시킨다.

		return randomNum;
    }


	public static String getRandomStr(char startChr, char endChr) {

		int randomInt;
		String randomStr = null;

		// 시작문자 및 종료문자를 아스키숫자로 변환한다.
		int startInt = Integer.valueOf(startChr);
		int endInt = Integer.valueOf(endChr);

		// 시작문자열이 종료문자열보가 클경우
		if (startInt > endInt) {
			throw new IllegalArgumentException("Start String: " + startChr + " End String: " + endChr);
		}

		// 랜덤 객체 생성
		SecureRandom rnd = new SecureRandom();

		do {
			// 시작문자 및 종료문자 중에서 랜덤 숫자를 발생시킨다.
			randomInt = rnd.nextInt(endInt + 1);
		} while (randomInt < startInt); // 입력받은 문자 'A'(65)보다 작으면 다시 랜덤 숫자 발생.

		// 랜덤 숫자를 문자로 변환 후 스트링으로 다시 변환
		randomStr = (char) randomInt + "";

		// 랜덤문자열를 리턴
		return randomStr;
	}


	public static String getRandomDate(String sDate1, String sDate2) {
		String dateStr1 = DateUtil.validChkDate(sDate1);
		String dateStr2 = DateUtil.validChkDate(sDate2);

		String randomDate = null;

		int sYear, sMonth, sDay;
		int eYear, eMonth, eDay;

		sYear = Integer.parseInt(dateStr1.substring(0, 4));
		sMonth = Integer.parseInt(dateStr1.substring(4, 6));
		sDay = Integer.parseInt(dateStr1.substring(6, 8));

		eYear = Integer.parseInt(dateStr2.substring(0, 4));
		eMonth = Integer.parseInt(dateStr2.substring(4, 6));
		eDay = Integer.parseInt(dateStr2.substring(6, 8));

		GregorianCalendar beginDate = new GregorianCalendar(sYear, sMonth - 1, sDay, 0, 0);
		GregorianCalendar endDate = new GregorianCalendar(eYear, eMonth - 1, eDay, 23, 59);

		if (endDate.getTimeInMillis() < beginDate.getTimeInMillis()) {
			throw new IllegalArgumentException("Invalid input date : " + sDate1 + "~" + sDate2);
		}

		SecureRandom r = new SecureRandom();

		long rand = ((r.nextLong() >>> 1) % (endDate.getTimeInMillis() - beginDate.getTimeInMillis() + 1)) + beginDate.getTimeInMillis();

		GregorianCalendar cal = new GregorianCalendar();
		//SimpleDateFormat calformat = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat calformat = new SimpleDateFormat("yyyyMMdd", Locale.ENGLISH);
		cal.setTimeInMillis(rand);
		randomDate = calformat.format(cal.getTime());

		// 랜덤문자열를 리턴
		return randomDate;
	}



	/**
	 * ranNum 8자리 + 알파벳 2자리
	 */
	public static String ranNum() {
		Random random = new Random();
		int createNum = 0;
		String ranNum = "";
		int letter = 8;
		String resultNum = "";
		String lowerRan = "";

		for(int i=0; i<letter; i++) {

			createNum = random.nextInt(9);
			ranNum = Integer.toString(createNum);
			resultNum += ranNum;
		}

		//문자열
		for (int i=0;i<2; i++) {
			char lowerCh = (char)((int) (Math.random()*25) + 97);
			lowerRan += lowerCh;
		}

		return lowerRan.toUpperCase() + resultNum;
	}

}
