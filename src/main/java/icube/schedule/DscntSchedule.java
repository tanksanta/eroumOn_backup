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
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.promotion.mlg.biz.MbrMlgService;
import icube.manage.promotion.point.biz.MbrPointService;
import icube.manage.promotion.point.biz.MbrPointVO;


/**
 * 마일리지, 포인트 소멸 처리
 * @author ogy
 */
@EnableScheduling
@Service("dscntSchedule")
public class DscntSchedule extends CommonAbstractController {

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "mbrPointService")
	private MbrPointService mbrPointService;

	@Resource(name = "mbrMlgService")
	private MbrMlgService mbrMlgService;

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
	
	SimpleDateFormat format = new SimpleDateFormat("yyyy년 MM월 dd일");
	
	SimpleDateFormat format2 = new SimpleDateFormat("yyyy");
	
	SimpleDateFormat format3 = new SimpleDateFormat("yyyy.MM.dd");
	
	
	/**
	 * 소멸예정 포인트 안내
	 */
	@Scheduled(cron="0 0 9 30 11 *")
	public void guideExtinctPoint() throws Exception {
		log.debug("   ###   guideExtinctPoint START  ####");

		List<MbrPointVO> mbrPointList = mbrPointService.selectExtinctPoinThisYear();
		Date now = new Date();
		String today = format.format(now);
		String thisYear = format2.format(now);
		
		for(MbrPointVO mbrPointVO : mbrPointList) {
			try {
				String MAIL_FORM_PATH = mailFormFilePath;
				String mailForm = FileUtil.readFile(MAIL_FORM_PATH+"mail_guide_extinct_point.html");
				MbrVO mbrVO = mbrPointVO.getMbrList().get(0);
				mailForm = mailForm.replace("((mbrNm))", mbrVO.getMbrNm());
				mailForm = mailForm.replace("((today))", today);
				mailForm = mailForm.replace("((point))", String.valueOf(mbrPointVO.getPointAcmtl()));
				mailForm = mailForm.replace("((thisYear))", thisYear);
				
				// 메일 발송
				String mailSj = "[이로움ON] 소멸예정 포인트 안내";
				if(!EgovStringUtil.equals("local", activeMode)) {
					mailService.sendMail(sendMail, mbrVO.getEml(), mailSj, mailForm);
				} else {
					mailService.sendMail(sendMail, this.mailTestuser, mailSj, mailForm); //테스트
				}
			}catch(Exception e) {
				log.debug("   ###   guideExtinctPoint Error   ### : " + e.toString());
				e.printStackTrace();
			}
		}

		log.debug("   ###   guideExtinctPoint END  ####");
	}
	
	/**
	 * 소멸예정 마일리지 안내
	 */
	@Scheduled(cron="0 15 9 * * *")
	public void guideExtinctMlg() throws Exception {
		log.debug("   ###   guideExtinctMlg START  ####");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchMbrStts", "NORMAL");
		List<MbrVO> mbrList = mbrService.selectMbrListAll(paramMap);

		Date now = new Date();
		String today = format.format(now);
		Date extinct = DateUtil.getDateAdd(now, "date", 7);
		String extinctDate = format3.format(extinct);
		
		for(MbrVO mbrVO : mbrList) {
			try {
				paramMap.clear();
				paramMap.put("srchTwoYearBeforeWeek", 1);
				paramMap.put("srchUniqueId", mbrVO.getUniqueId());
				Map<String, Object> mlgMap = mbrMlgService.selectAlltypeMlg(paramMap);
				
				int totalAccmtMlg = Integer.parseInt(String.valueOf(mlgMap.get("addMlg")));
				int totalUseMlg = Integer.parseInt(String.valueOf(mlgMap.get("useMlg")));
				int totalExtMlg = Integer.parseInt(String.valueOf(mlgMap.get("extMlg")));
				int restMlg = totalAccmtMlg - (totalUseMlg + totalExtMlg);
				
				//소멸 마일리지가 있음
				if(restMlg > 0) {
					String MAIL_FORM_PATH = mailFormFilePath;
					String mailForm = FileUtil.readFile(MAIL_FORM_PATH+"mail_guide_extinct_mlg.html");
					mailForm = mailForm.replace("((mbrNm))", mbrVO.getMbrNm());
					mailForm = mailForm.replace("((today))", today);
					mailForm = mailForm.replace("((ownMlg))", String.valueOf(mlgMap.get("ownMlg")));
					mailForm = mailForm.replace("((extinctMlg))", String.valueOf(restMlg));
					mailForm = mailForm.replace("((extinctDate))", extinctDate);
					
					// 메일 발송
					String mailSj = "[이로움ON] 소멸예정 마일리지 안내";
					if(!EgovStringUtil.equals("local", activeMode)) {
						mailService.sendMail(sendMail, mbrVO.getEml(), mailSj, mailForm);
					} else {
						mailService.sendMail(sendMail, this.mailTestuser, mailSj, mailForm); //테스트
					}
				}
				
			}catch(Exception e) {
				log.debug("   ###   guideExtinctMlg Error   ### : " + e.toString());
				e.printStackTrace();
			}
		}

		//소멸 마일리지 메일 발송 처리
		mbrMlgService.updateExtinctMlgMail();
		
		log.debug("   ###   guideExtinctMlg END  ####");
	}
	
	
	/**
	 * 회원 포인트 자동 소멸
	 */
	@Scheduled(cron="0 0 0 1 1 *")
	public void autoExtinctPoint() throws Exception {
		log.debug("   ###   autoExtinctPoint START  ####");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchMbrStts", "NORMAL");
		List<MbrVO> mbrList = mbrService.selectMbrListAll(paramMap);

		for(MbrVO mbrVO : mbrList) {
			try {
				mbrPointService.extinctMbrPoint(mbrVO.getUniqueId());
			}catch(Exception e) {
				log.debug("   ###   autoExtinctPoint Error   ### : " + e.toString());
				e.printStackTrace();
			}
		}

		log.debug("   ###   autoExtinctPoint END  ####");
	}

	/**
	 * 회원 마일리지 자동 소멸
	 * @see 자정 실행 -> 재작년 마일리지 계산
	 * @see 매일 실행으로 변경 (이다겸 대리 확인)
	 */
	@Scheduled(cron="0 0 9 * * *")
	public void autoExtinctMlg() throws Exception {
		log.debug("   ###   autoExtinctMlg START  ####");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchMbrStts", "NORMAL");
		List<MbrVO> mbrList = mbrService.selectMbrListAll(paramMap);

		for(MbrVO mbrVO : mbrList) {
			try {
				mbrMlgService.extinctMbrMlg(mbrVO.getUniqueId());
			}catch(Exception e) {
				log.debug("   ###   extinctMbrMlg Error   ### : " + e.toString());
				e.printStackTrace();
			}
		}

		//마일리지 소멸 처리 체크
		mbrMlgService.updateExtinctMlgAction();
		
		log.debug("   ###   extinctMbrMlg END  ####");
	}
}
