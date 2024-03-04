package icube.app.matching.bbs;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.vo.CommonListVO;
import icube.manage.sysmng.bbs.biz.BbsService;
import icube.manage.sysmng.bbs.biz.BbsVO;

@Controller
@RequestMapping(value={"#{props['Globals.Matching.path']}/bbs"})
public class MatBbsController  extends CommonAbstractController {
	
	@Resource(name="bbsService")
	private BbsService bbsService;

	protected String srchSrvcCd = "machingapp";

	@RequestMapping(value={"{bbsCd}/list"})//socialwelfare, guide
	public String bbsCommonList(
		@PathVariable String bbsCd
		, HttpServletRequest request
		, Model model) throws Exception {
		
		CommonListVO listVO = new CommonListVO(request);
		
		listVO.setParam("srchSrvcCd", srchSrvcCd);
		listVO.setParam("srchBbsCd", bbsCd);
		
		listVO = bbsService.selectNttListVO(listVO);

		model.addAttribute("listVO", listVO);
		
        return "/app/matching/bbs/"+bbsCd+"/list";
    }

	/**
	 * 상세
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="{bbsCd}/view")
	public String bbsCommonView(
			@PathVariable String bbsCd
			, @RequestParam(value="nttNo", required=true) int nttNo
			, HttpServletRequest request
			, Model model
		) throws Exception{
				
		BbsVO nttVO = bbsService.selectNttByBbsCd(srchSrvcCd, bbsCd, nttNo);
		if (nttVO == null) {
			model.addAttribute("alertMsg", getMsg("alert.author.common"));
			return "/common/msg";
		}

		// 조회수 증가
		bbsService.updateInqcnt(nttVO.getNttNo());

		model.addAttribute("nttVO", nttVO);

		return "/app/matching/bbs/"+bbsCd+"/view";
	}

	@RequestMapping(value="{bbsCd}/linkview/{uniqueText}")
	public String bbsLinkView(
			@PathVariable String bbsCd
			, @PathVariable String uniqueText
			// , @RequestParam(value="nttNo", required=true) int nttNo
			, HttpServletRequest request
			, Model model
		) throws Exception{
				
		BbsVO nttVO = bbsService.selectNttByUniqueText(srchSrvcCd, bbsCd, uniqueText);
		if (nttVO == null) {
			model.addAttribute("alertMsg", getMsg("alert.author.common"));
			return "/common/msg";
		}

		// 조회수 증가
		bbsService.updateInqcnt(nttVO.getNttNo());

		model.addAttribute("nttVO", nttVO);

		return "/app/matching/bbs/"+bbsCd+"/view";
	}
}
