package icube.manage.consult;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;
import org.springframework.web.util.HtmlUtils;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.CommonUtil;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.consult.biz.GdsReviewService;
import icube.manage.consult.biz.GdsReviewVO;
import icube.manage.sysmng.mngr.biz.MngrSession;


/**
 * 상품후기
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="/_mng/consult/gdsReview")
public class MGdsReviewController extends CommonAbstractController {

	@Resource(name = "gdsReviewService")
	private GdsReviewService gdsReviewService;

	@Autowired
	private MngrSession mngrSession;

	// Page Parameter Keys
	private static String[] targetParams = {"curPage", "cntPerPage", "sortBy","srchRegYmdBgng","srchRegYmdEnd","srchRgtrId", "srchRgtr","srchTtl","srchDspyYn","srchAnsYn","srchGdsCd","srchGdsNm"};

    /**
     * 상품후기 리스트
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = gdsReviewService.gdsReviewListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("useYnCode", CodeMap.USE_YN);
		model.addAttribute("dspyYnCode", CodeMap.DSPY_YN);

		return "/manage/consult/gds_review/list";
	}

	/**
	 * 상품후기 상세
	 */
	@RequestMapping(value="form")
	public String View(
			HttpServletRequest request
			, Model model
			, @RequestParam (value="gdsReviewNo", required=true) int gdsReviewNo
			, GdsReviewVO gdsReviewVO
			) throws Exception {

		gdsReviewVO = gdsReviewService.selectGdsReview(gdsReviewNo);

		model.addAttribute("gdsReivewVO", gdsReviewVO);
		model.addAttribute("useYnCode", CodeMap.USE_YN);

		return "/manage/consult/gds_review/form";
	}



	@RequestMapping(value="action")
	public View action(
			GdsReviewVO gdsReivewVO
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));


		// 관리자정보
		gdsReivewVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		gdsReivewVO.setMdfcnId(mngrSession.getMngrId());
		gdsReivewVO.setMdfr(mngrSession.getMngrNm());

		try {
			gdsReviewService.updateUseYn(gdsReivewVO);

			javaScript.setMessage(getMsg("action.complete.update"));
			javaScript.setLocation("./form?gdsReviewNo=" + gdsReivewVO.getGdsReivewNo() + ("".equals(pageParam) ? "" : "&" + pageParam));
		}catch(Exception e) {
			e.printStackTrace();
		}

		return new JavaScriptView(javaScript);
	}
}
