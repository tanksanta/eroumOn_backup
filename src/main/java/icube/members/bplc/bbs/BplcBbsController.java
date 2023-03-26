package icube.members.bplc.bbs;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.vo.CommonListVO;
import icube.manage.members.bplc.biz.BplcVO;
import icube.members.bplc.mng.biz.BplcBbsService;
import icube.members.bplc.mng.biz.BplcBbsVO;

/**
 * 사업소 >  공지사항 : 사업소에 게시되는 공지사항(사업소 관리자에서 작성한것)
 */
@Controller
@RequestMapping(value="#{props['Globals.Members.path']}/{bplcUrl}/bbs/notice")
public class BplcBbsController extends CommonAbstractController {

	@Resource(name = "bplcBbsService")
	private BplcBbsService bbsService;

    // 리스트
	@RequestMapping(value="list")
	public String list(
			@PathVariable String bplcUrl
			, HttpSession session
			, HttpServletRequest request
			, Model model) throws Exception {

		BplcVO bplcSetupVO = (BplcVO) request.getAttribute("bplcSetupVO");

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("bplcUniqueId", bplcSetupVO.getUniqueId());
		listVO.setParam("srchUseYn", "Y");
		listVO = bbsService.bplcBbsListVO(listVO);

		model.addAttribute("listVO", listVO);

		return "/members/bplc/bbs/list";
	}

	//상세
	@RequestMapping(value="view")
	public String view(
			@PathVariable String bplcUrl
			, HttpSession session
			, HttpServletRequest request
			, @RequestParam(value="nttNo" ,required=true) int nttNo
			, Model model) throws Exception {

		BplcVO bplcSetupVO = (BplcVO) request.getAttribute("bplcSetupVO");

		BplcBbsVO bbsVO = bbsService.selectBplcBbs(bplcSetupVO.getUniqueId(), nttNo);

		if(bbsVO != null) { //조회수 증가
			bbsService.updateInqcnt(bbsVO);
		}

		model.addAttribute("bbsVO", bbsVO);

		return "/members/bplc/bbs/view";
	}
}
