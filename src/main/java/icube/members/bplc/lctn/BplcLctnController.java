package icube.members.bplc.lctn;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.common.framework.abst.CommonAbstractController;

/**
 * 사업소 > 오시는길
 */

@Controller
@RequestMapping(value="#{props['Globals.Members.path']}/{bplcUrl}/lctn")
public class BplcLctnController extends CommonAbstractController {

	@Value("#{props['Globals.Members.path']}")
	private String membersPath;

	@RequestMapping(value = {"", "index"})
	public String lctnIndex(
			@PathVariable String bplcUrl
			, HttpSession session
			, HttpServletRequest request
			, Model model) throws Exception {

		return "/members/bplc/lctn/lctn";
	}

}
