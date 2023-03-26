package icube.common.framework.exception;

public class PageNotFoundException extends Exception {

	private static final long serialVersionUID = -7868134178151778616L;

	public PageNotFoundException(Throwable throwable) {
		super(throwable);
	}

	public PageNotFoundException(String message) {
		super(message);
	}

	public PageNotFoundException(String message, Throwable throwable) {
		super(message, throwable);
	}
}
