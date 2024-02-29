package icube.app.matching.membership.info;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.app.matching.membership.mbr.biz.MatMbrSession;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CodeMap;
import icube.manage.consult.biz.MbrConsltService;
import icube.manage.consult.biz.MbrConsltVO;
import icube.manage.mbr.recipients.biz.MbrRecipientsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;

/**
 * 상담 관련
 */
@Controller
@RequestMapping(value="#{props['Globals.Matching.path']}/membership/conslt")
public class MatMbrConsltController extends CommonAbstractController {
	
	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;
	
	@Resource(name= "mbrRecipientsService")
	private MbrRecipientsService mbrRecipientsService;
	
	@Autowired
	private MatMbrSession matMbrSession; 
	 
	
	/**
	 * 특정 수급자의 진행중인 상담 조회(서비스 > swipe 구성)
	 */
	@ResponseBody
	@RequestMapping("progress")
	public Map<String, Object> getConsltInProgress(@RequestParam int recipientsNo) {
		Map <String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", false);
		
		try {
			List<MbrConsltVO> mbrConsltList = mbrConsltService.getConsltInProgress(recipientsNo);
			List<String> prevPathList = mbrConsltList.stream().map(m -> m.getPrevPath()).distinct().collect(Collectors.toList());
			resultMap.put("success", true);
			resultMap.put("prevPathList", prevPathList);
		} catch (Exception ex) {
			log.error("===== 진행중인 상담 조회 API 오류", ex);
		}
		
		return resultMap;
	}
	
	/**
	 * 상담신청 전 상담 정보 확인 페이지
	 */
	@RequestMapping(value = "infoConfirm")
	public String infoConfirm(
		@RequestParam String prevPath
		, @RequestParam int recipientsNo 
		, Model model) throws Exception {
		
		List<MbrRecipientsVO> mbrRecipientList = mbrRecipientsService.selectMbrRecipientsByMbrUniqueId(matMbrSession.getUniqueId());
		MbrRecipientsVO recipientInfo = mbrRecipientList.stream().filter(f -> f.getRecipientsNo() == recipientsNo).findAny().orElse(null);
		if (recipientInfo == null) {
			model.addAttribute("appMsg", "등록된 수급자가 아닙니다.");
			model.addAttribute("appLocation", "/matching/main/service");
			return "/app/matching/common/appMsg";
		}
		
		model.addAttribute("prevPath", prevPath);
		model.addAttribute("recipientInfo", recipientInfo);
		
		model.addAttribute("prevPathMap", CodeMap.PREV_PATH_FOR_APP);
		
		return "/app/matching/membership/conslt/infoConfirm";
	}
}
