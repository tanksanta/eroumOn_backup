package icube.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CodeMap;
import icube.manage.mbr.recipients.biz.MbrRecipientsGdsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsGdsVO;
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
	
	@Resource(name= "mbrRecipientsGdsService")
	private MbrRecipientsGdsService mbrRecipientsGdsService;
	
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
		
		//수급자 관심 복지용구 선택값 저장
		Map<String, Boolean> recipientsGdsCheckMap = new HashMap<>();
//		List<MbrRecipientsGdsVO> recipientsGdsList = mbrRecipientsGdsService.selectMbrRecipientsGdsByRecipientsNo(recipientsNo);
//		for (MbrRecipientsGdsVO recipientsGds : recipientsGdsList) {
//			recipientsGdsCheckMap.put(recipientsGds.getCareCtgryCd(), true);
//		}
		
		model.addAttribute("recipientsNo", recipientsNo);
		model.addAttribute("relationCd", CodeMap.MBR_RELATION_CD);
		model.addAttribute("recipientsGdsCheckMap", recipientsGdsCheckMap);
		
		return "/main/equip/list";
	}
	
	
	/**
	 * 수급자 관심 복지용구 선택값 저장 API
	 */
	@ResponseBody
	@RequestMapping(value = "/addMbrRecipientsGds.json")
	public synchronized Map<String, Object> addMbrConslt(
			int recipientsNo,
			@RequestParam(value="ctgry10Nms[]", required = false) String[] ctgry10Nms, //판매 카테고리명
			@RequestParam(value="ctgry20Nms[]", required = false) String[] ctgry20Nms  //대여 카테고리명
		)throws Exception {
		
		Map <String, Object> resultMap = new HashMap<String, Object>();
		
		//선택 복지용구가 없는 경우
		int ctgry10Length = ctgry10Nms == null ? 0 : ctgry10Nms.length;
		int ctgry20Length = ctgry20Nms == null ? 0 : ctgry20Nms.length;
		if (ctgry10Length + ctgry20Length == 0) {
			resultMap.put("success", false);
            resultMap.put("msg", "관심 복지용구를 선택하세요");
            return resultMap;
		}
		
		List<MbrRecipientsVO> mbrRecipientsList = mbrRecipientsService.selectMbrRecipientsByMbrUniqueId(mbrSession.getUniqueId());
		if (!mbrRecipientsList.stream().anyMatch(f -> f.getRecipientsNo() == recipientsNo)) {
			resultMap.put("success", false);
            resultMap.put("msg", "등록되지 않은 수급자입니다");
            return resultMap;
		}
		
		try {
			mbrRecipientsGdsService.insertMbrRecipientsGds(recipientsNo, ctgry10Nms, ctgry20Nms);
			
			resultMap.put("success", true);
		} catch (Exception ex) {
			resultMap.put("success", false);
			resultMap.put("msg", "관심 복지용구 선택정보 저장에 실패하였습니다");
		}
		
		return resultMap;
	}
}
