package icube.app.matching;

import org.springframework.stereotype.Controller;
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
	
}