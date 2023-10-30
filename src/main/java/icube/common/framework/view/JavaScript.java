package icube.common.framework.view;

import java.util.Map;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONObject;

import icube.common.util.Base64Util;
import icube.common.util.JsonUtil;

public class JavaScript {
	private String message, location, method, src, httpMethod;
	private String[] methods;
	private Map<String, Object> reqParams;/*httpMethod=POST인 경우 포스트 파라미터 */
	private JSONObject jsonObject;/* 현재는 .get("loginRedirectDoubleSubmit").equal("1") 만 사용*/

	public JavaScript() {
		this("", "", "", null, null);
	}
	public JavaScript(String message) {
		this(message, "", "", null, null);
	}
	public JavaScript(String message, String location) {
		this(message, location, "", null, null);
	}
	public JavaScript(String message, String[] methods) {
		this(message, "", "", methods, null);
	}
	public JavaScript(String[] methods) {
		this("", "", "", methods, null);
	}
	public JavaScript(String message, String location, String method) {
		this(message, location, method, null, null);
	}
	public JavaScript(String message, String location, String method, String[] methods) {
		this(message, location, method, methods, null);
	}

	public JavaScript(String message, String location, String method, String[] methods, JSONObject jsonObject) {
		this.src = "";
		this.message = message;
		this.location = location;
		this.method = method;
		this.methods = methods;
		this.jsonObject = jsonObject;
	}
	public String getSrc() {
		return src;
	}

	public void setSrc(String src) {
		this.src = src;
	}

	public String getHttpMethod() {
		return httpMethod;
	}

	public void setHttpMethod(String src) {
		this.httpMethod = src;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		if("".equals(location)) {location = "/"; }//TO-DO
		this.location = location;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String[] getMethods() {
		return methods;
	}

	public void setMethods(String[] methods) {
		this.methods = methods;
	}
	
	public JSONObject getJsonObject() {
		return this.jsonObject;
	}

	public void setJsonObject(JSONObject val) {
		this.jsonObject = val;
	}

	public Map<String, Object> getReqParams() {
		return this.reqParams;
	}

	public void setReqParamsBase64(String param) throws Exception {
		if (EgovStringUtil.isEmpty(param)) {
			this.reqParams = null;
			return;
		}
		
		param = Base64Util.decoder(param);
		
		JSONObject jsonObject = JsonUtil.getJsonObjectFromString(param);
		
		this.reqParams = JsonUtil.getMapFromJsonObject(jsonObject);
	}
}
