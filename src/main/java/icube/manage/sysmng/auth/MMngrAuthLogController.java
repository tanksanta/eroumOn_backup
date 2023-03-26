package icube.manage.sysmng.auth;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.sysmng.auth.biz.MngrAuthLogService;

@Controller
@RequestMapping(value = "/_mng/sysmng/mngrAuthLog")
public class MMngrAuthLogController extends CommonAbstractController {

	@Resource(name = "mngrAuthLogService")
	private MngrAuthLogService mngrAuthLogService;

	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception{

		CommonListVO listVO = new CommonListVO(request);
		mngrAuthLogService.selectMngrAuthLogListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("mngrAuthLogTy", CodeMap.MNGR_AUTH_LOG_TY);

		return "/manage/sysmng/mngr-auth-log/list";
	}

}
