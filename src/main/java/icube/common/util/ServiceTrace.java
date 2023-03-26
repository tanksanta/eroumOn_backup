package icube.common.util;

import org.aspectj.lang.ProceedingJoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.framework.Advised;

public class ServiceTrace {

	private static final Logger logger = LoggerFactory.getLogger(ServiceTrace.class);

	/**
	 * 로그 처리
	 * @param joinPoint ProceedingJoinPoint
	 * @return Object
	 * @throws Throwable
	 */
    public Object trace(ProceedingJoinPoint joinPoint) throws Throwable {
        Object target = joinPoint.getTarget();

        // 타켓이 advised 일 경우
		while (target instanceof Advised) {
			try {
				target = ((Advised) target).getTargetSource().getTarget();
			} catch (Exception e) {
				logger.error("Fail to get target object from JointPoint.", e);
			}
		}

        if (target == null) return null;

        //HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

		//String remoteIp = WebUtil.getIp(request);
        String className = target.getClass().getSimpleName(); // 실행 클래스명
        String methodName = joinPoint.getSignature().getName(); // 실행 메서드명
        //String processTy = "";
        //String logCn = "";

        StringBuffer buf = new StringBuffer();
        buf.append("\n*******************************************************************");
        buf.append("\n* Trace Aspect : executed " + methodName + "() in " + className + " Class.");

        // 파라미터 로그
        Object[] arguments = joinPoint.getArgs();

        if (arguments.length > 0) {
            buf.append("\n* parmameter");
            for (int i=0, len=arguments.length; i<len; i++) {
                if (arguments[i] == null) {
                    buf.append("\n*      - null");
                } else {
                    buf.append("\n*      - " + arguments[i].getClass().getName() + " : " + arguments[i].toString());
                }
            }
        } else {
            buf.append("\n* No arguments");
        }

        // 실행 시작 시간
        long start = System.currentTimeMillis();

        try {
            Object result = joinPoint.proceed();
            return result;

        } finally {
            long finish = System.currentTimeMillis(); // 서비스 완료 시간
            //buf.append("\n* execute ip : " + remoteIp);
            buf.append("\n* execute time : " + (finish - start) + "ms");
            buf.append("\n*******************************************************************");


            //공통으로 사용할 경우
            //mngLogService.createMngLog(processTy, request.getServletPath(), logCn);

            if (logger.isDebugEnabled()) {
                logger.debug(buf.toString());
            }
        }
    }

}
