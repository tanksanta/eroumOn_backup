package icube.planner.cntnts;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;

/**
 * 플래너 > 컨텐츠 페이지 (하드코딩)
 */
@Controller
@RequestMapping(value="#{props['Globals.Planner.path']}/cntnts")
public class PlannerCntntsController extends CommonAbstractController {

	@RequestMapping(value = "{pageName}")
	public String page(
			@PathVariable String pageName
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {


		return "/planner/cntnts/" + pageName;
	}



}
