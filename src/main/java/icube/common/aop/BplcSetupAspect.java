package icube.common.aop;

import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import icube.common.framework.exception.PageNotFoundException;
import icube.common.util.HtmlUtil;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.members.bplc.biz.BplcService;
import icube.manage.members.bplc.biz.BplcVO;
import icube.members.bplc.mng.biz.BplcBbsService;

/**
 * 사업소 > 사용자 Aspect
 * - 특정 Controller에서만 사업소 기본정보 호출
 *
 * @author kkm
 */
@Aspect
@Order(1)
@Component
public class BplcSetupAspect {

	private static final Logger logger = LoggerFactory.getLogger(BplcSetupAspect.class);

	@Resource(name = "messageSource")
	private MessageSource messageSource;

	@Resource(name = "bplcService")
	private BplcService bplcService;

	@Resource(name = "bplcBbsService")
	private BplcBbsService bplcBbsService;

	@Value("#{props['Globals.Members.path']}")
	private String membersPath;

	// 사업소 관리자를 제외한 컨트롤러에서만 실행
	@Pointcut("within(icube.members.bplc.BplcController)"
			+ " || within(icube.members.bplc.bbs.BplcBbsController)"
			+ " || within(icube.members.bplc.gds.BplcGdsController)"
			+ " || within(icube.members.bplc.lctn.BplcLctnController)"
			)
	private void bplcSetup() {}

	@Before(value = "bplcSetup()")
	private void beforeBoardSetting(
			JoinPoint joinPoint
			) throws Exception {

		HttpServletRequest request = null;
		for (Object o : joinPoint.getArgs()) {
			if (o instanceof HttpServletRequest) {
				request = (HttpServletRequest) o;
			}
		}

		HttpSession session = request.getSession();
		Locale locale = (Locale) session.getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);

		//String methodName = joinPoint.getSignature().getName();
		String bplcUrl = String.valueOf(joinPoint.getArgs()[0]);
		String curPath = request.getServletPath();

		// 사업소 기본정보 CALL
		BplcVO bplcSetupVO = bplcService.selectBplcByUrl(bplcUrl);
		// TEXTAREA 문자 처리
		bplcSetupVO.setIntrcn(HtmlUtil.enterToBr(bplcSetupVO.getIntrcn()));
		bplcSetupVO.setBusDrc(HtmlUtil.enterToBr(bplcSetupVO.getBusDrc()));
		bplcSetupVO.setSubwayDrc(HtmlUtil.enterToBr(bplcSetupVO.getSubwayDrc()));
		bplcSetupVO.setCarDrc(HtmlUtil.enterToBr(bplcSetupVO.getCarDrc()));
		request.setAttribute("bplcSetupVO", bplcSetupVO);


		if(bplcSetupVO == null || "N".equals(bplcSetupVO.getUseYn())) {
			throw new PageNotFoundException(messageSource.getMessage("partners.error.not.found", null, locale));
		} else if("Y".equals(bplcSetupVO.getUseYn()) && "W".equals(bplcSetupVO.getAprvTy())) {
			throw new PageNotFoundException(messageSource.getMessage("partners.error.approval.ing", null, locale));
		} else if("Y".equals(bplcSetupVO.getUseYn()) && "R".equals(bplcSetupVO.getAprvTy())) {
			throw new PageNotFoundException(messageSource.getMessage("partners.error.approval.reject", null, locale));
		} else {

			request.setAttribute("bplcRstdeCode", CodeMap.BPLC_RSTDE);

			request.setAttribute("_bplcPath", "/" + membersPath + "/" + bplcSetupVO.getBplcUrl());
			request.setAttribute("_curPath", curPath);

			// 사업소 공지사항 TOP5
			CommonListVO listVO = new CommonListVO(request, 1, 5);
			listVO.setParam("srchSttsTy", "P"); // 출판
			listVO.setParam("srchUseYn", "Y"); // 사용중
			listVO.setParam("bplcUniqueId", bplcSetupVO.getUniqueId());
			listVO = bplcBbsService.bplcBbsListVO(listVO);
			request.setAttribute("bplcNtceTop5", listVO.getListObject());
			// e : 사업소 공지사항 TOP5
		}
	}

}
