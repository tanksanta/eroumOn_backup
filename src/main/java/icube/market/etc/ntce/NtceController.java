package icube.market.etc.ntce;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.HtmlUtil;
import icube.common.vo.CommonListVO;
import icube.manage.sysmng.bbs.biz.BbsService;
import icube.manage.sysmng.bbs.biz.BbsVO;

/**
 * 고객 센터 > 공지 사항
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/etc/ntce")
public class NtceController extends CommonAbstractController{

	@Resource(name="bbsService")
	private BbsService bbsService;

	/**
	 * 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="list")
	@SuppressWarnings("unchecked")
	public String list(
			HttpServletRequest request
			, Model model
			) throws Exception{

		CommonListVO listVO = new CommonListVO(request);

		// 공지사항 1번
		listVO.setParam("srchBbsNo", 1);
		// 블라인드 상태
		listVO.setParam("srchSttsTy", "C");
		listVO = bbsService.selectNttListVO(listVO);

		// 공지사항 내용 태그 처리
		List<BbsVO> bbsList = listVO.getListObject();
		for(BbsVO bbsVO : bbsList) {
			bbsVO.setCn(HtmlUtil.clean(bbsVO.getCn()));
		}

		model.addAttribute("listVO", listVO);

		return "/market/etc/ntce/list";
	}

	/**
	 * 상세
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="view")
	public String view(
			HttpServletRequest request
			, Model model
			, @RequestParam(value="nttNo", required=true) int nttNo
			) throws Exception{

		//TO-DO : 게시판설정 호출 필요

		BbsVO nttVO = bbsService.selectNtt(1, nttNo);
		if (nttVO == null) {
			model.addAttribute("alertMsg", getMsg("alert.author.common"));
			return "/common/msg";
		}

		// 조회수 증가
		bbsService.updateInqcnt(nttVO.getNttNo());

		model.addAttribute("nttVO", nttVO);

		return "/market/etc/ntce/view";
	}

}
