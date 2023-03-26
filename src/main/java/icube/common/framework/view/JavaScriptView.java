package icube.common.framework.view;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

@Component("javascript")
public class JavaScriptView extends AbstractView {

	private JavaScript javascript;

	public JavaScriptView() {
		super();
	}
	public JavaScriptView(JavaScript javascript) {
		super();
		this.javascript = javascript;
	}

	public JavaScript getJavascript() {
		return javascript;
	}
	public void setJavascript(JavaScript javascript) {
		this.javascript = javascript;
	}

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Content-Type", "text/html");

		PrintWriter out = response.getWriter();

		JavaScript script = null;
		if(javascript == null) {
			for(Map.Entry<String,Object> entry : model.entrySet()) {
				if(entry.getValue() instanceof JavaScript) {
					script = (JavaScript)entry.getValue();
					break;
				}
			}
		} else {
			script = javascript;
		}

		out.println("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">");
		out.println("<html>");
		out.println("<head>");
		out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">");

		if(script != null) {

			if( EgovStringUtil.isNotEmpty(script.getSrc())) {
				out.println("<script type=\"text/javascript\" src=\"" + script.getSrc() + "\" ></script>");
			}

			out.println("<script type=\"text/javascript\">");

			if(!"".equals(script.getMessage())) {
				out.println("alert(\"" + script.getMessage() + "\");");
			}
			if(!"".equals(script.getLocation())) {
				out.println("location.href = \"" + script.getLocation() + "\";");
			}
			if(!"".equals(script.getMethod())) {
				out.println(script.getMethod() + ";");
			}
			if(script.getMethods() != null && script.getMethods().length > 0) {
				for(String method : script.getMethods()) {
					out.println(method + ";");
				}
			}

			out.println("</script>");
		}

		out.println("</head>");
		out.println("</html>");

		out.flush();
		out.close();
		javascript = null;

	}

}
