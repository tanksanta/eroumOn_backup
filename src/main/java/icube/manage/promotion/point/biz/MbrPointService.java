package icube.manage.promotion.point.biz;

import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;
import icube.manage.mbr.mbr.biz.MbrDAO;
import icube.manage.mbr.mbr.biz.MbrPrtcrDAO;
import icube.manage.mbr.mbr.biz.MbrPrtcrVO;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.market.mbr.biz.MbrSession;

@Service("mbrPointService")
public class MbrPointService extends CommonAbstractServiceImpl {

	@Resource(name="mbrPointDAO")
	private MbrPointDAO mbrPointDAO;

	@Resource(name="mbrPrtcrDAO")
	private MbrPrtcrDAO mbrPrtcrDAO;

	@Resource(name="mbrDAO")
	private MbrDAO mbrDAO;

	@Autowired
	private MbrSession mbrSession;
	//TODO scheduler 소멸 포인트

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
	 * 포인트 사용
	 * @param Map
	 * @param ordr_no, ordr_dtl_cd, mlg(사용 마일리지), 회원 unique_id
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes","unchecked"})
	public void insertPointByUsed(Map<String, Object> paramMap) throws Exception {

		// 포인트 누계
		Map<String, Object> params = new HashMap();
		params.put("srchUniqueId", (String)paramMap.get("srchUniqueId"));
		MbrPointVO recentPointVO = this.selectMbrPoint(paramMap);
		int recentPoint = recentPointVO.getPointAcmtl();

		// 차감 내역 정보
		MbrPointVO mbrNewPointVO = new MbrPointVO();
		mbrNewPointVO.setUniqueId((String)paramMap.get("srchUniqueId"));
		mbrNewPointVO.setOrdrNo((Integer)paramMap.get("srchOrdrNo"));
		mbrNewPointVO.setOrdrDtlCd((String)paramMap.get("srchOrdrDtlCd"));
		mbrNewPointVO.setPointSe("M");
		mbrNewPointVO.setPointCn("3"); // 정해진 방향 x, 일단 상품구매 내역으로 FIX
		mbrNewPointVO.setPoint((Integer)paramMap.get("srchPoint"));
		mbrNewPointVO.setPointAcmtl(recentPoint - (Integer)paramMap.get("srchPoint"));

		// 사용자 정보
		mbrNewPointVO.setRegId(mbrSession.getMbrId());
		mbrNewPointVO.setRegUniqueId(mbrSession.getUniqueId());
		mbrNewPointVO.setRgtr(mbrSession.getMbrNm());

		mbrPointDAO.insertMbrPoint(mbrNewPointVO);
	}

	/**
	 * 이용 가능 포인트
	 * 이달 소멸 예정 포인트
	 * 가족회원 포인트
	 * @param uniqueId
	 * @return resultMap
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes","unchecked"})
	public Map<String, Object> selectTotalTypePoint(String uniqueId) throws Exception{
		Map<String, Object> resultMap = new HashMap();

		int availPoint = 0; //이용 가능 포인트
		int extTotalPoint = 0; // 소멸 예정 포인트
		int fmlPoint = 0; // 가족 회원 포인트


		Map<String, Object> paramMap = new HashMap();
		paramMap.put("srchUniqueId", uniqueId);

		// 포인트 적립 내역 화인
		int pointCount = this.selectMbrPointCount(paramMap);
		if(pointCount > 0) {
			// 이용 가능 포인트 (최근 누계)
			MbrPointVO mbrPointVO = this.selectMbrPoint(paramMap);
			availPoint = mbrPointVO.getPointAcmtl();

			// 2. 이달 소멸 예정 포인트
			List<MbrPointVO> mbrPointList = this.selectMbrPointList(paramMap);
			for(int i = 0; i < mbrPointList.size(); i ++) {

				LocalDate today = LocalDate.now(); //현재 날짜
				Date regDate = mbrPointList.get(i).getRegDt();
				LocalDate localRegDate = new java.sql.Date(regDate.getTime()).toLocalDate(); // 등록날짜

				if(localRegDate.getYear() < today.getYear()) {
					if(((localRegDate.getMonthValue() - (today.getMonthValue() +1 ))) < 0) {
						extTotalPoint = extTotalPoint + mbrPointList.get(i).getPoint();
					}
				}
			}
		}

		// 3. 가족 회원 마일리지
		paramMap.put("srchUniqueId", null);
		paramMap.put("srchMyUniqueId", uniqueId);
		paramMap.put("srchReqType", "F");
		List<MbrPrtcrVO> fmlList = mbrPrtcrDAO.selectPrtcrListByMap(paramMap);

		if(fmlList.size() > 0) {
			paramMap.put("srchUniqueId", uniqueId);
			for(int i=0; i < fmlList.size(); i ++) {
				// 자신이 수신한 경우 판별
				if(fmlList.get(i).getUniqueId().equals(uniqueId)) {
					paramMap.put("srchUniqueId", fmlList.get(i).getPrtcrUniqueId());
				}else {
					paramMap.put("srchUniqueId", fmlList.get(i).getUniqueId());
				}
				MbrPointVO mbrPointVO = mbrPointDAO.selectMbrPoint(paramMap);
				int point = 0;
				if(mbrPointVO !=null ) {
					point = mbrPointVO.getPointAcmtl();
				}

				fmlPoint = fmlPoint +point;
			}
		}

		resultMap.put("avail", availPoint);
		resultMap.put("exitPoint", extTotalPoint);
		resultMap.put("fmlPoint", fmlPoint);

		return resultMap;
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
	 * 포인트 종류별 합계
	 * @param uniqueId
	 * @return 총 포인트, 총 적립 포인트, 총 사용 포인트, 총 소멸 포인트 Map
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes","unchecked"})
	public Map<String, Integer> selectAlltypePoint(String uniqueId) throws Exception {
		Map<String, Integer> resultMap = new HashMap();
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("srchUniqueId", uniqueId);

		int totalPoint = 0;
		int totalAddPoint = 0;
		int totalDecPoint = 0;
		int totalExtPoint = 0;

		int pointCount = this.selectMbrPointCount(paramMap); // 내역 카운트
		paramMap.put("srchPointSe", "A");
		int addCount = this.selectMbrPointCount(paramMap); // 적립 카운트
		paramMap.put("srchPointSe", "M");
		int decCount = this.selectMbrPointCount(paramMap); // 사용 카운트
		paramMap.put("srchPointSe", "E");
		int extCount = this.selectMbrPointCount(paramMap); // 소멸 카운트

		if(pointCount > 0) {
			// 1. 총 가용 포인트
			paramMap.put("srchPointSe", null);
			MbrPointVO mbrPointVO = this.selectMbrPoint(paramMap);
			totalPoint = mbrPointVO.getPointAcmtl();
		}

		if(addCount > 0) {
			// 2. 총 적립 마일리지
			paramMap.put("srchPointSe", "A");
			totalAddPoint = this.selectSumPointByPointSe(paramMap);
		}

		if(decCount > 0) {
			// 3. 총 사용 마일리지
			paramMap.put("srchPointSe", "M");
			totalDecPoint = this.selectSumPointByPointSe(paramMap);
		}

		if(extCount > 0) {
			// 4. 총 소멸 마일리지
			paramMap.put("srchPointSe", "E");
			totalExtPoint = this.selectSumPointByPointSe(paramMap);
		}

		resultMap.put("totalPoint", totalPoint);
		resultMap.put("totalAddPoint", totalAddPoint);
		resultMap.put("totalDecPoint", totalDecPoint);
		resultMap.put("totalExtPoint", totalExtPoint);

		return resultMap;
	}

	/**
	 * 포인트 합계
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	private int selectSumPointByPointSe(Map<String, Object> paramMap) throws Exception{
		return mbrPointDAO.selectSumPointByPointSe(paramMap);
	}
}