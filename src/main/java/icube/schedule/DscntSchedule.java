package icube.schedule;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractController;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.promotion.mlg.biz.MbrMlgService;
import icube.manage.promotion.point.biz.MbrPointService;


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
	 */
	@Scheduled(cron="0 15 0 1 1 *")
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

		log.debug("   ###   extinctMbrMlg END  ####");
	}
}
