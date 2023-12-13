package icube.main;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CodeMap;
import icube.manage.mbr.recipients.biz.MbrRecipientsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 관심 복지용구 상담 관련 컨트롤러
 */
@Controller
@RequestMapping(value="#{props['Globals.Main.path']}/welfare/equip")
public class MainWelfareEquipmentController extends CommonAbstractController{

	@Resource(name= "mbrRecipientsService")
	private MbrRecipientsService mbrRecipientsService;
	
	@Autowired
	private MbrSession mbrSession;
	
	
	/**
	 * 관심 복지용구 상담 서브메인페이지
	 */
	@RequestMapping(value = "sub")
	public String sub(
		HttpServletRequest request
		, HttpSession session
		, Model model
			)throws Exception {
		
		model.addAttribute("mbrRelationCode", CodeMap.MBR_RELATION_CD);
		
		return "/main/equip/sub";
	}
	
	/**
	 * 관심 복지용구 상담 페이지
	 */
	@RequestMapping(value = "list")
	public String list(
		@RequestParam Integer recipientsNo
		, Model model)throws Exception {
		
		if (!mbrSession.isLoginCheck()) {
			model.addAttribute("alertMsg", "로그인 이후 이용가능합니다");
			model.addAttribute("goUrl", "/membership/login");
			return "/common/msg";
		}
		
		List<MbrRecipientsVO> mbrRecipientsList = mbrRecipientsService.selectMbrRecipientsByMbrUniqueId(mbrSession.getUniqueId());
		if (!mbrRecipientsList.stream().anyMatch(f -> f.getRecipientsNo() == recipientsNo)) {
			model.addAttribute("alertMsg", "등록되지 않은 수급자입니다");
			model.addAttribute("goUrl", "/main/welfare/equip/sub");
			return "/common/msg";
		}
		model.addAttribute("recipientsNo", recipientsNo);
		
		model.addAttribute("relationCd", CodeMap.MBR_RELATION_CD);
		
		return "/main/equip/list";
	}
}
