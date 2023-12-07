package icube.manage.mbr.mbr.biz;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.interceptor.biz.CustomProfileVO;
import icube.common.util.SHA256;
import icube.common.vo.CommonListVO;
import icube.main.test.biz.MbrTestService;
import icube.main.test.biz.MbrTestVO;
import icube.manage.consult.biz.MbrConsltService;
import icube.manage.consult.biz.MbrConsltVO;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;
import icube.manage.promotion.mlg.biz.MbrMlgDAO;
import icube.manage.promotion.mlg.biz.MbrMlgVO;
import icube.manage.promotion.point.biz.MbrPointDAO;
import icube.manage.promotion.point.biz.MbrPointVO;
import icube.market.mbr.biz.MbrSession;
import icube.membership.info.biz.DlvyDAO;

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
	
	@Resource(name = "mbrAgreementDAO")
	private MbrAgreementDAO mbrAgreementDAO;
	
	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;
	
	@Resource(name="mbrTestService")
    private MbrTestService mbrTestService;
	
	@Autowired
	private MbrSession mbrSession;
	
	@Value("#{props['Talk.Plugin.key']}")
	private String talkPluginKey;
	
	@Value("#{props['Talk.Secret.key']}")
	private String talkSecretKey;
	
	SimpleDateFormat dtFormat = new SimpleDateFormat("yy-MM-dd");
	

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

	public void deleteMbr(String uniqueId) throws Exception {
		mbrDAO.deleteMbr(uniqueId);
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
		mbrPointVO.setUniqueId((String)paramMap.get("srchUniqueId"));
		mbrPointVO.setPointSe("E");
		mbrPointVO.setPointCn(cn);
		mbrPointVO.setPoint(Integer.parseInt(String.valueOf(accmtMap.get("pointAcmtl"))));
		mbrPointVO.setPointAcmtl(0);
		mbrPointVO.setRgtr("System");
		mbrPointVO.setGiveMthd("SYS");

		// 마일리지
		MbrMlgVO mbrMlgVO = new MbrMlgVO();
		mbrMlgVO.setMlgMngNo(0);
		mbrMlgVO.setUniqueId((String)paramMap.get("srchUniqueId"));
		mbrMlgVO.setMlgSe("E");
		mbrMlgVO.setMlgCn(cn);
		mbrMlgVO.setMlg(Integer.parseInt(String.valueOf(accmtMap.get("mlgAcmtl"))));
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
	
	public void updateHumanMailYn(Map<String, Object> paramMap) throws Exception {
		mbrDAO.updateHumanMailYn(paramMap);
	}

	public void insertMbrAgreement(MbrAgreementVO mbrAgreementVO) throws Exception {
		mbrAgreementDAO.insertMbrAgreement(mbrAgreementVO);
	}
	
	public MbrAgreementVO selectMbrAgreementByMbrUniqueId(String uniqueId) throws Exception {
		return mbrAgreementDAO.selectMbrAgreementByMbrUniqueId(uniqueId);
	}
	
	// 간편 회원이면서 미등록자 조회
	public List<MbrVO> selectNotSnsRegistMbr() throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		return mbrDAO.selectNotSnsRegistMbr(paramMap);
	}
	
	
	/**
	 * 간편회원 전용 ID 생성 함수
	 */
	public String generateMbrId(String joinTy) throws Exception {
		String id = "";
		
		while ("".equals(id)) {
			id = "";
			for (int i = 0; i < 10; i++) {
				Random random = new Random();
				int num = random.nextInt(10);
				id += String.valueOf(num); 
			}
			
			//같은 ID가 있으면 다시 만들도록 처리
			MbrVO srchMbrVO = selectMbrById(id);
			if (srchMbrVO != null) {
				id = "";
			}
		}
		
		if ("K".equals(joinTy)) {
			id += "@K";
		} else if ("N".equals(joinTy)) {
			id += "@N";
		}
		
		return id;
	}
	
	
	/**
	 * 채널톡 고객프로필 연동데이터 추가 (GA4도 포함)
	 */
	public void setChannelTalk(HttpServletRequest request) throws Exception {
		
		if (mbrSession.isLoginCheck()) {
			CustomProfileVO customProfileVO = new CustomProfileVO();
			
			if (mbrSession.getCustomProfileVO() == null) {
				try {
					//고객프로필 데이터 셋팅
					MbrVO mbrVO = selectMbrByUniqueId(mbrSession.getUniqueId());
					customProfileVO.setMemberId(mbrVO.getMbrId());
					//회원 ID 해시하기
					customProfileVO.setMemberHash(SHA256.HmacEncrypt(mbrVO.getMbrId(), talkSecretKey));
					customProfileVO.setMbrNm(mbrVO.getMbrNm());
					customProfileVO.setMblTelno(mbrVO.getMblTelno());
					customProfileVO.setEml(mbrVO.getEml());
					customProfileVO.setUnsubscribeTexting(mbrVO.getSmsRcptnYn() != null && "Y".equals(mbrVO.getSmsRcptnYn()) ? false : true);
					customProfileVO.setUnsubscribeEmail(mbrVO.getEmlRcptnYn() != null && "Y".equals(mbrVO.getEmlRcptnYn()) ? false : true);
					
					//누적 상담 건수
					CommonListVO listVO = new CommonListVO(request);
					listVO.setParam("srchUseYn", "Y");
					listVO.setParam("srchUniqueId", mbrSession.getUniqueId());
					listVO = mbrConsltService.selectMbrConsltListVO(listVO);
					customProfileVO.setMbrConsltCnt(listVO.getListObject().size());
					
					//회원 수급자들의 테스트 정보
			    	List<MbrTestVO> mbrTestList = mbrTestService.selectMbrTestListByUniqueId(mbrSession.getUniqueId());
			    	customProfileVO.setExistTestResult(mbrTestList != null && mbrTestList.size() > 0 ? "O" : "X");
			   
			    	//회원의 수급자 정보
					List<MbrRecipientsVO> mbrRecipientList = mbrVO.getMbrRecipientsList();
			    	if (mbrRecipientList != null && mbrRecipientList.size() > 0) {
			    		//수급자 등록 여부
			    		customProfileVO.setRegisterRecipient(true);
			    		//L넘버값 유무
			    		MbrRecipientsVO recipient = mbrRecipientList.stream().filter(f -> "Y".equals(f.getRecipientsYn())).findAny().orElse(null);
			    		customProfileVO.setExistLNumber(recipient == null ? "X" : "O");
			    	} else {
			    		//수급자 등록 여부
			    		customProfileVO.setRegisterRecipient(false);
			    	 	//L넘버값 유무
			    		customProfileVO.setExistLNumber("X");
			    	}
			    	
			    	//회원의 상담 정보
			    	Map<String, Object> paramMap = new HashMap<>();
			    	paramMap.put("srchUniqueId", mbrSession.getUniqueId());
			    	List<MbrConsltVO> mbrConsltList = mbrConsltService.selectListForExcel(paramMap);
			    	customProfileVO.setExistConslt(mbrConsltList != null && mbrConsltList.size() > 0 ? "O" : "X");
			    	
			    	//쿠폰 보유 여부
			    	Map<String, Object> mbrEtcInfoMap = selectMbrEtcInfo(mbrSession.getUniqueId());
			    	customProfileVO.setCoupon(mbrEtcInfoMap.get("totalCoupon") != null && ((Long)mbrEtcInfoMap.get("totalCoupon")) > 0 ? true : false);
					//mbrEtcInfoMap.get("totalPoint")
					//mbrEtcInfoMap.get("totalMlg")
			    	
					mbrSession.setCustomProfileVO(customProfileVO);
					
					
					//채널톡 이벤트 처리(첫 로그인 처리)
					String joinTy = "K".equals(mbrVO.getJoinTy()) ? "kakao" : "N".equals(mbrVO.getJoinTy()) ? "naver" : "eroum";
					String recipientResist = mbrVO.getMbrRecipientsList() != null && mbrVO.getMbrRecipientsList().size() > 0 ? "O" : "X";
					Map<String, Object> channelTalkEvent = new HashMap<>();
					Map<String, Object> propertyObject = new HashMap<>();
					propertyObject.put("loginTy", joinTy);
					propertyObject.put("loginDate", dtFormat.format(mbrVO.getRecentCntnDt()));
					propertyObject.put("recipientResist", recipientResist);
					propertyObject.put("telNo", mbrVO.getMblTelno());
					
					channelTalkEvent.put("eventName", "view_loginsuccess");
					channelTalkEvent.put("propertyObj", propertyObject);
			      
					request.setAttribute("channelTalkEvent", channelTalkEvent);
					
					
					//GA4 이벤트 처리
					Map<String, Object> gaEvent = new HashMap<>();
					gaEvent.put("eventName", "view_loginsuccess");
					gaEvent.put("propertyObj", propertyObject);
					
					request.setAttribute("gaEvent", gaEvent);
				} catch (Exception ex) {
					log.error("===== Interceptor mbr 채널톡 정보 조회 오류", ex);
				}
			} else {
				customProfileVO = mbrSession.getCustomProfileVO();
			}
			
			
			//채널톡 이벤트 처리(회원가입)
			if (mbrSession.isRegistCheck()) {
				try {
					MbrVO mbrVO = selectMbrByUniqueId(mbrSession.getUniqueId());
					String joinTy = "K".equals(mbrVO.getJoinTy()) ? "kakao" : "N".equals(mbrVO.getJoinTy()) ? "naver" : "eroum";
					String recipientResist = mbrVO.getMbrRecipientsList() != null && mbrVO.getMbrRecipientsList().size() > 0 ? "O" : "X";
					
					Map<String, Object> channelTalkEvent2 = new HashMap<>();
					Map<String, Object> propertyObject2 = new HashMap<>();
					propertyObject2.put("mbrNm", mbrVO.getMbrNm());
					propertyObject2.put("joinDate", dtFormat.format(new Date()));
					propertyObject2.put("joinTy", joinTy);
					propertyObject2.put("recipientResist", recipientResist);
					
					channelTalkEvent2.put("eventName", "view_signupsuccess");
					channelTalkEvent2.put("propertyObj", propertyObject2);
			      
					request.setAttribute("channelTalkEvent", channelTalkEvent2);
					
					
					//GA4 이벤트 처리
					Map<String, Object> gaEvent = new HashMap<>();
					gaEvent.put("eventName", "view_signupsuccess");
					gaEvent.put("propertyObj", propertyObject2);
					
					request.setAttribute("gaEvent", gaEvent);
					
					
					mbrSession.setRegistCheck(false);
				} catch (Exception ex) {
					log.error("===== Interceptor mbr 채널톡 정보 조회 오류", ex);
				}
			}
			
			
			request.setAttribute("customProfileVO", customProfileVO);
		}
		
		//채널톡 pluginKey 셋팅
		request.setAttribute("talkPluginKey", talkPluginKey);
	}
}