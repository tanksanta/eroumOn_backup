package icube.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.market.mbr.biz.MbrSession;

/**
 * 통합 로그인
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="#{props['Globals.Main.path']}")
public class MainLoginController extends CommonAbstractController{
	
	@Autowired
	private MbrSession mbrSession;
	
	@Value("#{props['Globals.Main.path']}")
	private String mainPath;

	@RequestMapping(value = "login")
	public String login(
		HttpServletRequest request
		, HttpSession session
		, Model model
		, @RequestParam(value = "returnUrl", required=false) String returnUrl
		, @RequestParam(value = "recipter", required=false) String recipter
		, @RequestParam(value = "rcperRcognNo", required=false) String rcperRcognNo
			) throws Exception {
		
		if(mbrSession.isLoginCheck()) {
			return  "redirect:/" + mainPath + "/index";
		}
		
		if(EgovStringUtil.isNotEmpty(returnUrl)) {
			session.setAttribute("returnUrl", returnUrl);
		}
		
		if(EgovStringUtil.isNotEmpty(recipter)) {
			session.setAttribute("recipter", recipter);
		}
		
		if(EgovStringUtil.isNotEmpty(rcperRcognNo)) {
			session.setAttribute("rcperRcognNo", rcperRcognNo);
		}
		
		return "/main/login";
	}
}
