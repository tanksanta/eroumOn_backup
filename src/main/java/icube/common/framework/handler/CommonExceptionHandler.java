package icube.common.framework.handler;

import org.egovframe.rte.fdl.cmmn.exception.handler.ExceptionHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CommonExceptionHandler implements ExceptionHandler {

	private static final Logger LOGGER = LoggerFactory.getLogger(CommonExceptionHandler.class);

    /*
     * (non-Javadoc)
     * @see egovframework.rte.fdl.cmmn.exception.handler.ExceptionHandler#occur(java.lang.Exception, java.lang.String)
     */
    public void occur(Exception ex, String packageName) {

		try {
			LOGGER.debug(" ##### ExceptionHandler 클래스=" + packageName + " , exception 명" + ex.getClass().getName());
		} catch (Exception e) {
			e.printStackTrace();
		}
    }

}
