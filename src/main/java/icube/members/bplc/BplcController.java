package icube.members.bplc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.common.framework.abst.CommonAbstractController;

/**
 * 사업소 > 기본 + 기타 페이지 (찾아오시는 길 등)
 */
@Controller
@RequestMapping(value="#{props['Globals.Members.path']}")
public class BplcController extends CommonAbstractController {


	@Value("#{props['Globals.Members.path']}")
	private String membersPath;

	@RequestMapping(value = {"/{bplcUrl}"})
	public String bplcIndex(
			@PathVariable String bplcUrl
			, HttpSession session
			, HttpServletRequest request
			, Model model) throws Exception {

		// GDS INDEX로 redirect
		return "redirect:/"+ membersPath +"/"+bplcUrl+"/gds/list";
	}



}
