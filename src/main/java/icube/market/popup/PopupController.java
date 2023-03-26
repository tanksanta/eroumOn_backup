package icube.market.popup;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.common.framework.abst.CommonAbstractController;
import icube.manage.exhibit.popup.biz.PopupService;
import icube.manage.exhibit.popup.biz.PopupVO;

/**
 * 메인 > 팝업
 */

@Controller
@RequestMapping(value="comm/popup")
public class PopupController extends CommonAbstractController {

	@Resource(name = "popupService")
	private PopupService popupService;

	/**
	 * 팝업 새 창
	 */
	@RequestMapping(value = "{popNo}")
	public String newLink(
			HttpServletRequest request
			, @PathVariable("popNo") int popNo
			, Model model
			) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchPopNo", popNo);

		PopupVO popupVO = popupService.selectPopup(popNo);

		model.addAttribute("popupVO", popupVO);

		return "/market/popup/include/view";
	}



}
