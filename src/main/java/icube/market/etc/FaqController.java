package icube.market.etc;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.vo.CommonListVO;
import icube.manage.sysmng.bbs.biz.BbsService;
import icube.manage.sysmng.bbs.biz.BbsSetupService;
import icube.manage.sysmng.bbs.biz.BbsSetupVO;

/**
 * 고객센터 > 자주묻는 질문
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/etc/faq")
public class FaqController extends CommonAbstractController{

	@Resource(name="bbsService")
	private BbsService bbsService;

	@Resource(name = "bbsSetupService")
	private BbsSetupService bbsSetupService;


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
			, Model model
			, @RequestParam(value="ctgryNo", required = false, defaultValue = "0") int ctgryNo
			)throws Exception {

		CommonListVO listVO = new CommonListVO(request);

		// faq 게시판 2번
		listVO.setParam("srchBbsNo", 2);
		// 블라인드 상태
		listVO.setParam("srchSttsTy", "C");
		// 카테코리 No
		listVO.setParam("srchCtgry", ctgryNo);
		listVO = bbsService.selectNttListVO(listVO);

		// 카테고리
		BbsSetupVO bbsSetupVO = bbsSetupService.selectBbsSetup(2);

		model.addAttribute("listVO", listVO);
		model.addAttribute("bbsSetupVO", bbsSetupVO);


		return "/market/etc/faq";
	}
}
