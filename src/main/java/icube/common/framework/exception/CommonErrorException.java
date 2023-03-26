package icube.common.framework.exception;

public class CommonErrorException extends Exception {

	private static final long serialVersionUID = -7868134178151778616L;

	public CommonErrorException(Throwable throwable) {
		super(throwable);
	}

	public CommonErrorException(String message) {
		super(message);
	}

	public CommonErrorException(String message, Throwable throwable) {
		super(message, throwable);
	}
}
