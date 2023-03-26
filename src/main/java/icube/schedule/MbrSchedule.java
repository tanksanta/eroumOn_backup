package icube.schedule;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractController;
import icube.manage.mbr.mbr.biz.MbrMngInfoService;
import icube.manage.mbr.mbr.biz.MbrMngInfoVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;


/**
 * 회원휴면처리, 회원등급 조정
 */
@EnableScheduling
@Service("mbrSchedule")
public class MbrSchedule extends CommonAbstractController {

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "mbrMngInfoService")
	private MbrMngInfoService mbrMngInfoService;



	// 회원휴면처리 (매일 00시 30분)
	@Scheduled(cron="0 30 0 * * *")
	public void sleepMbr() throws Exception {
		log.info("################## 회원 휴면 처리 START #####################");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchMbrSttus", "NORMAL");
		paramMap.put("srchDrmcDate", 365); //1년

		List<MbrVO> mbrList = mbrService.selectMbrListAll(paramMap);

		try{
			for(MbrVO mbrVO : mbrList) {
				paramMap.clear();
				paramMap.put("mberSttus", "HUMAN");
				paramMap.put("uniqueId", mbrVO.getUniqueId());
				mbrService.updateMberSttus(paramMap);
			}
		}catch(Exception e) {
			e.printStackTrace();
			log.debug("회원 휴면 상태 변경 실패 : " + e.toString());
		}

		log.info("################## 회원 휴면 처리 END #####################");
	}


	// 회원등급 조정 (매월 1일 01시 00분)
	@Scheduled(cron="0 0 1 1 * *")
	public void transGrade() throws Exception {
		log.info("################## 회원 등급 조정 START #####################");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchMbrStts", "NORMAL");
		List<MbrVO> mbrList = mbrService.selectMbrListAll(paramMap);

		for(MbrVO mbrVO : mbrList) {

			paramMap.clear();
			paramMap.put("srchUniqueId", mbrVO.getUniqueId());
			int sumPc = mbrService.selectMbrSumPc(paramMap);

			// 전월 누적 결제 금액 50만원 미만 - RED
			if(sumPc < 500000) {
				mbrVO.setMberGrade("R");
			// 전월 누적 결제 금액 50만원 이상 - SILVER
			}else if(500000 <= sumPc && sumPc < 1500000 ) {
				mbrVO.setMberGrade("S");
			// 전월 누적 결제 금액 150만원 이상 - GOLD
			}else if(1500000 <= sumPc && sumPc < 3000000) {
				mbrVO.setMberGrade("G");
			// 전월 누적 결제 금액 300만원 이상 - VIP
			}else if(3000000 <= sumPc && sumPc < 5000000) {
				mbrVO.setMberGrade("V");
			// 전월 누적 결제 금액 500만원 이상 - PLATINUM
			}else if(5000000 <= sumPc) {
				mbrVO.setMberGrade("P");
			}
			mbrService.updateMbr(mbrVO);
		}

		log.info("################## 회원 등급 조정 END #####################");
	}




	// 블랙리스트 일시정지 회원 해제 (매일 01시 30분)
	 @Scheduled(cron="0 30 1 * * *")
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


}
