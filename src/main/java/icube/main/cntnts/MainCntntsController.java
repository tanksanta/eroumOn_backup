package icube.main.cntnts;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 메인 랜딩 페이지 > 컨텐츠 페이지
 */
@Controller
@RequestMapping(value="#{props['Globals.Main.path']}/cntnts")
public class MainCntntsController extends CommonAbstractController {

	@Autowired
    private MbrSession mbrSession;
	
	@Autowired
	private MbrService mbrService;
	 
	@Value("#{props['Globals.Main.path']}")
	private String mainPath;
	
	@RequestMapping(value = "{pageName}")
	public String page(
			@PathVariable String pageName
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {
		
		if ("test-result".equals(pageName)) {
			if(!mbrSession.isLoginCheck()) {
				String returnUrl = "/main/cntnts/test-result";
				session.setAttribute("returnUrl", returnUrl);
				return "redirect:" + "/"+ mainPath + "/login?returnUrl=" + returnUrl;
			}
			
		    MbrVO mbrVO = mbrService.selectMbrByUniqueId(mbrSession.getUniqueId());
			model.addAttribute("mbrEml", mbrVO.getEml());
		}

		return "/main/cntnts/" + pageName;
	}
}
