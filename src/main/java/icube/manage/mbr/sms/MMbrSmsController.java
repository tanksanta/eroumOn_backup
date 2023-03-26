package icube.manage.mbr.sms;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.vo.CommonListVO;

@Controller
@RequestMapping(value="/_mng/mbr/sms")
public class MMbrSmsController extends CommonAbstractController{


	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model
			) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		//

		model.addAttribute("listVO", listVO);


		return "/manage/mbr/sms/list";
	}
}
