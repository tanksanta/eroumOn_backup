package icube.schedule;

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
import icube.common.util.FileUtil;
import icube.common.util.ValidatorUtil;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.promotion.coupon.biz.CouponLstService;
import icube.manage.promotion.coupon.biz.CouponLstVO;
import icube.manage.promotion.coupon.biz.CouponService;
import icube.manage.promotion.coupon.biz.CouponVO;


/**
 * 할인
 * 마일리지 / 포인트 / 쿠폰 > 발급/소멸
 */
@EnableScheduling
@Service("dscntSchedule")
public class DscntSchedule extends CommonAbstractController {

	@Resource(name = "mbrService")
	private MbrService mbrService;

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

	@Value("#{props['Profiles.Active']}")
	private String activeMode;

	// 1년 마일리지 소멸


	// 1년 포인트 소멸


	// 생일 이메일 발송, 생일자 쿠폰
	@Scheduled(cron="0 30 8 * * *")
	public void sendEmailCoupon() throws Exception {

		log.debug("############## 생일 이메일, 쿠폰 Scheduler ##############");
		// 생일자 조회
		int brdtCount = mbrService.selectBrdtMbrCount();

		if(brdtCount > 0) {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("srchDate", "now");
			List<MbrVO> mbrList = mbrService.selectMbrListAll(paramMap);

			for(int i=0; i<mbrList.size(); i++) {

				// 이메일 발송
				try {
					if(ValidatorUtil.isEmail(mbrList.get(i).getEml())) {
						String MAIL_FORM_PATH = mailFormFilePath;
						String mailForm = FileUtil.readFile(MAIL_FORM_PATH+"mail_brdt.html");

						mailForm = mailForm.replace("{mbrNm}", mbrList.get(i).getMbrNm()); // 회원 이름

						mailForm = mailForm.replace("{company}", "㈜티에이치케이컴퍼니");
						mailForm = mailForm.replace("{name}", "이로움마켓");
						mailForm = mailForm.replace("{addr}", "부산시 금정구 중앙대로 1815, 5층(가루라빌딩)");
						mailForm = mailForm.replace("{brno}", "617-86-14330");
						mailForm = mailForm.replace("{telno}", "2018-서울강남-04157");



						// 메일 발송
						String mailSj = "[EROUM] 회원님의 생일을 진심으로 축하드립니다.";
						if(EgovStringUtil.equals("real", activeMode)) {
							mailService.sendMail(sendMail, mbrList.get(i).getEml(), mailSj, mailForm);
						} else if(EgovStringUtil.equals("dev", activeMode)) {
							mailService.sendMail(sendMail, mbrList.get(i).getEml(), mailSj, mailForm);
						}else{
							mailService.sendMail(sendMail, "gyoh@icubesystems.co.kr", mailSj, mailForm); //테스트
						}
					} else {
						log.debug(i + "번째" + mbrList.get(i).getMbrNm()+" 회원 생일 축하 EMAIL 전송 실패 :: 이메일 체크 " + mbrList.get(i).getEml());
					}
				} catch (Exception e) {
					log.debug(i + "번째" + mbrList.get(i).getMbrNm()+"회원 생일 축하 EMAIL 전송 실패 :: " + e.toString());
				}

				// 생일자 쿠폰
				paramMap.clear();
				paramMap.put("srchCouponTy", "BIRTH");
				int cnt = couponService.selectCouponCount(paramMap);
				if(cnt > 0) {
					try {
						CouponVO couponVO = couponService.selectCoupon(paramMap);
						CouponLstVO couponLstVO = new CouponLstVO();
						couponLstVO.setCouponNo(couponVO.getCouponNo());
						couponLstVO.setUniqueId(mbrList.get(i).getUniqueId());

						couponLstService.insertCouponLst(couponLstVO);
					}catch(Exception e) {
						e.printStackTrace();
						log.debug(i + "번째" + mbrList.get(i).getMbrNm() + "회원 쿠폰 발급 실패 " + e.toString());
					}

				}
			}
		}

	}



}
