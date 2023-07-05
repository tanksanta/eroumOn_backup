package icube.manage.mbr.mbr.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;
import icube.manage.promotion.mlg.biz.MbrMlgDAO;
import icube.manage.promotion.mlg.biz.MbrMlgVO;
import icube.manage.promotion.point.biz.MbrPointDAO;
import icube.manage.promotion.point.biz.MbrPointVO;
import icube.market.mypage.info.biz.DlvyDAO;

@Service("mbrService")
public class MbrService extends CommonAbstractServiceImpl {

	@Resource(name = "mbrDAO")
	private MbrDAO mbrDAO;
	
	@Resource(name = "dlvyDAO")
	private DlvyDAO dlvyDAO;

	@Resource(name = "mbrPointDAO")
	private MbrPointDAO mbrPointDAO;

	@Resource(name = "mbrMlgDAO")
	private MbrMlgDAO mbrMlgDAO;

	public CommonListVO mbrListVO(CommonListVO listVO) throws Exception {
		return mbrDAO.mbrListVO(listVO);
	}

	public List<MbrVO> selectMbrListAll(Map<String, Object> paramMap) throws Exception {
		return mbrDAO.selectMbrListAll(paramMap);
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
	 * 회원 상세정보 by Map
	 * @param paramMap
	 * @throws Exception
	 */
	public MbrVO selectMbr(Map<String, Object> paramMap) throws Exception{
		return mbrDAO.selectMbr(paramMap);
	}

	/**
	 * 회원 아이디 조회
	 * @param mbrId
	 * @see LIKE CONCAT
	 * @throws Exception
	 */
	public MbrVO selectMbrById(String mbrId) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchMbrId", mbrId);
		return this.selectMbr(paramMap);
	}

	/**
	 * 회원 유니크 아이디 조회
	 * @param uniqueId
	 * @see LIKE CONCAT
	 * @throws Exception
	 */
	public MbrVO selectMbrByUniqueId(String uniqueId) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", uniqueId);
		return this.selectMbr(paramMap);
	}

	/**
	 * 아이디 체크
	 * @param paramMap
	 * @throws Exception
	 */
	public Integer selectMbrIdChk(String mbrId) throws Exception{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("mbrId", mbrId);
		return mbrDAO.selectMbrIdChk(paramMap);
	}

	/**
	 * 로그인 실패 카운트
	 * @param mbrVO
	 * @throws Exception
	 */
	private int selectFailedLoginCount(MbrVO mbrVO) throws Exception {
		return mbrDAO.selectFailedLoginCount(mbrVO);
	}

	/**
	 * 회원 기타정보 (급여잔액, 마일리지, 포인트)
	 * @param uniqueId
	 * @throws Exception
	 */
	public Map<String, Object> selectMbrEtcInfo(String uniqueId) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", uniqueId);
		return mbrDAO.selectMbrEtcInfo(paramMap);
	}

	/**
	 * 회원 카운트
	 * @param paramMap
	 * @throws Exception
	 */
	public int selectMbrCount(Map<String, Object> paramMap) throws Exception {
		return mbrDAO.selectMbrCount(paramMap);
	}

	/**
	 * 생일자 카운트
	 * @return
	 * @throws Exception
	 */
	public int selectBrdtMbrCount() throws Exception{
		return mbrDAO.selectBrdtMbrCount();
	}

	/**
	 * 회원 selectOne
	 * @param rcmdtnId
	 * @return
	 * @throws Exception
	 */
	public MbrVO selectMbrIdByOne(String rcmdtnId) throws Exception {
		return mbrDAO.selectMbrIdByOne(rcmdtnId);
	}

	/**
	 * 누적 결제 금액 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectMbrSumPc(Map<String, Object> paramMap) throws Exception {
		return mbrDAO.selectMbrSumPc(paramMap);
	}

	/**
	 * 회원 보유, 소멸예정 마일리지, 포인트
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectOwnAccmt(Map<String, Object> paramMap) throws Exception {
		return mbrDAO.selectOwnAccmt(paramMap);
	}

	/**
	 * 회원 선택정보 업데이트
	 * @param reqMap
	 * @throws Exception
	 */
	public void updateChoiceYn(Map<String, String> reqMap) throws Exception{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("uniqueId", reqMap.get("uniqueId"));
		paramMap.put("smsYn", reqMap.get("smsYn"));
		paramMap.put("emlYn", reqMap.get("emlYn"));
		paramMap.put("telYn", reqMap.get("telYn"));

		mbrDAO.updateChoiceYn(paramMap);
	}

	/**
	 * 회원 약관동의 일시 업데이트
	 * @param reqMap
	 * @throws Exception
	 */
	public void updatePrvc(Map<String, String> reqMap) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("uniqueId", reqMap.get("uniqueId"));
		paramMap.put("prvcVldPd", reqMap.get("prvc"));

		mbrDAO.updatePrvc(paramMap);
	}

	/**
	 * 이벤트 수신 동의
	 * @param reqMap
	 * @throws Exception
	 */
	public void updateEvent(Map<String, String> reqMap) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("uniqueId", reqMap.get("uniqueId"));
		paramMap.put("eventRecptnYn", reqMap.get("eventYn"));

		mbrDAO.updateEvent(paramMap);
	}

	/**
	 * 로그인 실패 카운트 초기화
	 * @param mbrVO
	 * @throws Exception
	 */
	public void updateFailedLoginCountReset(MbrVO mbrVO) throws Exception {
		mbrDAO.updateFailedLoginCountReset(mbrVO);
	}

	/**
	 * 로그인 실패 카운트 ++1
	 * @param mbrVO
	 * @return
	 * @throws Exception
	 */
	public int getFailedLoginCountWithCountUp(MbrVO mbrVO) throws Exception {
		mbrDAO.updateFailedLoginCountUp(mbrVO);
		return selectFailedLoginCount(mbrVO);
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
	public void updateRlsDrmt(Map<String, Object> paramMap) throws Exception{
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

	/**
	 * 최근 접속 일시 업데이트
	 * @param uniqueId
	 * @throws Exception
	 */
	public void updateRecentDt(String uniqueId) throws Exception {
		mbrDAO.updateRecentDt(uniqueId);
	}

	/**
	 * 회원 상태 업데이트
	 * @param paramMap
	 * @throws Exception
	 */
	public void updateMberSttus(Map<String, Object> paramMap) throws Exception {
		mbrDAO.updateMberSttus(paramMap);
	}

	/**
	 * 회원 DI Key 업데이트
	 * @param paramMap
	 * @throws Exception
	 */
	public void updateDiKey(Map<String, Object> paramMap) throws Exception {
		mbrDAO.updateDiKey(paramMap);
	}

	/**
	 * 회원 등급 업데이트
	 * @param paramMap
	 * @throws Exception
	 */
	public Integer updateMberGrade(Map<String, Object> paramMap) throws Exception {
		return mbrDAO.updateMberGrade(paramMap);
	}

	/**
	 * 회원 전환시 포인트, 마일리지 소멸
	 * @param uniqueId
	 * @param mberStts
	 * @throws Exception
	 */
	public void resetMemberShip(Map<String, Object> paramMap) throws Exception{
		String cn = "99";
		Map<String, Object> accmtMap = this.selectOwnAccmt(paramMap);

		switch((String)paramMap.get("mberStts")){
		case "HUMAN":
			cn = "16";
			break;
		case "BLACK":
			cn = "17";
			break;
		case "EXIT":
			cn = "18";
			break;
		default:
			break;
		}

		// 포인트
		MbrPointVO mbrPointVO = new MbrPointVO();
		mbrPointVO.setPointMngNo(0);
		mbrPointVO.setUniqueId((String)paramMap.get("uniqueId"));
		mbrPointVO.setPointSe("E");
		mbrPointVO.setPointCn(cn);
		mbrPointVO.setPoint(Integer.parseInt(String.valueOf(accmtMap.get("ownPoint"))));
		mbrPointVO.setPointAcmtl(0);
		mbrPointVO.setRgtr("System");
		mbrPointVO.setGiveMthd("SYS");

		// 마일리지
		MbrMlgVO mbrMlgVO = new MbrMlgVO();
		mbrMlgVO.setMlgMngNo(0);
		mbrMlgVO.setUniqueId((String)paramMap.get("uniqueId"));
		mbrMlgVO.setMlgSe("E");
		mbrMlgVO.setMlgCn(cn);
		mbrMlgVO.setMlg(Integer.parseInt(String.valueOf(accmtMap.get("ownMlg"))));
		mbrMlgVO.setMlgAcmtl(0);
		mbrMlgVO.setRgtr("System");
		mbrMlgVO.setGiveMthd("SYS");



		mbrPointDAO.extinctMbrPoint(mbrPointVO);
		mbrMlgDAO.extinctMbrMlg(mbrMlgVO);
		}

	public void updateKaKaoInfo(MbrVO mbrVO) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", mbrVO.getUniqueId());
		paramMap.put("eml", mbrVO.getEml());
		paramMap.put("mblTelno", mbrVO.getMblTelno());
		
		mbrDAO.updateKaKaoInfo(paramMap);
		
	}

	public Integer updateMbrAddr(Map<String, Object> paramMap) throws Exception {
		return mbrDAO.updateMbrAddr(paramMap);
	}

}