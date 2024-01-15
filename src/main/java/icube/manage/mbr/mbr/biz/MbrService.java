package icube.manage.mbr.mbr.biz;

import java.security.PrivateKey;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.interceptor.biz.CustomProfileVO;
import icube.common.util.RSA;
import icube.common.util.SHA256;
import icube.common.util.WebUtil;
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
import icube.membership.info.biz.DlvyVO;

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
	
	@Resource(name = "mbrMngInfoService")
	private MbrMngInfoService mbrMngInfoService;
	
	@Resource(name = "mbrAgreementDAO")
	private MbrAgreementDAO mbrAgreementDAO;
	
	@Resource(name = "mbrAuthService")
	private MbrAuthService mbrAuthService;
	
	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;
	
	@Resource(name="mbrTestService")
    private MbrTestService mbrTestService;
	
	@Autowired
	private MbrSession mbrSession;
	
	@Value("#{props['Globals.Main.path']}")
	private String mainPath;
	
	@Value("#{props['Globals.Membership.path']}")
	private String membershipPath;
	
	@Value("#{props['Globals.Matching.path']}")
	private String matchingPath;
	
	@Value("#{props['Talk.Plugin.key']}")
	private String talkPluginKey;
	
	@Value("#{props['Talk.Secret.key']}")
	private String talkSecretKey;
	
	private static final String RSA_MEMBERSHIP_KEY = "__rsaMembersKey__";
	
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
					
					//간편회원이면서 본인인증 안헀으면 채널톡처리를 하지 않음
					if (!"E".equals(mbrVO.getJoinTy()) && mbrVO.getSnsRegistDt() == null) {
						return;
					}
					
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
	
	
	/**
	 * 일반 로그인 유효성 검사 
	 */
	public Map<String, Object> validateForEroumLogin(String mbrId, String encPw, HttpSession session) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("valid", false);
		
		PrivateKey rsaKey = (PrivateKey) session.getAttribute(RSA_MEMBERSHIP_KEY);
		String decPw = RSA.decryptRsa(rsaKey, encPw);
		if (EgovStringUtil.isEmpty(decPw)) {
			resultMap.put("msg", "패스워드 복호화에 실패하였습니다.");
			return resultMap;
		}
		
		mbrId = WebUtil.clearSqlInjection(mbrId);
		decPw = WebUtil.clearSqlInjection(decPw);
		
		MbrAuthVO srchMbrAuthVO = mbrAuthService.selectMbrAuthByMbrId(mbrId);
		if (srchMbrAuthVO == null) {
			resultMap.put("msg", "존재하지 않는 회원입니다.");
			return resultMap;
		}
		MbrVO srchMbrVO = selectMbrIdByOne(mbrId.toLowerCase());
		resultMap.put("srchMbrVO", srchMbrVO);
		
		int failCount = srchMbrVO.getLgnFailrCnt();
		if (failCount > 4) {
			resultMap.put("msg", "비밀번호를 5회 이상 틀렸습니다.");
			resultMap.put("code", "EROUM_FAIL_PWD");
			return resultMap;
		}
		
		//회원 인증의 패스워드 검사
		boolean passwordCheck = BCrypt.checkpw(decPw, srchMbrAuthVO.getPswd());
		if (!passwordCheck) {
			getFailedLoginCountWithCountUp(srchMbrVO);
			resultMap.put("msg", "비밀번호가 일치 하지 않습니다.");
			return resultMap;
		}
		
		if ("EXIT".equals(srchMbrVO.getMberSttus())) {
			resultMap.put("msg", "탈퇴한 회원입니다.");
			return resultMap;
		}
		
		if ("HUMAN".equals(srchMbrVO.getMberSttus())) {
			resultMap.put("msg", "휴면 회원입니다.");
			resultMap.put("code", "EROUM_HUMAN");
			return resultMap;
		}
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", srchMbrVO.getUniqueId());
		MbrMngInfoVO mbrMngInfoVO = mbrMngInfoService.selectMbrMngInfo(paramMap);
		if (mbrMngInfoVO != null && "BLACK".equals(mbrMngInfoVO.getMngTy()) && !"NONE".equals(mbrMngInfoVO.getMngSe())) {
			if ("PAUSE".equals(mbrMngInfoVO.getMngSe())) {
				resultMap.put("msg", "일시정지된 회원입니다.");
				return resultMap;
			}
			else if ("UNLIMIT".equals(mbrMngInfoVO.getMngSe())) {
				resultMap.put("msg", "영구정지된 회원입니다.");
				return resultMap;
			}
		}
		
		resultMap.put("valid", true);
		return resultMap;
	}
	
	/**
	 * 간편 로그인 유효성 검사 및 redirect 또는 로그인 처리
	 */
	public Map<String, Object> validateForSnsLogin(HttpSession session, MbrVO snsUserInfo) throws Exception {
		//어떤 로그인으로 시도하는지 확인(카카오, 네이버)
		String joinTy = snsUserInfo.getJoinTy();
 		String mblTelno = snsUserInfo.getMblTelno();
 		String prevPath = (String)session.getAttribute("prevSnsPath");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("valid", false);
		String rootPath = "membership".equals(prevPath) ? ("/" + mainPath) : ("/" + matchingPath);
		String membershipRootPath = "membership".equals(prevPath) ? ("/" + membershipPath) : rootPath;
		String registPath = "membership".equals(prevPath) ? (membershipRootPath + "/regist") : (rootPath + "/login");
		
		//번호로 회원 검색
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchMblTelno", mblTelno);
		paramMap.put("srchMbrStts", "NORMAL");
		List<MbrVO> mbrList = selectMbrListAll(paramMap);
		
		//가입정보가 2개 이상인 경우 오류 처리
		if (mbrList.size() > 1) {
			resultMap.put("srchMbrVO", new MbrVO());
			resultMap.put("msg", "동일한 가입 정보가 1건 이상 존재합니다. 관리자에게 문의바랍니다.");
			resultMap.put("location", registPath);
			return resultMap;
		}
		//회원이 없으면 회원가입 처리하도록 셋팅
		else if (mbrList == null || mbrList.size() < 1) {
			//해당 kakao, naver 계정으로 가입된 회원이 있는지 확인
			Map<String, Object> authParamMap = new HashMap<String, Object>();
			if ("K".equals(joinTy)) {
				authParamMap.put("srchKakaoAppId", snsUserInfo.getKakaoAppId());
			}
			else if ("N".equals(joinTy)) {
				authParamMap.put("srchNaverAppId", snsUserInfo.getNaverAppId());
			}
			List<MbrAuthVO> srchMbrAuthList = mbrAuthService.selectMbrAuthListAll(authParamMap);
			if (srchMbrAuthList.size() > 0) {
				resultMap.put("srchMbrVO", new MbrVO());
				resultMap.put("msg", "동일한 가입 정보가 1건 이상 존재합니다. 관리자에게 문의바랍니다");
				resultMap.put("location", registPath);
			}
			return resultMap;
		}
		
		
		MbrVO srchMbrVO = mbrList.get(0);
		resultMap.put("srchMbrVO", srchMbrVO);
		
		//탈퇴와 휴면회원은 나올수가 없다 (위에 NORMAL만 검색)
//		if ("EXIT".equals(srchMbrVO.getMberSttus())) {
//			resultMap.put("msg", "탈퇴한 회원입니다.");
//			resultMap.put("location", rootPath);
//			return resultMap;
//		}
//		if ("HUMAN".equals(srchMbrVO.getMberSttus())) {
//			resultMap.put("msg", "휴면 회원입니다.");
//			if ("membership".equals(prevPath)) {
//				resultMap.put("location", "/" + membershipPath + "/drmt/view?mbrId=" + srchMbrVO.getMbrId());
//			} else if ("matching".equals(prevPath)) {
//				resultMap.put("location", rootPath);
//			}
//			return resultMap;
//		}
		
		Map<String, Object> infoParamMap = new HashMap<String, Object>();
		infoParamMap.put("srchUniqueId", srchMbrVO.getUniqueId());
		MbrMngInfoVO mbrMngInfoVO = mbrMngInfoService.selectMbrMngInfo(infoParamMap);
		if (mbrMngInfoVO != null && "BLACK".equals(mbrMngInfoVO.getMngTy()) && !"NONE".equals(mbrMngInfoVO.getMngSe())) {
			if ("PAUSE".equals(mbrMngInfoVO.getMngSe())) {
				resultMap.put("msg", "일시정지된 회원입니다.");
				resultMap.put("location", registPath);
				return resultMap;
			}
			else if ("UNLIMIT".equals(mbrMngInfoVO.getMngSe())) {
				resultMap.put("msg", "영구정지된 회원입니다.");
				resultMap.put("location", registPath);
				return resultMap;
			}
		}
		
		//해당 회원이 본인 인증을 아직 안함 계정인 경우
		if (srchMbrVO.getSnsRegistDt() == null) {
			//회원가입 시도한 유형과 다르다면
			if (!joinTy.equals(srchMbrVO.getJoinTy())) {
				if ("K".equals(srchMbrVO.getJoinTy())) {
					resultMap.put("msg", "현재 카카오 계정으로 간편 가입 진행 중입니다.");
					resultMap.put("location", registPath);
				} else if ("N".equals(srchMbrVO.getJoinTy())) {
					resultMap.put("msg", "현재 네이버 계정으로 간편 가입 진행 중입니다.");
					resultMap.put("location", registPath);
				}
			}
			//본인 인증창으로 이동
			else {
				resultMap.put("location", membershipRootPath + "/sns/regist?uid=" + srchMbrVO.getUniqueId());
			}
			return resultMap;
		}
		
		//해당 인증수단이 존재하는지 확인
		List<MbrAuthVO> authList = mbrAuthService.selectMbrAuthByMbrUniqueId(srchMbrVO.getUniqueId());
		MbrAuthVO mbrAuthVO = authList.stream().filter(auth -> joinTy.equals(auth.getJoinTy())).findFirst().orElse(null);
		//인증수단이 없으면 안내메시지
		if (mbrAuthVO == null) {
			if ("K".equals(joinTy)) {
				resultMap.put("msg", "카카오 인증이 등록되지 않는 회원 입니다.");
			} else if ("N".equals(joinTy)) {
				resultMap.put("msg", "네이버 인증이 등록되지 않는 회원 입니다.");
			}
			resultMap.put("location", registPath);
			return resultMap;
		}
		else {
			//인증수단이 등록되었지만 계정이 다르다면
			if ("K".equals(joinTy) && !EgovStringUtil.equals(snsUserInfo.getKakaoAppId(), mbrAuthVO.getKakaoAppId())) {
				resultMap.put("msg", "등록하신 카카오 계정과 일치하지 않습니다.");
				resultMap.put("location", registPath);
				return resultMap;
			} else if ("N".equals(joinTy) && !EgovStringUtil.equals(snsUserInfo.getNaverAppId(), mbrAuthVO.getNaverAppId())) {
				resultMap.put("msg", "등록하신 네이버 계정과 일치하지 않습니다.");
				resultMap.put("location", registPath);
				return resultMap;
			}
		}
		
			
		//최근 접속일 갱신
		updateRecentDt(srchMbrVO.getUniqueId());
		
		//로그인 처리
		mbrSession.setParms(srchMbrVO, true);
		mbrSession.setMbrInfo(session, mbrSession);
		
		//해당 회원이 본인인증을 하지 않은 상태일 때 본인인증 창으로 이동(session에 담겨있어야 하므로 여기에 위치)
		if (srchMbrVO.getSnsRegistDt() == null) {
			String snsRegistPath = "membership".equals(prevPath) ? (membershipRootPath + "/sns/regist?uid=" + srchMbrVO.getUniqueId()) : (rootPath + "/login");
			resultMap.put("location", snsRegistPath);
			session.removeAttribute("returnUrl");
			return resultMap;
		}
		
		resultMap.put("valid", true);
		return resultMap;
	}
	
	/**
	 * 간편 로그인 회원가입 및 로그인 처리
	 */
	public void registerSnsMbrAndLogin(HttpSession session, MbrVO mbrVO, DlvyVO dlvyVO) throws Exception {
		if (dlvyVO != null) {
			mbrVO.setZip(dlvyVO.getZip());
			mbrVO.setAddr(dlvyVO.getAddr());
			mbrVO.setDaddr(dlvyVO.getDaddr());
			
			dlvyVO.setMblTelno(mbrVO.getMblTelno());
		}
		
		insertMbr(mbrVO);
		//본인 인증 단계에서 주소정보 저장되므로 사용안함
//		if (dlvyVO != null) {
//			dlvyVO.setUniqueId(mbrVO.getUniqueId());
//			dlvyService.insertBassDlvy(dlvyVO);
//		}
		
		//로그인 처리
		mbrSession.setParms(mbrVO, true);
		mbrSession.setMbrInfo(session, mbrSession);
	}
	
	
	/**
	 * 간편 로그인 재인증 확인
	 */
	public JavaScript reAuthCheck(String joinTy, MbrVO userInfo, HttpSession session) throws Exception {
		JavaScript javaScript = new JavaScript();
		
		// 재인증 확인		
		String checkId = "K".equals(joinTy) ? userInfo.getKakaoAppId() : userInfo.getNaverAppId();
		String mbrSnsId = "K".equals(joinTy) ? mbrSession.getKakaoAppId() : mbrSession.getNaverAppId();
		log.debug("### 재인증 진행 ###" + mbrSnsId + "//" + checkId);

		if(EgovStringUtil.equals(mbrSnsId, checkId)) {
			session.setAttribute("infoStepChk", "EASYLOGIN");
			
			String requestView = (String)session.getAttribute("requestView");
			if (EgovStringUtil.isNotEmpty(requestView) && "whdwl".equals(requestView)) {
				String resnCn = (String)session.getAttribute("resnCn");
				String whdwlEtc = (String)session.getAttribute("whdwlEtc");
				
				javaScript.setLocation("/" + membershipPath + "/info/whdwl/action?resnCn=" + resnCn + "&whdwlEtc=" + whdwlEtc);
			} else {
				javaScript.setLocation("/" + membershipPath + "/info/myinfo/form");
			}
		} else {
			javaScript.setMessage("소셜 정보가 불일치 합니다. 인증에 실패하였습니다.");
			javaScript.setLocation("/" + membershipPath + "/info/myinfo/confirm");
		}
		
		return javaScript;
	}
}