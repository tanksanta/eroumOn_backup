package icube.schedule;

import java.lang.reflect.Type;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import icube.common.api.biz.BootpayApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.mail.MailService;
import icube.common.util.DateUtil;
import icube.common.util.FileUtil;
import icube.common.util.ValidatorUtil;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.ordr.dtl.biz.OrdrDtlService;
import icube.manage.ordr.dtl.biz.OrdrDtlVO;
import icube.manage.ordr.ordr.biz.OrdrService;
import icube.manage.ordr.ordr.biz.OrdrVO;
import icube.manage.ordr.rebill.biz.OrdrRebillService;
import icube.manage.ordr.rebill.biz.OrdrRebillVO;

@Service("ordrPaySchedule")
@EnableScheduling
public class OrdrPaySchedule extends CommonAbstractController {

	@Resource(name = "mbrService")
	private MbrService mbrService;
	
	@Resource(name = "ordrDtlService")
	private OrdrDtlService ordrDtlService;

	@Resource(name = "ordrService")
	private OrdrService ordrService;

	@Resource(name = "ordrRebillService")
	private OrdrRebillService ordrRebillService;

	@Resource(name = "bootpayApiService")
	private BootpayApiService bootpayApiService;

	@Resource(name = "mailService")
	private MailService mailService;

	@Value("#{props['Mail.Form.FilePath']}")
	private String mailFormFilePath;

	@Value("#{props['Mail.Username']}")
	private String sendMail;

	@Value("#{props['Mail.Testuser']}")
	private String mailTestuser;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;

	// 현재월 기준 > 정기(자동)결제 (오전 10시)
	@Scheduled(cron="0 0 10 * * *")
	public void ordrBilling() throws Exception {
		log.info("################## ordrBilling START #####################");

		Map<String, Object> paramMap = new HashMap<String, Object>();

		int year = EgovStringUtil.string2integer(DateUtil.getDate("yyyy"));
		int month = EgovStringUtil.string2integer(DateUtil.getDate("MM"));
		int day = EgovStringUtil.string2integer(DateUtil.getDate("dd"));
		int payDay = day;

		//결제월 마지막날일 경우 ~31일자 포함 결제 시도
		if(DateUtil.lastDay(year, month) == day) {
			payDay = 31;
		}

		// 결제 실패시 다음날 다시 시도
		paramMap.put("srchBillingDay", payDay);
		List<OrdrVO> ordrList =  ordrRebillService.selectRebillList(paramMap);

		int stlmAmt = 0;
		String gdsNm = "";
		for(OrdrVO ordrVO : ordrList) {
			stlmAmt = 0;
			gdsNm = "";
			System.out.println("ordrVO: " + ordrVO.getOrdrCd());
			for(OrdrDtlVO ordrDtlVO : ordrVO.getOrdrDtlList()) {
				System.out.println("ordrDtlVO > gdsPc: " + ordrDtlVO.getGdsPc() * ordrDtlVO.getOrdrQy()); // 주문금액x(배송비, 할인 빠짐 등) -> 상품금액 * 수량
				stlmAmt = ordrDtlVO.getGdsPc() * ordrDtlVO.getOrdrQy();
				gdsNm = ordrDtlVO.getGdsNm(); // 대여상품은 1건 > 추후 증가한다면 ++
			}
			OrdrRebillVO ordrRebillVO = new OrdrRebillVO();

			ordrRebillVO.setBillingKey(ordrVO.getBillingKey());
			ordrRebillVO.setOrdrCd(ordrVO.getOrdrCd());
			ordrRebillVO.setGdsNm(gdsNm);

			ordrRebillVO.setOrdrNo(ordrVO.getOrdrNo());
			ordrRebillVO.setStlmAmt(stlmAmt);

			ordrRebillVO.setOrdrrNm(ordrVO.getOrdrrNm());
			ordrRebillVO.setOrdrrEml(ordrVO.getOrdrrEml());
			ordrRebillVO.setOrdrrMblTelno(ordrVO.getOrdrrMblTelno());

			int selfBndRt = ordrVO.getOrdrDtlList().get(0).getRecipterInfo().getSelfBndRt();  // 본인부담율

			if(selfBndRt != 0 && stlmAmt != 0) {

				try {
					String purchasedAt = "";
					HashMap<String, Object> res = bootpayApiService.requestSubscribe(ordrRebillVO);

					if(res.get("error_code") == null) { //success
						System.out.println("requestSubscribe success: " + res);
						ordrRebillVO.setStlmYn("Y");
						ordrRebillVO.setDelngNo((String) res.get("receipt_id"));

						// 카드정보
						System.out.println("card_data: " + String.valueOf( res.get("card_data") ));

						Type resType = new TypeToken<HashMap<String, String>>(){}.getType();
						HashMap<String, String> cardMap = new Gson().fromJson(String.valueOf(res.get("card_data")), resType);

						ordrRebillVO.setCardAprvno((String) cardMap.get("card_approve_no") );
						ordrRebillVO.setCardCoNm((String) cardMap.get("card_company"));
						ordrRebillVO.setCardNo((String) cardMap.get("card_no"));

					} else {
						System.out.println("requestSubscribe fail: " + res);
						ordrRebillVO.setStlmDt(DateUtil.getCurrentDateTime("yyyy-MM-dd HH:mm:ss"));
						ordrRebillVO.setStlmYn("N");
						ordrRebillVO.setMemo("FAIL : " + (String) res.get("status"));
					}

					purchasedAt = (String) res.get("purchased_at");
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
					SimpleDateFormat output = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					if(EgovStringUtil.isNotEmpty(purchasedAt)) {
						Date parseStlmDt = format.parse(purchasedAt);
						String convertStlmDt =  output.format(parseStlmDt);
						ordrRebillVO.setStlmDt(convertStlmDt);
					}

				} catch (Exception e) {
					e.printStackTrace();
					ordrRebillVO.setStlmYn("N");
					ordrRebillVO.setMemo("ERROR : "+e.getMessage());
					ordrRebillVO.setStlmDt(DateUtil.getCurrentDateTime("yyyy-MM-dd HH:mm:ss"));
				}
			}

			System.out.println("ordrRebillVO: " + ordrRebillVO.toString());

			ordrRebillService.insertOrdrRebill(ordrRebillVO);
		}

		log.info("################## ordrBilling END #####################");
	}

	public static <T> String arrayToString(ArrayList<T> list) {
	    Gson g = new Gson();
	    return g.toJson(list);
	}

	public static <T> List<T> stringToArray(String s, Class<T[]> clazz) {
	    T[] arr = new Gson().fromJson(s, clazz);
	    return Arrays.asList(arr); //or return Arrays.asList(new Gson().fromJson(s, clazz)); for a one-liner
	}

	// 배송완료 처리
	@Scheduled(cron="0 0 1 * * *")
	public void order08() throws Exception {
		log.info("########## 배송 완료 처리 START ##########");

		Map <String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchSttsTy", "OR07");
		paramMap.put("srchContainer", 1);
		paramMap.put("srchIntervalDay", "7");

		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrSttsList(paramMap);

		for (OrdrDtlVO ordrDtlVO : ordrDtlList) {
			ArrayList<String> tmpOrdrDtlNos = new ArrayList<String>();
			paramMap.clear();
			paramMap.put("ordrCd", ordrDtlVO.getOrdrCd());
			List<OrdrDtlVO> itemList = ordrDtlService.selectOrdrSttsList(paramMap);

			for(OrdrDtlVO ordrDdtlVO : itemList) {
				tmpOrdrDtlNos.add(EgovStringUtil.integer2string(ordrDdtlVO.getOrdrDtlNo()));
			}
			String[] ordrDtlNos = tmpOrdrDtlNos.toArray(new String[tmpOrdrDtlNos.size()]);

			OrdrDtlVO newDtlVO = new OrdrDtlVO();
			newDtlVO.setOrdrNo(ordrDtlVO.getOrdrNo());
			newDtlVO.setOrdrDtlCd(ordrDtlVO.getOrdrDtlCd());
			newDtlVO.setOrdrDtlNos(ordrDtlNos);
			newDtlVO.setSttsTy("OR08");
			newDtlVO.setResnTy(ordrDtlVO.getResnTy());
			newDtlVO.setResn("자동 전환");
			newDtlVO.setRegUniqueId(null);
			newDtlVO.setRegId("SYS");
			newDtlVO.setRgtr("SYS");

			ordrDtlService.updateOrdrOR08(newDtlVO);
		}

		log.info("########## 배송 완료 처리 END ##########");
	}


	// 구매확정 처리
	@Scheduled(cron="0 30 1 * * *")
	public void order09() throws Exception {
		log.info("########## 구매 확정 처리 START ##########");

		Map <String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchSttsTy", "OR08");
		paramMap.put("srchContainer", 1);
		paramMap.put("srchIntervalDay", "7");

		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrSttsList(paramMap);

		for(OrdrDtlVO ordrDtlVO : ordrDtlList) {
			ArrayList<String> tmpOrdrDtlNos = new ArrayList<String>();
			paramMap.clear();
			paramMap.put("ordrCd", ordrDtlVO.getOrdrCd());
			List<OrdrDtlVO> itemList = ordrDtlService.selectOrdrSttsList(paramMap);

			int totalAccmlMlg = 0;
			for(OrdrDtlVO ordrDdtlVO : itemList) {
				tmpOrdrDtlNos.add(EgovStringUtil.integer2string(ordrDdtlVO.getOrdrDtlNo()));
				totalAccmlMlg += ordrDdtlVO.getAccmlMlg();
			}

			String[] ordrDtlNos = tmpOrdrDtlNos.toArray(new String[tmpOrdrDtlNos.size()]);

			OrdrDtlVO newDtlVO = new OrdrDtlVO();
			newDtlVO.setOrdrNo(ordrDtlVO.getOrdrNo());
			newDtlVO.setOrdrDtlCd(ordrDtlVO.getOrdrDtlCd());
			newDtlVO.setOrdrDtlNos(ordrDtlNos);
			newDtlVO.setSttsTy("OR09");
			newDtlVO.setResn("자동 전환");
			newDtlVO.setRegUniqueId(null);
			newDtlVO.setRegId("SYS");
			newDtlVO.setRgtr("SYS");

			newDtlVO.setTotalAccmlMlg(totalAccmlMlg);

			ordrDtlService.updateOrdrOR09(newDtlVO);
		}

		log.info("########## 구매 확정 처리 END ##########");
	}



	// 가상계좌 입금기간 만료시 -> 취소 (매일 자정)
	@Scheduled(cron="0 30 0 * * *")
	public void cancle02() throws Exception {

		log.info("########## 가상계좌 취소 처리 START ##########");

		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("srchStlmTy", "VBANK");
		paramMap.put("srchStlmYn", "N");
		paramMap.put("srchDate", "NOW");
		paramMap.put("srchContainer", 1);
		paramMap.put("srchExSttsTy", "CA02");

		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrSttsList(paramMap);

		for(OrdrDtlVO ordrDtlVO : ordrDtlList) {
			ArrayList<String> tmpOrdrDtlNos = new ArrayList<String>();
			paramMap.clear();
			paramMap.put("ordrCd", ordrDtlVO.getOrdrCd());

			List<OrdrDtlVO> itemList = ordrDtlService.selectOrdrSttsList(paramMap);
			for(OrdrDtlVO ordrDdtlVO : itemList) {
				tmpOrdrDtlNos.add(EgovStringUtil.integer2string(ordrDdtlVO.getOrdrDtlNo()));
			}

			String[] ordrDtlNos = tmpOrdrDtlNos.toArray(new String[tmpOrdrDtlNos.size()]);

			OrdrDtlVO newDtlVO = new OrdrDtlVO();
			newDtlVO.setOrdrNo(ordrDtlVO.getOrdrNo());
			newDtlVO.setOrdrDtlNos(ordrDtlNos);
			newDtlVO.setSttsTy("CA02");
			newDtlVO.setResnTy(ordrDtlVO.getResnTy());
			newDtlVO.setResn("자동 전환");
			newDtlVO.setRegUniqueId(null);
			newDtlVO.setRegId("SYS");
			newDtlVO.setRgtr("SYS");

			ordrDtlService.updateOrdrCA02(newDtlVO);

			// 이메일 발송
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			DecimalFormat numberFormat = new DecimalFormat("###,###");

			OrdrVO ordrVO = ordrService.selectOrdrByCd(ordrDtlVO.getOrdrCd());
			
			//탈퇴한 회원에게는 발송하지 않음
			Map<String, Object> searchParamMap = new HashMap<String, Object>();
			searchParamMap.put("srchUniqueId", ordrVO.getUniqueId());
			MbrVO mbrVO = mbrService.selectMbr(searchParamMap);
			if ("Y".equals(mbrVO.getWhdwlYn())) {
				continue;
			}

			try {
				if (ValidatorUtil.isEmail(ordrVO.getOrdrrEml())) {
					String MAIL_FORM_PATH = mailFormFilePath;
					String mailForm = FileUtil.readFile(MAIL_FORM_PATH + "mail_ordr_auto_cancel.html");

					// 입금기한
					mailForm = mailForm.replace("{yyyy}", ordrVO.getDpstTermDt().substring(0, 4));
					mailForm = mailForm.replace("{MM}", ordrVO.getDpstTermDt().substring(5, 7));
					mailForm = mailForm.replace("{dd}", ordrVO.getDpstTermDt().substring(8, 10));
					mailForm = mailForm.replace("{HH}", ordrVO.getDpstTermDt().substring(11, 16));

					mailForm = mailForm.replace("{mbrNm}", ordrVO.getOrdrrNm()); // 주문자
					mailForm = mailForm.replace("{ordrDt}", formatter.format(ordrVO.getOrdrDt())); // 주문일
					mailForm = mailForm.replace("{ordrCd}", ordrVO.getOrdrCd()); // 주문번호

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
							base = base.replace("{aditOptn}", "");
							base_reset = "";
							String base_html = FileUtil.readFile(MAIL_FORM_PATH + "mail_ordr_gds.html");
							base_html = base_html.replace("{gdsNm}", ordrVO.getOrdrDtlList().get(i).getGdsNm());
							base_html = base_html.replace("{gdsOptnNm}", ordrVO.getOrdrDtlList().get(i).getOrdrOptn());
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
							adit_html = adit_html.replace("{optnNm}", ordrVO.getOrdrDtlList().get(i).getOrdrOptn());
							adit_html = adit_html.replace("{optnQy}", EgovStringUtil.integer2string(ordrVO.getOrdrDtlList().get(i).getOrdrQy()));
							adit_html = adit_html.replace("{optnPc}", numberFormat.format(ordrVO.getOrdrDtlList().get(i).getOrdrOptnPc()));

							adit_reset = adit_html;
						}


						if(i == (ordrVO.getOrdrDtlList().size()-1)) {

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

					// 결제 정보
					int totalGdsPc = 0; // 총 상품 금액 (상품 가격 * 수량)
					int dlvyPc = 0; // 배송비
					int couponAmt = 0; // 쿠폰 할인

					int mlg = ordrVO.getUseMlg(); // 마일리지
					int point = ordrVO.getUsePoint(); // 포인트

					for (OrdrDtlVO ordrDtl2VO : ordrVO.getOrdrDtlList()) {
						if(ordrDtl2VO.getOrdrOptnTy().equals("BASE")) {
							totalGdsPc += (ordrDtl2VO.getGdsPc() * ordrDtl2VO.getOrdrQy());
						}else {
							totalGdsPc += (ordrDtl2VO.getOrdrOptnPc() * ordrDtl2VO.getOrdrQy());
						}
						dlvyPc += (ordrDtl2VO.getDlvyBassAmt() + ordrDtl2VO.getDlvyAditAmt());
						couponAmt += ordrDtl2VO.getCouponAmt();
					}

					mailForm = mailForm.replace("{totalOrdrPc}", numberFormat.format(totalGdsPc));
					mailForm = mailForm.replace("{dlvyPc}", numberFormat.format(dlvyPc));
					mailForm = mailForm.replace("{couponAmt}", numberFormat.format(couponAmt + mlg + point));

					mailForm = mailForm.replace("{stlmAmt}", numberFormat.format(ordrVO.getStlmAmt())); // 결제금액

					mailForm = mailForm.replace("{bank}", ordrVO.getDpstBankNm()); // 은행
					mailForm = mailForm.replace("{actno}", ordrVO.getVrActno()); // 계좌번호
					mailForm = mailForm.replace("{dsptDt}", ordrVO.getDpstTermDt().substring(0, 16)); // 입금기한

					// 메일 발송
					String mailSj = "[이로움ON] 회원님의 주문이 자동취소 되었습니다.";
					if (EgovStringUtil.equals("real", activeMode)) {
						mailService.sendMail(sendMail, ordrVO.getOrdrrEml(), mailSj, mailForm);
					} else if (EgovStringUtil.equals("dev", activeMode)) {
						mailService.sendMail(sendMail, ordrVO.getOrdrrEml(), mailSj, mailForm);
					} else {
						mailService.sendMail(sendMail, mailTestuser, mailSj, mailForm); // 테스트
					}
				} else {
					System.out.println("사용자 상품 주문 자동 취소 EMAIL 전송 실패 :: 이메일 체크 " + ordrVO.getOrdrrEml());
				}
			} catch (Exception e) {
				System.out.println("사용자 상품 주문 자동 취소 EMAIL 전송 실패 :: " + e.toString());
			}
		}

		log.info("########## 가상계좌 취소 처리 END ##########");
	}

}
