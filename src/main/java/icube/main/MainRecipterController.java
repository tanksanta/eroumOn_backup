package icube.main;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.common.api.biz.TilkoApiVO;
import icube.common.framework.abst.CommonAbstractController;
import icube.main.biz.ItemMap;
import icube.main.biz.MainService;

/**
 * 요양정보 간편 조회
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="#{props['Globals.Main.path']}/recipter")
public class MainRecipterController extends CommonAbstractController{

	@Resource(name = "mainService")
	private MainService mainService;
	
	@RequestMapping(value = "list")
	public String list(
		HttpServletRequest request
		, HttpSession session
		, Model model
			)throws Exception {
		
		TilkoApiVO apiVO = new TilkoApiVO();
		
		model.addAttribute("apiVO",apiVO);
		model.addAttribute("apiCode", ItemMap.RECIPTER_ITEM);
		model.addAttribute("recipter", (String)session.getAttribute("recipter"));
		model.addAttribute("rcperRcognNo", (String)session.getAttribute("rcperRcognNo"));
		
		return "/main/recipter/list";
	}
}
