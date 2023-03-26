package icube.common.values;

import java.util.ArrayList;
import java.util.List;


public class CodeList {

	/** 첨부파일 제한 확장자 */
	public static final List<String> BAD_FILE_EXTENSION = new ArrayList<String>() {
		private static final long serialVersionUID = 1L;
		{
			add("bat");
			add("sh");
			add("exe");
			add("jsp");
			add("asp");
			add("php");
			add("html");
			add("perl");
			add("java");
			add("bash");
			add("app");
			add("pkg");
			add("rpm");
			add("deb");
		}
	};
}
