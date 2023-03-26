package icube.common.framework.view;

public class JavaScript {
	private String message, location, method, src;
	private String[] methods;

	public JavaScript() {
		this.src = "";
		this.message = "";
		this.location = "";
		this.method = "";
		this.methods = null;
	}
	public JavaScript(String message) {
		this.src = "";
		this.message = message;
		this.location = "";
		this.method = "";
		this.methods = null;
	}
	public JavaScript(String message, String location) {
		this.src = "";
		this.message = message;
		this.location = location;
		this.method = "";
		this.methods = null;
	}
	public JavaScript(String message, String[] methods) {
		this.src = "";
		this.message = message;
		this.location = "";
		this.method = "";
		this.methods = methods;
	}
	public JavaScript(String[] methods) {
		this.src = "";
		this.message = "";
		this.location = "";
		this.method = "";
		this.methods = methods;
	}
	public JavaScript(String message, String location, String method, String[] methods) {
		this.src = "";
		this.message = message;
		this.location = location;
		this.method = method;
		this.methods = methods;
	}

	public String getSrc() {
		return src;
	}

	public void setSrc(String src) {
		this.src = src;
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
}
