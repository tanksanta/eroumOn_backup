package icube.manage.mbr.human;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.mbr.mbr.biz.MbrMngInfoService;
import icube.manage.mbr.mbr.biz.MbrService;

/**
 * 관리자 > 회원 > 휴면회원관리
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="/_mng/mbr/human")
public class MMbrHumanContoller extends CommonAbstractController{

	@Resource(name = "mbrService")
	private MbrService mbrService;

	/**
	 * 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model)throws Exception {

		CommonListVO listVO = new CommonListVO(request);

		listVO.setParam("srchMbrSttus","HUMAN");
		listVO = mbrService.mbrListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("gender", CodeMap.GENDER);

		return "/manage/mbr/human/list";
	}
}
