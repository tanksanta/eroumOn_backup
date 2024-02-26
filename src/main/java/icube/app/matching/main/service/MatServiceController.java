package icube.app.matching.main.service;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 메인 서비스 페이지
 */
@Controller
@RequestMapping(value="#{props['Globals.Matching.path']}/main/service")
public class MatServiceController {
	
	
	@RequestMapping(value = "")
	public String service() {
		return "/app/matching/main/service";
	}
}
