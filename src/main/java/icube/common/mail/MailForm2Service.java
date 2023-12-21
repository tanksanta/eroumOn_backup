package icube.common.mail;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.util.DateUtil;
import icube.common.util.FileUtil;
import icube.common.util.ValidatorUtil;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.ordr.dtl.biz.OrdrDtlVO;
import icube.manage.ordr.ordr.biz.OrdrService;
import icube.manage.ordr.ordr.biz.OrdrVO;
import icube.common.values.CodeMap;
import icube.common.framework.helper.HttpHelper;;

/**
 * EROUM 메일 폼 Maker
 * @author dylee
 *
 */
@Service("mailForm2Service")
public class MailForm2Service extends CommonAbstractServiceImpl {

	@Resource(name = "ordrService")
	private OrdrService ordrService;

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "mailService")
	private MailService mailService;

	@Value("#{props['Mail.Form.FilePath']}")
	private String mailFormFilePath;

	@Value("#{props['Mail.Username']}")
	private String mailSender;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;


	// 공통 선언
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	DecimalFormat numberFormat = new DecimalFormat("###,###");
	
	/**
	 * 양식 읽기
	 * @param mailHtml
	 * @return mailForm
	 * @throws Exception
	 */
	protected String getRead(String mailHtml) throws Exception {
		String MAIL_FORM_PATH = mailFormFilePath;
		String mailForm = FileUtil.readFile(MAIL_FORM_PATH + mailHtml);

		return mailForm;
	}

	public void sendMailOrder(String ordrMailTy, MbrVO mbrVO, OrdrVO ordrVO) throws Exception {
		this.sendMailOrder(ordrMailTy, mbrVO, ordrVO, "");
	}
	public void sendMailOrder(String ordrMailTy, MbrVO mbrVO, OrdrVO ordrVO, String addInfo) throws Exception {
		try{
			this.sendMailOrderAction(ordrMailTy, mbrVO, ordrVO, addInfo);
		}catch(Exception e){
			System.out.println("EMAIL 전송 실패 :: " + e.toString());
		}
	}

	protected void sendMailOrderAction(String ordrMailTy, MbrVO mbrVO, OrdrVO ordrVO, String addInfo) throws Exception {

		if (!CodeMap.MAIL_SEND_TY.containsKey(ordrMailTy)){
			throw new Exception("not found mail type");
		}

		if (mbrVO == null || EgovStringUtil.isEmpty(mbrVO.getUniqueId())){
			throw new Exception("not found mbrVO uniqueid");
		}

		if (ordrVO == null || EgovStringUtil.isEmpty(ordrVO.getOrdrCd())){
			throw new Exception("not found ordrVO OrdrCd");
		}

		//탈퇴한 회원에게는 발송하지 않음
		if ("Y".equals(mbrVO.getWhdwlYn())) {
			return;
		}

		String content = this.makeMailForm2Ordr(ordrMailTy, mbrVO, ordrVO, addInfo);
		String mailSubject = "";
		switch (ordrMailTy) {
			case "MAILSEND_ORDR_MARKET_PAYDONE_CARD":
			case "MAILSEND_ORDR_MARKET_PAYDONE_BANK":
			case "MAILSEND_ORDR_MARKET_PAYDONE_FREE":
				mailSubject = "[이로움ON] 회원님의 주문이 완료 되었습니다.";
				break;
			case "MAILSEND_ORDR_MARKET_PAYDONE_VBANK":
				mailSubject = "[이로움ON] 회원님의 주문이 접수 되었습니다.";
				break;
			case "MAILSEND_ORDR_SCHEDULE_VBANK_REQUEST":
				mailSubject = "[이로움ON] 주문하신 상품의 입금확인 부탁드립니다.";
				break;
			case "MAILSEND_ORDR_SCHEDULE_VBANK_CANCEL":
				mailSubject = "[이로움ON] 회원님의 주문이 자동취소 되었습니다.";
				break;
			case "MAILSEND_ORDR_BOOTPAY_VBANK_INCOME":
				mailSubject = "[이로움ON] 주문하신 상품의 입금이 확인되었습니다.";
				break;
			case "MAILSEND_ORDR_MNG_CONFIRM":
				mailSubject = "[이로움ON] 주문하신 상품의 배송 준비가 완료되었습니다.";
				break;
			case "MAILSEND_ORDR_MNG_RETURN":
				mailSubject = "[이로움ON] 회원님의 상품 반품이 완료 되었습니다.";
				break;
			case "MAILSEND_ORDR_MNG_REFUND":
				mailSubject = "[이로움ON] 회원님의 주문이 취소 되었습니다.";
				break;
			case "MAILSEND_ORDR_SCHEDULE_CONFIRM_NOTICE":
				mailSubject = "[이로움ON] 주문하신 상품이 자동 구매확정처리 예정입니다.";
				break;
			case "MAILSEND_ORDR_SCHEDULE_CONFIRM_ACTION":
				mailSubject = "[이로움ON] 주문하신 상품이 자동 구매확정처리 되었습니다.";
				break;
			default:
				throw new Exception("not found mail file");
		}

		if(!EgovStringUtil.equals("real", activeMode)) {
			mailSubject = "[TEST] " + mailSubject;
		}

		// System.out.print(mailSubject);
		// System.out.print(content);
		/* 
		주문자의 메일로 보냄
		*/
		mailService.sendMail(mailSender, mbrVO.getEml(), mailSubject, content);
		
	}

	protected String makeMailForm2Ordr(String ordrMailTy, MbrVO mbrVO, OrdrVO ordrVO, String addInfo) throws Exception {
		
		String sFileNM = "";

		/*기본이 되는 메일양식 선택*/
		switch (ordrMailTy) {
			case "MAILSEND_ORDR_MARKET_PAYDONE_CARD":
			case "MAILSEND_ORDR_MARKET_PAYDONE_BANK":
			case "MAILSEND_ORDR_MARKET_PAYDONE_FREE":
				sFileNM = "/mail/ordr/mail_ordr_market_paydone_card.html";
				break;
			case "MAILSEND_ORDR_MARKET_PAYDONE_VBANK":
				sFileNM = "/mail/ordr/mail_ordr_market_paydone_vbank.html";
				break;
			case "MAILSEND_ORDR_SCHEDULE_VBANK_REQUEST":
				sFileNM = "/mail/ordr/mail_ordr_schedule_vbank_request.html";
				break;
			case "MAILSEND_ORDR_SCHEDULE_VBANK_CANCEL":
				sFileNM = "/mail/ordr/mail_ordr_schedule_vbank_cancel.html";
				break;
			case "MAILSEND_ORDR_BOOTPAY_VBANK_INCOME":
				sFileNM = "/mail/ordr/mail_ordr_bootpay_vbank_income.html";
				break;
			case "MAILSEND_ORDR_MNG_CONFIRM":
				sFileNM = "/mail/ordr/mail_ordr_mng_confirm.html";
				break;
			case "MAILSEND_ORDR_MNG_RETURN":
				sFileNM = "/mail/ordr/mail_ordr_mng_return.html";
				break;
			case "MAILSEND_ORDR_MNG_REFUND":
				sFileNM = "/mail/ordr/mail_ordr_mng_rfnd.html";
				break;
			case "MAILSEND_ORDR_SCHEDULE_CONFIRM_NOTICE":
				sFileNM = "/mail/ordr/mail_ordr_schedule_confirm_notice.html";
				break;
			case "MAILSEND_ORDR_SCHEDULE_CONFIRM_ACTION":
				sFileNM = "/mail/ordr/mail_ordr_schedule_confirm_action.html";
				break;
			default:
				throw new Exception("not found mail file");
		}

		String mailContent;

		try{
			mailContent = this.getRead(sFileNM);
		}catch(Exception e){
			throw new Exception("not found mail file read");
		}
		
		mailContent = this.convertMailFormMbr(mbrVO, mailContent);

		/*메일양식을 내용으로 치환*/
		switch (ordrMailTy) {
			case "MAILSEND_ORDR_MARKET_PAYDONE_CARD":
			case "MAILSEND_ORDR_MARKET_PAYDONE_BANK":
			case "MAILSEND_ORDR_MARKET_PAYDONE_FREE":
				mailContent = this.makeMailForm2OrdrMarketPaydoneCard(ordrVO, mailContent);
				break;
			case "MAILSEND_ORDR_MARKET_PAYDONE_VBANK":
				mailContent = this.makeMailForm2OrdrMarketPaydoneVBank(ordrVO, mailContent);
				break;
			case "MAILSEND_ORDR_SCHEDULE_VBANK_REQUEST":
				mailContent = this.makeMailForm2OrdrScheduleVbankRqeuqst(ordrVO, mailContent);
				break;
			case "MAILSEND_ORDR_SCHEDULE_VBANK_CANCEL":
				mailContent = this.makeMailForm2OrdrScheduleVbankCancel(ordrVO, mailContent);
				break;
			case "MAILSEND_ORDR_BOOTPAY_VBANK_INCOME":
				mailContent = this.makeMailForm2OrdrBootpayVbankIncome(ordrVO, mailContent);
				break;
			case "MAILSEND_ORDR_MNG_CONFIRM":
				mailContent = this.makeMailForm2OrdrMngConfirm(ordrVO, mailContent);
				break;
			case "MAILSEND_ORDR_MNG_RETURN":
				mailContent = this.makeMailForm2OrdrMngReturn(ordrVO, addInfo, mailContent);
				break;
			case "MAILSEND_ORDR_MNG_REFUND":
				mailContent = this.makeMailForm2OrdrMngRefund(ordrVO, addInfo, mailContent);
				break;
			case "MAILSEND_ORDR_SCHEDULE_CONFIRM_NOTICE":
				mailContent = this.makeMailForm2OrdrScheduleConfirmNotice(ordrVO, addInfo, mailContent);
				break;
			case "MAILSEND_ORDR_SCHEDULE_CONFIRM_ACTION":
				mailContent = this.makeMailForm2OrdrScheduleConfirmAction(ordrVO, addInfo, mailContent);
				break;
			default:
				throw new Exception("not found mail content");
		}


		return mailContent;
	}

	/*주문 접수 중 결제가 완료된 경우(CARD, BANK)*/
	protected String makeMailForm2OrdrMarketPaydoneCard(OrdrVO ordrVO, String mailContent) throws Exception {

		mailContent = this.convertMailFormOrdrCommon(ordrVO, mailContent);
		mailContent = this.convertMailFormORDRR(ordrVO, mailContent);
		mailContent = this.convertMailFormOrdrRECPTR(ordrVO, mailContent);
		mailContent = this.convertMailFormOrdrPayment(ordrVO, mailContent);
		mailContent = this.convertMailFormOrdrCardDisp(ordrVO, mailContent);
		
		mailContent = this.convertMailFormOrdrDtlList(ordrVO.getOrdrDtlList(), mailContent);

		
		return mailContent;
	}

	/*주문 접수 중 결제가 바로 되지 않는 경우 (VBANK), 가상계좌 정보를 더 표시 한다.*/
	protected String makeMailForm2OrdrMarketPaydoneVBank(OrdrVO ordrVO, String mailContent) throws Exception {

		mailContent = this.makeMailForm2OrdrMarketPaydoneCard(ordrVO, mailContent);

		mailContent = this.convertMailFormOrdrVBankInfo(ordrVO, mailContent);
		mailContent = this.convertMailFormOrdrVBankGuide(ordrVO, mailContent);
		
		return mailContent;
	}

	/* schedule에서 입금 요청.*/
	protected String makeMailForm2OrdrScheduleVbankRqeuqst(OrdrVO ordrVO, String mailContent) throws Exception {

		mailContent = this.makeMailForm2OrdrMarketPaydoneCard(ordrVO, mailContent);

		mailContent = this.convertMailFormOrdrVBankInfo(ordrVO, mailContent);
		mailContent = this.convertMailFormOrdrVBankGuide(ordrVO, mailContent);
		
		return mailContent;
	}

	/* schedule에서 입금 요청 취소.*/
	protected String makeMailForm2OrdrScheduleVbankCancel(OrdrVO ordrVO, String mailContent) throws Exception {
		mailContent = this.makeMailForm2OrdrMarketPaydoneCard(ordrVO, mailContent);

		mailContent = this.convertMailFormOrdrVBankGuide(ordrVO, mailContent);

		return mailContent;
	}
	
	/*bootpay callback에서 입금이 확인.*/
	protected String makeMailForm2OrdrBootpayVbankIncome(OrdrVO ordrVO, String mailContent) throws Exception {

		mailContent = this.makeMailForm2OrdrMarketPaydoneCard(ordrVO, mailContent);

		mailContent = this.convertMailFormOrdrVBankInfo(ordrVO, mailContent);
		
		mailContent = this.convertMailFormDateFull(ordrVO.getStlmDt(), "stlmDt", mailContent);
		
		return mailContent;
	}

	protected String makeMailForm2OrdrMngConfirm(OrdrVO ordrVO, String mailContent) throws Exception {

		mailContent = this.makeMailForm2OrdrMarketPaydoneCard(ordrVO, mailContent);
		return mailContent;
	}

	protected String makeMailForm2OrdrMngReturn(OrdrVO ordrVO, String ordrDtlCd, String mailContent) throws Exception {

		mailContent = this.convertMailFormOrdrCommon(ordrVO, mailContent);
		mailContent = this.convertMailFormORDRR(ordrVO, mailContent);
		mailContent = this.convertMailFormOrdrRECPTR(ordrVO, mailContent);
		mailContent = this.convertMailFormOrdrPayment(ordrVO, mailContent);
		mailContent = this.convertMailFormOrdrCardDisp(ordrVO, mailContent);

		// List<OrdrDtlVO> listDtl = ordrVO.getOrdrDtlList().stream()
		// 		    .filter(t -> EgovStringUtil.equals(ordrDtlCd, t.getOrdrDtlCd()))
		// 		    .collect(Collectors.toList());
		mailContent = this.convertMailFormOrdrDtlList(ordrVO.getOrdrDtlList(), mailContent);

		mailContent = this.convertMailFormDate(new Date(), "ordrDt", mailContent);

		mailContent = this.convertMailFormOrdrPartRefundInfo(ordrVO, ordrVO.getOrdrDtlList().get(0), mailContent);
		mailContent = this.convertMailFormOrdrPartRefundGuide(mailContent);
		
		return mailContent;
	}

	protected String makeMailForm2OrdrMngRefund(OrdrVO ordrVO, String ordrDtlCd, String mailContent) throws Exception {

		mailContent = this.convertMailFormOrdrCommon(ordrVO, mailContent);
		mailContent = this.convertMailFormORDRR(ordrVO, mailContent);
		mailContent = this.convertMailFormOrdrRECPTR(ordrVO, mailContent);
		mailContent = this.convertMailFormOrdrPayment(ordrVO, mailContent);
		mailContent = this.convertMailFormOrdrCardDisp(ordrVO, mailContent);

		List<OrdrDtlVO> listDtl = ordrVO.getOrdrDtlList().stream()
				    .filter(t -> EgovStringUtil.equals(ordrDtlCd, t.getOrdrDtlCd()))
				    .collect(Collectors.toList());
		mailContent = this.convertMailFormOrdrDtlList(listDtl, mailContent);

		mailContent = this.convertMailFormDate(ordrVO.getOrdrDt(), "now", mailContent);

		mailContent = this.convertMailFormOrdrPartRefundInfo(ordrVO, ordrVO.getOrdrDtlList().get(0), mailContent);
		mailContent = this.convertMailFormOrdrPartRefundGuide(mailContent);
		
		return mailContent;
	}

	protected String makeMailForm2OrdrScheduleConfirmNotice(OrdrVO ordrVO, String srchIntervalDay, String mailContent) throws Exception {
		mailContent = this.convertMailFormOrdrCommon(ordrVO, mailContent);
		mailContent = this.convertMailFormORDRR(ordrVO, mailContent);
		mailContent = this.convertMailFormOrdrRECPTR(ordrVO, mailContent);
		mailContent = this.convertMailFormOrdrPayment(ordrVO, mailContent);
		mailContent = this.convertMailFormOrdrCardDisp(ordrVO, mailContent);
					
		mailContent = this.convertMailFormOrdrDtlList(ordrVO.getOrdrDtlList(), mailContent);

		//구매확정 예정일
		mailContent = this.convertMailFormDate(DateUtil.getDateAdd(new Date(), "date", 2), "now", mailContent);

		return mailContent;
	}

	protected String makeMailForm2OrdrScheduleConfirmAction(OrdrVO ordrVO, String ordrDtlCd, String mailContent) throws Exception {
		mailContent = this.convertMailFormOrdrCommon(ordrVO, mailContent);
		mailContent = this.convertMailFormORDRR(ordrVO, mailContent);
		mailContent = this.convertMailFormOrdrRECPTR(ordrVO, mailContent);
		mailContent = this.convertMailFormOrdrPayment(ordrVO, mailContent);
		mailContent = this.convertMailFormOrdrCardDisp(ordrVO, mailContent);
					
		mailContent = this.convertMailFormOrdrDtlList(ordrVO.getOrdrDtlList(), mailContent);
		
		return mailContent;
	}

	/*회원 일반 사항*/
	protected String convertMailFormMbr(MbrVO mbrVO, String mailContent){
		String keyword;

		keyword = "((mbrNm))";				if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, mbrVO.getMbrNm());

		return mailContent;
	}

	/*주문 일반 사항*/
	protected String convertMailFormOrdrCommon(OrdrVO ordrVO, String mailContent){
		String keyword;
		
		keyword = "((ordrDt))";				if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, formatter.format(ordrVO.getOrdrDt()));
		keyword = "((ordrCd))";				if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, ordrVO.getOrdrCd());
		
		return mailContent;
	}

	/*주문 가상계좌 info*/
	protected String convertMailFormOrdrVBankInfo(OrdrVO ordrVO, String mailContent) throws Exception {
		
		String filePath = "/mail/ordr/part/mail_ordr_part_vbank_info.html";
		String mailTemp = this.getRead(filePath);

		mailTemp = this.convertMailFormDateFull(ordrVO.getDpstTermDt(), "dpstTermDt", mailTemp);

		mailContent = mailContent.replace("((ordrPartVbankInfo))", mailTemp);
		

		return mailContent;
	}

	/*주문 가상계좌 Guide*/
	protected String convertMailFormOrdrVBankGuide(OrdrVO ordrVO, String mailContent) throws Exception {
		String keyword;

		String filePath = "/mail/ordr/part/mail_ordr_part_vbank_guide.html";
		String mailTemp = this.getRead(filePath);
		
		// keyword = "((ordrDt))";				if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, formatter.format(ordrVO.getOrdrDt()));
		// keyword = "((ordrCd))";				if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, ordrVO.getOrdrCd());
		mailTemp = this.convertMailFormDateFull(ordrVO.getDpstTermDt(), "dpstTermDt", mailTemp);

		keyword = "((dpstBankNm))";			if (mailTemp.indexOf(keyword) >= 0) mailTemp = this.convertReplace(keyword, ordrVO.getDpstBankNm(), mailTemp);
		keyword = "((vrActno))";			if (mailTemp.indexOf(keyword) >= 0) mailTemp = this.convertReplace(keyword, ordrVO.getVrActno(), mailTemp);
		
		mailContent = mailContent.replace("((ordrPartVbankGuide))", mailTemp);

		return mailContent;
	}

	/*주문 주문자*/
	protected String convertMailFormORDRR(OrdrVO ordrVO, String mailContent){
		String keyword;
		
		keyword = "((ordrrEml))";			if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrVO.getOrdrrEml(), mailContent);
		keyword = "((ordrrNm))";			if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrVO.getOrdrrNm(), mailContent);
		keyword = "((ordrrTelno))";			if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrVO.getOrdrrTelno(), mailContent);
		keyword = "((ordrrMblTelno))";		if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrVO.getOrdrrMblTelno(), mailContent);
		keyword = "((ordrrZip))";			if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrVO.getOrdrrZip(), mailContent);
		keyword = "((ordrrAddr))";			if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrVO.getOrdrrAddr(), mailContent);
		keyword = "((ordrrDaddr))";			if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrVO.getOrdrrDaddr(), mailContent);
		
		return mailContent;
	}

	/*주문 배송*/
	protected String convertMailFormOrdrRECPTR(OrdrVO ordrVO, String mailContent){
		String keyword;
		
		keyword = "((recptrNm))";			if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrVO.getRecptrNm(), mailContent);
		keyword = "((recptrTelno))";		if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrVO.getRecptrTelno(), mailContent);
		keyword = "((recptrMblTelno))";		if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrVO.getRecptrMblTelno(), mailContent);
		keyword = "((recptrZip))";			if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrVO.getRecptrZip(), mailContent);
		keyword = "((recptrAddr))";			if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrVO.getRecptrAddr(), mailContent);
		keyword = "((recptrDaddr))";		if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrVO.getRecptrDaddr(), mailContent);
		
		return mailContent;
	}

	/*주문 금액*/
	protected String convertMailFormOrdrPayment(OrdrVO ordrVO, String mailContent){
		String keyword;
		
		Map<String, Integer> resultMap = this.ordrDtlSum(ordrVO);

		keyword = "((stlmAmt))";				if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword	, ordrVO.getStlmAmt(), mailContent);// 결제금액

		// keyword = "((SUM_GDS_PC))";				if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, numberFormat.format(totalGdsPc));// 상품_가격
		keyword = "((SumGdsPc))";				if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword	, resultMap.get("SumGdsPc"), mailContent);// 주문_가격
		keyword = "((SumDlvyPc))";				if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword	, resultMap.get("SumDlvyPc"), mailContent);// 배송_금액 + 배송_추가_금액
		keyword = "((SumCouponAmts))";			if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword	, resultMap.get("SumCouponAmts"), mailContent);// 쿠폰_금액
		
		return mailContent;
	}

	/*주문 결제정보*/
	protected String convertMailFormOrdrCardDisp(OrdrVO ordrVO, String mailContent){
		String keyword;
		
		keyword = "((cardCoNm))";		if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrVO.getCardCoNm(), mailContent);
		keyword = "((cardNo))";			if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrVO.getCardNo(), mailContent);
		keyword = "((dpstBankNm))";		if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrVO.getDpstBankNm(), mailContent);
		keyword = "((vrActno))";		if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrVO.getVrActno(), mailContent);
		keyword = "((dpstr))";			if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrVO.getDpstr(), mailContent);
		keyword = "((pyrNm))";			if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrVO.getPyrNm(), mailContent);
		keyword = "((dpstTermDt))";		if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrVO.getDpstTermDt(), mailContent);

		mailContent = this.convertMailFormDateFull(ordrVO.getDpstTermDt(), "dpstTermDt", mailContent);

		return mailContent;
	}

	protected String convertMailFormOrdrDtlList(List<OrdrDtlVO> ordrDtlList, String mailContent) throws Exception {
		String filePath;
		String mailGdsBase, mailGdsTemp, mailGdsAditBase;
		ArrayList<String> arrayList = new ArrayList<String>();
		OrdrDtlVO ordrDtlOne;

		filePath = "/mail/ordr/part/mail_ordr_part_gds_view.html";
		mailGdsBase = this.getRead(filePath);

		filePath = "/mail/ordr/part/mail_ordr_part_gds_optn.html";
		mailGdsAditBase = this.getRead(filePath);


		int ifor, ilen  = ordrDtlList.size();

		for(ifor=0 ; ifor<ilen ; ifor++){
			ordrDtlOne = ordrDtlList.get(ifor);

			if (ordrDtlOne.getOrdrOptnTy().equals("ADIT")){
				continue;
			}
			mailGdsTemp = this.convertMailFormOrdrDtlOne(ordrDtlList.get(ifor), ordrDtlList, mailGdsBase, mailGdsAditBase);

			arrayList.add(mailGdsTemp);
		}

		String keyword;

		keyword = "((ordrPartGdsView))";		
		mailContent = mailContent.replace(keyword	, String.join("\n", arrayList));

		return mailContent;
	}

	protected String convertMailFormOrdrDtlOne(OrdrDtlVO ordrDtlOne, List<OrdrDtlVO> ordrDtlList, String mailContent, String mailGdsAditBase) throws Exception {
		String keyword;
		String aditOptn;

		keyword = "((gdsNm))";			if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrDtlOne.getGdsNm(), mailContent);
		
		keyword = "((gdsOptnNm))";		if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrDtlOne.getOrdrOptn(), mailContent);
		keyword = "((ordrQy))";			if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrDtlOne.getOrdrQy(), mailContent);
		keyword = "((ordrPc))";			if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrDtlOne.getOrdrPc(), mailContent);
		keyword = "((bplc))";			if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, ordrDtlOne.getBplcNm(), mailContent);
		
		aditOptn = this.convertMailFormOrdrDtlOneAditAll(ordrDtlOne, ordrDtlList, mailGdsAditBase);
		keyword = "((aditOptn))";		if (mailContent.indexOf(keyword) >= 0) mailContent = this.convertReplace(keyword, aditOptn, mailContent);

		return mailContent;
	}

	protected String convertMailFormOrdrDtlOneAditAll(OrdrDtlVO ordrDtlOne, List<OrdrDtlVO> ordrDtlList, String mailGdsAditBase) throws Exception {
		int ifor, ilen = ordrDtlList.size();
		OrdrDtlVO ordrDtlAdit;
		ArrayList<String> arrayList = new ArrayList<String>();

		for(ifor=0 ; ifor<ilen ; ifor++){
			ordrDtlAdit = ordrDtlList.get(ifor);

			if (EgovStringUtil.equals(ordrDtlOne.getOrdrDtlCd(), ordrDtlAdit.getOrdrDtlCd()) && ordrDtlAdit.getOrdrOptnTy().equals("ADIT")){
				arrayList.add(this.convertMailFormOrdrDtlOneAditOne(ordrDtlAdit, mailGdsAditBase));
			}
		}

		return String.join("\n", arrayList);
	}

	protected String convertMailFormOrdrDtlOneAditOne(OrdrDtlVO ordrDtlAdit, String mailGdsAditBase) throws Exception {
		String mailGdsAditTemp = mailGdsAditBase;
		String keyword;

		keyword = "((optnNm))";
		if(EgovStringUtil.isNotEmpty(ordrDtlAdit.getOrdrOptn())) {
			mailGdsAditTemp = this.convertReplace(keyword, ordrDtlAdit.getOrdrOptn(), mailGdsAditTemp);
		}else {
			mailGdsAditTemp = this.convertReplace(keyword, "", mailGdsAditTemp);
		}

		keyword = "((optnQy))";
		mailGdsAditTemp = this.convertReplace(keyword, EgovStringUtil.integer2string(ordrDtlAdit.getOrdrQy()), mailGdsAditTemp);

		keyword = "((optnPc))";
		mailGdsAditTemp = this.convertReplace(keyword, numberFormat.format(ordrDtlAdit.getOrdrOptnPc()), mailGdsAditTemp);

		return mailGdsAditTemp;
	}

	protected String convertMailFormOrdrPartRefundInfo(OrdrVO ordrVO, OrdrDtlVO ordrDtlVO, String mailContent) throws Exception {
		String filePath;
		
		if (EgovStringUtil.equals(ordrVO.getStlmKnd(), "FREE")){
			mailContent = mailContent.replace("((ordrPartRfndInfo))", "");
			return mailContent;
		}else if (EgovStringUtil.equals(ordrVO.getStlmKnd(), "CARD")){
			filePath = "/mail/ordr/part/mail_ordr_part_rfnd_card.html";
		}else if (EgovStringUtil.equals(ordrVO.getStlmKnd(), "BANK") || EgovStringUtil.equals(ordrVO.getStlmKnd(), "VBANK")){
			filePath = "/mail/ordr/part/mail_ordr_part_rfnd_bank.html";
		}else{
			throw new Exception("not defind StlmKnd.");
		}
		
		if (ordrDtlVO == null) ordrDtlVO = ordrVO.getOrdrDtlList().get(0);
		String mailTemp = this.getRead(filePath);

		Map<String, Integer> resultMap = this.ordrDtlSum(ordrVO);
		
		String key, keyword;

		key = "rfndTy"; 		keyword = "((" + key + "))"; if (mailTemp.indexOf(keyword) >= 0) mailTemp = this.convertReplace(keyword, CodeMap.BASS_STLM_TY.get(ordrVO.getStlmKnd()), mailTemp);
		key = "rfndTotalAmt"; 	keyword = "((" + key + "))"; if (mailTemp.indexOf(keyword) >= 0) mailTemp = this.convertReplace(keyword, resultMap.get(key), mailTemp);
		
		key = "rfndBank"; 		keyword = "((" + key + "))"; mailTemp = this.convertReplace(keyword, ordrDtlVO.getRfndBank(), mailTemp);
		key = "rfndActno"; 		keyword = "((" + key + "))"; mailTemp = this.convertReplace(keyword, ordrDtlVO.getRfndActno(), mailTemp);
		key = "rfndNm"; 		keyword = "((" + key + "))"; mailTemp = this.convertReplace(keyword, ordrDtlVO.getRfndDpstr(), mailTemp);

		mailContent = mailContent.replace("((ordrPartRfndInfo))", mailTemp);

		return mailContent;

	}
	protected String convertMailFormOrdrPartRefundGuide(String mailContent) throws Exception {
		String filePath = "/mail/ordr/part/mail_ordr_part_rfnd_guide.html";
		String mailTemp = this.getRead(filePath);

		mailContent = mailContent.replace("((ordrPartRfndGuide))", mailTemp);

		return mailContent;
	}

	protected String convertMailFormDate(Date date, String keyword, String mailContent){
		if (date == null) return mailContent;

		return this.convertMailFormDate(formatter.format(date), keyword, mailContent);
	}

	protected String convertMailFormDate(String date10, String keyword, String mailContent){
		if (date10 == null || date10.length() < 10) return mailContent;

		String stemp;

		stemp = date10.substring(0, 4);		mailContent = mailContent.replace("((" + keyword + "Year))"		, stemp); // 년
		stemp = date10.substring(5, 7);		mailContent = mailContent.replace("((" + keyword + "Month))"	, stemp); // 월
		stemp = date10.substring(8, 10);	mailContent = mailContent.replace("((" + keyword + "Day))"		, stemp); // 일

		return mailContent;
	}

	/*
	 * date19 : 2023-11-23 12:03:59
	*/
	protected String convertMailFormDateFull(Date date, String keyword, String mailContent){
		if (date == null) return mailContent;

		return this.convertMailFormDateFull(formatter.format(date), keyword, mailContent);
	}
	protected String convertMailFormDateFull(String date19, String keyword, String mailContent){
		if (date19 == null || date19.length() < 19) return mailContent;

		String stemp;

		stemp = date19.substring(0, 4);		mailContent = mailContent.replace("((" + keyword + "Year))"		, stemp); // 년
		stemp = date19.substring(5, 7);		mailContent = mailContent.replace("((" + keyword + "Month))"	, stemp); // 월
		stemp = date19.substring(8, 10);	mailContent = mailContent.replace("((" + keyword + "Day))"		, stemp); // 일

		stemp = date19.substring(11, 13);	mailContent = mailContent.replace("((" + keyword + "Hour))"		, stemp); // 시
		stemp = date19.substring(14, 16);	mailContent = mailContent.replace("((" + keyword + "Minute))"	, stemp); // 분
		stemp = date19.substring(17, 19);	mailContent = mailContent.replace("((" + keyword + "Second))"	, stemp); // 초

		return mailContent;
	}

	protected String convertReplace(String keyword, String value, String mailContent){
		if (value == null){
			mailContent = mailContent.replace(keyword		, "");
		}else{
			mailContent = mailContent.replace(keyword		, value);
		}
		return mailContent;
	}

	protected String convertReplace(String keyword, int value, String mailContent){
		mailContent = mailContent.replace(keyword		, numberFormat.format(value));

		return mailContent;
	}

	protected String convertReplaceInt(String keyword, String value, String mailContent){
		if (value == null){
			mailContent = mailContent.replace(keyword		, "");
		}else{
			if (ValidatorUtil.isNumeric(value)){
				mailContent = mailContent.replace(keyword		, numberFormat.format(value));
			}else{
				mailContent = mailContent.replace(keyword		, "0");
			}
		}

		return mailContent;
	}

	protected Map<String, Integer> ordrDtlSum(OrdrVO ordrVO){

		List<OrdrDtlVO> list = ordrVO.getOrdrDtlList();

		// 결제 정보
		int totalGdsPc = 0; // 총 상품 금액 (상품 가격 * 수량)
		int dlvyPc = 0; // 배송비
		int ordrPc = 0; // 주문가격
		int couponAmts = 0; // 쿠폰 할인
		
		int rfndTotalAmt = 0; // 환불금액
//		boolean rfFLag = false;
//		String rfndBanks = "";
//		String rfndActnos = "";

		for (OrdrDtlVO ordrDtlVO : list) {
			if(ordrDtlVO.getOrdrOptnTy().equals("BASE")) {
				totalGdsPc += (ordrDtlVO.getGdsPc() * ordrDtlVO.getOrdrQy());
			}else {
				totalGdsPc += (ordrDtlVO.getOrdrOptnPc() * ordrDtlVO.getOrdrQy());
			}
			dlvyPc += (ordrDtlVO.getDlvyBassAmt() + ordrDtlVO.getDlvyAditAmt());
			couponAmts += ordrDtlVO.getCouponAmt();
			
			if(ordrDtlVO.getSttsTy().equals("RE03") || ordrDtlVO.getSttsTy().equals("CA02")) {
				rfndTotalAmt += ordrDtlVO.getRfndAmt();
				// rfndBanks = ordrDtlVO.getRfndBank();
				// rfndActnos = ordrDtlVO.getRfndActno();
				// rfFLag = true;
			}
		}

		couponAmts += ordrVO.getUseMlg();/*마일리지 금액*/
		couponAmts += ordrVO.getUsePoint();/*포인트 금액*/

		Map<String, Integer> resultMap = new HashMap<String, Integer>();

		resultMap.put("SumGdsPc", totalGdsPc);
		resultMap.put("SumOrdrPc", ordrPc);
		resultMap.put("SumDlvyPc", dlvyPc);
		resultMap.put("SumCouponAmts", couponAmts);
		
		resultMap.put("rfndTotalAmt", rfndTotalAmt);
//		resultMap.put("rfndBanks", rfndBanks);
//		resultMap.put("rfndActnos", rfndActnos);
//		resultMap.put("rfFLag", rfFLag);
		
		return resultMap;
	}


	/*주문접수 카드*/
	protected void mail_test_market_paydone_card() throws Exception 
	{
		MbrVO mbrVO =  mbrService.selectMbrById("dylee96");
		OrdrVO ordrVO = ordrService.selectOrdrByCd("O31124131046432");

		this.sendMailOrder("MAILSEND_ORDR_MARKET_PAYDONE_CARD", mbrVO, ordrVO);

	}

	/*가상계좌 입금요청*/
	protected void mail_test_schedule_vbank_retry() throws Exception 
	{//OrdrPaySchedule.vbankReqeust 에서 테스트
		
	}
	/*가상계좌 입금취소*/
	protected void mail_test_schedule_vbank_cancel() throws Exception 
	{//OrdrPaySchedule.cancle02 에서 테스트
		MbrVO mbrVO =  mbrService.selectMbrById("dylee96");
		OrdrVO ordrVO = ordrService.selectOrdrByCd("O31128144851767");

		this.sendMailOrder("MAILSEND_ORDR_SCHEDULE_VBANK_CANCEL", mbrVO, ordrVO);
	}

	/*가상계좌 입금완료*/
	protected void mail_test_bootpay_vbank_income() throws Exception 
	{
		String callbackTxt = "{\"receipt_id\":\"6560225fa575b4002adcb1c4\",\"order_id\":\"O31124131046432\",\"price\":44700,\"tax_free\":0,\"cancelled_price\":0\r\n" + //
				",\"cancelled_tax_free\":0,\"order_name\":\"뼈까지 먹는 고등어조림 외 4건\",\"company_name\":\"(주)티에이치케이컴퍼니\"\r\n" + //
				",\"gateway_url\":\"https://gw.bootpay.co.kr\"\r\n" + //
				",\"metadata\":{},\"sandbox\":true,\"pg\":\"이니시스\",\"method\":\"가상계좌\",\"method_symbol\":\"vbank\",\"method_origin\":\"가상계좌\"\r\n" + //
				",\"method_origin_symbol\":\"vbank\",\"purchased_at\":\"2023-11-24T13:11:28+09:00\",\"requested_at\":\"2023-11-24T13:11:11+09:00\"\r\n" + //
				",\"status_locale\":\"결제완료\",\"currency\":\"KRW\"\r\n" + //
				",\"receipt_url\":\"https://door.bootpay.co.kr/receipt/K1pVMmwrNzczTmRUR0U3ZnlzaGtQQ3FVT2lhMTRXdk9SdnM9LS1rMzlyVUJQ%0AeXNpRXpaVlBqLS1CTWI5Vm1WOWFpdVpFZ2FWci9MZGx3PT0%3D%0A\"\r\n" + //
				",\"status\":1\r\n" + //
				",\"vbank_data\":{\"tid\":\"StdpayVBNKINIpayTest20231124131125326893\",\"bank_code\":\"020\",\"bank_name\":\"우리은행\"\r\n" + //
				"\t\t\t,\"bank_account\":\"27490242018118\",\"sender_name\":\"이동열\",\"expired_at\":\"2023-11-26T23:59:00+09:00\"\r\n" + //
				"\t\t\t,\"cash_receipt_tid\":\"test-cash-tid-31820940\",\"cash_receipt_no\":\"61614407\"\r\n" + //
				"\t\t\t}\r\n" + //
				",\"application_id\":\"6369b8f5cf9f6d002023e2d1\"}";

		// BootpayApiController bootpay = new BootpayApiController();
		// bootpay.bootpayAction(callbackTxt);

		JSONParser parser = new JSONParser();
		Object obj = parser.parse(callbackTxt);

		JSONObject jsonObj = (JSONObject) obj;

		HttpHelper ohttp = new HttpHelper();

		ohttp.postJson("http://local-on.eroum.co.kr/common/bootpay/callback.json", jsonObj, null);

		// MbrVO mbrVO =  mbrService.selectMbrById("dylee96");
		// OrdrVO ordrVO = ordrService.selectOrdrByCd("O31124131046432");

		// this.sendMailOrder("MAILSEND_ORDR_MARKET_PAYDONE_CARD", mbrVO, ordrVO);
	}

	protected void mail_test_mng_confirm() throws Exception {
		MbrVO mbrVO =  mbrService.selectMbrById("dylee96");
		OrdrVO ordrVO = ordrService.selectOrdrByCd("O31122100315848");

		this.sendMailOrder("MAILSEND_ORDR_MNG_CONFIRM", mbrVO, ordrVO);

	}

	protected void mail_test_mng_return() throws Exception 
	{//MOrdrController.java - returnDone.json
		MbrVO mbrVO =  mbrService.selectMbrById("dylee96");
		OrdrVO ordrVO = ordrService.selectOrdrByCd("O31128143539257");

		this.sendMailOrder("MAILSEND_ORDR_MNG_RETURN", mbrVO, ordrVO, "O31128143539257_2");

	}
	protected void mail_test_mng_refund() throws Exception 
	{//MOrdrController.java - ordrRtrcnSave.json
		MbrVO mbrVO =  mbrService.selectMbrById("dylee96");
		OrdrVO ordrVO = ordrService.selectOrdrByCd("O31128144753147");

		this.sendMailOrder("MAILSEND_ORDR_MNG_REFUND", mbrVO, ordrVO);

	}

	public void mail_test(HttpServletRequest request) throws Exception {
		this.mail_test_mng_return();

	}
}
