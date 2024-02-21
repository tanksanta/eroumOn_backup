package icube.app.matching;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	/**
	 * app전용 공통 메시지 모달 표출 jsp
	 */
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
	
	/**
	 * app 접근 권한 설정 페이지
	 */
	@RequestMapping(value = "/appAccessSetting")
	public String appAccessSetting(
			@RequestParam String redirectUrl,
			HttpSession session, 
			Model model) {
		model.addAttribute("redirectUrl", redirectUrl);
		return "/app/matching/appAccessSetting";
	}
	
	/**
	 * 등록완료 페이지 호출
	 */
	@RequestMapping(value = "/common/complete")
	public String complete(
			@RequestParam String redirectUrl,
			@RequestParam String msg,
			Model model) {
		model.addAttribute("redirectUrl", redirectUrl);
		model.addAttribute("msg", msg);
		return "/app/matching/common/screen/complete";
	}
}
