package icube.market.cntnts;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;

/**
 * 마켓 > 컨텐츠 페이지 (하드코딩)
 */
@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/cntnts")
public class CntntsController extends CommonAbstractController {

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;


	@RequestMapping(value = "{pageName}")
	public String MarketIndex(
			@PathVariable String pageName
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {


		return "/market/cntnts/" + pageName;
	}



}
