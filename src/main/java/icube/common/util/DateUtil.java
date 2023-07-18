package icube.common.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.commons.lang.time.DateUtils;
import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DateUtil {

	private static final Logger logger = LoggerFactory.getLogger(DateUtil.class);

	/**
	 * 현재 년-월-일 시:분:초
	 * @return
	 */
	public static String getCurrentDttm() {
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
	}


	/**
	 * 날짜형식 변환
	 * @param dateStr
	 * @param pattern
	 * @return
	 */
	public static String convertDate(String dateStr, String pattern) {

		if( dateStr.trim().length() < 8 ) {
			return dateStr;
		}

		try {
			int year = EgovStringUtil.string2integer(dateStr.substring(0,4));
			int month = EgovStringUtil.string2integer(dateStr.substring(4,6)) - 1;
			int date = EgovStringUtil.string2integer(dateStr.substring(6,8));

			Calendar cal = Calendar.getInstance();
			cal.set(year, month, date);

			Date targetDate = cal.getTime();
			SimpleDateFormat format = new SimpleDateFormat(pattern);

			return format.format(targetDate);
		} catch(Exception e) {
			return dateStr;
		}
	}

    /**
     * format에 맞는 현재 날짜 및 시간을 리턴
     * @param format yyyy-MM-dd HH:mm:ss
     * @return String
     */
    public static String getCurrentDateTime(String format){
        return new SimpleDateFormat(format).format(new Date());
    }

    /**
	 * Date format String을 "yyyy/MM/dd" format으로 convert format 한다!
	 * @IssueID :
	 * @param str
	 *            original date format String
	 * @return
	 * @throws ParseException
	 */
	public static String formatDate( String str ) throws ParseException {
		return formatDate( str, "yyyy/MM/dd" );
	}

	/**
	 * Date format String을 pattern으로 convert format 한다!
	 * @IssueID :
	 * @param str
	 *            original date format String
	 * @param pattern
	 *            변경할 date format
	 * @return
	 * @throws ParseException
	 */
	public static String formatDate( String str, String pattern ) throws ParseException {
		if( str == null ) return "";
		Date dt = DateUtils.parseDate( str, new String[] { "yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss.S",
				"yyyy-MM-dd HH:mm", "yyyy/MM/dd HH:mm", "yyyyMMdd", "yyyy/MM/dd" } );
		return DateFormatUtils.format( dt, pattern );
	}

	public static String nowSimpleDateFormat(String pattern ) throws ParseException {
		 SimpleDateFormat sdf = new SimpleDateFormat(pattern);
	     Calendar c1 = Calendar.getInstance();
		 String strToday = sdf.format(c1.getTime());
		return strToday;
	}

	public static String getFirstDate() throws Exception {
		Calendar cal = Calendar.getInstance();
		cal.setTime( new Date() );

		cal.set( Calendar.DATE, 1 );

		SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd", new Locale( "ko", "KOREA" ) );
		String dateFirst = formatter.format( cal.getTime() );

		return dateFirst;
	}

	public static String getLastDate() throws Exception {
		Calendar cal = Calendar.getInstance();
		cal.setTime( new Date() );

		int month = cal.get( Calendar.MONTH ) + 1;
		cal.set( Calendar.MONTH, month );
		cal.set( Calendar.DATE, 0 );

		SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd", new Locale( "ko", "KOREA" ) );
		String dateLast = formatter.format( cal.getTime() );

		return dateLast;
	}

	public static String getYear() throws Exception {
		Calendar cal = Calendar.getInstance();
		cal.setTime( new Date() );
		int year = cal.get( Calendar.YEAR ) ;
		return String.valueOf( year );
	}

	public static String getMonth() throws Exception {
		String returnParam="";
		Calendar cal = Calendar.getInstance();
		cal.setTime( new Date() );
		int month = cal.get( Calendar.MONTH )+1 ;
		returnParam = String.valueOf( month );
		if(month < 10)returnParam = "0"+month;

		return returnParam;
	}

	/*
	 * 현재날짜 전달 1일... jinny100
	 */
	public static String getFirstDatePreMon() throws Exception {
		String dateFirst = "";

		Calendar cal = Calendar.getInstance();
		cal.setTime( new Date() );

		int month = cal.get( Calendar.MONTH ) - 1;
		cal.set( Calendar.MONTH, month );
		cal.set( Calendar.DATE, 1 );

		SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd", new Locale( "ko", "KOREA" ) );
		dateFirst = formatter.format( cal.getTime() );

		return dateFirst;
	}

	/*
	 * 현재날짜 전달 말일... jinny100
	 */
	public static String getLastDatePreMon() throws Exception {
		Calendar cal = Calendar.getInstance();
		cal.setTime( new Date() );

		int month = cal.get( Calendar.MONTH );
		cal.set( Calendar.MONTH, month );
		cal.set( Calendar.DATE, 0 );

		SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd", new Locale( "ko", "KOREA" ) );
		String dateLast = formatter.format( cal.getTime() );

		return dateLast;
	}

	/**
	 * (0 = Sunday, 1 = Monday, 2 = Tuesday, 3 = Wednesday, 4 = Thursday, 5 =
	 * Friday, 6 = Saturday) 특정일(yyyyMMdd) 에서 주어진 일자만큼 더한 날짜를 계산한다.
	 *
	 * @param date
	 *            특정일
	 * @param rday
	 *            주어진 일자
	 * @return 더한 날짜
	 * @throws Exception
	 *             modified by keegun!!!!
	 */
	public static String getRelativeDate( String date, int rday ) throws Exception {
		if( date == null ) return null;
		if( date.length() < 8 ) return ""; // 최소 8 자리
		String time = "";

		TimeZone kst = TimeZone.getTimeZone( "JST" );
		TimeZone.setDefault( kst );
		Calendar cal = Calendar.getInstance( kst ); // 현재
		int yyyy = Integer.parseInt( date.substring( 0, 4 ) );
		int mm = Integer.parseInt( date.substring( 4, 6 ) );
		int dd = Integer.parseInt( date.substring( 6, 8 ) );
		cal.set( yyyy, mm - 1, dd ); // 카렌더를 주어진 date 로 세팅하고
		cal.add( Calendar.DATE, rday ); // 그 날짜에서 주어진 rday 만큼 더한다.
		time = new SimpleDateFormat( "yyyyMMdd" ).format( cal.getTime() );

		return time;
	}

	/**
	 * 날짜를 다양한 형태로 리턴한다. 예) getDate("yyyyMMdd"); getDate("yyyyMMddHHmmss");
	 * getDate("yyyy/MM/dd HH:mm:ss"); getDate("yyyy/MM/dd"); getDate("HHmm");
	 *
	 * @param type
	 *            날짜형태
	 * @return String SimpleDateFormat
	 * @throws Exception
	 */
	public static String getDate( String type ) throws Exception {
		if( type == null ) return null;
		String s = "";

		s = new SimpleDateFormat( type ).format( new Date() );

		return s;
	}

	/**
	 * 해당날짜의 요일을 계산한다. (년월일(6자리)을 지정하는데 지정되지 않으면 default 값을 사용한다. 2000.2)
	 *
	 * 예) getDayOfWeek("2000") -> 토 (2000/1/1) getDayOfWeek("200002") -> 화
	 * (2000/2/1) getDayOfWeek("20000225") -> 금 (2000/2/25)
	 *
	 * @param date
	 *            요일을 구할 날짜
	 * @return String 요일
	 */
	public static String getDayOfWeek( String date ) throws Exception {
		if( date == null ) return null;
		int yyyy = 0, MM = 1, dd = 1, day_of_week; // default
		String days[] = { "일", "월", "화", "수", "목", "금", "토" };

		yyyy = Integer.parseInt( date.substring( 0, 4 ) );
		MM = Integer.parseInt( date.substring( 4, 6 ) );
		dd = Integer.parseInt( date.substring( 6, 8 ) );

		Calendar cal = Calendar.getInstance();
		cal.set( yyyy, MM - 1, dd );
		day_of_week = cal.get( Calendar.DAY_OF_WEEK );
		//1(일),2(월),3(화),4(수),5(목),6(금),7(토)
		return days[day_of_week - 1];
	}

	/**
	 * 오늘의 요일을 계산한다.
	 *
	 * @return String yyyyMMdd
	 * @throws Exception
	 */
	public static String getDayOfWeek() throws Exception {
		return getDayOfWeek( getDate( "yyyyMMdd" ) );
	}

	/**
	 * 시간을 스트링으로 받어서 type 형태로 리턴한다.
	 *
	 * 예) formatTime("1200","HH:mm") -> "12:00" formatTime("1200","HH:mm:ss") ->
	 * "12:00:00" formatTime("120003","HH:mm") -> "12:00"
	 * formatTime("120003","HH:mm ss") -> "12:00 03"
	 *
	 * @param time
	 *            시간
	 * @param type
	 *            시간형태
	 * @return 시간을 스트링으로 받어서 type 형태로 리턴
	 * @throws Exception
	 */

	public static String formatTime( String time, String type ) throws Exception {
		if( time == null || type == null ) return null;

		String result = "";
		int hour = 0, min = 0, sec = 0, length = time.length();

		hour = Integer.parseInt( time.substring( 0, 2 ) );
		min = Integer.parseInt( time.substring( 2, 4 ) );
		sec = Integer.parseInt( time.substring( 4, 6 ) );
		Calendar cal = Calendar.getInstance();
		cal.set( 0, 0, 0, hour, min, sec );
		result = ( new SimpleDateFormat( type ) ).format( cal.getTime() );

		return result;
	}

	/**
	 * 두 시간의 차이를 분으로 계산한다.
	 *
	 * 예) getMinuteDiff("20000302","20000303") --> 3600
	 * getMinuteDiff("2000030210","2000030211") --> 60
	 * getMinuteDiff("200003021020","200003021021") --> 1
	 * getMinuteDiff("20000302102000","20000302102130") --> 1 처음 파라메터가 작은 날짜인데
	 * 만약 더 큰날짜를 처음으로 주면 음수를리턴.
	 *
	 * @param s_start
	 *            첫번째 시간
	 * @param s_end
	 *            두번째 시간
	 * @return 두 시간의 차이를 분으로 계산
	 * @throws Exception
	 */
	public static int getMinuteDiff( String s_start, String s_end ) throws Exception {
		long l_start, l_end, l_gap;
		int i_start_year = 0, i_start_month = 1, i_start_day = 1, i_start_hour = 0, i_start_min = 0, i_start_sec = 0;
		int i_end_year = 0, i_end_month = 1, i_end_day = 1, i_end_hour = 0, i_end_min = 0, i_end_sec = 0;
		try {
			i_start_year = Integer.parseInt( s_start.substring( 0, 4 ) );
			i_start_month = Integer.parseInt( s_start.substring( 4, 6 ) );
			// month는 Calendar에서 0 base으로 작동하므로 1 을 빼준다.
			i_start_day = Integer.parseInt( s_start.substring( 6, 8 ) );
			i_start_hour = Integer.parseInt( s_start.substring( 8, 10 ) );
			i_start_min = Integer.parseInt( s_start.substring( 10, 12 ) );
			i_start_sec = Integer.parseInt( s_start.substring( 12, 14 ) );

			i_end_year = Integer.parseInt( s_end.substring( 0, 4 ) );
			i_end_month = Integer.parseInt( s_end.substring( 4, 6 ) );
			// month는 Calendar에서0 base으로 작동하므로 1 을 빼준다.
			i_end_day = Integer.parseInt( s_end.substring( 6, 8 ) );
			i_end_hour = Integer.parseInt( s_end.substring( 8, 10 ) );
			i_end_min = Integer.parseInt( s_end.substring( 10, 12 ) );
			i_end_sec = Integer.parseInt( s_end.substring( 12, 14 ) );

		} finally {
			logger.debug("getMinuteDiff error");
		}

		Calendar cal = Calendar.getInstance();
		cal.set( i_start_year, i_start_month - 1, i_start_day, i_start_hour, i_start_min,
				i_start_sec );
		l_start = cal.getTime().getTime();
		cal.set( i_end_year, i_end_month - 1, i_end_day, i_end_hour, i_end_min, i_end_sec );
		l_end = cal.getTime().getTime();
		l_gap = l_end - l_start;
		return (int)( l_gap / ( 1000 * 60 ) );
	}

	/**
	 * 일정표에서 사용하는 반복적인 날짜 입력시 사용..
	 * @param s
	 * @param type
	 * @param gubn
	 * @param rec
	 * @return
	 * @throws Exception
	 */
	public static String getDateAdd( String s, String type, String gubn, int rec ) throws Exception {
		String result = "";
		int year = 0, month = 0, day = 0, length = s.length();

		if( s == null ) return null;
		if( type == null ) return null;
		if( length != 8 ) return null;

		Calendar cal = Calendar.getInstance();

		try {
			year = Integer.parseInt( s.substring( 0, 4 ) );
			month = Integer.parseInt( s.substring( 4, 6 ) ) - 1; // month 는 Calendar 에서 0 base 으로 작동하므로 1 을 빼준다.
			day = Integer.parseInt( s.substring( 6, 8 ) );

			cal.set( year, month, day );
			if( gubn == "year" ) cal.add( Calendar.YEAR, rec );
			if( gubn == "month" ) cal.add( Calendar.MONTH, rec );
			if( gubn == "date" ) cal.add( Calendar.DATE, rec );
			if( gubn == "week" ) cal.add( Calendar.WEEK_OF_MONTH, rec );
			if( gubn == "hour" ) cal.add( Calendar.HOUR_OF_DAY, rec );
			if( gubn == "minute" ) cal.add( Calendar.MINUTE, rec );

			result = ( new SimpleDateFormat( type ) ).format( cal.getTime() );
		} finally {
			cal = null;
		}

		return result;
	}

	/**
	 * 날짜를 입력하면 요일을 나타내준다..
	 * @param date
	 * @return
	 */
	public static int Weekday( String date ) throws Exception {
		if( date == null ) return -1;

		int yyyy = 0, MM = 1, dd = 1, day_of_week; // default

		try {
			yyyy = Integer.parseInt( date.substring( 0, 4 ) );
			MM = Integer.parseInt( date.substring( 4, 6 ) );
			dd = Integer.parseInt( date.substring( 6, 8 ) );
		} finally {
			logger.debug("Weekday error");
		}

		Calendar cal = Calendar.getInstance();
		cal.set( yyyy, MM - 1, dd );
		day_of_week = cal.get( Calendar.DAY_OF_WEEK ); //1(일),2(월),3(화),4(수),5(목),6(금),7(토)

		return day_of_week;
	}

	/**
	 * 오늘 날짜를 리턴한다...
	 * @param date
	 * @return
	 */
	public static String getToday() throws Exception {
		Calendar cal = Calendar.getInstance();
		return ( new SimpleDateFormat( "yyyyMMddHHmmss" ) ).format( cal.getTime() );
	}

	/**
	 * 오늘 날짜 포맷 형태로 리턴
	 * @param formatStr
	 * @return
	 */
	public static String getToday(String formatStr)
	  {
	    SimpleDateFormat format = new SimpleDateFormat(formatStr, Locale.getDefault());
	    return format.format(new Date());
	  }

	/*
	 * 해당년도 월 의 마지막 일자 리턴
	 */
	public static int lastDay( int year, int month ) throws java.text.ParseException {
		int day = 0;
		switch( month ) {
		case 1 :
		case 3 :
		case 5 :
		case 7 :
		case 8 :
		case 10 :
		case 12 :
			day = 31;
			break;
		case 2 :
			if( ( year % 4 ) == 0 ) {
				if( ( year % 100 ) == 0 && ( year % 400 ) != 0 ) {
					day = 28;
				} else {
					day = 29;
				}
			} else {
				day = 28;
			}
			break;
		default :
			day = 30;
		}
		return day;
	}

	public static long getDate() {
		Calendar cal = Calendar.getInstance();
		return cal.getTime().getTime();
	}

	/**
	 * 몇번째 주인지 리턴
	 * @IssueID :
	 * @param date
	 * @return
	 * @throws Exception
	 */
	public static int getWeekSeq( String date ) throws Exception {
		if( date == null ) return -1;

		int yyyy = 0, MM = 1, dd = 1, day_of_week; // default

		try {
			yyyy = Integer.parseInt( date.substring( 0, 4 ) );
			MM = Integer.parseInt( date.substring( 4, 6 ) );
			dd = Integer.parseInt( date.substring( 6, 8 ) );
		} finally {
			logger.debug("getWeekSeq error");
		}

		Calendar cal = Calendar.getInstance();
		cal.set( yyyy, MM - 1, 1 );
		day_of_week = cal.get( Calendar.DAY_OF_WEEK ); //1(일),2(월),3(화),4(수),5(목),6(금),7(토)

		int seq = 0;
		seq = ( dd + day_of_week + 5 ) / 7 ;
		return seq;
	}

	public static String lastDayOfMonth(String src) throws java.text.ParseException {
    return lastDayOfMonth(src, "yyyyMMdd");
	}

	public static String lastDayOfMonth(String src, String format) throws java.text.ParseException {
		java.text.SimpleDateFormat formatter =
	    new java.text.SimpleDateFormat (format, java.util.Locale.KOREA);
		java.util.Date date = check(src, format);

		java.text.SimpleDateFormat yearFormat =
	    new java.text.SimpleDateFormat("yyyy", java.util.Locale.KOREA);
		java.text.SimpleDateFormat monthFormat =
	    new java.text.SimpleDateFormat("MM", java.util.Locale.KOREA);

	    int year = Integer.parseInt(yearFormat.format(date));
	    int month = Integer.parseInt(monthFormat.format(date));
	    int day = lastDay(year, month);

	    java.text.DecimalFormat fourDf = new java.text.DecimalFormat("0000");
	    java.text.DecimalFormat twoDf = new java.text.DecimalFormat("00");
	    String tempDate = fourDf.format(year)
	                     + twoDf.format(month)
	                     + twoDf.format(day);
	    date = check(tempDate, format);

	    return formatter.format(date);
	}

	/**
	 * check date string validation with an user defined format.
	 * @param s date string you want to check.
	 * @param format string representation of the date format. For example, "yyyy-MM-dd".
     * @return date java.util.Date
	 */
	public static java.util.Date check(String s, String format) throws java.text.ParseException {
		if ( s == null )
			throw new java.text.ParseException("date string to check is null", 0);
		if ( format == null )
			throw new java.text.ParseException("format string to check date is null", 0);

		java.text.SimpleDateFormat formatter =
            new java.text.SimpleDateFormat (format, java.util.Locale.KOREA);
		java.util.Date date = null;
		try {
			date = formatter.parse(s);
		}
		catch(java.text.ParseException e) {
            /*
			throw new java.text.ParseException(
				e.getMessage() + " with format \"" + format + "\"",
				e.getErrorOffset()
			);
            */
            throw new java.text.ParseException(" wrong date:\"" + s +
            "\" with format \"" + format + "\"", 0);
		}

		if ( ! formatter.format(date).equals(s) )
			throw new java.text.ParseException(
				"Out of bound date:\"" + s + "\" with format \"" + format + "\"",
				0
			);
        return date;
	}


	/**
	 * 입력된 일자 문자열을 확인하고 8자리로 리턴
	 * @param sDate
	 * @return
	 */
	public static String validChkDate(String dateStr) {
		String _dateStr = dateStr;

		if (dateStr == null || !(dateStr.trim().length() == 8 || dateStr.trim().length() == 10)) {
			throw new IllegalArgumentException("Invalid date format: " + dateStr);
		}
		if (dateStr.length() == 10) {
			_dateStr = dateStr.replace("-", "");
		}
		return _dateStr;
	}

	/**
	 * 만나이 구하기
	 * @param dateStr yyyy-MM-dd 형식
	 * @return 만나이
	 */
	public static String getAge(Date birthDate) {
		if (birthDate == null) {
			return "";
		}
		
		Calendar birthCalendar = Calendar.getInstance();
		birthCalendar.setTime(birthDate);
		 int birthYear = birthCalendar.get(Calendar.YEAR);
		 int birthMonth = birthCalendar.get(Calendar.MONTH) + 1;
		 int birthDay = birthCalendar.get(Calendar.DAY_OF_MONTH);
		 
		 Calendar current = Calendar.getInstance();
         int currentYear  = current.get(Calendar.YEAR);
         int currentMonth = current.get(Calendar.MONTH) + 1;
         int currentDay   = current.get(Calendar.DAY_OF_MONTH);
         
         int age = currentYear - birthYear;
         if (birthMonth * 100 + birthDay > currentMonth * 100 + currentDay) {
        	 age--;
         }
         
         return String.valueOf(age);
	}
}
