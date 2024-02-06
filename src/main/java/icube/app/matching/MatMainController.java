package icube.app.matching;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.common.framework.abst.CommonAbstractController;

/**
 * 랜딩 페이지
 */
@Controller
@RequestMapping(value="#{props['Globals.Matching.path']}")
public class MatMainController extends CommonAbstractController {
	
	@RequestMapping(value = "")
	public String main() {
		return "/app/matching/main";
	}
	
	@RequestMapping(value = "/common/msg")
	public String appMsg(HttpSession session, Model model) {
		Object appMsg = session.getAttribute("appMsg");
		if (appMsg != null) {
			model.addAttribute("appMsg", appMsg);
		}
		Object appLocation = session.getAttribute("appLocation");
		if (appLocation != null) {
			model.addAttribute("appLocation", appLocation);
		}
		
		return "/app/matching/common/appMsg";
	}
}
