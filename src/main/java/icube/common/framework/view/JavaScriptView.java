package icube.common.framework.view;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

import icube.common.util.HtmlUtil;
import icube.common.util.egov.EgovDoubleSubmitHelper;
import java.util.HashMap;

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
			
			String location = script.getLocation();
			String httpMethod = script.getHttpMethod();
			String sTemp;
			
			if (httpMethod != null && httpMethod.equals("POST") && !"".equals(location) && script.getReqParams() != null) {
				out.println("document.addEventListener(\"DOMContentLoaded\", function(){");
				out.println(	"const form = document.createElement('form');");
				out.println(	"form.setAttribute('method', 'POST');");
				out.println(	"form.setAttribute('action', '" + location + "');");
				
				int ifor=1;
				boolean bToken = false;
				if (script.getJsonObject() != null && script.getJsonObject().get("loginRedirectDoubleSubmit").equals("1")) {
					bToken = true;
				}
				Map<String, Object> reqParams = script.getReqParams();
				for( String strKey : reqParams.keySet() ){
					if (strKey.equals(EgovDoubleSubmitHelper.SESSION_TOKEN_KEY) || strKey.equals(EgovDoubleSubmitHelper.PARAMETER_NAME) || strKey.equals("preventTokenKey")) {
						bToken = true;
						continue;
					}
					
					sTemp = HtmlUtil.addElementInputHidden(Integer.toString(ifor), "form", strKey, (String)reqParams.get(strKey));
					out.println(sTemp);
					ifor++;
				}
				
				if (bToken) {
					sTemp = this.getDoubleSubmit(request, "preventTokenKey");
					sTemp = HtmlUtil.addElementInputHidden(Integer.toString(ifor), "form", EgovDoubleSubmitHelper.PARAMETER_NAME, sTemp);
					out.println(sTemp);

					ifor++;
				}
				
				out.println(	"document.body.appendChild(form);");
				out.println(	"form.submit();");
				out.println("});");
			}else {
				if(!"".equals(location)) {
					out.println("location.href = \"" + location + "\";");
				}
				if(!"".equals(script.getMethod())) {
					out.println(script.getMethod() + ";");
				}
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
	
	/*
	 * DoubleSubmitTag.doStartTag에서 발췌
	 * */
	protected String getDoubleSubmit(HttpServletRequest request, String tokenKey) {
		HttpSession session = request.getSession();
		
		Map<String, String> map = null;
		
		if (session.getAttribute(EgovDoubleSubmitHelper.SESSION_TOKEN_KEY) == null) {
			map = new HashMap<String, String>();
			
			session.setAttribute(EgovDoubleSubmitHelper.SESSION_TOKEN_KEY, map);
		} else {
			map = (Map<String, String>) session.getAttribute(EgovDoubleSubmitHelper.SESSION_TOKEN_KEY);
		}
		
		// First call (check session)
		if (map.get(tokenKey) == null) {
			map.put(tokenKey, EgovDoubleSubmitHelper.getNewUUID());
//			LOGGER.debug("[Double Submit] session token created({}) : {}", tokenKey, map.get(tokenKey)); 
		}

		return map.get(tokenKey);
		// buffer.append("<input type='hidden' name='").append(EgovDoubleSubmitHelper.PARAMETER_NAME).append("' value='").append(map.get(tokenKey)).append("'/>");
	}

}
