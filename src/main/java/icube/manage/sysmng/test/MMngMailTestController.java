package icube.manage.sysmng.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.mail.MailForm2Service;
import icube.common.values.CodeMap;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.ordr.dtl.biz.OrdrDtlService;
import icube.manage.ordr.dtl.biz.OrdrDtlVO;
import icube.manage.ordr.ordr.biz.OrdrService;
import icube.manage.ordr.ordr.biz.OrdrVO;
import icube.schedule.DscntSchedule;
import icube.schedule.MailSchedule;
import icube.schedule.MbrSchedule;

/**
 * 관리자에 사용하는 메뉴가 아닌 IT 본부에서 이메일 전송 테스트 용으로 사용
 */
@Controller
@RequestMapping(value="/_mng/sysmng/test/mail")
public class MMngMailTestController {

	@Resource(name = "mailSchedule")
	private MailSchedule mailSchedule;
	
	@Resource(name = "dscntSchedule")
	private DscntSchedule dscntSchedule;
	
	@Resource(name = "mbrSchedule")
	private MbrSchedule mbrSchedule;

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "ordrService")
	private OrdrService ordrService;
	
	@Resource(name = "ordrDtlService")
	private OrdrDtlService ordrDtlService;

	@Resource(name = "mailForm2Service")
	private MailForm2Service mailForm2Service;
	
	@RequestMapping(value="list")
	public String list() {
		return "/manage/sysmng/test/mail/list";
	}
	
	@ResponseBody
	@RequestMapping(value="brdt.json")
	public Map<String, Object> sendBrdtEmail() {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		boolean success = false;
		
		try {
			mailSchedule.sendBrdtEmail();
			success = true;
		} catch (Exception ex) {
			resultMap.put("msg", "생일 축하 메일 발송중 오류 발생");
		}
		
		resultMap.put("success", success);
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value="info.json")
	public Map<String, Object> sendInfoEmail() {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		boolean success = false;
		
		try {
			mailSchedule.sendInfoMail();
			success = true;
		} catch (Exception ex) {
			resultMap.put("msg", "개인정보 이용내역 통지안내 메일 발송 중 오류 발생");
		}
		
		resultMap.put("success", success);
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value="guideExtinctPoint.json")
	public Map<String, Object> guideExtinctPoint() {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		boolean success = false;
		
		try {
			dscntSchedule.guideExtinctPoint();
			success = true;
		} catch (Exception ex) {
			resultMap.put("msg", "소멸예정 포인트 메일 발송 중 오류 발생");
		}
		
		resultMap.put("success", success);
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value="guideExtinctMlg.json")
	public Map<String, Object> guideExtinctMlg() {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		boolean success = false;
		
		try {
			dscntSchedule.guideExtinctMlg();
			success = true;
		} catch (Exception ex) {
			resultMap.put("msg", "소멸예정 마일리지 메일 발송 중 오류 발생");
		}
		
		resultMap.put("success", success);
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value="guidDrmcMbrMail.json")
	public Map<String, Object> sendGuidDrmcMbrMail() {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		boolean success = false;
		
		try {
			mailSchedule.sendGuidDrmcMbrMail();
			success = true;
		} catch (Exception ex) {
			resultMap.put("msg", "휴면계정 대상 안내 메일 발송 중 오류 발생");
		}
		
		resultMap.put("success", success);
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value="sleepMbr.json")
	public Map<String, Object> sleepMbr() {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		boolean success = false;
		
		try {
			mbrSchedule.sleepMbr();
			success = true;
		} catch (Exception ex) {
			resultMap.put("msg", "휴면계정 전환 안내 메일 발송 중 오류 발생");
		}
		
		resultMap.put("success", success);
		return resultMap;
	}

	@RequestMapping(value="ordr")
	public String ordrForm(HttpServletRequest request
		, Model model) {

		model.addAttribute("mailSendTyCode", CodeMap.MAIL_SEND_TY);

		return "/manage/sysmng/test/mail/ordr";
	}

	@ResponseBody
	@RequestMapping(value="ordrMailSend.json")
	public Map<String, Object> ordrMailSend(
		HttpServletRequest request
		, @RequestParam Map<String,Object> reqMap
		, @RequestParam(value = "ordrCd", required=true) String ordrCd
		, @RequestParam(value = "ordrDtlCd") String ordrDtlCd
		, @RequestParam(value = "ordrrId", required=true) String ordrrId
		, @RequestParam(value = "mailTy", required=true) String mailTy
		, Model model
		) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		boolean success = false;
		
		OrdrVO ordrVO = ordrService.selectOrdrByCd(ordrCd);

		if (ordrVO == null){
			resultMap.put("success", success);
			resultMap.put("error_code", "00001");
			resultMap.put("error_msg", "주문번호가 존재하지 않습니다.");
			return resultMap;
		}

		if (EgovStringUtil.isNotEmpty(ordrDtlCd)){
			List<OrdrDtlVO> listDtl = ordrVO.getOrdrDtlList().stream()
				    .filter(t -> EgovStringUtil.equals(ordrDtlCd, t.getOrdrDtlCd()))
				    .collect(Collectors.toList());

			if (listDtl.size() == 0){
				resultMap.put("success", success);
				resultMap.put("error_code", "00002");
				resultMap.put("error_msg", "주문에 상세코드가 존재하지 않습니다.");
				return resultMap;
			}
		}

		if (!CodeMap.MAIL_SEND_TY.containsKey(mailTy)){
			resultMap.put("success", success);
			resultMap.put("error_code", "00003");
			resultMap.put("error_msg", "메일 타입이 존재하지 않습니다.");
			return resultMap;
		}

		MbrVO mbrVO = mbrService.selectMbrById(ordrrId);
		if (mbrVO == null){
			resultMap.put("success", success);
			resultMap.put("error_code", "00004");
			resultMap.put("error_msg", "발송자를 확인하여 주십시오.");
			return resultMap;
		}

		if (EgovStringUtil.equals(mailTy, "MAILSEND_ORDR_MNG_RETURN") 
			|| EgovStringUtil.equals(mailTy,"MAILSEND_ORDR_MNG_REFUND")
			|| EgovStringUtil.equals(mailTy,"MAILSEND_ORDR_SCHEDULE_CONFIRM_ACTION")
			|| EgovStringUtil.equals(mailTy,"MAILSEND_ORDR_SCHEDULE_CONFIRM_NOTICE")){

			if (EgovStringUtil.isEmpty(ordrDtlCd)){
				resultMap.put("success", success);
				resultMap.put("error_code", "00101");
				resultMap.put("error_msg", "주문상세 번호를 확인하여 주십시오.");
				return resultMap;
			}

			List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
			ordrVO.setOrdrDtlList(ordrDtlList);
		}
		

		mailForm2Service.sendMailOrder(mailTy, mbrVO, ordrVO, ordrDtlCd);
		
		success = true;
		resultMap.put("success", success);
		resultMap.put("email", mbrVO.getEml());
		return resultMap;
	}

}
