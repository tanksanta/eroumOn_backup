package icube.manage.members.app;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import icube.manage.members.bplc.biz.BplcService;
import icube.manage.members.bplc.biz.BplcVO;
import icube.manage.sysmng.mngr.biz.MngrSession;
import icube.members.bplc.mng.biz.BplcGdsService;

@Controller
@RequestMapping(value="/_mng/members/bplcApp")
public class MBplcAppController extends CommonAbstractController {

	@Resource(name = "bplcService")
	private BplcService bplcService;

	@Resource(name = "bplcGdsService")
	private BplcGdsService bplcGdsService;

	@Autowired
	private MngrSession mngrSession;

	private static String[] targetParams = {"curPage", "cntPerPage", "srchBgngDt", "srchEndDt", "sortBy", "srchBplcId", "srchBplcNm", "srchRprsvNm", "srchBrno", "sortsrchPicNm", "srchPicTelno", "srchAprvTy"};

    // 파트너 신청 관리 리스트
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("apptype", "C");
		listVO = bplcService.bplcListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("aprvTy", CodeMap.APRV_TY);

		return "/manage/members/bplcApp/list";
	}

	// 파트너 신청 관리 상세
	@RequestMapping(value="view")
	public String view(
			@RequestParam(value="uniqueId", required=true) String uniqueId
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception{

		BplcVO bplcVO = bplcService.selectBplcByUniqueId(uniqueId);

		if (bplcVO == null) {
			model.addAttribute("alertMsg", getMsg("alert.author.common"));
			return "/common/msg";
		}

		model.addAttribute("bplcVO", bplcVO);

		model.addAttribute("aprvTyCode", CodeMap.APRV_TY);
		model.addAttribute("useYnCode", CodeMap.USE_YN);
		model.addAttribute("dspyYnCode", CodeMap.DSPY_YN);
		model.addAttribute("bankTyCode", CodeMap.BANK_TY);

		model.addAttribute("param", reqMap);

		return "/manage/members/bplcApp/view";
	}

	//파트너 신청관리 처리
	@RequestMapping(value="action")
	public View action(
			BplcVO bplcVO
			, @RequestParam Map<String,Object> reqMap
			, HttpSession session) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));


		// 관리자정보
		bplcVO.setRegUniqueId(mngrSession.getUniqueId());
		bplcVO.setRegId(mngrSession.getMngrId());
		bplcVO.setRgtr(mngrSession.getMngrNm());
		bplcVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		bplcVO.setMdfcnId(mngrSession.getMngrId());
		bplcVO.setMdfr(mngrSession.getMngrNm());

		switch (bplcVO.getCrud()) {
			case CREATE:
				bplcService.insertBplc(bplcVO);

				javaScript.setMessage(getMsg("action.complete.insert"));
				javaScript.setLocation("./list?" + pageParam);
				break;

			case UPDATE:
				bplcService.updateBplcApp(bplcVO);

				//사업소 전체 상품 등록
				int resultCnt = 0;
				if(bplcVO.getAprvTy().equals("C")) {
					Map<String, Object> paramMap = new HashMap<String, Object>();
					paramMap.put("srchUniqueId", bplcVO.getUniqueId());
					resultCnt += bplcGdsService.selectInsertGds(paramMap);
				}

				log.debug("####### " + resultCnt + " 건의 상품 등록 완료 ###### ");

				javaScript.setMessage(getMsg("action.complete.update"));
				javaScript.setLocation("./view?uniqueId=" + bplcVO.getUniqueId() + ("".equals(pageParam) ? "" : "&" + pageParam));
				break;

			default:
				break;
		}

		return new JavaScriptView(javaScript);
	}

}
