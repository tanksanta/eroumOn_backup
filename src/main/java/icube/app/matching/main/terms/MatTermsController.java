package icube.app.matching.main.terms;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.manage.sysmng.terms.TermsService;
import icube.manage.sysmng.terms.TermsVO;

/**
 * 약관 동의
 */
@Controller
@RequestMapping(value="#{props['Globals.Matching.path']}")
public class MatTermsController {
	
	@Resource(name = "termsService")
	private TermsService termsService;
	
	
	/**
	 * 약관동의 전용 페이지
	 */
	@RequestMapping(value = "/terms/{termsNo}")
	public String terms(@PathVariable Integer termsNo
			, Model model) throws Exception {
		
		TermsVO termsVO = termsService.selectTermsOne(termsNo);
		model.addAttribute("termsVO", termsVO);
		
		return "/app/matching/main/cntnts/terms";
	}
}
