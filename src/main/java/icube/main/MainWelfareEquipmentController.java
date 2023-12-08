package icube.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.common.framework.abst.CommonAbstractController;

/**
 * 관심 복지용구 상담 관련 컨트롤러
 */
@Controller
@RequestMapping(value="#{props['Globals.Main.path']}/welfare/equip")
public class MainWelfareEquipmentController extends CommonAbstractController{

	/**
	 * 관심 복지용구 상담 서브메인페이지
	 */
	@RequestMapping(value = "sub")
	public String sub(
		HttpServletRequest request
		, HttpSession session
		, Model model
			)throws Exception {
		
		return "/main/equip/sub";
	}
	
	/**
	 * 관심 복지용구 상담 페이지
	 */
	@RequestMapping(value = "list")
	public String list(
		Model model)throws Exception {
		
		return "/main/equip/list";
	}
}
