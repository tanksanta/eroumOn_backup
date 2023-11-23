package icube.manage.promotion.mlg.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;
import icube.manage.mbr.mbr.biz.MbrDAO;
import icube.market.mbr.biz.MbrSession;

@Service("mbrMlgService")
public class MbrMlgService extends CommonAbstractServiceImpl {

	@Resource(name="mbrMlgDAO")
	private MbrMlgDAO mbrMlgDAO;

	@Resource(name="mbrDAO")
	private MbrDAO mbrDAO;

	@Autowired
	private MbrSession mbrSession;

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
	 * 회원 마일리지 소멸 (매일 실행되는 소멸 schedule)
	 * 유효기간 : 적립일 기준 2년
	 * @param uniqueId
	 * @throws Exception
	 */
	public void extinctMbrMlg(String uniqueId) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchTwoYear", 1);
		paramMap.put("srchUniqueId", uniqueId);
		Map<String, Object> mlgMap = this.selectAlltypeMlg(paramMap);

		int ownMlg = Integer.parseInt(String.valueOf(mlgMap.get("ownMlg")));
		int totalAccmtMlg = Integer.parseInt(String.valueOf(mlgMap.get("addMlg")));
		int totalUseMlg = Integer.parseInt(String.valueOf(mlgMap.get("useMlg")));
		int totalExtMlg = Integer.parseInt(String.valueOf(mlgMap.get("extMlg")));
		int restMlg = totalAccmtMlg - (totalUseMlg + totalExtMlg);

		if(restMlg > 0) {
			MbrMlgVO mbrMlgVO = new MbrMlgVO();
			mbrMlgVO.setMlgMngNo(0);
			mbrMlgVO.setUniqueId(uniqueId);
			mbrMlgVO.setMlgSe("E");
			mbrMlgVO.setMlg(restMlg);
			mbrMlgVO.setMlgCn("15");
			mbrMlgVO.setMlgAcmtl(ownMlg - restMlg);
			mbrMlgVO.setRgtr("System");
			mbrMlgVO.setGiveMthd("SYS");

			try {
				mbrMlgDAO.extinctMbrMlg(mbrMlgVO);
			}catch(Exception e) {
				log.debug("   ###   resetMbrMlg Error   ### : " + e.toString());
			}
		}else {
			log.debug("###  회원 : " + uniqueId + " 소멸 마일리지 없음 ###");
		}
	}

	/**
	 * 마일리지 종합
	 * @param uniqueId
	 * @return mlgMap
	 * @throws Exception
	 */
	public Map<String, Object> selectAlltypeMlg(Map<String, Object> paramMap) throws Exception {
		return mbrMlgDAO.selectAlltypeMlg(paramMap);
	}

	//소멸 안내 이메일 발송 처리
	public void updateExtinctMlgMail() throws Exception {
		mbrMlgDAO.updateExtinctMlgMail(new HashMap<>());
	}
	
	//마일리지 소멸 여부 처리
	public void updateExtinctMlgAction() throws Exception {
		mbrMlgDAO.updateExtinctMlgAction(new HashMap<>());
	}
}