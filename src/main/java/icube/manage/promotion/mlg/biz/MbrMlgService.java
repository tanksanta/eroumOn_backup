package icube.manage.promotion.mlg.biz;

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
import icube.market.mbr.biz.MbrSession;

@Service("mbrMlgService")
public class MbrMlgService extends CommonAbstractServiceImpl {

	@Resource(name="mbrMlgDAO")
	private MbrMlgDAO mbrMlgDAO;

	@Resource(name="mbrDAO")
	private MbrDAO mbrDAO;

	@Resource(name="mbrPrtcrDAO")
	private MbrPrtcrDAO mbrPrtcrDAO;

	@Autowired
	private MbrSession mbrSession;
	//TODO scheduler 소멸 포인트

	public CommonListVO mbrMlgListVO(CommonListVO listVO) throws Exception {
		return mbrMlgDAO.mbrMlgListVO(listVO);
	}

	/**
	 * 최근 마일리지 누계
	 * @param paramMap
	 * @return mlg
	 * @throws Exception
	 */
	public MbrMlgVO selectMbrMlg(Map<String, Object> paramMap) throws Exception {
		return mbrMlgDAO.selectMbrMlg(paramMap);
	}

	/**
	 * 마일리지 내역 등록
	 * @param mbrMlgVO
	 * @throws Exception
	 */
	public void insertMbrMlg(MbrMlgVO mbrMlgVO) throws Exception {
		mbrMlgDAO.insertMbrMlg(mbrMlgVO);
	}

	/**
	 * 마일리지 사용
	 * @param Map
	 * @param ordr_no, ordr_dtl_cd, mlg(사용 마일리지), 회원 unique_id
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes","unchecked"})
	public void insertMlgByUsed(Map<String, Object> paramMap) throws Exception {

		// 마일리지 누계
		Map<String, Object> params = new HashMap();
		params.put("srchUniqueId", (String)paramMap.get("srchUniqueId"));
		MbrMlgVO recentMlgVO = this.selectMbrMlg(params);
		int recentMlg = recentMlgVO.getMlgAcmtl();

		// 차감 내역 정보
		MbrMlgVO mbrNewMlgVO = new MbrMlgVO();
		mbrNewMlgVO.setUniqueId((String)paramMap.get("srchUniqueId"));
		//mbrNewMlgVO.setOrdrNo((Integer)paramMap.get("srchOrdrNo"));
		mbrNewMlgVO.setOrdrCd((String)paramMap.get("srchOrdrCd"));
		mbrNewMlgVO.setOrdrDtlCd((String)paramMap.get("srchOrdrDtlCd"));
		mbrNewMlgVO.setMlgSe("M");
		mbrNewMlgVO.setMlgCn("11"); // 정해진 방향 x, 일단 상품구매 내역으로 FIX
		mbrNewMlgVO.setMlg((Integer)paramMap.get("srchMlg"));
		mbrNewMlgVO.setMlgAcmtl(recentMlg - (Integer)paramMap.get("srchMlg"));

		// 사용자 정보
		mbrNewMlgVO.setRegId(mbrSession.getMbrId());
		mbrNewMlgVO.setRegUniqueId(mbrSession.getUniqueId());
		mbrNewMlgVO.setRgtr(mbrSession.getMbrNm());

		mbrMlgDAO.insertMbrMlg(mbrNewMlgVO);
	}

	/**
	 * 이용 가능 마일리지
	 * 이달 소멸 예정 마일리지
	 * 가족회원 마일리지
	 * @param uniqueId
	 * @return resultMap
	 * @throws Exception
	 */
	public Map<String, Object> selectTotalTypeMlg(String uniqueId) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		int availMlg = 0; //이용 가능 마일리지
		int extTotalMlg = 0; // 소멸 예정 마일리지
		int fmlMlg = 0; // 가족 회원 마일리지

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", uniqueId);


		// 마일리지 적립 내역 확인
		int mlgCount = this.selectMbrMlgCount(paramMap);

		if(mlgCount > 0) {
			// 이용 가능 마일리지 (최근 누계)
			MbrMlgVO mbrMlgVO = this.selectMbrMlg(paramMap);
			if(mbrMlgVO != null) {

			availMlg = mbrMlgVO.getMlgAcmtl();

			// 2. 이달 소멸 예정 마일리지
			List<MbrMlgVO> mbrMlgList = this.selectMbrMlgList(paramMap);
				for(int i = 0; i < mbrMlgList.size(); i ++) {

					LocalDate today = LocalDate.now(); //현재 날짜
					Date regDate = mbrMlgList.get(i).getRegDt();
					LocalDate localRegDate = new java.sql.Date(regDate.getTime()).toLocalDate(); // 등록날짜

					// 2022-12-14   2023-11-31
					if(localRegDate.getYear() < today.getYear()) { // true
						if(((localRegDate.getMonthValue() - (today.getMonthValue() +1 ))) < 0) {
							extTotalMlg = extTotalMlg + mbrMlgList.get(i).getMlg();
						}
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
				//TODO 메소드 수정
				MbrMlgVO mbrMlgVO = mbrMlgDAO.selectMbrMlg(paramMap);
				int mlg = 0;
				if(mbrMlgVO != null) {
					mlg = mbrMlgVO.getMlgAcmtl();
				}

				fmlMlg = fmlMlg + mlg;
			}
		}

		resultMap.put("avail", availMlg);
		resultMap.put("exitMlg", extTotalMlg);
		resultMap.put("fmlMlg", fmlMlg);

		return resultMap;
	}

	/**
	 * 마일리지 카운트
	 * @param uniqueId
	 * @return
	 * @throws Exception
	 */
	public int selectMbrMlgCount(Map<String, Object> paramMap) throws Exception {
		return mbrMlgDAO.selectMbrMlgCount(paramMap);
	}

	/**
	 * 마일리지 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<MbrMlgVO> selectMbrMlgList(Map<String, Object> paramMap) throws Exception {
		return mbrMlgDAO.selectMbrMlgList(paramMap);
	}

	/**
	 * 마일리지 종류별 합계
	 * @param uniqueId
	 * @return 총 마일리지, 총 적립 마일리지, 총 사용 마일리지, 총 소멸 마일리지 Map
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes","unchecked"})
	public Map<String, Integer> selectAlltypeMlg(String uniqueId) throws Exception {
		Map<String, Integer> resultMap = new HashMap();
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("srchUniqueId", uniqueId);

		int totalMlg = 0;
		int totalAddMlg = 0;
		int totalDecMlg = 0;
		int totalExtMlg = 0;

		int mlgCount = this.selectMbrMlgCount(paramMap); // 내역 카운트
		paramMap.put("srchMlgSe", "A");
		int addCount = this.selectMbrMlgCount(paramMap); // 적립 카운트
		paramMap.put("srchMlgSe", "M");
		int decCount = this.selectMbrMlgCount(paramMap); // 사용 카운트
		paramMap.put("srchMlgSe", "E");
		int extCount = this.selectMbrMlgCount(paramMap); // 소멸 카운트



		if(mlgCount > 0) {
			// 1. 총 가용 마일리지
			paramMap.put("srchMlgSe", null);
			MbrMlgVO mbrMlgVO = this.selectMbrMlg(paramMap);
			totalMlg = mbrMlgVO.getMlgAcmtl();
		}

		if(addCount > 0) {
			// 2. 총 적립 마일리지
			paramMap.put("srchMlgSe", "A");
			totalAddMlg = this.selectSumMlgByMlgSe(paramMap);
		}

		if(decCount > 0) {
			// 3. 총 사용 마일리지
			paramMap.put("srchMlgSe", "M");
			totalDecMlg = this.selectSumMlgByMlgSe(paramMap);
		}

		if(extCount > 0) {
			// 4. 총 소멸 마일리지
			paramMap.put("srchMlgSe", "E");
			totalExtMlg = this.selectSumMlgByMlgSe(paramMap);
		}

		resultMap.put("totalMlg", totalMlg);
		resultMap.put("totalAddMlg", totalAddMlg);
		resultMap.put("totalDecMlg", totalDecMlg);
		resultMap.put("totalExtMlg", totalExtMlg);

		return resultMap;
	}

	/**
	 * 마일리지 합계
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectSumMlgByMlgSe(Map<String, Object> paramMap) throws Exception {
		return mbrMlgDAO.selectSumMlgByMlgSe(paramMap);
	}

	/**
	 * 회원 소멸 마일리지
	 * @return
	 * @throws Exception
	 */
	public List<MbrMlgVO> selectMbrDedMlgList() throws Exception {
		return mbrMlgDAO.selectMbrDedMlgList();
	}

}