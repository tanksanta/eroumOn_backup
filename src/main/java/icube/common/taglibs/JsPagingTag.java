package icube.common.taglibs;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import icube.common.vo.CommonListVO;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class JsPagingTag extends TagSupport {

	private static final long serialVersionUID = 1L;
	private CommonListVO listVO;
	private String targetObject;

	public int doStartTag() throws JspException {
		JspWriter out = pageContext.getOut();

		int totalCount 	= listVO.getTotalCount();
		int curPage 	= listVO.getCurPage();
		int cntPerPage 	= listVO.getCntPerPage();
		int cntPerblock = listVO.getCntPerblock();

		try {

			int totalPage = 0;
			int blockNum = 0;
			int totalBlock = 0;

			// 페이지 설정에 필요한 값 연산
			if ( totalCount > 0) {

				if ( totalCount % cntPerPage == 0) {
					totalPage = (int) ( totalCount / cntPerPage);
				} else {
					totalPage = (int) ( totalCount / cntPerPage) + 1;
				}

				if ( curPage % cntPerblock == 0) {
					blockNum = (int)(curPage/cntPerblock);
				} else {
					blockNum = (int)(curPage/cntPerblock)+1;
				}

				if (totalPage % cntPerblock == 0) {
					totalBlock = (int) (totalPage / cntPerblock);
				} else {
					totalBlock = (int) (totalPage / cntPerblock) + 1;
				}
			}

			StringBuffer pageBuf = new StringBuffer();
			pageBuf.append("<div class=\"paging "+ targetObject +"\">\n");

			if (totalPage > 0) {

				if (blockNum > 1) {
					pageBuf.append("<a href=\"#prev\" title=\"이전  페이지\" class=\"prev\" data-page-no=\""+ (cntPerblock * (blockNum - 1)) +"\">");
				} else {
					pageBuf.append("<a href=\"#prev\" title=\"이전  페이지\" class=\"prev\" data-page-no=\""+ (1) +"\">");
				}
				pageBuf.append("이전</a>\n");

				for (int i = ((blockNum - 1) * cntPerblock + 1); i <= (blockNum * cntPerblock); i++) {
					if (i > totalPage) {
						break;
					} else {
						if (i != curPage) {
							pageBuf.append("<a href=\"#page\" class=\"page\" title=\"" + i + " 페이지\" data-page-no=\"" + i + "\" >" + i + "</a>\n");
						} else {
							pageBuf.append("<a href=\"#page\" class=\"page active\">").append(i).append("</a>\n");
						}
					}
				}

				if (blockNum != totalBlock) {
					pageBuf.append("<a href=\"#next\" title=\"다음  페이지\" class=\"next\" data-page-no=\""+ ((cntPerblock * blockNum) + 1) +"\" >");
				} else {
					pageBuf.append("<a href=\"#next\" title=\"다음  페이지\" class=\"next\" data-page-no=\""+ 0 +"\" >");
				}
				pageBuf.append("다음</a>\n");


			}
			pageBuf.append("</div>");

			out.println(pageBuf.toString());
		} catch(Exception e) {
			e.printStackTrace();
		}
		return SKIP_BODY;
	}
}
