package icube.app.matching.main;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.app.matching.main.biz.AppVersionDAO;
import icube.app.matching.main.biz.AppVersionVO;
import icube.common.framework.abst.CommonAbstractController;

/**
 * 랜딩 페이지
 */
@Controller
@RequestMapping(value="#{props['Globals.Matching.path']}")
public class MatMainController extends CommonAbstractController {
	
	@Resource(name = "appVersionDAO")
	private AppVersionDAO appVersionDAO;
	
	
	@RequestMapping(value = "")
	public String main() {
		return "redirect:/matching/main/service";
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
	 * app 온보딩 (접근 권한 설정 전)
	 */
	@RequestMapping(value = "/onboarding")
	public String onboarding(
			@RequestParam String redirectUrl,
			Model model) {
		model.addAttribute("redirectUrl", redirectUrl);
		return "/app/matching/main/onboarding";
	}
	
	/**
	 * app 접근 권한 설정 페이지
	 */
	@RequestMapping(value = "/appAccessSetting")
	public String appAccessSetting(
			@RequestParam String redirectUrl,
			Model model) {
		model.addAttribute("redirectUrl", redirectUrl);
		return "/app/matching/main/appAccessSetting";
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
	
	/**
	 * 시스템 점검 페이지 호출
	 */
	@RequestMapping(value = "/common/systemCheck")
	public String systemCheck(
			Model model) {
		return "/app/matching/common/screen/systemCheck";
	}
	
	/**
	 * app 버전 조회 API
	 */
	@RequestMapping(value = "/app/version.json")
	@ResponseBody
	public Map<String, Object> appVersion() throws Exception {
		AppVersionVO appVersionVO = appVersionDAO.selectLastAppVersion("dolbom");
		Map <String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("version", appVersionVO.getVersion());
		resultMap.put("forceYn", appVersionVO.getForceYn());
		resultMap.put("regDt", appVersionVO.getRegDt());
		return resultMap;
	}
}
