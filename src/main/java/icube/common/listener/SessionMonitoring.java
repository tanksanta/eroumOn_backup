package icube.common.listener;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class SessionMonitoring implements HttpSessionListener {

	protected Log log = LogFactory.getLog(this.getClass());
	
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		log.debug("@@ session created @@");
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		log.debug("@@ session destroyed @@");
	}

}
