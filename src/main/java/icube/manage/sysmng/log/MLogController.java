package icube.manage.sysmng.log;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.sysmng.mngr.biz.MngrLogService;

@Controller
@RequestMapping(value="/_mng/sysmng/log")
public class MLogController extends CommonAbstractController {

	@Resource(name="mngrLogService")
	private MngrLogService mngrLogService;


    /**
     * 관리자 관리 > 이용내역 > 리스트
     */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = mngrLogService.selectMngrExcelLogListVO(listVO);

		model.addAttribute("listVO", listVO);

		return "/manage/sysmng/log/list";
	}
}
