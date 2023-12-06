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
import icube.common.util.FileUtil;
import icube.manage.mbr.mbr.biz.MbrMngInfoService;
import icube.manage.mbr.mbr.biz.MbrMngInfoVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.ordr.dtl.biz.OrdrDtlService;
import icube.manage.promotion.mlg.biz.MbrMlgService;
import icube.manage.promotion.point.biz.MbrPointService;


/**
 * 회원 관련 스케줄러
 */
@EnableScheduling
@Service("mbrSchedule")
public class MbrSchedule extends CommonAbstractController {

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "mbrMngInfoService")
	private MbrMngInfoService mbrMngInfoService;

	@Resource(name = "mbrPointService")
	private MbrPointService mbrPointService;

	@Resource(name = "mbrMlgService")
	private MbrMlgService mbrMlgService;

	@Resource(name = "ordrDtlService")
	private OrdrDtlService ordrDtlService;

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
	

	// 회원휴면으로 전환
	@Scheduled(cron="0 0 2 * * *")
	public void sleepMbr() throws Exception {
		log.info("################## 회원 휴면 처리 START #####################");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchMbrSttus", "NORMAL");
		paramMap.put("srchDrmcDate", 365); //1년

		List<MbrVO> mbrList = mbrService.selectMbrListAll(paramMap);

		Date now = new Date();
		String today = format2.format(now);
		
		try{
			for(MbrVO mbrVO : mbrList) {
				paramMap.clear();
				paramMap.put("mberSttus", "HUMAN");
				paramMap.put("uniqueId", mbrVO.getUniqueId());
				mbrService.updateMberSttus(paramMap);

				//TODO 소멸 포인트, 마일리지에 대한 로그 (관리자 페이지 기획중)
				// 포인트, 마일리지 reset
				paramMap.clear();
				paramMap.put("srchUniqueId", mbrVO.getUniqueId());
				paramMap.put("mberStts", "HUMAN");
				mbrService.resetMemberShip(paramMap);

				
				//이메일 수신거부 확인
//				if (!"Y".equals(mbrVO.getEmlRcptnYn())) {
//					continue;
//				}

				String MAIL_FORM_PATH = mailFormFilePath;
				String mailForm = FileUtil.readFile(MAIL_FORM_PATH+"mail/mbr/mail_drmc.html");
				mailForm = mailForm.replace("((mbrNm))", mbrVO.getMbrNm());
				mailForm = mailForm.replace("((mbrId))", mbrVO.getMbrId());
				mailForm = mailForm.replace("((recentCntnDt))", format.format(mbrVO.getRecentCntnDt()));
				mailForm = mailForm.replace("((extinctDate))", today);
				
				// 메일 발송
				String mailSj = "[이로움ON] 휴면계정 전환 안내";
				if(EgovStringUtil.equals("real", activeMode)) {
					mailService.sendMail(sendMail, mbrVO.getEml(), mailSj, mailForm);
				} else {
					mailService.sendMail(sendMail, this.mailTestuser, mailSj, mailForm); //테스트
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
			log.debug("회원 휴면 상태 변경 실패 : " + e.toString());
		}

		log.info("################## 회원 휴면 처리 END #####################");
	}


	// 회원등급 조정
	@Scheduled(cron="0 30 2 1 * *")
	public void transGrade() throws Exception {
		log.info("################## 회원 등급 조정 START #####################");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchMbrStts", "NORMAL");
		List<MbrVO> mbrList = mbrService.selectMbrListAll(paramMap);

		for(MbrVO mbrVO : mbrList) {

			paramMap.clear();
			paramMap.put("srchUniqueId", mbrVO.getUniqueId());

			int sumPc = mbrService.selectMbrSumPc(paramMap);

			// 누적 결제 금액 30만원 미만 - 신규
			if(sumPc < 300000) {
				paramMap.put("mberGrade", "N");
			// 누적 결제 금액 30만원 이상 - 새로움
			}else if(300000 <= sumPc && sumPc < 900000 ) {
				paramMap.put("mberGrade", "S");
			// 누적 결제 금액 90만원 이상 - 반가움
			}else if(900000 <= sumPc && sumPc < 3600000) {
				paramMap.put("mberGrade", "B");
			// 누적 결제 금액 360만원 이상 - 이로움
			}else if(3600000 <= sumPc) {
				paramMap.put("mberGrade", "E");
			}
			mbrService.updateMberGrade(paramMap);
		}

		log.info("################## 회원 등급 조정 END #####################");
	}




	// 블랙리스트 일시정지 회원 해제
	 @Scheduled(cron="0 0 3 * * *")
	public void transMbrSttus() throws Exception {
		log.info("################## 블랙리스트 검사 START #####################");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchMngTy", "BLACK");
		paramMap.put("srchMngSe", "PAUSE");
		paramMap.put("srchDate", "1");
		List<MbrMngInfoVO> mbrList = mbrMngInfoService.selectMbrMngInfoListBySort(paramMap);

		try {
			for(MbrMngInfoVO mbrMngInfoVO : mbrList) {
				if(mbrMngInfoVO.getMngSe().equals("PAUSE")) {
					paramMap.clear();
					paramMap.put("uniqueId", mbrMngInfoVO.getMbrVO().getUniqueId());
					paramMap.put("mberSttus", "NORMAL");
					mbrService.updateMberSttus(paramMap);

					//일시 정지 내역
					MbrMngInfoVO newInfoVO = new MbrMngInfoVO();
					newInfoVO.setUniqueId(mbrMngInfoVO.getUniqueId());
					newInfoVO.setMngTy("BLACK");
					newInfoVO.setMngSe("NONE");
					newInfoVO.setResnCd("SYS");
					newInfoVO.setMngrMemo("일시정지 자동 해제");
					newInfoVO.setRgtr("SYS");

					mbrMngInfoService.insertMbrMngInfo(newInfoVO);

				}
			}
		}catch(Exception e) {
			e.printStackTrace();
			log.debug("블랙리스트 회원 일시정지 해제 실패 : " + e.toString());
		}


		log.info("################## 블랙리스트 검사 END #####################");

	}

	 // 탈퇴회원 DI Key Null
	 //@Scheduled(cron="0 05 12 * * *")
	 public void updateDiKey() throws Exception {
		 log.info("################## 탈퇴 회원 날짜 검사 START #####################");

		 Map<String, Object> paramMap = new HashMap<String, Object>();
		 paramMap.put("srchMbrStts", "EXIT");

		 List<MbrVO> mbrList = mbrService.selectMbrListAll(paramMap);

		 for(MbrVO mbrVO : mbrList) {
			paramMap.clear();
			paramMap.put("srchUniqueId", mbrVO.getUniqueId());
			try {
				mbrService.updateDiKey(paramMap);
			}catch(Exception e) {
				e.printStackTrace();
				log.info("회원 : " + mbrVO.getMbrNm() + "업데이트 실패 : " + e.toString());
			}
		 }

		 log.info("################## 탈퇴 회원 날짜 검사 END #####################");

	 }

	 //간편회원 미등록 계정 삭제 처리 (10분 마다 체크)
	 @Scheduled(cron="0 */10 * * * *")
	 public void deleteSnsNotRegistMbr() throws Exception {
		 log.info("################## 간편가입 회원 등록 검사 START #####################");
		 
		 List<MbrVO> mbrList = mbrService.selectNotSnsRegistMbr();
		 
		 for(MbrVO mbrVO : mbrList) {
			try {
				mbrService.deleteMbr(mbrVO.getUniqueId());
			}catch(Exception e) {
				e.printStackTrace();
				log.info("간편가입 회원 : " + mbrVO.getMbrNm() + "삭제 실패 : " + e.toString());
			}
		 }
		 
		 log.info("################## 간편가입 회원 등록 검사 END #####################");
	 }
}
