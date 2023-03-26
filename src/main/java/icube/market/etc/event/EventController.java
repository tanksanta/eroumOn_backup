package icube.market.etc.event;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.WebUtil;
import icube.common.vo.CommonListVO;
import icube.manage.promotion.event.biz.EventApplcnService;
import icube.manage.promotion.event.biz.EventApplcnVO;
import icube.manage.promotion.event.biz.EventIemService;
import icube.manage.promotion.event.biz.EventIemVO;
import icube.manage.promotion.event.biz.EventPrzwinService;
import icube.manage.promotion.event.biz.EventPrzwinVO;
import icube.manage.promotion.event.biz.EventService;
import icube.manage.promotion.event.biz.EventVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 이로움 이벤트
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/etc/event")
public class EventController extends CommonAbstractController{

	@Resource(name = "eventService")
	private EventService eventService;

	@Resource(name = "eventIemService")
	private EventIemService eventIemService;

	@Resource(name = "eventApplcnService")
	private EventApplcnService eventApplcnService;

	@Resource(name = "eventPrzwinService")
	private EventPrzwinService przwinService;

	@Autowired
	private MbrSession mberSession;

	/**
	 * 이벤트 > 리스트
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "list")
	public String list(
		HttpServletRequest request
		, Model model
		, @RequestParam(value="sortVal", required=false, defaultValue = "all") String eventSttus
			)throws Exception {

		CommonListVO listVO = new CommonListVO(request);

		listVO.setParam("eventSttus", eventSttus);
		listVO.setParam("dspyYn", "Y");
		listVO = eventService.eventListVO(listVO);

		model.addAttribute("listVO", listVO);

		return "/market/etc/event/list";
	}

	/**
	 * 이벤트 > 상세
	 * @param request
	 * @param model
	 * @param reqMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "view")
	@SuppressWarnings({"unchecked","rawtypes"})
	public String view(
			HttpServletRequest request
			, Model model
			, @RequestParam (value="eventNo", required=true) int eventNo
			) throws Exception {

		//이벤트 정보
		EventVO eventVO = eventService.selectEvent(eventNo);

		//항목
		List <EventIemVO> eventIemList = eventIemService.selectListEventIem(eventNo);

		//당첨자
		Map paramMap = new HashMap();
		paramMap.put("eventNo", eventNo);
		EventPrzwinVO eventPrzwinVO = przwinService.selectEventPrzwin(paramMap);

		model.addAttribute("eventVO", eventVO);
		model.addAttribute("eventPrzwinVO", eventPrzwinVO);
		model.addAttribute("eventIemList", eventIemList);


		return "/market/etc/event/view";
	}

	/**
	 * 당첨자 확인
	 */
	@RequestMapping(value = "przwin_view")
	public String przwin_view(
			@RequestParam(value = "eventNo", required=true) String eventNo
			, HttpServletRequest request
			, Model model
			) throws Exception {

		EventVO eventVO = eventService.selectEvent(EgovStringUtil.string2integer(eventNo));

		model.addAttribute("eventVO", eventVO);

		return "/market/etc/event/przwin_view";
	}

	/**
	 * 이벤트 응모 정보 등록
	 * @param request
	 * @param model
	 * @param reqMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="action")
	public View action(
			HttpServletRequest request
			, Model model
			, @RequestParam (value="eventNo", required=true) int eventNo
			, @RequestParam (value="iemCn", required=false) String iemCn
			, @RequestParam (value="iem", required=false) String iem
			, @RequestParam (value="eventTy", required=false) String eventTy
			, @RequestParam Map<String,Object> reqMap
			)throws Exception {
		JavaScript javaScript = new JavaScript();

		List <EventIemVO> eventIemList = eventIemService.selectListEventIem(eventNo);

			EventApplcnVO eventApplcnVO = new EventApplcnVO();
			eventApplcnVO.setEventNo(eventNo);
			eventApplcnVO.setApplctId(mberSession.getMbrId());
			eventApplcnVO.setApplctNm(mberSession.getMbrNm());
			eventApplcnVO.setApplctUniqueId(mberSession.getUniqueId());
			eventApplcnVO.setApplctTelno(mberSession.getMblTelno());
			eventApplcnVO.setIp(WebUtil.getIp(request));

			try {
				//응모형 유무
				if(!EgovStringUtil.isNull(eventTy) && eventTy.equals("A")) {
					eventApplcnService.insertEventApplcn(eventApplcnVO);
				}else {
					//텍스트 항목
					if(iemCn != null) {
						eventApplcnVO.setChcIemNo(EgovStringUtil.string2integer(iemCn));
						eventApplcnService.insertEventApplcn(eventApplcnVO);
					}else {
						//이미지 항목
						for(int i=0; i<eventIemList.size(); i++) {
							if(eventIemList.get(i).getIemCn().equals(iem)) {
								eventApplcnVO.setChcIemNo(eventIemList.get(i).getIemNo());
								eventApplcnService.insertEventApplcn(eventApplcnVO);
							}
						}
					}
				}
				javaScript.setMessage(getMsg("action.complete.applcn"));
				javaScript.setLocation("./list?sortVal=all");
			} catch (Exception e) {
				log.debug("EVENT_APPLCN INSERT ERROR");
			}

		return new JavaScriptView(javaScript);
	}


	/**
	 * 응모 확인 검사
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="applcnChk.json")
	@ResponseBody
	@SuppressWarnings({"rawtypes","unchecked"})
	public int applcnChk(
			HttpServletRequest request
			, Model model
			, @RequestParam (value="eventNo", required=true) int eventNo
			)throws Exception {

		int cnt = 0;

		//로그인 검사
		if(!mberSession.isLoginCheck()) {
			//로그인 msg
			cnt = 1;
		}else {
			//이벤트 중복 검사
			Map paramMap = new HashMap();
			paramMap.put("eventNo", eventNo);
			paramMap.put("uniqueId", mberSession.getUniqueId());
			int count = eventApplcnService.selectApplcnCount(paramMap);

			if(count > 0) {
				//중복 msg
				cnt = 2;
			}
		}
		return cnt;
	}

}
