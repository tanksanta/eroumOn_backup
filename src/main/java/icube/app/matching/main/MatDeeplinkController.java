package icube.app.matching.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 딥링크 이동 전용 페이지
 */
@Controller
@RequestMapping(value="app")
public class MatDeeplinkController {
	
	@RequestMapping(value = "deeplink")
	public String main() {
		return "/app/matching/common/deeplink";
	}
}
