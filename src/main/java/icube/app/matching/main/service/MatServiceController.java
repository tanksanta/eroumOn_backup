package icube.app.matching.main.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.app.matching.membership.mbr.biz.MatMbrSession;
import icube.manage.mbr.recipients.biz.MbrRecipientsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;

/**
 * 서비스 페이지
 */
@Controller
@RequestMapping(value="#{props['Globals.Matching.path']}/main/service")
public class MatServiceController {
	
	@Resource(name= "mbrRecipientsService")
	private MbrRecipientsService mbrRecipientsService;
	
	@Autowired
	private MatMbrSession matMbrSession;
	
	
	/*
	 * 메인 서비스 페이지
	 */
	@RequestMapping(value = "")
	public String service(Model model) throws Exception {
		
		if (matMbrSession.isLoginCheck()) {
			//어르신 정보 조회
			List<MbrRecipientsVO> mbrRecipientsList = mbrRecipientsService.selectMbrRecipientsByMbrUniqueId(matMbrSession.getUniqueId());
			model.addAttribute("mbrRecipientsList", mbrRecipientsList);
			//메인 수급자 정보
			MbrRecipientsVO mainRecipient = mbrRecipientsList.stream().filter(f -> "Y".equals(f.getMainYn())).findAny().orElse(null);
			model.addAttribute("mainRecipient", mainRecipient);
		}
		
		return "/app/matching/main/service";
	}
	
	/**
	 * 간편 서비스 페이지
	 */
	@RequestMapping(value = "simple")
	public String simpleService() throws Exception {
		return "/app/matching/main/simpleService";
	}
}
