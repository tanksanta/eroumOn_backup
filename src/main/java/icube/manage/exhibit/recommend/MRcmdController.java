package icube.manage.exhibit.recommend;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.values.CodeMap;
import icube.manage.exhibit.recommend.biz.GdsRcmdService;
import icube.manage.exhibit.recommend.biz.GdsRcmdVO;
import icube.manage.gds.ctgry.biz.GdsCtgryService;

@RequestMapping("/_mng/exhibit/rcmd")
@Controller
public class MRcmdController extends CommonAbstractController{

	@Resource(name = "gdsCtgryService")
	private GdsCtgryService gdsCtgryService;

	@Resource(name = "gdsRcmdService")
	private GdsRcmdService gdsRcmdService;

	@RequestMapping(value = "list")
	public String list(
			HttpServletRequest request
			, Model model
			) throws Exception{

		List<GdsRcmdVO> rcmdList = gdsRcmdService.selectRcmdList();

		model.addAttribute("dspyYnCode", CodeMap.DSPY_YN);
		model.addAttribute("rcmdList", rcmdList);

		return "/manage/exhibit/recommend/list";
	}


	@RequestMapping(value = "action")
	public View action(
			GdsRcmdVO gdsRcmdVO
			, HttpServletRequest request
			, @RequestParam Map<String,Object> reqMap
			) throws Exception{

		JavaScript javaScript = new JavaScript();

		if(request.getParameterValues("gdsNo") != null) {

			String[] noList = request.getParameterValues("gdsNo");

			gdsRcmdService.updateRcmd(noList);
		}else {
			gdsRcmdService.deleteRcmd();
		}

		javaScript.setMessage(getMsg("action.complete.update"));
		javaScript.setLocation("./list");

		return new JavaScriptView(javaScript);
	}
}
