package icube.main;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.common.framework.abst.CommonAbstractController;

/**
 * 랜딩 페이지
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="#{props['Globals.Main.path']}")
public class MainController extends CommonAbstractController  {

	@RequestMapping(value = {"","index"})
	public String list(
		HttpServletRequest request
		, Model model
			) throws Exception {
		
		return "/main/main";
	}
}
