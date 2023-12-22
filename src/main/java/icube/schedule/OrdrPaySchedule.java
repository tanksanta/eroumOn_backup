package icube.schedule;

import java.lang.reflect.Type;
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
import org.springframework.context.annotation.Profile;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import icube.common.api.biz.BiztalkOrderService;
import icube.common.api.biz.BootpayApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.mail.MailForm2Service;
import icube.common.mail.MailService;
import icube.common.util.DateUtil;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.ordr.dtl.biz.OrdrDtlService;
import icube.manage.ordr.dtl.biz.OrdrDtlVO;
import icube.manage.ordr.ordr.biz.OrdrService;
import icube.manage.ordr.ordr.biz.OrdrVO;
import icube.manage.ordr.rebill.biz.OrdrRebillService;
import icube.manage.ordr.rebill.biz.OrdrRebillVO;

@Service("ordrPaySchedule")
@Profile(value = {"dev", "test", "real"}) /*개발, 운영서버에서만 실행*/
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

	@Resource(name = "mailForm2Service")
	private MailForm2Service mailForm2Service;

	@Resource(name = "biztalkOrderService")
	private BiztalkOrderService biztalkOrderService;

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
		paramMap.put("srchChgStts", "OR07");
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

	// 구매확정 예정
	@Scheduled(cron="0 40 9 * * *")
	public void order09_notice() throws Exception {
		log.info("########## 구매 확정 처리 START ##########");

		String srchIntervalDay = "-4";

		Map <String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchSttsTy", "OR08");
		paramMap.put("srchChgStts", "OR08");
		paramMap.put("srchIntervalDay", srchIntervalDay);

		List<OrdrDtlVO> ordrDtlList;
		List<OrdrDtlVO> ordrNoList = ordrDtlService.selectOrdrSttsDaysList(paramMap);
		OrdrVO ordrVO;
		MbrVO mbrVO;

		for(OrdrDtlVO ordrDtlVO : ordrNoList) {
			ordrVO = ordrService.selectOrdrByNo(ordrDtlVO.getOrdrNo());

			paramMap.put("ordrNo", ordrVO.getOrdrNo());

			ordrDtlList = ordrDtlService.selectOrdrSttsDaysDtlList(paramMap);

			ordrVO.setOrdrDtlList(ordrDtlList);

			mbrVO = mbrService.selectMbrByUniqueId(ordrVO.getUniqueId());

			biztalkOrderService.sendOrdr("BIZTALKSEND_ORDR_SCHEDULE_CONFIRM_NOTICE", mbrVO, ordrVO);
			mailForm2Service.sendMailOrder("MAILSEND_ORDR_SCHEDULE_CONFIRM_NOTICE", mbrVO, ordrVO, srchIntervalDay);
		}
	}


	// 구매확정 처리
	@Scheduled(cron="0 50 9 * * *")
	public void order09_action() throws Exception {
		log.info("########## 구매 확정 처리 START ##########");

		Map <String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchSttsTy", "OR08");
		paramMap.put("srchChgStts", "OR08");
		paramMap.put("srchIntervalDay", "-7");

		MbrVO mbrVO;
		OrdrVO ordrVO;
		OrdrDtlVO newDtlVO;
		List<OrdrDtlVO> ordrNoList = ordrDtlService.selectOrdrSttsDaysList(paramMap);
		List<OrdrDtlVO> ordrDtlList;
		String[] ordrDtlNos;
		
		for(OrdrDtlVO ordrNoDtlVO : ordrNoList) {
			ordrVO = ordrService.selectOrdrByNo(ordrNoDtlVO.getOrdrNo());

			paramMap.put("ordrNo", ordrNoDtlVO.getOrdrNo());
			ordrDtlList = ordrDtlService.selectOrdrSttsDaysDtlList(paramMap);

			for(OrdrDtlVO ordrDtlVO : ordrDtlList) {

				
				ordrDtlNos = new String[]{String.valueOf(ordrDtlVO.getOrdrDtlNo())};


				newDtlVO = new OrdrDtlVO();
				newDtlVO.setOrdrNo(ordrDtlVO.getOrdrNo());
				newDtlVO.setOrdrDtlCd(ordrDtlVO.getOrdrDtlCd());
				newDtlVO.setSttsTy("OR09");
				newDtlVO.setResn("자동 전환");
				newDtlVO.setRegUniqueId(null);
				newDtlVO.setRegId("SYS");
				newDtlVO.setRgtr("SYS");

				newDtlVO.setOrdrDtlNos(ordrDtlNos);

				newDtlVO.setTotalAccmlMlg(ordrDtlVO.getAccmlMlg());

				ordrDtlService.updateOrdrOR09(ordrVO, newDtlVO);
			}

			ordrVO.setOrdrDtlList(ordrDtlList);
			
			mbrVO = mbrService.selectMbrByUniqueId(ordrVO.getUniqueId());

			biztalkOrderService.sendOrdr("BIZTALKSEND_ORDR_SCHEDULE_CONFIRM_ACTION", mbrVO, ordrVO);
			mailForm2Service.sendMailOrder("MAILSEND_ORDR_SCHEDULE_CONFIRM_ACTION", mbrVO, ordrVO);
		}

		log.info("########## 구매 확정 처리 END ##########");
	}

	// 가상계좌 입금요청 -> 매일 오전 9시 30분
	@Scheduled(cron="0 0 10 * * *")
	public void vbankReqeust() throws Exception {
		log.info("########## 가상계좌 입금요청 처리 START ##########");

		String mailSendType = "MAILSEND_ORDR_SCHEDULE_VBANK_REQUEST";
		MbrVO mbrVO;
		OrdrVO ordrVO;
		List<OrdrVO> ordrList = ordrService.selectOrdrScheduleStlmNForRequestList();
		int ifor, ilen = ordrList.size();
		for(ifor=0 ; ifor<ilen; ifor++){
			ordrVO = ordrList.get(ifor);

			mbrVO = mbrService.selectMbrByUniqueId(ordrVO.getUniqueId());

			biztalkOrderService.sendOrdr("BIZTALKSEND_ORDR_SCHEDULE_VBANK_REQUEST", mbrVO, ordrVO);
			mailForm2Service.sendMailOrder(mailSendType, mbrVO, ordrVO);
		}

		log.info("########## 가상계좌 입금요청 처리 END ##########");
	}

	// 가상계좌 입금기간 만료시 -> 취소 (매일 자정)
	@Scheduled(cron="0 30 9 * * *")
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

			OrdrVO ordrVO = ordrService.selectOrdrByCd(ordrDtlVO.getOrdrCd());
			
			//탈퇴한 회원에게는 발송하지 않음
			Map<String, Object> searchParamMap = new HashMap<String, Object>();
			searchParamMap.put("srchUniqueId", ordrVO.getUniqueId());
			MbrVO mbrVO = mbrService.selectMbr(searchParamMap);
			
			biztalkOrderService.sendOrdr("BIZTALKSEND_ORDR_SCHEDULE_VBANK_CANCEL", mbrVO, ordrVO);
			mailForm2Service.sendMailOrder("MAILSEND_ORDR_SCHEDULE_VBANK_CANCEL", mbrVO, ordrVO);
		}

		log.info("########## 가상계좌 취소 처리 END ##########");
	}

}
