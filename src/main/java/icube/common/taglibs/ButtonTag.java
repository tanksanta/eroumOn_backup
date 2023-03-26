package icube.common.taglibs;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.support.RequestContextUtils;

import icube.manage.sysmng.menu.biz.MngMenuService;
import icube.manage.sysmng.menu.biz.MngMenuVO;
import icube.manage.sysmng.mngr.biz.MngrSession;
import lombok.Getter;
import lombok.Setter;

/**
 * 권한에 따른 버튼 노출설정
 * @author K
 *
 */
@Getter
@Setter
public class ButtonTag extends BodyTagSupport {

	protected Log log = LogFactory.getLog(this.getClass());

	private static final long serialVersionUID = 1L;

	private String btnTy = null;
	private String modifyParam = null;
	private String path = null;
	private String script =  null;
	private String btnId = null;
	private String btnClass = "";
	private String defaultDisplay = "";

	@Autowired
	private MngrSession mngrSession;

	@Override
	public int doAfterBody() {
		JspWriter out = getPreviousOut();
		BodyContent body = getBodyContent();

		try {

			WebApplicationContext ctx = RequestContextUtils.findWebApplicationContext((HttpServletRequest) pageContext.getRequest(),
					pageContext.getServletContext());
			MngMenuService mngMenuService = (MngMenuService) ctx.getBean("mngMenuService");

			if(path.startsWith("/_mng/sysmng/bbs/")){//게시판일 경우
				path = "/_mng/sysmng/bbsSet/";
			}

			MngMenuVO menuVO = mngMenuService.selectMenuInfoFromUrl(path);

			String authrtYn = "";
			String bodyString = body.getString();

			for(int i=0;i<mngrSession.getMngMenuList().size();i++){
				if(menuVO.getMenuNo() == mngrSession.getMngMenuList().get(i).getMenuNo()){
					authrtYn = mngrSession.getMngMenuList().get(i).getAuthrtYn();
					break;
				}
			}
			if("save".equals(btnTy)){
				if("Y".equals(authrtYn)){
					String html = "";
					html += "<button class=\"btn "+ btnClass +"\"";
					if(btnId !=null && !btnId.equals("")) {
						html += " id=\""+btnId+"\"";
					}
					if(script != null && !script.equals("")){
						html += " onclick=\""+script+"\"";
					}
					html += ">"+bodyString+"</button>";
					out.print(html);
				}
			}else if("form".equals(btnTy)){
				if("Y".equals(authrtYn)){
					String html = "";
					if(modifyParam != null && !modifyParam.equals("")){
						html += "<a href=\"./form"+modifyParam+"\" class=\"btn "+ btnClass +"\">"+bodyString+"</a>";
					} else {
						html += "<a href=\"./form\" class=\"btn "+ btnClass +"\">"+bodyString+"</a>";
					}
					out.print(html);
				}
			}else if("modify".equals(btnTy)){
				if(authrtYn.equals("Y")){
					String html = "";
					html += "<a href=\"./form"+modifyParam+"\" class=\"btn "+ btnClass +"\">"+bodyString+"</a>";
					out.print(html);
				}
			}else if("use".equals(btnTy)){
				if(authrtYn.equals("Y")){
					String html = "";
					html += "<a href=\"#f_useAtChg\" ";
					html += "onclick=\""+script+"\" ";
					html += "class=\"btn "+ btnClass +"\">"+bodyString+"</a>";
					out.print(html);
				}

			}else if("delete".equals(btnTy)){
				if(authrtYn.equals("Y")){
					String html = "";
					html += "<button class=\"btn "+ btnClass +"\" id=\"delBtn\" ";
					if(script != null && !script.equals("")){
						html += "onclick=\""+script+"\"";
					}
					html += ">"+bodyString+"</button>";
					out.print(html);
				}
			}else if("display".equals(btnTy)) {//기타기능 숨김시
				if(authrtYn.equals("Y")){
					String html = bodyString;
					out.print(html);
				}else {
					if(!defaultDisplay.equals("")) {
						out.print(defaultDisplay);
					}
				}
			}else if("orther".equals(btnTy)){//기타버튼
				if(authrtYn.equals("Y")){
					String html = "";
					html += "<button class=\"btn "+ btnClass +"\" id=\"ortherBtn\" ";
					if(script != null && !script.equals("")){
						html += "onclick=\""+script+"\"";
					}
					html += ">"+bodyString+"</button>";
					out.print(html);
				}
			}
		} catch (Exception e) {
			log.error("버튼 생성 오류: " + e.toString());
		}
		return SKIP_BODY;
	}


}
