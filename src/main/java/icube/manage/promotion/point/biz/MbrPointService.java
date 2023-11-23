package icube.manage.promotion.point.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;
import icube.manage.mbr.mbr.biz.MbrDAO;

@Service("mbrPointService")
public class MbrPointService extends CommonAbstractServiceImpl {

	@Resource(name="mbrPointDAO")
	private MbrPointDAO mbrPointDAO;

	@Resource(name="mbrDAO")
	private MbrDAO mbrDAO;

	public CommonListVO mbrPointListVO(CommonListVO listVO) throws Exception {
		return mbrPointDAO.mbrPointListVO(listVO);
	}

	/**
	 * 최근 포인트 누계
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public MbrPointVO selectMbrPoint(Map<String, Object> paramMap) throws Exception {
		return mbrPointDAO.selectMbrPoint(paramMap);
	}

	/**
	 * 포인트 내역 등록
	 * @param mbrPointVO
	 * @throws Exception
	 */
	public void insertMbrPoint(MbrPointVO mbrPointVO) throws Exception {
		mbrPointDAO.insertMbrPoint(mbrPointVO);
	}

	/**
	 * 포인트 카운트
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectMbrPointCount(Map<String, Object> paramMap) throws Exception {
		return mbrPointDAO.selectMbrPointCount(paramMap);
	}

	/**
	 * 포인트 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<MbrPointVO> selectMbrPointList(Map<String, Object> paramMap) throws Exception {
		return mbrPointDAO.selectMbrPointList(paramMap);
	}

	/**
	 * 회원 포인트 소멸 처리
	 * 유효기간 : 적립일 해 말일
	 * @param uniqueId
	 */
	public void extinctMbrPoint(String uniqueId) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchNowYear", 1);
		paramMap.put("srchUniqueId", uniqueId);
		Map<String, Object> pointMap = this.selectAlltypePoint(paramMap);

		int totalAccmtPoint = Integer.parseInt(String.valueOf(pointMap.get("addPoint")));
		int totalUsePoint = Integer.parseInt(String.valueOf(pointMap.get("usePoint")));
		int totalExtPoint = Integer.parseInt(String.valueOf(pointMap.get("extPoint")));
		int restPoint = totalAccmtPoint - (totalUsePoint + totalExtPoint);

		if(totalAccmtPoint > (totalUsePoint + totalExtPoint)) {
			MbrPointVO mbrPointVO = new MbrPointVO();
			mbrPointVO.setPointMngNo(0);
			mbrPointVO.setUniqueId(uniqueId);
			mbrPointVO.setPointSe("E");
			mbrPointVO.setPoint(restPoint);
			mbrPointVO.setPointCn("15");
			mbrPointVO.setPointAcmtl(0);
			mbrPointVO.setRgtr("System");
			mbrPointVO.setGiveMthd("SYS");

			try {
				mbrPointDAO.extinctMbrPoint(mbrPointVO);
			}catch(Exception e) {
				log.debug("   ###   resetMbrPoint Error   ### : " + e.toString());
			}
		}else {
			log.debug("###  회원 : " + uniqueId + " 소멸 포인트 없음 ###");
		}
	}

	/**
	 * 관리자 회원 상세 종합 내역
	 * @param uniqueId
	 * @throws Exception
	 */
	public Map<String, Object> selectAlltypePoint(Map<String, Object> paramMap) throws Exception {
		return mbrPointDAO.selectAlltypePoint(paramMap);
	}
	
	/**
	 * 소멸 예정 안내 메일 발송 시 사용
	 */
	public List<MbrPointVO> selectExtinctPoinThisYear() throws Exception {
		return mbrPointDAO.selectExtinctPoinThisYear(new HashMap<String, Object>());
	}
}