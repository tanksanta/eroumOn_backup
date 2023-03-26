package icube.members.bplc.mng;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.vo.CommonListVO;
import icube.manage.members.bplc.biz.BplcVO;
import icube.manage.members.notice.biz.BplcNoticeService;
import icube.manage.members.notice.biz.BplcNoticeVO;

/**
 * 사업소 관리자 > 이로움마켓 공지사항
 */
@Controller
@RequestMapping(value="#{props['Globals.Members.path']}/{bplcUrl}/mng/mNotice")
public class MBplcNtceController extends CommonAbstractController {

	@Resource(name="bplcNoticeService")
	private BplcNoticeService noticeService;

	@Value("#{props['Globals.Members.path']}")
	private String membersPath;

	//리스트
	@RequestMapping(value = { "list" })
	public String info(
			@PathVariable String bplcUrl
			, HttpSession session
			, HttpServletRequest request
			, BplcVO bplcVO
			, Model model) throws Exception {


		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("srchUseYn", "Y");
		listVO = noticeService.bplcNoticeListVO(listVO);

		model.addAttribute("listVO", listVO);

		return "/members/bplc/mng/ntce/list";
	}

	//상세
	@RequestMapping(value = "view")
	public String view(
		@PathVariable String bplcUrl
		, HttpSession session
		, HttpServletRequest request
		, @RequestParam(value="noticeNo", required=true) int noticeNo
		, Model model
			)throws Exception {

		BplcNoticeVO noticeVO = noticeService.selectBplcNotice(noticeNo);

		model.addAttribute("noticeVO", noticeVO);

		return "/members/bplc/mng/ntce/view";
	}
}
