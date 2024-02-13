package icube.app.matching.membership;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.app.matching.membership.mbr.biz.MatMbrSession;
import icube.common.framework.abst.CommonAbstractController;
import icube.manage.mbr.mbr.biz.MbrService;

/**
 * 매칭앱 - 일반 회원가입
 */
@Controller
@RequestMapping(value="#{props['Globals.Matching.path']}/membership")
public class MatRegistController extends CommonAbstractController {
	
	@Resource(name = "mbrService")
	private MbrService mbrService;
	
	@Autowired
	private MatMbrSession matMbrSession;
	
	@Value("#{props['Globals.Matching.path']}")
	private String matchingPath;
	
	@Value("#{props['Bootpay.Script.Key']}")
	private String bootpayScriptKey;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;
	
	
	@RequestMapping(value="regist")
	public String login(
			HttpServletRequest request
			, HttpSession session) {
		return "/app/matching/membership/regist";
	}
}
