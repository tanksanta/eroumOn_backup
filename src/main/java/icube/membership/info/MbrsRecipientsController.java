package icube.membership.info;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.common.framework.abst.CommonAbstractController;

/**
 * 마이페이지 > 수급자 관리
 */
@Controller
@RequestMapping(value = "#{props['Globals.Membership.path']}/info/recipients")
public class MbrsRecipientsController extends CommonAbstractController {
	
	/**
	 * 수급자 관리 목록
	 */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model
			) throws Exception {

		return "/membership/info/recipients/list";
	}
	/**
	 * 수급자 관리 상세
	 */
	@RequestMapping(value="view")
	public String view(
			HttpServletRequest request
			, Model model
			) throws Exception {

		return "/membership/info/recipients/view";
	}
}
