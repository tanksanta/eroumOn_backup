package icube.common.util;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.egovframe.rte.fdl.string.EgovStringUtil;

public class HtmlUtil {

	private static interface Patterns {
		public static final Pattern SCRIPTS = Pattern.compile("<(no)?script[^>]*>.*?</(no)?script>", Pattern.DOTALL);
		public static final Pattern STYLE = Pattern.compile("<style[^>]*>.*</style>", Pattern.DOTALL);
		public static final Pattern TAGS = Pattern.compile("<(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>");
		public static final Pattern ENTITY_REFS = Pattern.compile("&[^;]+;");
		//public static final Pattern WHITESPACE = Pattern.compile("\\s\\s+");
		public final static Pattern IMG_SRC_PATTERN = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");
		public final static Pattern YOUTUBE_SRC_PATTERN  = Pattern.compile("http(?:s)?:\\/\\/(?:m.)?(?:www\\.)?youtu(?:\\.be\\/|(?:be-nocookie|be)\\.com\\/(?:watch|[\\w]+\\?(?:feature=[\\w]+.[\\w]+\\&)?v=|v\\/|e\\/|embed\\/|user\\/(?:[\\w#]+\\/)+))([^&#?\\n]+)");
		//http(?:s)?:\/\/(?:m.)?(?:www\.)?youtu(?:\.be\/|(?:be-nocookie|be)\.com\/(?:watch|[\w]+\?(?:feature=[\w]+.[\w]+\&)?v=|v\/|e\/|embed\/|user\/(?:[\w#]+\/)+))([^&#?\n]+)
	}

	/**
	 * 개행문자 <br> 변경
	 * @param text
	 * @return
	 */
	public static String enterToBr(String text) {
		if( text == null )
			return "";
		return text.replaceAll("\n", " <br>");
	}

	/**
	 * HTML TAG 제거
	 * @param str
	 * @return
	 */
	/*public static String removeHtmlTag(String str){
		return EgovStringUtil.isNull(str) ? "" : str.replaceAll("(<script(\\s|\\S)*?<\\/script>)|(<style(\\s|\\S)*?<\\/style>)|(<!--(\\s|\\S)*?-->)|(<\\/?(\\s|\\S)*?>)", "");
	}*/

	public static String clean(String html) {
		if (html == null) {
			return "";
		}

		Matcher matcher;
		matcher = Patterns.SCRIPTS.matcher(html);
		html = matcher.replaceAll("");

		matcher = Patterns.STYLE.matcher(html);
		html = matcher.replaceAll("");

		matcher = Patterns.TAGS.matcher(html);
		html = matcher.replaceAll("");

		matcher = Patterns.ENTITY_REFS.matcher(html);
		html = matcher.replaceAll("");

		//matcher = Patterns.WHITESPACE.matcher(html);
		//html = matcher.replaceAll(" ");

		matcher = matcher.reset();

		html = html.trim();

		return html;
	}

	/**
	 * HTML > image만 추출
	 * @param html
	 * @return list
	 */
	public static List<String> getImageSrcs(String html) {
		List<String> result = new ArrayList<String>();
		Matcher matcher = Patterns.IMG_SRC_PATTERN.matcher(html);
		while(matcher.find()) {
			result.add(matcher.group(1));
		}
		return result;

	}

    public static String linkUrlCheck(String linkUrl) {
    	if(EgovStringUtil.isNotEmpty(linkUrl)) {
    		if(!linkUrl.matches("https.*")) {
    			linkUrl = "http://" + linkUrl.replaceAll("http://", "");
    		}
    	}
    	return linkUrl;
    }


    public static String cleanHtmlExcludeTag(String str, String strAllowTag) {
    	String[] allowTags = strAllowTag.split(",");
    	StringBuilder buffer = new StringBuilder();
    	for(int i=0; i<allowTags.length; i++) {
    		buffer.append("|"+ allowTags[i].trim() +"(?!\\w)");
    	}

    	return str.replaceAll("<(\\/?)(?!\\/"+ buffer.toString() +")([^<|>]+)?>", "");
    }


	public static String escapeXmlStr(String str) {
		str = str.replace("&", "&amp;");
		str = str.replace("<", "&lt;");
		str = str.replace(">", "&gt;");
		str = str.replace("'", "&apos;");
		str = str.replace("\"", "&quot;");

		return str;
	}


	public static String getYoutubeId(String videoUrl) {
		if(videoUrl == null) {
			return "";
		}
		String videoId = "";
	    Matcher matcher = Patterns.YOUTUBE_SRC_PATTERN.matcher(videoUrl);
	    if(matcher.find()){
	        videoId = matcher.group(1);
	    }
	    return videoId;
	}
}
