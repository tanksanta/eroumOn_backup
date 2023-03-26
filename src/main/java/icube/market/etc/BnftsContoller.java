package icube.market.etc;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.common.framework.abst.CommonAbstractController;

@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/etc/bnft")
public class BnftsContoller extends CommonAbstractController{

	/**
	 * 혜택 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model
			)throws Exception {


		return "/market/etc/bnft";
	}
}
