
package icube.common.mail;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.util.FileUtil;
import icube.common.util.ValidatorUtil;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.ordr.dtl.biz.OrdrDtlService;
import icube.manage.ordr.dtl.biz.OrdrDtlVO;
import icube.manage.ordr.ordr.biz.OrdrService;
import icube.manage.ordr.ordr.biz.OrdrVO;
import icube.manage.ordr.rebill.biz.OrdrRebillVO;
import icube.common.values.CodeList;

/**
 * EROUM 메일 폼 Maker
 * @author ogy
 *
 */
@Service("mailFormService")
public class MailFormService extends CommonAbstractServiceImpl {

	@Resource(name = "ordrService")
	private OrdrService ordrService;

	@Resource(name = "ordrDtlService")
	private OrdrDtlService ordrDtlService;

	@Resource(name = "mailService")
	private MailService mailService;

	@Value("#{props['Mail.Form.FilePath']}")
	private String mailFormFilePath;

	@Value("#{props['Mail.Username']}")
	private String mailSender;

	
	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;

	@Value("#{props['Mail.Testuser']}")
	private String testUser;

	// 공통 선언
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	DecimalFormat numberFormat = new DecimalFormat("###,###");
	Calendar cal = Calendar.getInstance();

	/**
	 * 양식 읽기
	 * @param mailHtml
	 * @return mailForm
	 * @throws Exception
	 */
	public String getRead(String mailHtml) throws Exception {
		String MAIL_FORM_PATH = mailFormFilePath;
		String mailForm = FileUtil.readFile(MAIL_FORM_PATH + mailHtml);

		return mailForm;
	}

	/**
	 * 상단
	 * @param ordrVO
	 * @param mailHtml
	 * @return mailForm
	 */
	public String getHeader(OrdrVO ordrVO, String mailHtml) throws Exception{

		String mailForm = this.getRead(mailHtml);

		if(mailHtml.equals("mail_ordr.html") && EgovStringUtil.isNotEmpty(ordrVO.getDelngNo())) {

			if(!ordrVO.getStlmTy().equals("VBANK")) {/*  가상계좌가 아니면 */
				mailForm = mailForm.replace("{img}", "<img src=\"https://eroum.co.kr/html/page/mail/images/t-mail7.png\" alt=\"주문하신 상품의 입금이 확인되었습니다.\" width=\"350\">");
				mailForm = mailForm.replace("{vbankInfo}", "");
				mailForm = mailForm.replace("{vbankGuide}", "");
			}else {
				mailForm = mailForm.replace("{img}", "<img src=\"https://eroum.co.kr/html/page/mail/images/t-mail6.png\" alt=\"주문하신 상품의 입금확인 부탁드립니다.\" width=\"350\">");
				mailForm = mailForm.replace("{vbankInfo}", "<p style=\"margin:0; padding:0; font-size:24px; line-height:1.45; word-break:keep-all;\"><strong>주문해 주셔서 감사합니다!</strong></p>\r\n"
						+ "	                                <p style=\"margin:0; padding:0; line-height:0.375;\">&nbsp;</p>\r\n"
						+ "	                                <p style=\"margin:0; padding:0;\">\r\n"
						+ "	                                    주문하신 주문에 대한 입금 기한을 확인해주세요.<br>\r\n"
						+ "	                                    주문일로부터 3일 이내에 입금 확인이 되지 않으면<br>\r\n"
						+ "	                                    주문이 자동 취소됩니다.\r\n"
						+ "	                                </p>\r\n"
						+ "	                                <p style=\"margin:0; padding:0;\">&nbsp;</p>\r\n"
						+ "	                                <p style=\"margin:0; padding:0;\">\r\n"
						+ "	                                    <b>입금기한은</b><br>\r\n"
						+ "	                                    <b><span style=\"font-family:'Roboto'; color:#E91919;\">"+ordrVO.getDpstTermDt().substring(0, 4)+"</span>년 <span style=\"font-family:'Roboto'; color:#E91919;\">"+ordrVO.getDpstTermDt().substring(5, 7)+"</span>월 <span style=\"font-family:'Roboto'; color:#E91919;\">"+ordrVO.getDpstTermDt().substring(8, 10)+"</span>일 <span style=\"font-family:'Roboto'; color:#E91919;\">"+ordrVO.getDpstTermDt().substring(11, 16)+"</span>까지 입니다</b>\r\n"
						+ "	                                </p>");
				mailForm = mailForm.replace("{vbankGuide}", "<p style=\"margin:0; padding:0;\"><strong>가상계좌 입금안내</strong></p>\r\n"
						+ "	                                <p style=\"margin:0; padding:0; line-height:0.5;\">&nbsp;</p>\r\n"
						+ "	                                <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border:1px solid #999; border-radius:8px;\">\r\n"
						+ "	                                    <tr>\r\n"
						+ "	                                        <td bgcolor=\"#fff\" align=\"left\" width=\"64\" style=\"padding:12px 6px 3px 14px; border-top-left-radius:8px; background-color:#fff; text-align:left;\"><p style=\"margin:0; padding:0; font-size:13px;\">가상계좌</p></td>\r\n"
						+ "	                                        <td bgcolor=\"#fff\" style=\"padding:12px 14px 3px; border-top-right-radius:8px; background-color:#fff;\"><p style=\"margin:0; padding:0; font-size:16px;\"><b>"+ordrVO.getDpstBankNm()+" <span style=\"font-family:'Roboto'\">"+ordrVO.getVrActno()+"</span></b></p></td>\r\n"
						+ "	                                    </tr>\r\n"
						+ "	                                    <tr>\r\n"
						+ "	                                        <td bgcolor=\"#fff\" align=\"left\" width=\"64\" style=\"padding:3px 6px 12px 14px; border-bottom-left-radius:8px; background-color:#fff; text-align:left;\"><p style=\"margin:0; padding:0; font-size:13px;\">입금기한</p></td>\r\n"
						+ "	                                        <td bgcolor=\"#fff\" align=\"left\" style=\"padding:3px 14px 12px; border-bottom-right-radius:8px; background-color:#fff; text-align:left;\"><p style=\"margin:0; padding:0; font-size:16px; color:#F81616;\"><b><span style=\"font-family:'Roboto'\">"+ordrVO.getDpstTermDt().substring(0, 16)+"</span> 까지</b></p></td>\r\n"
						+ "	                                    </tr>\r\n"
						+ "	                                </table>");
			}
		}else if(mailHtml.equals("mail_ordr_auto.html") ) {

			cal.setTime(formatter.parse(ordrVO.getDpstTermDt()));
			cal.add(Calendar.DATE, 7);

			mailForm = mailForm.replace("{yyyy}", formatter.format(cal.getTime()).substring(0, 4));
			mailForm = mailForm.replace("{mm}", formatter.format(cal.getTime()).substring(5, 7));
			mailForm = mailForm.replace("{dd}", formatter.format(cal.getTime()).substring(8, 10));
		}else if(mailHtml.equals("mail_ordr_return.html")) {
			mailForm = mailForm.replace("{yyyy}", formatter.format(ordrVO.getOrdrDt()).substring(0, 4));
			mailForm = mailForm.replace("{mm}", formatter.format(ordrVO.getOrdrDt()).substring(5, 7));
			mailForm = mailForm.replace("{dd}", formatter.format(ordrVO.getOrdrDt()).substring(8, 10));
		}else if(mailHtml.equals("mail_ordr_rfnd.html")) {
			Date now = new Date();
			mailForm = mailForm.replace("{now_year}", formatter.format(now).substring(0, 4)); // 현재 년
			mailForm = mailForm.replace("{now_month}", formatter.format(now).substring(5, 7)); // 현재 월
			mailForm = mailForm.replace("{now_day}", formatter.format(now).substring(8, 10)); // 현재 일
		}
		return mailForm;
	}

	/**
	 * 본문
	 * @param ordrVO
	 * @param thisDtlVO
	 * @param mailForm
	 * @return mailForm
	 */
	public String getBody(OrdrVO ordrVO, OrdrDtlVO thisDtlVO, String mailForm) throws Exception {

		//mailForm = this.getHeader(ordrVO, mailForm);
		String MAIL_FORM_PATH = mailFormFilePath;

		mailForm = mailForm.replace("{mbrNm}", ordrVO.getOrdrrNm()); // 주문자
		mailForm = mailForm.replace("{ordrDt}", formatter.format(ordrVO.getOrdrDt())); // 주문일
		mailForm = mailForm.replace("{ordrCd}", ordrVO.getOrdrCd()); // 주문번호

		if(thisDtlVO != null) {
			if(thisDtlVO.getSttsTy().equals("CA02") || thisDtlVO.getSttsTy().equals("RE03")) {
				mailForm = this.getDtlLoop(ordrVO, thisDtlVO, mailForm);
			}
		}else {
			mailForm = this.getOrdrLoop(ordrVO, mailForm);
		}

		// 배송 정보
		mailForm = mailForm.replace("{recptrNm}", ordrVO.getRecptrNm()); // 받는사람

		if(EgovStringUtil.equals(ordrVO.getStlmTy(), "CARD") || ordrVO.getDpstTermDt() == null){
			mailForm = mailForm.replace("{dpstTermDt}", ""); // 입금기한
		}else {
			mailForm = mailForm.replace("{dpstTermDt}", ordrVO.getDpstTermDt()); // 입금기한
		}

		mailForm = mailForm.replace("{zip}", ordrVO.getRecptrZip()); // 지번
		mailForm = mailForm.replace("{addr}", ordrVO.getRecptrAddr() + " " + ordrVO.getRecptrDaddr()); // 주소

		// 결제 정보
		int totalGdsPc = 0; // 총 상품 금액 (상품 가격 * 수량)
		int dlvyPc = 0; // 배송비
		int couponAmts = 0; // 쿠폰 할인
		int totalRfndAmt = 0; // 환불금액
		boolean rfFLag = false;
		String rfndBanks = "";
		String actnos = "";

		int mlg = ordrVO.getUseMlg(); // 마일리지
		int point = ordrVO.getUsePoint(); // 포인트

		for (OrdrDtlVO ordrDtlVO : ordrVO.getOrdrDtlList()) {
			if(ordrDtlVO.getOrdrOptnTy().equals("BASE")) {
				totalGdsPc += (ordrDtlVO.getGdsPc() * ordrDtlVO.getOrdrQy());
			}else {
				totalGdsPc += (ordrDtlVO.getOrdrOptnPc() * ordrDtlVO.getOrdrQy());
			}
			dlvyPc += (ordrDtlVO.getDlvyBassAmt() + ordrDtlVO.getDlvyAditAmt());
			couponAmts += ordrDtlVO.getCouponAmt();

			if(ordrDtlVO.getSttsTy().equals("RE03") || ordrDtlVO.getSttsTy().equals("CA02")) {
				totalRfndAmt += ordrDtlVO.getRfndAmt();
				rfndBanks = ordrDtlVO.getRfndBank();
				actnos = ordrDtlVO.getRfndActno();
				rfFLag = true;
			}
		}

		if(rfFLag) {
			String rfndCard = FileUtil.readFile(MAIL_FORM_PATH+"mail_rfnd_card.html");
			String rfndBank = FileUtil.readFile(MAIL_FORM_PATH+"mail_rfnd_bank.html");

			if(ordrVO.getStlmTy().equals("VBANK") || ordrVO.getStlmTy().equals("BANK")) {
				rfndBank = rfndBank.replace("{rfndTy}", "계좌이체");
				rfndBank = rfndBank.replace("{rfndAmt}", numberFormat.format(totalRfndAmt));
				rfndBank = rfndBank.replace("{rfndBank}", rfndBanks);
				rfndBank = rfndBank.replace("{actno}", actnos);
				rfndBank = rfndBank.replace("{rfndNm}", ordrVO.getPyrNm());
				mailForm = mailForm.replace("{rfndInfo}", rfndBank);

			}else {
				rfndCard = rfndCard.replace("{rfndTy}", ordrVO.getCardCoNm());
				rfndCard = rfndCard.replace("{stlmAmt2}", ordrVO.getDpstTermDt());
				mailForm = mailForm.replace("{rfndInfo}", rfndCard);
			}
		}

		mailForm = mailForm.replace("{totalOrdrPc}", numberFormat.format(totalGdsPc));
		mailForm = mailForm.replace("{dlvyPc}", numberFormat.format(dlvyPc));
		mailForm = mailForm.replace("{couponAmt}", numberFormat.format(couponAmts + mlg + point));

		mailForm = mailForm.replace("{stlmAmt}", numberFormat.format(ordrVO.getStlmAmt())); // 결제금액

		return mailForm;
	}

	/**
	 * 주문 전체 Loop
	 * @param ordrVO
	 * @param mailForm
	 * @return mailForm
	 */
	public String getOrdrLoop(OrdrVO ordrVO, String mailForm) throws Exception {
		String MAIL_FORM_PATH = mailFormFilePath;

		// 상품 정보 Start
		String last = "";
		String base = "";
		String adit = "";
		String base_reset = "";
		String adit_reset = "";
		String bplc = "";

		for (int i=0; i<ordrVO.getOrdrDtlList().size(); i++) {

			// BASE
			if(ordrVO.getOrdrDtlList().get(i).getOrdrOptnTy().equals("BASE")) {
				if(i != 0 && (i+1) <= ordrVO.getOrdrDtlList().size()-1 && ordrVO.getOrdrDtlList().get(i).getOrdrDtlCd() != ordrVO.getOrdrDtlList().get(i+1).getOrdrDtlCd()) {
					base = base.replace("{aditOptn}", "");
				}
				base_reset = "";
				String base_html = FileUtil.readFile(MAIL_FORM_PATH + "mail_ordr_gds.html");
				base_html = base_html.replace("{gdsNm}", ordrVO.getOrdrDtlList().get(i).getGdsNm());
				if(EgovStringUtil.isNotEmpty(ordrVO.getOrdrDtlList().get(i).getOrdrOptn())) {
					base_html = base_html.replace("{gdsOptnNm}", ordrVO.getOrdrDtlList().get(i).getOrdrOptn());
				}else {
					base_html = base_html.replace("{gdsOptnNm}", "");
				}

				base_html = base_html.replace("{ordrQy}", EgovStringUtil.integer2string(ordrVO.getOrdrDtlList().get(i).getOrdrQy()));
				base_html = base_html.replace("{ordrPc}", numberFormat.format(ordrVO.getOrdrDtlList().get(i).getOrdrPc()));

				// 멤버스
				if (!ordrVO.getOrdrTy().equals("N")) {
					bplc = FileUtil.readFile(MAIL_FORM_PATH + "mail_ordr_bplc.html");
					bplc = bplc.replace("{bplcNm}", ordrVO.getOrdrDtlList().get(i).getBplcInfo().getBplcNm());
					bplc = bplc.replace("{telno}", ordrVO.getOrdrDtlList().get(i).getBplcInfo().getTelno());
					bplc = bplc.replace("{dlvyPc}",
							numberFormat.format((ordrVO.getOrdrDtlList().get(i).getDlvyAditAmt()
									+ ordrVO.getOrdrDtlList().get(i).getDlvyBassAmt())));
					base_html = base_html.replace("{bplc}", bplc);
				} else {
					base_html = base_html.replace("{bplc}", "");
				}

				base_reset = base_html;
			}

			if(ordrVO.getOrdrDtlList().get(i).getOrdrOptnTy().equals("ADIT")) {
				// ADIT
				adit_reset = "";
				String adit_html = FileUtil.readFile(MAIL_FORM_PATH + "mail_ordr_gds_optn.html");
				if(EgovStringUtil.isNotEmpty(ordrVO.getOrdrDtlList().get(i).getOrdrOptn())) {
					adit_html = adit_html.replace("{optnNm}", ordrVO.getOrdrDtlList().get(i).getOrdrOptn());
				}else {
					adit_html = adit_html.replace("{optnNm}", "");
				}
				adit_html = adit_html.replace("{optnQy}", EgovStringUtil.integer2string(ordrVO.getOrdrDtlList().get(i).getOrdrQy()));
				adit_html = adit_html.replace("{optnPc}", numberFormat.format(ordrVO.getOrdrDtlList().get(i).getOrdrOptnPc()));

				adit_reset = adit_html;
			}


			if(i == (ordrVO.getOrdrDtlList().size()-1)) {
				base = base.replace("{aditOptn}",adit_reset);
				if(ordrVO.getOrdrDtlList().get(i).getOrdrOptnTy().equals("BASE")) {
					base += base_reset;
					base = base.replace("{aditOptn}", "");
				}else {
					adit += adit_reset;
					base = base.replace("{aditOptn}",adit);
				}
				last += base;

				mailForm = mailForm.replace("{gdsView}", last);
			}else {
				if(ordrVO.getOrdrDtlList().get(i).getOrdrOptnTy().equals("BASE")) {
					base += base_reset;
				}else {
					adit += adit_reset;
				}
			}
		}

		return mailForm;
	}

	/**
	 * 주문 상세 Loop
	 * @param ordrVO
	 * @param ordrDtlVO
	 * @param mailForm
	 * @return mailForm
	 */
	public String getDtlLoop(OrdrVO ordrVO, OrdrDtlVO ordrDtlVO, String mailForm) throws Exception {
		String MAIL_FORM_PATH = mailFormFilePath;

		// 상품 정보 Start
		String last = "";
		String base = "";
		String adit = "";
		String base_reset = "";
		String adit_reset = "";
		String bplc = "";

		List<OrdrDtlVO> ordrDtlList = new ArrayList<OrdrDtlVO>();
		for(String ordrDtlNo : ordrDtlVO.getOrdrDtlNos()) {
			OrdrDtlVO addDtlVO = ordrDtlService.selectOrdrDtl(EgovStringUtil.string2integer(ordrDtlNo));
			ordrDtlList.add(addDtlVO);
		}

		for (int i=0; i<ordrDtlList.size(); i++) {

			// BASE
			if(ordrDtlList.get(i).getOrdrOptnTy().equals("BASE")) {
				if(i != 0 && (i+1) <= ordrDtlList.size()-1 && ordrDtlList.get(i).getOrdrDtlCd() != ordrDtlList.get(i+1).getOrdrDtlCd()) {
					base = base.replace("{aditOptn}", "");
				}
				base_reset = "";
				String base_html = FileUtil.readFile(MAIL_FORM_PATH + "mail_ordr_gds.html");
				base_html = base_html.replace("{gdsNm}", ordrDtlList.get(i).getGdsNm());
				if(EgovStringUtil.isNotEmpty(ordrDtlList.get(i).getOrdrOptn())) {
					base_html = base_html.replace("{gdsOptnNm}", ordrDtlList.get(i).getOrdrOptn());
				}else {
					base_html = base_html.replace("{gdsOptnNm}", "");
				}

				base_html = base_html.replace("{ordrQy}", EgovStringUtil.integer2string(ordrDtlList.get(i).getOrdrQy()));
				base_html = base_html.replace("{ordrPc}", numberFormat.format(ordrDtlList.get(i).getOrdrPc()));

				// 멤버스
				if (!ordrVO.getOrdrTy().equals("N")) {
					bplc = FileUtil.readFile(MAIL_FORM_PATH + "mail_ordr_bplc.html");
					bplc = bplc.replace("{bplcNm}", ordrDtlList.get(i).getBplcInfo().getBplcNm());
					bplc = bplc.replace("{telno}", ordrDtlList.get(i).getBplcInfo().getTelno());
					bplc = bplc.replace("{dlvyPc}",numberFormat.format((ordrDtlList.get(i).getDlvyAditAmt() + ordrDtlList.get(i).getDlvyBassAmt())));
					base_html = base_html.replace("{bplc}", bplc);
				} else {
					base_html = base_html.replace("{bplc}", "");
				}

				base_reset = base_html;
			}

			if(ordrDtlList.get(i).getOrdrOptnTy().equals("ADIT")) {
				// ADIT
				adit_reset = "";
				String adit_html = FileUtil.readFile(MAIL_FORM_PATH + "mail_ordr_gds_optn.html");
				if(EgovStringUtil.isNotEmpty(ordrDtlList.get(i).getOrdrOptn())) {
					adit_html = adit_html.replace("{optnNm}", ordrDtlList.get(i).getOrdrOptn());
				}else {
					adit_html = adit_html.replace("{optnNm}", "");
				}
				adit_html = adit_html.replace("{optnQy}", EgovStringUtil.integer2string(ordrDtlList.get(i).getOrdrQy()));
				adit_html = adit_html.replace("{optnPc}", numberFormat.format(ordrDtlList.get(i).getOrdrOptnPc()));

				adit_reset = adit_html;
			}


			if(i == (ordrDtlList.size()-1)) {
				base = base.replace("{aditOptn}",adit_reset);
				if(ordrDtlList.get(i).getOrdrOptnTy().equals("BASE")) {
					base += base_reset;
					base = base.replace("{aditOptn}", "");
				}else {
					adit += adit_reset;
					base = base.replace("{aditOptn}",adit);
				}
				last += base;

				mailForm = mailForm.replace("{gdsView}", last);
			}else {
				if(ordrDtlList.get(i).getOrdrOptnTy().equals("BASE")) {
					base += base_reset;
				}else {
					adit += adit_reset;
				}
			}
		}
		return mailForm;
	}

	/**
	 * 발송
	 * @param ordrVO
	 * @param mailForm
	 * @param mailSj
	 * @throws Exception
	 */
	public void doSender(OrdrVO ordrVO, String mailForm, String mailSj) throws Exception {
		/* 
		주문자의 메일로 보냄
		*/
		mailService.sendMail(mailSender, ordrVO.getOrdrrEml(), mailSj, mailForm);
	}

	/**
	 * 메일 종합
	 * @param ordrVO
	 * @param mailHtml : 메일 양식
	 * @param testMail : 테스트 메일
	 * @param mailSj : 메일 제목
	 */
	public void makeMailForm(OrdrVO ordrVO, OrdrDtlVO ordrDtlVO, String mailHtml, String mailSj) {

		try {
			if (ValidatorUtil.isEmail(ordrVO.getOrdrrEml())) {

				String mailForm = this.getHeader(ordrVO, mailHtml);

				mailForm = this.getBody(ordrVO, ordrDtlVO, mailForm);

				this.doSender(ordrVO, mailForm, mailSj);

			} else {
				System.out.println("EMAIL 전송 실패 :: 이메일 체크 " + ordrVO.getOrdrrEml());
			}

		} catch (Exception e) {
			System.out.println("EMAIL 전송 실패 :: " + e.toString());
		}
	}

	public void mail_test() throws Exception 
	{
		MbrVO mbrVO =  mbrService.selectMbrById("dylee96");
		OrdrVO ordrVO = ordrService.selectOrdrByCd("O31122094739188");

		this.sendMailOrder("MAILSEND_ORDR_CARD", mbrVO, ordrVO);

	}

	public void sendMailOrder(String ordrMailTy, MbrVO mbrVO, OrdrVO ordrVO) throws Exception {
		if (!EgovStringUtil.equals("Y", mbrVO.getEmlRcptnYn())){
			return;
		}

		if (!CodeList.MAIL_SEND_TY.contains(ordrMailTy)){
			throw new Exception("not found mail type");
		}

		String content = this.makeMailForm2Ordr(ordrMailTy, mbrVO, ordrVO);
		String mailSubject = "";
		switch (ordrMailTy) {
			case "MAILSEND_ORDR_CARD":
			case "MAILSEND_ORDR_ACCOUNT":
				break;
		
			case "MAILSEND_ORDR_VBANK":
			case "MAILSEND_ORDR_VBANK_RETRY":
			case "MAILSEND_ORDR_VBANK_CANCEL":
			case "MAILSEND_ORDR_VBANK_INCOME":
			default:
				throw new Exception("not found mail file");
		}
		/* 
		주문자의 메일로 보냄
		*/
		mailService.sendMail(mailSender, ordrVO.getOrdrrEml(), mailSubject, content);
	}

	public String makeMailForm2Ordr(String ordrMailTy, MbrVO mbrVO, OrdrVO ordrVO) throws Exception {
		// String aaa = MAIL_SEND_TY
		if (!CodeList.MAIL_SEND_TY.contains(ordrMailTy)){
			throw new Exception("not found mail type");
		}

		String sFileNM = "";

		switch (ordrMailTy) {
			case "MAILSEND_ORDR_CARD":
			case "MAILSEND_ORDR_ACCOUNT":
				sFileNM = "/mail/ordr/mail_ordr_card.html";
				break;
		
			case "MAILSEND_ORDR_VBANK":
			case "MAILSEND_ORDR_VBANK_RETRY":
			case "MAILSEND_ORDR_VBANK_CANCEL":
			case "MAILSEND_ORDR_VBANK_INCOME":
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

		switch (ordrMailTy) {
			case "ORDR_ACCOUNT_SEND":
			case "ORDR_CARD_SEND":
				mailContent = this.makeMailForm2OrdrCard(ordrVO, mailContent);

				break;
		
		}


		return mailContent;
	}

	protected String makeMailForm2OrdrCard(OrdrVO ordrVO, String mailContent){

		mailContent = this.convertMailFormOrdrCommon(ordrVO, mailContent);
		
		mailContent = this.convertMailFormOrdrDtl(ordrVO.getOrdrDtlList(), mailContent);

		mailContent = this.convertMailFormOrdrRebill(ordrVO.getOrdrRebillList(), mailContent);
		
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

	/*주문 주문자*/
	protected String convertMailFormORDRR(OrdrVO ordrVO, String mailContent){
		String keyword;
		
		keyword = "((ordrrEml))";			if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, ordrVO.getOrdrrEml());
		keyword = "((ordrrNm))";			if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, ordrVO.getOrdrrNm());
		keyword = "((ordrrTelno))";			if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, ordrVO.getOrdrrTelno());
		keyword = "((ordrrMblTelno))";		if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, ordrVO.getOrdrrMblTelno());
		keyword = "((ordrrZip))";			if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, ordrVO.getOrdrrZip());
		keyword = "((ordrrAddr))";			if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, ordrVO.getOrdrrAddr());
		keyword = "((ordrrDaddr))";			if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, ordrVO.getOrdrrDaddr());
		
		return mailContent;
	}

	/*주문 배송*/
	protected String convertMailFormOrdrRECPTR(OrdrVO ordrVO, String mailContent){
		String keyword;
		
		keyword = "((recptrNm))";			if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, ordrVO.getRecptrNm());
		keyword = "((recptrTelno))";		if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, ordrVO.getRecptrTelno());
		keyword = "((recptrMblTelno))";		if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, ordrVO.getRecptrMblTelno());
		keyword = "((recptrZip))";			if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, ordrVO.getRecptrZip());
		keyword = "((recptrAddr))";			if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, ordrVO.getRecptrAddr());
		keyword = "((recptrDaddr))";		if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, ordrVO.getRecptrDaddr());
		
		return mailContent;
	}

	/*주문 금액*/
	protected String convertMailFormOrdrPayment(OrdrVO ordrVO, String mailContent){
		String keyword;
		
		Map<String, Integer> resultMap = this.ordrDtlSum(ordrVO.getOrdrDtlList());

		keyword = "((stlmAmt))";				if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, numberFormat.format(ordrVO.getStlmAmt()));// 결제금액

		// keyword = "((SUM_GDS_PC))";				if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, numberFormat.format(totalGdsPc));// 상품_가격
		keyword = "((SumOrdrPc))";				if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, numberFormat.format(resultMap.get("ordrPc")));// 주문_가격
		keyword = "((SumDlvyPc))";				if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, numberFormat.format(resultMap.get("dlvyPc")));// 배송_금액 + 배송_추가_금액
		keyword = "((SumCouponAmts))";			if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, numberFormat.format(resultMap.get("couponAmts")));// 쿠폰_금액
		
		return mailContent;
	}

	/*주문 결제정보*/
	protected String convertMailFormOrdrCardDisp(OrdrVO ordrVO, String mailContent){
		String keyword;
		
		keyword = "((cardCoNm))";		if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, ordrVO.getCardCoNm());
		keyword = "((cardNo))";			if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, ordrVO.getCardNo());

		keyword = "((dpstBankNm))";		if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, ordrVO.getDpstBankNm());
		keyword = "((vrActno))";		if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, ordrVO.getVrActno());
		keyword = "((dpstr))";			if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, ordrVO.getDpstr());
		keyword = "((pyrNm))";			if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, ordrVO.getPyrNm());
		keyword = "((dpstTermDt))";		if (mailContent.indexOf(keyword) >= 0) mailContent = mailContent.replace(keyword	, ordrVO.getDpstTermDt());

		mailContent = this.convertMailFormDateFull(ordrVO.getDpstTermDt(), "dpstTermDt", mailContent);

		return mailContent;
	}

	protected String convertMailFormOrdrDtl(List<OrdrDtlVO> ordrDtlList, String mailContent){

		return mailContent;
	}

	protected String convertMailFormOrdrRebill(List<OrdrRebillVO> ordrRebillList, String mailContent){

		return mailContent;
	}

	protected String convertMailFormDate(String date10, String keyword, String mailContent){

		mailContent = mailContent.replace("((" + keyword + "Year))"		, date10.substring(0, 4)); // 년
		mailContent = mailContent.replace("((" + keyword + "Month))"	, date10.substring(5, 7)); // 월
		mailContent = mailContent.replace("((" + keyword + "Day))"		, date10.substring(8, 10)); // 일

		return mailContent;
	}

	/*
	 * date19 : 2023-11-23 12:03:59
	 * 
	*/
	protected String convertMailFormDateFull(String date19, String keyword, String mailContent){

		mailContent = mailContent.replace("((" + keyword + "Year))"		, date19.substring(0, 4)); // 년
		mailContent = mailContent.replace("((" + keyword + "Month))"	, date19.substring(5, 7)); // 월
		mailContent = mailContent.replace("((" + keyword + "Day))"		, date19.substring(8, 10)); // 일

		mailContent = mailContent.replace("((" + keyword + "Hour))"		, date19.substring(11, 13)); // 시
		mailContent = mailContent.replace("((" + keyword + "Minute))"	, date19.substring(14, 16)); // 분
		mailContent = mailContent.replace("((" + keyword + "Second))"	, date19.substring(17, 19)); // 초

		return mailContent;
	}

	protected Map<String, Integer> ordrDtlSum(List<OrdrDtlVO> list){
		// 결제 정보
		int totalGdsPc = 0; // 총 상품 금액 (상품 가격 * 수량)
		int dlvyPc = 0; // 배송비
		int ordrPc = 0; // 주문가격
		int couponAmts = 0; // 쿠폰 할인

		for (OrdrDtlVO ordrDtlVO : list) {
			if(ordrDtlVO.getOrdrOptnTy().equals("BASE")) {
				totalGdsPc += (ordrDtlVO.getGdsPc() * ordrDtlVO.getOrdrQy());
			}else {
				totalGdsPc += (ordrDtlVO.getOrdrOptnPc() * ordrDtlVO.getOrdrQy());
			}
			dlvyPc += (ordrDtlVO.getDlvyBassAmt() + ordrDtlVO.getDlvyAditAmt());
			couponAmts += ordrDtlVO.getCouponAmt();
		}


		Map<String, Integer> resultMap = new HashMap<String, Integer>();

		resultMap.put("totalGdsPc", totalGdsPc);
		resultMap.put("ordrPc", ordrPc);
		resultMap.put("dlvyPc", dlvyPc);
		resultMap.put("couponAmts", couponAmts);

		return resultMap;
	}

}
