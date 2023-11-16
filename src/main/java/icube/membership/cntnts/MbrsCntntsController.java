package icube.membership.cntnts;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.manage.sysmng.terms.TermsService;
import icube.manage.sysmng.terms.TermsVO;

/**
 * 멤버쉽 > 컨텐츠 페이지 (하드코딩)
 */
@Controller
@RequestMapping(value="#{props['Globals.Membership.path']}/cntnts")
public class MbrsCntntsController extends CommonAbstractController {

	@Resource(name = "termsService")
	private TermsService termsService;

	@RequestMapping(value = "{pageName}")
	public String MarketIndex(
			@PathVariable String pageName
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {

		if (EgovStringUtil.equals(pageName.toLowerCase(), "privacy") || EgovStringUtil.equals(pageName.toLowerCase(), "terms") ){
			Map<String, Object> paramMap = new HashMap<String, Object>();

			paramMap.put("srchTermsKind", pageName.toUpperCase());
			paramMap.put("srchUseYn", "Y");
			paramMap.put("srchPublicYn", "Y");

			List<TermsVO> listHVO = termsService.selectListVO(paramMap);

			model.addAttribute("listHistoryVO", listHVO);
		}

		return "/membership/cntnts/" + pageName;
	}
}
