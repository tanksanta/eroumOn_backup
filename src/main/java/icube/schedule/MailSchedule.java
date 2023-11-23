package icube.schedule;

import java.text.SimpleDateFormat;
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

import icube.common.framework.abst.CommonAbstractController;
import icube.common.mail.MailService;
import icube.common.util.DateUtil;
import icube.common.util.FileUtil;
import icube.common.util.ValidatorUtil;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.promotion.coupon.biz.CouponLstService;
import icube.manage.promotion.coupon.biz.CouponLstVO;
import icube.manage.promotion.coupon.biz.CouponService;
import icube.manage.promotion.coupon.biz.CouponVO;
import icube.manage.promotion.mlg.biz.MbrMlgService;
import icube.manage.promotion.point.biz.MbrPointService;


@EnableScheduling
@Service("mailSchedule")
public class MailSchedule extends CommonAbstractController  {

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "mbrMlgService")
	private MbrMlgService mbrMlgService;

	@Resource(name = "mbrPointService")
	private MbrPointService mbrPointService;

	@Resource(name = "couponService")
	private CouponService couponService;
	
	@Resource(name = "couponLstService")
	private CouponLstService couponLstService;
	
	@Resource(name="mailService")
	private MailService mailService;

	@Value("#{props['Mail.Form.FilePath']}")
	private String mailFormFilePath;

	@Value("#{props['Mail.Username']}")
	private String sendMail;

	@Value("#{props['Mail.Testuser']}")
	private String mailTestuser;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;
	
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	SimpleDateFormat format2 = new SimpleDateFormat("yyyy.MM.dd");
	SimpleDateFormat format3 = new SimpleDateFormat("yyyy년 MM월 dd일");


	// 생일 이메일 발송
	@Scheduled(cron = "0 30 8 * * *")
	public void sendBrdtEmail() throws Exception {

		log.debug("############## 생일 이메일, 쿠폰 Scheduler ##############");
		
		// 생일자 조회
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchDate", "now");
		List<MbrVO> mbrList = mbrService.selectMbrListAll(paramMap);

		if (mbrList.size() > 0) {
			Map<String, Object> param = new HashMap<>();
			param.put("srchCouponTy", "BRDT");
			param.put("srchSttusTy", "USE");
			CouponVO brdtCouponVO = couponService.selectCoupon(param);
			if (brdtCouponVO == null) {
				throw new Exception("생일축하 쿠폰이 존재하지 않습니다.");
			}
			
			for (MbrVO mbrVO : mbrList) {
				try {
					// 생일축하 쿠폰 발급
					CouponLstVO couponLstVO = new CouponLstVO();
					couponLstVO.setCouponNo(brdtCouponVO.getCouponNo());
					couponLstVO.setUniqueId(mbrVO.getUniqueId());
					if(brdtCouponVO.getUsePdTy().equals("ADAY")) {
						couponLstVO.setUseDay(brdtCouponVO.getUsePsbltyDaycnt());
					}
					couponLstService.insertCouponLst(couponLstVO);
					
					
					//이메일 수신거부 확인
					if (!"Y".equals(mbrVO.getEmlRcptnYn())) {
						continue;
					}
					
					// 이메일 발송
					if (ValidatorUtil.isEmail(mbrVO.getEml())) {
						String MAIL_FORM_PATH = mailFormFilePath;
						String mailForm = FileUtil.readFile(MAIL_FORM_PATH + "mail/mbr/mail_brdt.html");
						mailForm = mailForm.replace("((mbrNm))", mbrVO.getMbrNm()); // 회원 이름

						String mailSj = "[이로움ON] 생일을 진심으로 축하드립니다.";
						if (EgovStringUtil.equals("real", activeMode)) {
							mailService.sendMail(sendMail, mbrVO.getEml(), mailSj, mailForm);
						} else {
							mailService.sendMail(sendMail, this.mailTestuser, mailSj, mailForm); // 테스트
						}
					} else {
						log.debug(mbrVO.getUniqueId() + "," + mbrVO.getMbrNm() + " 회원 생일 축하 EMAIL 전송 실패 :: 이메일 체크 " + mbrVO.getEml());
					}
				} catch (Exception e) {
					log.debug(mbrVO.getUniqueId() + "," + mbrVO.getMbrNm() + "회원 생일 축하 EMAIL 전송 실패 :: " + e.toString());
				}
			}
		}
	}

	// 휴면계정 대상 안내 발송
	@Scheduled(cron="0 30 9 * * *")
	public void sendGuidDrmcMbrMail() throws Exception {
		log.info("################## 휴면계정대상 MAIL START #####################");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchMbrSttus", "NORMAL");
		paramMap.put("srchDrmcDate", 335); //휴면전환 30일 전 (1년 - 30일)
		paramMap.put("srchNotHumanMail", "1");

		Date now = new Date();
		Date extinct = DateUtil.getDateAdd(now, "date", 30);
		String extinctDate = format2.format(extinct);
		String extinctDate2 = format3.format(extinct);
		
		List<MbrVO> mbrList = mbrService.selectMbrListAll(paramMap);

		for(MbrVO mbrVO : mbrList) {
			try {
				if(ValidatorUtil.isEmail(mbrVO.getEml())) {
					
					//이메일 수신거부 확인
					if (!"Y".equals(mbrVO.getEmlRcptnYn())) {
						continue;
					}
					
					String MAIL_FORM_PATH = mailFormFilePath;
					String mailForm = FileUtil.readFile(MAIL_FORM_PATH+"mail/mbr/mail_guide_drmc.html");

					mailForm = mailForm.replace("((mbrNm))", mbrVO.getMbrNm());
					mailForm = mailForm.replace("((mbrId))", mbrVO.getMbrId());
					mailForm = mailForm.replace("((recentCntnDt))", format.format(mbrVO.getRecentCntnDt()));
					mailForm = mailForm.replace("((extinctDate))", extinctDate);
					mailForm = mailForm.replace("((extinctDate2))", extinctDate2);
					
					// 메일 발송
					String mailSj = "[이로움ON] 휴면계정 대상 안내";
					if(EgovStringUtil.equals("real", activeMode)) {
						mailService.sendMail(sendMail, mbrVO.getEml(), mailSj, mailForm);
					} else {
						mailService.sendMail(sendMail, this.mailTestuser, mailSj, mailForm); //테스트
					}
				} else {
					log.debug(mbrVO.getMbrNm()+" 휴면계정대상 EMAIL 전송 실패 :: 이메일 체크 " + mbrVO.getEml());
				}
			} catch (Exception e) {
				log.debug(mbrVO.getMbrNm()+"휴면계정대상 EMAIL 전송 실패 :: " + e.toString());
			}
		}
		
		//휴면계정 대상 안내 발송 처리 체크
		mbrService.updateHumanMailYn(paramMap);
	}

	// 개인정보 이용내역
	@Scheduled(cron="0 0 12 31 12 *")
	public void sendInfoMail() throws Exception {

		log.info("################## 개인정보 MAIL START #####################");
		// 개인정보 유효기간으로부터 1개월 전 발송

		Map<String, Object> paramMap = new HashMap<String, Object>();

		//유효기간 select
		List<MbrVO> mbrList = mbrService.selectMbrListAll(paramMap);

		//개인정보 이용내역 메일
		for(MbrVO mbrVO : mbrList) {
			try {
				if(ValidatorUtil.isEmail(mbrVO.getEml())) {
					String MAIL_FORM_PATH = mailFormFilePath;
					String mailForm = FileUtil.readFile(MAIL_FORM_PATH+"mail/mbr/mail_privacy_info.html");


					// 메일 발송
					String mailSj = "[이로움ON] 개인정보 이용내역 안내";
					if(EgovStringUtil.equals("real", activeMode)) {
						mailService.sendMail(sendMail, mbrVO.getEml(), mailSj, mailForm);
					} else {
						mailService.sendMail(sendMail, this.mailTestuser, mailSj, mailForm); //테스트
					}
				} else {
					log.debug(mbrVO.getMbrNm()+" 개인정보 이용내역 EMAIL 전송 실패 :: 이메일 체크 " + mbrVO.getEml());
				}
			} catch (Exception e) {
				log.debug(mbrVO.getMbrNm()+"개인정보 이용내역 EMAIL 전송 실패 :: " + e.toString());
			}
		}
	}
}

