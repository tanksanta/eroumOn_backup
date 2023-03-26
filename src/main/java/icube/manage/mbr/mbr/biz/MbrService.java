package icube.manage.mbr.mbr.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@SuppressWarnings({"unchecked","rawtypes"})
@Service("mbrService")
public class MbrService extends CommonAbstractServiceImpl {

	@Resource(name="mbrDAO")
	private MbrDAO mbrDAO;

	public CommonListVO mbrListVO(CommonListVO listVO) throws Exception {
		return mbrDAO.mbrListVO(listVO);
	}

	public List<MbrVO> selectMbrListAll(Map paramMap) throws Exception {
		return mbrDAO.selectMbrListAll(paramMap);
	}

	/**
	 * 회원 상세정보 by Map
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public MbrVO selectMbr(Map<String, Object> paramMap) throws Exception{
		return mbrDAO.selectMbr(paramMap);
	}

	public MbrVO selectMbrById(String mbrId) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchMbrId", mbrId);
		return this.selectMbr(paramMap);
	}
	public MbrVO selectMbrByUniqueId(String uniqueId) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", uniqueId);
		return this.selectMbr(paramMap);
	}


	public void insertMbr(MbrVO mbrVO) throws Exception {
		mbrDAO.insertMbr(mbrVO);
	}

	public void updateMbr(MbrVO mbrVO) throws Exception {
		mbrDAO.updateMbr(mbrVO);
	}

	public void deleteMbr(String string) throws Exception {
		mbrDAO.deleteMbr(string);
	}


	/**
	 * 아이디 체크
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public Integer selectMbrIdChk(String mbrId) throws Exception{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("mbrId", mbrId);
		return mbrDAO.selectMbrIdChk(paramMap);
	}

	public void updateChoiceYn(Map<String, String> reqMap) throws Exception{
		Map paramMap = new HashMap();
		paramMap.put("uniqueId", reqMap.get("uniqueId"));
		paramMap.put("smsYn", reqMap.get("smsYn"));
		paramMap.put("emlYn", reqMap.get("emlYn"));
		paramMap.put("telYn", reqMap.get("telYn"));

		mbrDAO.updateChoiceYn(paramMap);
	}

	public void updatePrvc(Map<String, String> reqMap) throws Exception {
		Map paramMap = new HashMap();
		paramMap.put("uniqueId", reqMap.get("uniqueId"));
		paramMap.put("prvcVldPd", reqMap.get("prvc"));

		mbrDAO.updatePrvc(paramMap);
	}

	public void updateEvent(Map<String, String> reqMap) throws Exception {
		Map paramMap = new HashMap();
		paramMap.put("uniqueId", reqMap.get("uniqueId"));
		paramMap.put("eventRecptnYn", reqMap.get("eventYn"));

		mbrDAO.updateEvent(paramMap);
	}

	public void updateFailedLoginCountReset(MbrVO mbrVO) throws Exception {
		mbrDAO.updateFailedLoginCountReset(mbrVO);
	}

	public int getFailedLoginCountWithCountUp(MbrVO mbrVO) throws Exception {
		mbrDAO.updateFailedLoginCountUp(mbrVO);
		return selectFailedLoginCount(mbrVO);
	}

	private int selectFailedLoginCount(MbrVO mbrVO) throws Exception {
		return mbrDAO.selectFailedLoginCount(mbrVO);
	}

	/**
	 * 회원 비밀번호 업데이트
	 * @param mbrVO
	 * @throws Exception
	 */
	public void updateMbrPswd(MbrVO mbrVO) throws Exception{
		mbrDAO.updateMbrPswd(mbrVO);
	}

	/**
	 * 회원 휴면계정 해제
	 * @param paramMap
	 * @throws Exception
	 */
	public void updateRlsDrmt(Map paramMap) throws Exception{
		mbrDAO.updateRlsDrmt(paramMap);
	}

	/**
	 * 회원 탈퇴
	 * @param paramMap
	 * @throws Exception
	 */
	public void updateExitMbr(Map<String, Object> paramMap) throws Exception{
		mbrDAO.updateExitMbr(paramMap);
	}

	/**
	 * 마이페이지 정보 수정
	 * @param mbrVO
	 * @throws Exception
	 */
	public void updateMbrInfo(MbrVO mbrVO) throws Exception{
		mbrDAO.updateMbrInfo(mbrVO);
	}

	// 회원 기타정보 (급여잔액, 마일리지, 포인트)
	public Map<String, Object> selectMbrEtcInfo(String uniqueId) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", uniqueId);
		return mbrDAO.selectMbrEtcInfo(paramMap);
	}

	/**
	 * 최근 접속 일시 업데이트
	 * @param uniqueId
	 * @throws Exception
	 */
	public void updateRecentDt(String uniqueId) throws Exception {
		mbrDAO.updateRecentDt(uniqueId);
	}

	public int selectMbrCount(Map paramMap) throws Exception {
		return mbrDAO.selectMbrCount(paramMap);
	}

	public int selectBrdtMbrCount() throws Exception{
		return mbrDAO.selectBrdtMbrCount();
	}

	public MbrVO selectMbrIdByOne(String rcmdtnId) throws Exception {
		return mbrDAO.selectMbrIdByOne(rcmdtnId);
	}

	public void updateMberSttus(Map<String, Object> paramMap) throws Exception {
		mbrDAO.updateMberSttus(paramMap);
	}

	public int selectMbrSumPc(Map<String, Object> paramMap) throws Exception {
		return mbrDAO.selectMbrSumPc(paramMap);
	}


}