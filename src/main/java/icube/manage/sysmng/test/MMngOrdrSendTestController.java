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

import icube.common.api.biz.BiztalkOrderService;
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
@RequestMapping(value="/_mng/sysmng/test/ordrsend")
public class MMngOrdrSendTestController {

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

	@Resource(name = "biztalkOrderService")
	private BiztalkOrderService biztalkOrderService;
	

	@RequestMapping(value="mail/form")
	public String ordrMailForm(HttpServletRequest request
		, Model model) {

		model.addAttribute("mailSendTy", "mail");
		model.addAttribute("mailSendTyCdList", CodeMap.MAIL_SEND_TY);

		return "/manage/sysmng/test/mail/ordr";
	}

	@RequestMapping(value="biztalk/form")
	public String ordrBiztalkForm(HttpServletRequest request
		, Model model) {

		model.addAttribute("mailSendTy", "biztalk");	
		model.addAttribute("mailSendTyCdList", CodeMap.BIZTALK_SEND_TY);
		

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

	@ResponseBody
	@RequestMapping(value="ordrBiztalkSend.json")
	public Map<String, Object> ordrBiztalkSend(
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

		if (!CodeMap.BIZTALK_SEND_TY.containsKey(mailTy)){
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

		if (mailTy != null){
			if (mailTy.indexOf("BIZTALKSEND_ORDR_MARKET_PAYDONE") >= 0 
				|| EgovStringUtil.equals(mailTy, "BIZTALKSEND_ORDR_SCHEDULE_VBANK_REQUEST")
				|| EgovStringUtil.equals(mailTy, "BIZTALKSEND_ORDR_BOOTPAY_VBANK_INCOME")
				|| EgovStringUtil.equals(mailTy, "BIZTALKSEND_ORDR_SCHEDULE_VBANK_CANCEL")
				|| EgovStringUtil.equals(mailTy, "BIZTALKSEND_ORDR_SCHEDULE_CONFIRM_NOTICE")
				|| EgovStringUtil.equals(mailTy, "BIZTALKSEND_ORDR_SCHEDULE_CONFIRM_ACTION")
				// || EgovStringUtil.equals(mailTy, "BIZTALKSEND_ORDR_MYPAGE_CONFIRM_ACTION")
			){

				success = biztalkOrderService.sendOrdr(mailTy, mbrVO, ordrVO);
			}
			

		}
		
		resultMap.put("success", success);
		resultMap.put("phoneno", mbrVO.getMblTelno());
		return resultMap;
	}

}
