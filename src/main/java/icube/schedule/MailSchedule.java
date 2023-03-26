package icube.schedule;

import java.text.SimpleDateFormat;
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
import icube.manage.promotion.mlg.biz.MbrMlgService;
import icube.manage.promotion.mlg.biz.MbrMlgVO;


@EnableScheduling
@Service("mailSchedule")
public class MailSchedule extends CommonAbstractController  {

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "mbrMlgService")
	private MbrMlgService mbrMlgService;

	@Resource(name="mailService")
	private MailService mailService;

	@Value("#{props['Mail.Form.FilePath']}")
	private String mailFormFilePath;

	@Value("#{props['Mail.Username']}")
	private String sendMail;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;



	// 소멸예정 포인트
	@Scheduled(cron="0 0 9 * * *")
	public void extinctMail() throws Exception {

		log.info("################## 소멸예정 포인트 MAIL START #####################");
		// 소멸 예정 마일리지
		//TODO 쿼리 포인트 추가, 현재 날짜
		SimpleDateFormat  formatter = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		List<MbrMlgVO> mlgList = mbrMlgService.selectMbrDedMlgList();

		for(MbrMlgVO mbrMlgVO : mlgList) {
			try {
				if(ValidatorUtil.isEmail(mbrMlgVO.getEml())) {
					String MAIL_FORM_PATH = mailFormFilePath;
					String mailForm = FileUtil.readFile(MAIL_FORM_PATH+"mail_dscnt.html");

					mailForm = mailForm.replace("{mbrNm}", mbrMlgVO.getMbrNm()); // 회원 이름
					mailForm = mailForm.replace("{now}", formatter.format(mbrMlgVO.getNow()));  //문의 등록일
					mailForm = mailForm.replace("{mbrPoint}", EgovStringUtil.integer2string(mbrMlgVO.getMbrPoint())); // 보유 포인트
					mailForm = mailForm.replace("{dedPoint}", EgovStringUtil.integer2string(mbrMlgVO.getDedPoint())); // 소멸예정 포인트
					mailForm = mailForm.replace("{dedDt}", formatter.format(mbrMlgVO.getDedDt())); // 소멸예정일 - 포인트

					mailForm = mailForm.replace("{mbrMlg}", EgovStringUtil.integer2string(mbrMlgVO.getMlgTotal())); // 보유 마일리지
					mailForm = mailForm.replace("{dedMlg}", EgovStringUtil.integer2string(mbrMlgVO.getDedMlg())); // 소멸예정 마일리지
					mailForm = mailForm.replace("{dedMlgDt}", formatter.format(mbrMlgVO.getDedMlgDt())); // 소멸예정일 - 마일리지


					mailForm = mailForm.replace("{company}", "㈜티에이치케이컴퍼니");
					mailForm = mailForm.replace("{name}", "이로움마켓");
					mailForm = mailForm.replace("{addr}", "부산시 금정구 중앙대로 1815, 5층(가루라빌딩)");
					mailForm = mailForm.replace("{brno}", "617-86-14330");
					mailForm = mailForm.replace("{telno}", "2018-서울강남-04157");


					// 메일 발송
					String mailSj = "[EROUM] 소멸예정 포인트/마일리지 안내";
					if(EgovStringUtil.equals("real", activeMode)) {
						mailService.sendMail(sendMail, mbrMlgVO.getEml(), mailSj, mailForm);
					} else {
						mailService.sendMail(sendMail, "gyoh@icubesystems.co.kr", mailSj, mailForm); //테스트
					}
				} else {
					log.debug(mbrMlgVO.getMbrNm() + " 회원 소멸예정 안내 EMAIL 전송 실패 :: 이메일 체크 " + mbrMlgVO.getEml());
				}
			} catch (Exception e) {
				log.debug(mbrMlgVO.getMbrNm() + "회원 소멸예정 안내 EMAIL 전송 실패 :: " + e.toString());
			}
		}

	}

	// 휴면계정
	@Scheduled(cron="0 30 9 * * *")
	public void drmcMbrMail() throws Exception {

		// 12개월동안 접속하지 않은 회원
		log.info("################## 휴면계정 MAIL START #####################");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchMbrSttus", "NORMAL");
		paramMap.put("srchDrmcDate", 365); //1년

		List<MbrVO> mbrList = mbrService.selectMbrListAll(paramMap);
		SimpleDateFormat  formatter = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");

		for(MbrVO mbrVO : mbrList) {
			try {
				paramMap.clear();
				paramMap.put("mberSttus", "HUMAN");
				paramMap.put("srchUniqueId", mbrVO.getUniqueId());
				paramMap.put("mdfcnId", "SYS");
				paramMap.put("mdfr", "SYS");

				mbrService.updateRlsDrmt(paramMap);


				if(ValidatorUtil.isEmail(mbrVO.getEml())) {

					String MAIL_FORM_PATH = mailFormFilePath;
					String mailForm = FileUtil.readFile(MAIL_FORM_PATH+"mail_drmc.html");

					mailForm = mailForm.replace("{name}", mbrVO.getMbrNm());
					mailForm = mailForm.replace("{mbrId}", mbrVO.getMbrId());
					mailForm = mailForm.replace("{recentDate}", formatter.format(mbrVO.getRecentCntnDt()));
					mailForm = mailForm.replace("{chgDate}", formatter.format(mbrVO.getMdfcnDt()));


					mailForm = mailForm.replace("{company}", "㈜티에이치케이컴퍼니");
					mailForm = mailForm.replace("{name}", "이로움마켓");
					mailForm = mailForm.replace("{addr}", "부산시 금정구 중앙대로 1815, 5층(가루라빌딩)");
					mailForm = mailForm.replace("{brno}", "617-86-14330");
					mailForm = mailForm.replace("{telno}", "2018-서울강남-04157");



					// 메일 발송
					String mailSj = "[EROUM] 휴면계정 전환 안내";
					if(EgovStringUtil.equals("real", activeMode)) {
						mailService.sendMail(sendMail, mbrVO.getEml(), mailSj, mailForm);
					} else {
						mailService.sendMail(sendMail, "gyoh@icubesystems.co.kr", mailSj, mailForm); //테스트
					}
				} else {
					log.debug(mbrVO.getMbrNm()+" 개인정보 이용내역 EMAIL 전송 실패 :: 이메일 체크 " + mbrVO.getEml());
				}
			} catch (Exception e) {
				log.debug(mbrVO.getMbrNm()+"개인정보 이용내역 EMAIL 전송 실패 :: " + e.toString());
			}
		}


	}


	// 개인정보 이용내역
	@Scheduled(cron="0 0 0 31 12 *")
	public void infoMail() throws Exception {

		log.info("################## 개인정보 MAIL START #####################");
		// 개인정보 유효기간으로부터 1개월 전 발송

		Map<String, Object> paramMap = new HashMap<String, Object>();

		//유효기간 select
		List<MbrVO> mbrList = mbrService.selectMbrListAll(paramMap);

		//개인정보 이용내역 메일
		for(int i=0; i < mbrList.size(); i++) {
			try {
				if(ValidatorUtil.isEmail(mbrList.get(i).getEml())) {
					String MAIL_FORM_PATH = mailFormFilePath;
					String mailForm = FileUtil.readFile(MAIL_FORM_PATH+"mail_info.html");

					mailForm = mailForm.replace("{company}", "㈜티에이치케이컴퍼니");
					mailForm = mailForm.replace("{name}", "이로움마켓");
					mailForm = mailForm.replace("{addr}", "부산시 금정구 중앙대로 1815, 5층(가루라빌딩)");
					mailForm = mailForm.replace("{brno}", "617-86-14330");
					mailForm = mailForm.replace("{telno}", "2018-서울강남-04157");



					// 메일 발송
					String mailSj = "[EROUM] 개인정보 이용내역 안내";
					if(EgovStringUtil.equals("real", activeMode)) {
						mailService.sendMail(sendMail, mbrList.get(i).getEml(), mailSj, mailForm);
					} else {
						mailService.sendMail(sendMail, "gyoh@icubesystems.co.kr", mailSj, mailForm); //테스트
					}
				} else {
					log.debug(i + "번째" + mbrList.get(i).getMbrNm()+" 개인정보 이용내역 EMAIL 전송 실패 :: 이메일 체크 " + mbrList.get(i).getEml());
				}
			} catch (Exception e) {
				log.debug(i + "번째" + mbrList.get(i).getMbrNm()+"개인정보 이용내역 EMAIL 전송 실패 :: " + e.toString());
			}
		}
	}





}

