package icube.manage.members.notice;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.util.HtmlUtils;

import icube.common.file.biz.FileService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.CommonUtil;
import icube.common.util.WebUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.members.notice.biz.BplcNoticeService;
import icube.manage.members.notice.biz.BplcNoticeVO;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Controller
@RequestMapping(value="/_mng/members/bplcNotice")
public class MBplcNoticeController extends CommonAbstractController {

	@Resource(name = "bplcNoticeService")
	private BplcNoticeService bplcNoticeService;

	@Resource(name = "fileService")
	private FileService fileService;
	@Autowired
	private MngrSession mngrSession;

	private static String[] targetParams = {"curPage", "cntPerPage", "srchTarget", "srchText", "sortBy", "srchBgngDt", "srchEndDt", "srchUseYn"};

    // 리스트
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = bplcNoticeService.bplcNoticeListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("useYn", CodeMap.USE_YN);

		return "/manage/members/bplc_notice/list";
	}

	// 작성 or 수정
	@RequestMapping(value="form")
	public String form(
			BplcNoticeVO bplcNoticeVO
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception{

		int noticeNo = EgovStringUtil.string2integer((String) reqMap.get("noticeNo"));

		if(noticeNo == 0){
			bplcNoticeVO.setCrud(CRUD.CREATE);
		}else{
			bplcNoticeVO = bplcNoticeService.selectBplcNotice(noticeNo);
			//조회수
			bplcNoticeService.updateInqcnt(bplcNoticeVO);

			bplcNoticeVO.setCrud(CRUD.UPDATE);
		}

		model.addAttribute("bplcNoticeVO", bplcNoticeVO);
		model.addAttribute("param", reqMap);
		model.addAttribute("useYnCode", CodeMap.USE_YN);

		return "/manage/members/bplc_notice/form";
	}


	@RequestMapping(value="action")
	public View action(
			BplcNoticeVO bplcNoticeVO
			, @RequestParam Map<String,Object> reqMap
			, MultipartHttpServletRequest multiReq
			, HttpSession session) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));
		Map<String, MultipartFile> fileMap = multiReq.getFileMap();

		// 관리자정보
		bplcNoticeVO.setRegUniqueId(mngrSession.getUniqueId());
		bplcNoticeVO.setRegId(mngrSession.getMngrId());
		bplcNoticeVO.setRgtr(mngrSession.getMngrNm());
		bplcNoticeVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		bplcNoticeVO.setMdfcnId(mngrSession.getMngrId());
		bplcNoticeVO.setMdfr(mngrSession.getMngrNm());

		switch (bplcNoticeVO.getCrud()) {
			case CREATE:
				bplcNoticeService.insertBplcNotice(bplcNoticeVO);

				fileService.creatFileInfo(fileMap, bplcNoticeVO.getNoticeNo(), "NOTICE");

				javaScript.setMessage(getMsg("action.complete.insert"));
				javaScript.setLocation("./list?" + pageParam);
				break;

			case UPDATE:

				// 첨부파일 수정
				String delAttachFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delAttachFileNo"));
				String[] arrDelAttachFile = delAttachFileNo.split(",");
				if (!EgovStringUtil.isEmpty(arrDelAttachFile[0])) {
					fileService.deleteFilebyNo(arrDelAttachFile, bplcNoticeVO.getNoticeNo(), "NOTICE", "ATTACH");
				}

				// file upload & data insert
				fileService.creatFileInfo(fileMap, bplcNoticeVO.getNoticeNo(), "NOTICE");

				bplcNoticeService.updateBplcNotice(bplcNoticeVO);

				javaScript.setMessage(getMsg("action.complete.update"));
				javaScript.setLocation(
					"./form?noticeNo=" + bplcNoticeVO.getNoticeNo() + ("".equals(pageParam) ? "" : "&" + pageParam));
				break;


			default:
				break;
		}

		return new JavaScriptView(javaScript);
	}

}
