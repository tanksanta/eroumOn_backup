package icube.main;

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
		@RequestParam(required = false) String recipientsNm
		, @RequestParam(required = false) String rcperRcognNo
		, @RequestParam(required = false) Integer recipientsNo
		, Model model)throws Exception {
		
		if (recipientsNo != null) {
			MbrRecipientsVO recipient = mbrRecipientsService.selectMbrRecipientsByRecipientsNo(recipientsNo);
			recipientsNm = recipient.getRecipientsNm();
			rcperRcognNo = recipient.getRcperRcognNo();
		}
		
		TilkoApiVO apiVO = new TilkoApiVO();
		model.addAttribute("apiVO",apiVO);
		model.addAttribute("apiCode", ItemMap.RECIPTER_ITEM);
		model.addAttribute("recipientsNm", recipientsNm);
		model.addAttribute("rcperRcognNo", rcperRcognNo);
		
		return "/main/recipter/list";
	}
}
