package icube.manage.promotion.event;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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
import icube.manage.promotion.event.biz.EventApplcnService;
import icube.manage.promotion.event.biz.EventApplcnVO;
import icube.manage.promotion.event.biz.EventIemService;
import icube.manage.promotion.event.biz.EventIemVO;
import icube.manage.promotion.event.biz.EventPrzwinService;
import icube.manage.promotion.event.biz.EventPrzwinVO;
import icube.manage.promotion.event.biz.EventService;
import icube.manage.promotion.event.biz.EventVO;
import icube.manage.sysmng.mngr.biz.MngrSession;

/**
 * 관리자 이벤트
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="/_mng/promotion/event")
public class MEventController extends CommonAbstractController {

	@Resource(name = "eventService")
	private EventService eventService;

	@Resource(name = "fileService")
	private FileService fileService;

	@Resource(name = "eventIemService")
	private EventIemService eventIemService;

	@Resource(name = "eventApplcnService")
	private EventApplcnService  eventApplcnService;

	@Resource(name = "eventPrzwinService")
	private EventPrzwinService  eventPrzwinService;

	@Autowired
	private MngrSession mngrSession;

	private static String[] targetParams = {"curPage", "cntPerPage", "srchTarget", "srchText", "sortBy", "srchYn", "srchBgngDt", "srchEndDt", "eventTy","cntPerPageEvent"};

    /**
     * 이벤트 리스트
     */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = eventService.eventListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("dspyYn", CodeMap.DSPY_YN);
		model.addAttribute("eventTy", CodeMap.EVENT_TY);
		model.addAttribute("playSttus", CodeMap.PLAY_STTUS);

		return "/manage/promotion/event/list";
	}

	/**
	 * 이벤트 작성 및 수정
	 */
	@RequestMapping(value="form")
	@SuppressWarnings({"unchecked","rawtypes"})
	public String form(
			EventVO eventVO
			, EventIemVO eventIemVO
			, EventPrzwinVO eventPrzwinVO
			, @RequestParam Map<String, Object> reqMap
			, @RequestParam (value="curPage", required=false) String paramCurPage
			, @RequestParam (value="cntPerPageEvent", required=false) String paramCntPerPageEvent
			, HttpServletRequest request
			, Model model) throws Exception{

		int eventNo = EgovStringUtil.string2integer((String)reqMap.get("eventNo"));
		int przwinNo = EgovStringUtil.string2integer((String)reqMap.get("przwinNo"));
		int curPage = EgovStringUtil.string2integer(paramCurPage);
		int cntPerPageEvent = EgovStringUtil.string2integer(paramCntPerPageEvent);

		//응모자 확인 폼
		CommonListVO listVO = new CommonListVO(request, curPage, cntPerPageEvent);
		if(eventNo != 0) {
			listVO.setParam("eventNo", eventNo);
			listVO = eventApplcnService.eventApplcnListVO(listVO);
		}

		if(eventNo == 0){
			eventVO.setCrud(CRUD.CREATE);
		}else{
			eventVO = eventService.selectEvent(eventNo);
			List <EventIemVO> eventIemList = eventIemService.selectListEventIem(eventNo);
			eventVO.setCrud(CRUD.UPDATE);
			model.addAttribute("eventIemList", eventIemList);
		}

		//당첨자 확인 폼
		if(przwinNo == 0) {
			eventPrzwinVO.setCrud(CRUD.CREATE);
		}else {
			Map paramMap = new HashMap();
			paramMap.put("przwinNo", przwinNo);
			paramMap.put("eventNo", eventNo);
			eventPrzwinVO = eventPrzwinService.selectEventPrzwin(paramMap);
			eventPrzwinVO.setCrud(CRUD.UPDATE);
			model.addAttribute("eventPrzwinVO", eventPrzwinVO);
		}


		model.addAttribute("eventVO", eventVO);
		model.addAttribute("listVO", listVO);
		model.addAttribute("param", reqMap);
		model.addAttribute("eventTrgtCode", CodeMap.EVENT_TRGT);
		model.addAttribute("eventTyCode", CodeMap.EVENT_TY);
		model.addAttribute("useYnCode", CodeMap.USE_YN);
		model.addAttribute("dspyYnCode", CodeMap.DSPY_YN);

		return "/manage/promotion/event/form";
	}

	@RequestMapping(value="action")
	public View action(
			EventVO eventVO
			, @RequestParam Map<String,Object> reqMap
			, @RequestParam (value="przwinNo", required=false) int przwinNo
			, @RequestParam (value="textBtn", required=false) String textBtn
			, MultipartHttpServletRequest multiReq
			, HttpSession session
			, HttpServletRequest request) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));

		Map<String, MultipartFile> fileMap = multiReq.getFileMap();


		// 관리자정보
		eventVO.setRegUniqueId(mngrSession.getUniqueId());
		eventVO.setRegId(mngrSession.getMngrId());
		eventVO.setRgtr(mngrSession.getMngrNm());
		eventVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		eventVO.setMdfcnId(mngrSession.getMngrId());
		eventVO.setMdfr(mngrSession.getMngrNm());


		//날짜 시간
		String Bdate = request.getParameter("bgngDt");
		String Btime = request.getParameter("bgngTime");
		String Edate = request.getParameter("endDt");
		String Etime = request.getParameter("endTime");

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date bgngDt = formatter.parse(Bdate + " " + Btime);
		Date endDt = formatter.parse(Edate + " " + Etime);

		eventVO.setBgngDt(bgngDt);
		eventVO.setEndDt(endDt);

		switch (eventVO.getCrud()) {
			case CREATE:

				//정보 등록
				eventService.insertEvent(eventVO);

				//목록 이미지
				fileService.creatFileInfo(fileMap, eventVO.getEventNo(), "EVENT", reqMap);

				//이벤트 항목
				if(EgovStringUtil.isNotEmpty(textBtn)) {
					eventIemService.insertEventIem(eventVO.getEventNo(), reqMap, fileMap);
				}

				javaScript.setMessage(getMsg("action.complete.insert"));
				javaScript.setLocation("./list?" + pageParam);
				break;

			case UPDATE:

				// 목록 이미지
				String delThumbFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delThumbFileNo"));
				String[] arrDelThumbFile = delThumbFileNo.split(",");
				if (!EgovStringUtil.isEmpty(arrDelThumbFile[0])) {
					fileService.deleteFilebyNo(arrDelThumbFile, eventVO.getEventNo(), "EVENT", "THUMB");
				}

				//설문 항목 이미지
				String delImgFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delImgFileNo"));
				String[] arrDelImgFile = delImgFileNo.split(",");
				if (!EgovStringUtil.isEmpty(arrDelImgFile[0])) {
					fileService.deleteFilebyNo(arrDelImgFile, eventVO.getEventNo(), "EVENT", "IMG");
				}

				fileService.creatFileInfo(fileMap, eventVO.getEventNo(), "EVENT", reqMap);

				//정보 수정
				eventService.updateEvent(eventVO);

				// 목록 이미지 대체 텍스트
				String updtThumbFileDc = WebUtil.clearSqlInjection((String) reqMap.get("updtThumbFileDc"));

				if (!"".equals(updtThumbFileDc)) {
					String[] arrUptThumbFileDc = updtThumbFileDc.split(",");
					for (String uptThumbFileDcNm : arrUptThumbFileDc) {
						String[] uptThumbFileElm = uptThumbFileDcNm.split("FileDc");
						fileService.updateFileDc("EVENT", eventVO.getEventNo(), StringUtil.nvl(uptThumbFileElm[1], 0),
								"THUMB", (String) reqMap.get(uptThumbFileDcNm));
					}
				}

				//이벤트 항목
				if(textBtn != null) {
					eventIemService.updateIem(eventVO.getEventNo(), textBtn, fileMap, reqMap);
				}

				javaScript.setMessage(getMsg("action.complete.update"));
				javaScript.setLocation(
					"./form?eventNo=" + eventVO.getEventNo() +"&"+"przwinNo="+przwinNo+ ("".equals(pageParam) ? "" : "&" + pageParam));
				break;

			default:
				break;
		}


		return new JavaScriptView(javaScript);
	}

	/**
	 * 당첨자 발표 처리
	 * @param eventPrzwinVO
	 * @param reqMap
	 * @param multiReq
	 * @param session
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "appAction")
	public View appAction(
			EventPrzwinVO eventPrzwinVO
			, @RequestParam Map<String,Object> reqMap
			, MultipartHttpServletRequest multiReq
			, HttpSession session
			, HttpServletRequest request) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));

		Map<String, MultipartFile> fileMap = multiReq.getFileMap();

		// 관리자정보
		eventPrzwinVO.setRegUniqueId(mngrSession.getUniqueId());
		eventPrzwinVO.setRegId(mngrSession.getMngrId());
		eventPrzwinVO.setRgtr(mngrSession.getMngrNm());
		eventPrzwinVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		eventPrzwinVO.setMdfcnId(mngrSession.getMngrId());
		eventPrzwinVO.setMdfr(mngrSession.getMngrNm());


		switch (eventPrzwinVO.getCrud()) {
			case CREATE:

				//정보 등록
				eventPrzwinService.insertEventPrzwin(eventPrzwinVO);

				//목록 이미지
				fileService.creatFileInfo(fileMap, eventPrzwinVO.getPrzwinNo(), "EVENT_PRZWIN");

				javaScript.setMessage(getMsg("action.complete.insert"));
				javaScript.setLocation("./list?" + pageParam);
				break;

			case UPDATE:

				// 목록 이미지
				String delAttachFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delAttachFileNo"));
				String[] arrDelAttachFile = delAttachFileNo.split(",");
				if (!EgovStringUtil.isEmpty(arrDelAttachFile[0])) {
					fileService.deleteFilebyNo(arrDelAttachFile, eventPrzwinVO.getPrzwinNo(), "EVENT_PRZWIN", "ATTACH");
				}

				fileService.creatFileInfo(fileMap, eventPrzwinVO.getPrzwinNo(), "EVENT_PRZWIN");

				//정보 수정
				eventPrzwinService.updateEventPrzwin(eventPrzwinVO);


				javaScript.setMessage(getMsg("action.complete.update"));
				javaScript.setLocation(
					"./form?eventNo=" +eventPrzwinVO.getEventNo() + "&" + "przwinNo=" + eventPrzwinVO.getPrzwinNo() + ("".equals(pageParam) ? "" : "&" + pageParam));
				break;

			default:
				break;
		}

		return new JavaScriptView(javaScript);
	}

	/**
	 * 해당 항목 응모자 내역 엑셀 다운
	 * @param request
	 * @param reqMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="excel")
	@SuppressWarnings({"rawtypes","unchecked"})
	public String excelDownload(
			HttpServletRequest request
			, @RequestParam Map<String, Object> reqMap
			, @RequestParam (value="eventNo", required=true) int eventNo
			, @RequestParam (value="iemNo", required=false) String iemNo
			, Model model) throws Exception{

		Map paramMap = new HashMap();
		paramMap.put("eventNo", eventNo);
		if(EgovStringUtil.isNotEmpty(iemNo)) {
			paramMap.put("iemNo", EgovStringUtil.string2integer(iemNo));
		}
		 List<EventApplcnVO> itemList = eventApplcnService.eventApplcnListByIemNo(paramMap);


		model.addAttribute("itemList", itemList);

		return "/manage/promotion/include/event_applcn_excel";
	}

}
