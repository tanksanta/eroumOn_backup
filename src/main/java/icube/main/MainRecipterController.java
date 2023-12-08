package icube.main;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.api.biz.TilkoApiVO;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CodeMap;
import icube.main.biz.ItemMap;
import icube.main.biz.MainService;
import icube.manage.mbr.recipients.biz.MbrRecipientsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;

/**
 * 요양정보 간편 조회
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="#{props['Globals.Main.path']}/recipter")
public class MainRecipterController extends CommonAbstractController{

	@Resource(name = "mainService")
	private MainService mainService;
	
	@Resource(name= "mbrRecipientsService")
	private MbrRecipientsService mbrRecipientsService;
	
	/**
	 * 간편조회 서브메인페이지
	 */
	@RequestMapping(value = "sub")
	public String sub(
		HttpServletRequest request
		, HttpSession session
		, Model model
			)throws Exception {
		
		model.addAttribute("mbrRelationCode", CodeMap.MBR_RELATION_CD);
		
		return "/main/recipter/sub";
	}
	
	/**
	 * 간편조회 결과 페이지
	 */
	@RequestMapping(value = "list")
	public String list(
		@RequestParam Integer recipientsNo
		, Model model)throws Exception {
		
		MbrRecipientsVO recipient = mbrRecipientsService.selectMbrRecipientsByRecipientsNo(recipientsNo);
		String recipientsNm = recipient.getRecipientsNm();
		String rcperRcognNo = recipient.getRcperRcognNo();
		
		TilkoApiVO apiVO = new TilkoApiVO();
		model.addAttribute("apiVO",apiVO);
		model.addAttribute("apiCode", ItemMap.RECIPTER_ITEM);
		model.addAttribute("recipientsNo", recipientsNo);
		model.addAttribute("recipientsNm", recipientsNm);
		model.addAttribute("rcperRcognNo", rcperRcognNo);
		
		model.addAttribute("relationCd", CodeMap.MBR_RELATION_CD);
		
		
		//채널톡 event 처리 (jsp에서 스크립트로 처리함)
//		Map<String, Object> channelTalkEvent = new HashMap<>();
//		Map<String, Object> propertyObject = new HashMap<>();
//		channelTalkEvent.put("eventName", "view_infocheck_success");
//		channelTalkEvent.put("propertyObj", propertyObject);
//		
//		model.addAttribute("channelTalkEvent", channelTalkEvent);
		
		return "/main/recipter/list";
	}
}
