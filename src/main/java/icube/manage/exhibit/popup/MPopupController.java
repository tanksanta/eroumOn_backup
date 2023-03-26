package icube.manage.exhibit.popup;

import java.text.SimpleDateFormat;
import java.util.Date;
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
import icube.common.util.StringUtil;
import icube.common.util.WebUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.exhibit.popup.biz.PopupService;
import icube.manage.exhibit.popup.biz.PopupVO;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Controller
@RequestMapping(value="/_mng/exhibit/popup")
public class MPopupController extends CommonAbstractController {

	@Resource(name = "popupService")
	private PopupService popupService;

	@Resource(name = "fileService")
	private FileService fileService;

	@Autowired
	private MngrSession mngrSession;

	private static String[] targetParams = {"curPage", "cntPerPage", "srchYn", "srchText", "sortBy"};

    /**
     * 전시관리 > 팝업 관리 > 리스트
     */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = popupService.selectPopupListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("useYn", CodeMap.USE_YN);

		return "/manage/exhibit/popup/list";
	}

    /**
     * 전시관리 > 팝업 관리 > 정보 작성
     */
	@RequestMapping(value="form")
	public String form(
			PopupVO popupVO
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, HttpSession session
			, Model model) throws Exception{

		int popNo = EgovStringUtil.string2integer((String) reqMap.get("popNo"));

		if(popNo == 0){
			popupVO.setCrud(CRUD.CREATE);
		}else{
			popupVO = popupService.selectPopup(popNo);
			popupVO.setCrud(CRUD.UPDATE);
		}

		model.addAttribute("popupVO", popupVO);
		model.addAttribute("param", reqMap);
		model.addAttribute("useYn", CodeMap.USE_YN);
		model.addAttribute("dspyYn", CodeMap.DSPY_YN);
		model.addAttribute("linkTy", CodeMap.POPUP_LINK_TY);

		return "/manage/exhibit/popup/form";
	}


	/**
	 * 전시관리 > 팝업 관리 > 정보 처리
	 */
	@RequestMapping(value="action")
	public View action(
			PopupVO popupVO
			, @RequestParam Map<String,Object> reqMap
			, MultipartHttpServletRequest multiReq
			, HttpSession session
			, HttpServletRequest request) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));
		Map<String, MultipartFile> fileMap = multiReq.getFileMap();

		// 관리자정보
		popupVO.setRegUniqueId(mngrSession.getUniqueId());
		popupVO.setRegId(mngrSession.getMngrId());
		popupVO.setRgtr(mngrSession.getMngrNm());
		popupVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		popupVO.setMdfcnId(mngrSession.getMngrId());
		popupVO.setMdfr(mngrSession.getMngrNm());

		// 날짜 시간
		String Bdate = request.getParameter("bgngDt");
		String Btime = request.getParameter("bgngTime");
		String Edate = request.getParameter("endDt");
		String Etime = request.getParameter("endTime");

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date bgngDt = formatter.parse(Bdate + " " + Btime);
		Date endDt = formatter.parse(Edate + " " + Etime);

		popupVO.setBgngDt(bgngDt);
		popupVO.setEndDt(endDt);

		switch (popupVO.getCrud()) {
			case CREATE:

				//정보 등록
				popupService.insertPopup(popupVO);

				//첨부파일 등록
				fileService.creatFileInfo(fileMap, popupVO.getPopNo(), "POPUP", reqMap);

				javaScript.setMessage(getMsg("action.complete.insert"));
				javaScript.setLocation("./list?" + pageParam);
				break;

			case UPDATE:

				// 첨부파일 수정
				String delAttachFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delAttachFileNo"));
				String[] arrDelAttachFile = delAttachFileNo.split(",");
				if (!EgovStringUtil.isEmpty(arrDelAttachFile[0])) {
					fileService.deleteFilebyNo(arrDelAttachFile, popupVO.getPopNo(), "POPUP", "ATTACH");
				}

				// file upload & data insert
				fileService.creatFileInfo(fileMap, popupVO.getPopNo(), "POPUP", reqMap);

				// 정보 수정
				popupService.updatePopup(popupVO);

				// file description update
				String updtImgFileDc = WebUtil.clearSqlInjection((String) reqMap.get("updtImgFileDc"));

				if (!"".equals(updtImgFileDc)) {
					String[] arrUptImgFileDc = updtImgFileDc.split(",");
					for (String uptImgFileDcNm : arrUptImgFileDc) {
						String[] uptImgFileElm = uptImgFileDcNm.split("FileDc");
						fileService.updateFileDc("POPUP", popupVO.getPopNo(), StringUtil.nvl(uptImgFileElm[1], 0),
								"ATTACH", (String) reqMap.get(uptImgFileDcNm));
					}
				}
				javaScript.setMessage(getMsg("action.complete.update"));
				javaScript.setLocation(
						"./form?popNo=" + popupVO.getPopNo() + ("".equals(pageParam) ? "" : "&" + pageParam));
				break;

				default:
					break;

			}
			return new JavaScriptView(javaScript);
		}

	}


