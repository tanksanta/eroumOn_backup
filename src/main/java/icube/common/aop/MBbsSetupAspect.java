package icube.common.aop;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import icube.manage.sysmng.bbs.biz.BbsSetupService;
import icube.manage.sysmng.bbs.biz.BbsSetupVO;

@Aspect
@Order(2)
@Component
public class MBbsSetupAspect {

	private static final Logger logger = LoggerFactory.getLogger(MBbsSetupAspect.class);

	@Autowired
	private BbsSetupService bbsSetupService;

	@Pointcut("within(icube.manage.sysmng.bbs.MBbsController)")
	private void bbsSetup() {
	}

	@Before(value = "bbsSetup()")
	private void beforeBoardSetting(
			JoinPoint joinPoint) throws Exception {

		HttpServletRequest request = null;
		for (Object o : joinPoint.getArgs()) {
			if (o instanceof HttpServletRequest)
				request = (HttpServletRequest) o;
		}

		String methodName = joinPoint.getSignature().getName();
		logger.info("bbs methodName: " + methodName);

		if(EgovStringUtil.equals(methodName, "list") || EgovStringUtil.equals(methodName, "view")
				|| EgovStringUtil.equals(methodName, "form") || EgovStringUtil.equals(methodName, "answer")
				|| EgovStringUtil.equals(methodName, "action")) {
			int bbsNo = EgovStringUtil.string2integer(request.getParameter("bbsNo"));
			int srchBbsNo = EgovStringUtil.string2integer(request.getParameter("srchBbsNo"));

			if (bbsNo == 0) { bbsNo = srchBbsNo; }
			if (bbsNo > 0) {
				BbsSetupVO bbsSetupVO = bbsSetupService.selectBbsSetup(bbsNo);
				request.setAttribute("bbsSetupVO", bbsSetupVO);
				logger.info("게시판 정보: " + bbsSetupVO.getBbsNm());
			}
		}
	}


}
