package icube.main;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
		, Model model
			) throws Exception {
		
		if(mbrSession.isLoginCheck()) {
			return  "redirect:/" + mainPath + "/index";
		}
		
		return "/main/login";
	}
}
