package icube.manage.mbr.mbr.biz;

import java.security.PrivateKey;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Service;

import icube.app.matching.membership.mbr.biz.MatMbrSession;
import icube.common.api.biz.BiztalkConsultService;
import icube.common.api.biz.BootpayApiService;
import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.framework.view.JavaScript;
import icube.common.interceptor.biz.CustomProfileVO;
import icube.common.mail.MailService;
import icube.common.util.DateUtil;
import icube.common.util.FileUtil;
import icube.common.util.RSA;
import icube.common.util.SHA256;
import icube.common.util.ValidatorUtil;
import icube.common.util.WebUtil;
import icube.common.vo.CommonListVO;
import icube.main.test.biz.MbrTestService;
import icube.main.test.biz.MbrTestVO;
import icube.manage.consult.biz.MbrConsltService;
import icube.manage.consult.biz.MbrConsltVO;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;
import icube.manage.promotion.coupon.biz.CouponLstService;
import icube.manage.promotion.coupon.biz.CouponLstVO;
import icube.manage.promotion.coupon.biz.CouponService;
import icube.manage.promotion.coupon.biz.CouponVO;
import icube.manage.promotion.mlg.biz.MbrMlgDAO;
import icube.manage.promotion.mlg.biz.MbrMlgVO;
import icube.manage.promotion.point.biz.MbrPointDAO;
import icube.manage.promotion.point.biz.MbrPointVO;
import icube.market.mbr.biz.MbrSession;
import icube.membership.info.biz.DlvyDAO;
import icube.membership.info.biz.DlvyService;
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
	
	@Resource(name = "dlvyService")
	private DlvyService dlvyService;
	
	@Resource(name = "couponService")
	private CouponService couponService;

	@Resource(name = "couponLstService")
	private CouponLstService couponLstService;
	
	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;
	
	@Resource(name="mbrTestService")
    private MbrTestService mbrTestService;
	
	@Resource(name= "bootpayApiService")
	private BootpayApiService bootpayApiService;
	
	@Resource(name = "biztalkConsultService")
	private BiztalkConsultService biztalkConsultService;
	
	@Autowired
	private MbrSession mbrSession;
	
	@Autowired
	private MatMbrSession matMbrSession;
	
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
	
	@Resource(name="mailService")
	private MailService mailService;
	
	@Value("#{props['Mail.Form.FilePath']}")
	private String mailFormFilePath;

	@Value("#{props['Mail.Username']}")
	private String sendMail;
	
	@Value("#{props['Profiles.Active']}")
	private String activeMode;

	@Value("#{props['Mail.Testuser']}")
	private String mailTestuser;
	
	private static final String RSA_MEMBERSHIP_KEY = "__rsaMembersKey__";
	
	private SimpleDateFormat dtFormat = new SimpleDateFormat("yy-MM-dd");

	private SimpleDateFormat dtFormat2 = new SimpleDateFormat("yyyyMMdd HHmmss");
	

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
		MbrAuthVO authVO = mbrAuthService.selectMbrAuthByMbrId(mbrId);
		if (authVO == null) {
			return null;
		}
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", authVO.getMbrUniqueId());
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
		MbrAuthVO authVO = mbrAuthService.selectMbrAuthByMbrId(mbrId);
		if (authVO == null) {
			return 0;
		} else {
			return 1;
		}
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
		
		//탈퇴후 인증정보도 삭제처리
		mbrAuthService.deleteMbrAuthByUniqueId((String)paramMap.get("srchUniqueId"));
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
	public void updateRecentDtAndLgnTy(String uniqueId, MbrVO mbrVO, String lgnTy) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("uniqueId", uniqueId);
		param.put("lgnTy", lgnTy);
		mbrDAO.updateRecentDt(param);
		
		//세션에 현재 시점의 로그인 타입을 넣기 위함
		mbrVO.setLgnTy(lgnTy);
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
	 * 회원의 APP Token 상태 저장
	 */
	public String updateMbrAppTokenInfo(String uniqueId) throws Exception {
		String newToken = generateMbrAppToken(uniqueId);
		Date now = new Date();
		Date expiredDate = DateUtil.getDateAdd(now, "date", 3650); //유효기간 10년
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("srchUniqueId", uniqueId);
		paramMap.put("appMatToken", newToken);
		paramMap.put("appMatExpiredDt", expiredDate);
		
		mbrDAO.updateMbrAppTokenInfo(paramMap);
		return newToken;
	}
	
	/**
	 * 회원의 위치 정보 저장
	 */
	public void updateMbrLocation(String uniqueId, String lat, String lot) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("srchUniqueId", uniqueId);
		paramMap.put("lat", lat);
		paramMap.put("lot", lot);
		
		mbrDAO.updateMbrLocation(paramMap);
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
	
	/*
	 * 매칭앱 전용 토큰 생성 함수
	 */
	public String generateMbrAppToken(String uniqueId) throws Exception {
		String uuid = UUID.randomUUID().toString();
		return uniqueId + "_" + uuid;
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
		
		String decPw = null;
		try {
			PrivateKey rsaKey = (PrivateKey) session.getAttribute(RSA_MEMBERSHIP_KEY);
			decPw = RSA.decryptRsa(rsaKey, encPw);
		} catch (Exception ex) {
			log.error("=============password 복호화 오류", ex);
		}
		
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
		MbrVO srchMbrVO = selectMbrByUniqueId(srchMbrAuthVO.getMbrUniqueId());
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
 		String ciKey = snsUserInfo.getCiKey();
 		String prevPath = (String)session.getAttribute("prevSnsPath");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("valid", false);
		String rootPath = "";
		String membershipRootPath = "";
		String registPath = "";
		// 웹브라우저로 로그인 한 경우
		if ("membership".equals(prevPath)) {
			rootPath = "/" + mainPath;
			membershipRootPath = "/" + membershipPath;
			registPath = membershipRootPath + "/regist";
		}
		// 매칭앱으로 로그인 한 경우
		if ("matching".equals(prevPath)) {
			rootPath = "/" + matchingPath;
			membershipRootPath = rootPath + "/" + membershipPath;
			
			if ("K".equals(joinTy)) {
				registPath = rootPath + "/kakao/login";
			} else if ("N".equals(joinTy)) {
				registPath = rootPath + "/naver/login";
			} else {
				registPath = rootPath + "/membership/login";
			}
		}
		
		
		List<MbrVO> mbrList = new ArrayList<>();
		
		//로그인 된 상태로 온 경우는 회원정보수정에서 연결하기를 누른 상황으로 unique_id로 검색
		if (mbrSession.isLoginCheck()) {
			MbrVO mbrVO = selectMbrByUniqueId(mbrSession.getUniqueId());
			mbrList.add(mbrVO);
		} else {
			//이미 kakao, naver 계정으로 인증된 회원이 있는지 검색
			Map<String, Object> authParamMap = new HashMap<String, Object>();
			if ("K".equals(joinTy)) {
				authParamMap.put("srchKakaoAppId", snsUserInfo.getKakaoAppId());
			}
			else if ("N".equals(joinTy)) {
				authParamMap.put("srchNaverAppId", snsUserInfo.getNaverAppId());
			}
			List<MbrAuthVO> srchMbrAuthList = mbrAuthService.selectMbrAuthListAll(authParamMap);
			if (srchMbrAuthList.size() > 0) {
				MbrVO mbrVO = selectMbrByUniqueId(srchMbrAuthList.get(0).getMbrUniqueId());
				mbrList.add(mbrVO);
			}
			
			//네이버의 경우 CI값이 없는 경우도 있으므로 체크 추가
			if ((mbrList == null || mbrList.size() < 1) && EgovStringUtil.isNotEmpty(ciKey)) {
				//CI 값으로 회원 검색
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("srchCiKey", ciKey);
				//paramMap.put("srchMbrStts", "NORMAL"); srchMbrStts가 null이면 EXIT를 제외한 회원 조회
				mbrList = selectMbrListAll(paramMap);
			}
		}
		
		
		//가입정보가 2개 이상인 경우 오류 처리
		if (mbrList.size() > 1) {
			resultMap.put("srchMbrVO", new MbrVO());
			resultMap.put("msg", "동일한 가입 정보가 2건 이상 존재합니다. 관리자에게 문의바랍니다.");
			resultMap.put("location", registPath);
			return resultMap;
		}
		
		//회원이 없으면 회원가입(간편가입 본인인증)으로 이동
		if (mbrList == null || mbrList.size() < 1) {
			return resultMap;
		}
		
		
		MbrVO srchMbrVO = mbrList.get(0);
		resultMap.put("srchMbrVO", srchMbrVO);
		
		//탈퇴는 나올수가 없다
//		if ("EXIT".equals(srchMbrVO.getMberSttus())) {
//			resultMap.put("msg", "탈퇴한 회원입니다.");
//			resultMap.put("location", rootPath);
//			return resultMap;
//		}
		//휴면 회원 정책 사라짐
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
		
		//해당 인증수단이 존재하는지 확인
		List<MbrAuthVO> authList = mbrAuthService.selectMbrAuthByMbrUniqueId(srchMbrVO.getUniqueId());
		MbrAuthVO mbrAuthVO = authList.stream().filter(auth -> joinTy.equals(auth.getJoinTy())).findFirst().orElse(null);
		//인증 수단이 등록안되어 있는 경우라면 계정 연결을 하도록 보내준다.
		if (mbrAuthVO == null) {
			snsUserInfo.setUniqueId(srchMbrVO.getUniqueId());
			
			//로그인 된 상태로 온 경우는 회원정보수정에서 연결하기를 누른 상황
			if (mbrSession.isLoginCheck()) {
				//회원 인증정보 등록
				mbrAuthService.insertMbrAuthWithMbrVO(snsUserInfo);
				
				resultMap.put("location", membershipRootPath + "/info/myinfo/form?returnUrl=/membership/info/myinfo/form");
			}
			//로그인 시에 온 경우는 회원 연결페이지로 이동
			else {
				if ("membership".equals(prevPath)) {
					mbrSession.setParms(snsUserInfo, false);
				}
				if ("matching".equals(prevPath)) {
					matMbrSession.setProperty(snsUserInfo);
					matMbrSession.setLoginCheck(false);
				}
				
				//바인딩 페이지로 이동
				resultMap.put("location", membershipRootPath + "/binding");
			}
			return resultMap;
		}
		
		//인증수단이 등록되었지만 계정이 다르다면
		if ("K".equals(joinTy) && !EgovStringUtil.equals(snsUserInfo.getKakaoAppId(), mbrAuthVO.getKakaoAppId())) {
			resultMap.put("msg", getAlreadyMbrMsg(mbrAuthVO));
			if ("membership".equals(prevPath)) {
				resultMap.put("location", membershipRootPath + "/kakao/reAuth");
			} else {
				resultMap.put("location", registPath);
			}
			return resultMap;
		} else if ("N".equals(joinTy) && !EgovStringUtil.equals(snsUserInfo.getNaverAppId(), mbrAuthVO.getNaverAppId())) {
			resultMap.put("msg", getAlreadyMbrMsg(mbrAuthVO));
			if ("membership".equals(prevPath)) {
				resultMap.put("location", membershipRootPath + "/naver/reAuth");
			} else {
				resultMap.put("location", registPath);
			}
			return resultMap;
		}
		
		
		//최근 접속일 갱신
		updateRecentDtAndLgnTy(srchMbrVO.getUniqueId(), srchMbrVO, joinTy);
		
		//로그인 처리
		// 웹브라우저로 로그인 한 경우
		if ("membership".equals(prevPath)) {
			mbrSession.setParms(srchMbrVO, true);
			mbrSession.setMbrInfo(session, mbrSession);
		}
		// 매칭앱으로 로그인 한 경우
		if ("matching".equals(prevPath)) {
			matMbrSession.login(session, srchMbrVO);
		}
		
		//SNS 인증정보 갱신(이메일, 번호, CI값, 엑세스 토큰, 리프레시 토큰)
		mbrAuthService.updateSnsInfo(mbrAuthVO.getAuthNo(), snsUserInfo.getEml(), snsUserInfo.getMblTelno(), snsUserInfo.getCiKey(), snsUserInfo.getAccessToken(), snsUserInfo.getRefreshToken());
		
		resultMap.put("valid", true);
		return resultMap;
	}
	
	/**
	 * 간편회원 임시 로그인 처리(본인인증 등록 전)
	 */
	public void loginTempSnsMbr(HttpSession session, MbrVO mbrVO, DlvyVO dlvyVO) throws Exception {
		if (dlvyVO != null) {
			mbrVO.setZip(dlvyVO.getZip());
			mbrVO.setAddr(dlvyVO.getAddr());
			mbrVO.setDaddr(dlvyVO.getDaddr());
			
			dlvyVO.setMblTelno(mbrVO.getMblTelno());
		}
		//CI가 없으면 회원가입창에서 벗어나지 못하도록 임시 ci값 입력
		if (EgovStringUtil.isEmpty(mbrVO.getCiKey())) {
			mbrVO.setCiKey("regist_ci_value");
		}
		
//		insertMbr(mbrVO);
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
		
		List<MbrAuthVO> mbrAuthVO = mbrAuthService.selectMbrAuthByMbrUniqueId(mbrSession.getUniqueId()); 
		MbrAuthVO authInfo = mbrAuthVO.stream().filter(f -> joinTy.equals(f.getJoinTy())).findAny().orElse(null);
		if (authInfo == null) {
			javaScript.setMessage("등록된 소셜 정보가 존재하지 않습니다.");
			javaScript.setLocation("/" + membershipPath + "/info/myinfo/confirm");
			return javaScript;
		}
		
		String mbrSnsId = "K".equals(joinTy) ? authInfo.getKakaoAppId() : authInfo.getNaverAppId();
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
	
	
	/**
	 * 부트페이 인증 후 사용자 정보 반환
	 */
	public Map<String, Object> certificateBootpay(String receiptId) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("valid", false);
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		// 본인인증정보 체크
		HashMap<String, Object> res = bootpayApiService.certificate(receiptId);

		String authData =String.valueOf(res.get("authenticate_data"));
		String[] spAuthData = authData.substring(1, authData.length()-1).split(",");

		HashMap<String, String> authMap = new HashMap<String, String>();
		for(String auth : spAuthData) {
			System.out.println("spAuthData: " + auth.trim());
			String[] spTmp = auth.trim().split("=", 2);
			authMap.put(spTmp[0], spTmp[1]); //key:value
		}
		/*
		 !참고:부트페이 제공문서와 결과 값이 다름
		      결과값에 json 문자열 처리가 정확하지 않아 타입변환이 안됨

		 */
        
		Date sBrdt = formatter.parse(DateUtil.formatDate(authMap.get("birth"), "yyyy-MM-dd")); //생년월일
        
        String mblTelno = authMap.get("phone");
        String gender = authMap.get("gender"); //1.0 > 부트페이 제공문서와 다름
        if(EgovStringUtil.equals("1.0", gender)) {
        	gender = "M";
        }else {
        	gender = "W";
        }

        
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(sBrdt);
        //만 14세 미만인지 체크
        if (DateUtil.getRealAge(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH) + 1, calendar.get(Calendar.DAY_OF_MONTH)) < 14) {
        	resultMap.put("msg", "14세 이상만 가입 가능합니다.");
    		return resultMap;
        }
        
        
        MbrVO certMbrInfoVO = new MbrVO();
        certMbrInfoVO.setCiKey(authMap.get("unique"));  //unique가 CI에 해당하는 값
        certMbrInfoVO.setDiKey(authMap.get("di"));
        certMbrInfoVO.setMbrNm(authMap.get("name"));
        certMbrInfoVO.setMblTelno(mblTelno.substring(0, 3) + "-" + mblTelno.substring(3, 7) +"-"+ mblTelno.substring(7, 11));
        certMbrInfoVO.setGender(gender);
        certMbrInfoVO.setBrdt(sBrdt);
        
        resultMap.put("certMbrInfoVO", certMbrInfoVO);
        resultMap.put("valid", true);
		return resultMap;
	}
	
	
	/**
	 * 회원 생성 전 이미 존재하는 계정이 있는지 확인(회원 바인딩 고려)
	 */
	public Map<String, Object> checkDuplicateMbrForRegist(MbrAuthVO mbrAuthVO, String diKey) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("valid", false);
		
		//같은 CI를 등록한 회원이 있는 지 확인
		MbrVO srchMbr = getBindingMbr(mbrAuthVO.getCiKey(), diKey);
		if (srchMbr != null) {
			//검색된 바인딩 계정에 이미 해당 인증수단이 있는 경우
			List<MbrAuthVO> authList = mbrAuthService.selectMbrAuthByMbrUniqueId(srchMbr.getUniqueId());
			MbrAuthVO authInfo = authList.stream().filter(f -> f.getJoinTy().equals(mbrAuthVO.getJoinTy())).findAny().orElse(null);
			if (authInfo != null) {
				resultMap.put("msg", getAlreadyMbrMsg(authInfo));
				
				if ("K".equals(mbrAuthVO.getJoinTy())) {
					resultMap.put("location", "/membership/kakao/reAuth");
				}
				else if ("N".equals(mbrAuthVO.getJoinTy())) {
					resultMap.put("location", "/membership/naver/reAuth");
				}
				else {
					resultMap.put("location", "/membership/login");
				}
				mbrSession.setParms(new MbrVO(), false);
				return resultMap;
			} else {
				//바인딩으로 이동 처리
				resultMap.put("bindingMbr", srchMbr);
				return resultMap;
			}
		}
		
		
		//인증 정보를 이미 등록한 회원이 있는 지 확인
		MbrAuthVO findMbrAuth = null;
		if ("K".equals(mbrAuthVO.getJoinTy())) {
			findMbrAuth = mbrAuthService.selectMbrAuthByKakaoAppId(mbrAuthVO.getKakaoAppId());
			if (findMbrAuth != null) {
				resultMap.put("msg", getAlreadyMbrMsg(findMbrAuth));
				resultMap.put("location", "/membership/kakao/reAuth");
				mbrSession.setParms(new MbrVO(), false);
				return resultMap;
			}
		}
		else if ("N".equals(mbrAuthVO.getJoinTy())) {
			findMbrAuth = mbrAuthService.selectMbrAuthByNaverAppId(mbrAuthVO.getNaverAppId());
			if (findMbrAuth != null) {
				resultMap.put("msg", getAlreadyMbrMsg(findMbrAuth));
				resultMap.put("location", "/membership/naver/reAuth");
				mbrSession.setParms(new MbrVO(), false);
				return resultMap;
			}
		}
		//아이디 입력 전 시점이라 아이디 조회 불가능
//		else { 
//			findMbrAuth = mbrAuthService.selectMbrAuthByMbrId(mbrAuthVO.getMbrId());
//			if (findMbrAuth != null) {
//				idInfoStr = "이미 이로움ON에 가입된 계정이 있습니다.\\n아이디 : " + findMbrAuth.getMbrId();
//			}
//		}
		
		
		//재가입 7일 이내 불가
		MbrVO mbrExitUser = getBindingExitMbr(mbrAuthVO.getCiKey(), diKey);
		if (mbrExitUser != null) {
			//해당 명의로 탈퇴한 적이 있다면 탈퇴 후 7일이 지났는지와 이로움계정 인증수단을 포함하고 있는지 체크
			Date aWeekAgo = DateUtil.getDateAdd(new Date(), "date", -7);
			List<MbrAuthVO> authList = mbrAuthService.selectMbrAuthWithDelete(mbrExitUser.getUniqueId());
			MbrAuthVO eroumAuthInfo = authList.stream().filter(f -> "E".equals(f.getJoinTy())).findAny().orElse(null);
			if (eroumAuthInfo != null && aWeekAgo.compareTo(mbrExitUser.getWhdwlDt()) < 0) {
				resultMap.put("msg", "탈퇴 후 7일 이내의 재가입은 불가능합니다.");
				resultMap.put("location", "/membership/login");
				mbrSession.setParms(new MbrVO(), false);
				return resultMap;
			}
		}
		
		
		resultMap.put("valid", true);
		return resultMap;
	}
	
	
	/**
	 * 회원가입 이후 처리 (회원 생성 이후 처리 공통 함수)
	 */
	public void workAfterMbrRegist(MbrVO mbrVO, MbrAgreementVO mbrAgreementVO) throws Exception {
		//회원 인증정보 등록
		mbrAuthService.insertMbrAuthWithMbrVO(mbrVO);
		
		// 모든 항목 동의처리 로그
		if (mbrAgreementVO != null) {
			mbrAgreementVO.setMbrUniqueId(mbrVO.getUniqueId());
			insertMbrAgreement(mbrAgreementVO);
		}
		

		// 기본 배송지 등록
		DlvyVO dlvyVO = new DlvyVO();
		dlvyVO.setUniqueId(mbrVO.getUniqueId());
		dlvyVO.setDlvyNm(mbrVO.getMbrNm());
		dlvyVO.setNm(mbrVO.getMbrNm());
		dlvyVO.setZip(mbrVO.getZip());
		dlvyVO.setAddr(mbrVO.getAddr());
		dlvyVO.setDaddr(mbrVO.getDaddr());
		dlvyVO.setTelno(mbrVO.getTelno());
		dlvyVO.setMblTelno(mbrVO.getMblTelno());
		dlvyVO.setBassDlvyYn("Y");
		dlvyVO.setUseYn("Y");

		dlvyService.insertBassDlvy(dlvyVO);

		
		/** 2023-04-05 포인트 지급 삭제 **/

		// 회원가입 쿠폰
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("srchCouponTy", "JOIN");
			paramMap.put("srchSttusTy", "USE");
			int cnt = couponService.selectCouponCount(paramMap);
			if(cnt > 0) {
				CouponVO couponVO = couponService.selectCoupon(paramMap);
				CouponLstVO couponLstVO = new CouponLstVO();
				couponLstVO.setCouponNo(couponVO.getCouponNo());
				couponLstVO.setUniqueId(dlvyVO.getUniqueId());

				if(couponVO.getUsePdTy().equals("ADAY")) {
					couponLstVO.setUseDay(couponVO.getUsePsbltyDaycnt());
				}

				couponLstService.insertCouponLst(couponLstVO);
			}else {
				log.debug("회원 가입 쿠폰 개수 : " + cnt);
			}
			
			
			// 2023년 11/6 ~ 12/08 까지 5천원 추가 쿠폰 자동 지급
			Date now = new Date();
			String startDtStr = "20231106 000000";
			Date startDt = dtFormat2.parse(startDtStr);
			String endDtStr = "20231208 235959";
			Date endDt = dtFormat2.parse(endDtStr);
			
			//쿠폰발급 기간조건 (크다(1), 같다(0), 작다(-1))
			if (now.compareTo(startDt) >= 0 && now.compareTo(endDt) <= 0) {
				paramMap = new HashMap<String, Object>();
				paramMap.put("srchCouponTy", "JOIN_ADD");
				paramMap.put("srchSttusTy", "USE");
				CouponVO couponVO = couponService.selectCoupon(paramMap);
				
				//회원가입 추가발급 쿠폰이 있는 경우
				if (couponVO != null) {
					CouponLstVO couponLstVO = new CouponLstVO();
					couponLstVO.setCouponNo(couponVO.getCouponNo());
					couponLstVO.setUniqueId(dlvyVO.getUniqueId());
					
					if(couponVO.getUsePdTy().equals("ADAY")) {
						couponLstVO.setUseDay(couponVO.getUsePsbltyDaycnt());
					}

					couponLstService.insertCouponLst(couponLstVO);
				}
			}
			
		}catch(Exception e) {
			log.debug("회원 가입 쿠폰 발송 실패" + e.toString());
		}
		
		// 가입 축하 메일 발송
		try {
			if(ValidatorUtil.isEmail(mbrVO.getEml())) {
				String MAIL_FORM_PATH = mailFormFilePath;
				String mailForm = FileUtil.readFile(MAIL_FORM_PATH+"mail/mbr/mail_join.html");

				mailForm = mailForm.replace("{mbrNm}", mbrVO.getMbrNm()); // 회원 이름
				if ("K".equals(mbrVO.getJoinTy())) {
					mailForm = mailForm.replace("{mbrId}", "간편가입(카카오)");
				} else if ("N".equals(mbrVO.getJoinTy())) {
					mailForm = mailForm.replace("{mbrId}", "간편가입(네이버)");
				} else {
					mailForm = mailForm.replace("{mbrId}", mbrVO.getMbrId());
				}
				mailForm = mailForm.replace("{mbrEml}", mbrVO.getEml()); // 회원 이메일
				mailForm = mailForm.replace("{mblTelno}", mbrVO.getMblTelno()); // 회원 전화번호


				// 메일 발송
				String mailSj = "[이로움ON] 회원이 되신것을 환영합니다.";
				if(EgovStringUtil.equals("real", activeMode)) {
					mailService.sendMail(sendMail, mbrVO.getEml(), mailSj, mailForm);
				} else {
					mailService.sendMail(sendMail, this.mailTestuser, mailSj, mailForm); //테스트
				}
			} else {
				log.debug("회원 가입 알림 EMAIL 전송 실패 :: 이메일 체크 " + mbrVO.getEml());
			}
		} catch (Exception e) {
			log.debug("회원 가입 알림 EMAIL 전송 실패 :: " + e.toString());
		}
		
		//알림톡 발송
		biztalkConsultService.sendOnJoinComleted(mbrVO);
	}
	
	
	/**
	 * 바인딩 가능 회원 반환 (연결 가능한 계정이 있으면 반환)
	 */
	public MbrVO getBindingMbr(String ciKey, String diKey) throws Exception {
		
		//CI로 찾기
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchCiKey", ciKey);
		//paramMap.put("srchMbrStts", stts); //srchMbrStts가 null이면 EXIT를 제외한 회원 조회
		MbrVO srchMbr = selectMbr(paramMap);
		if (srchMbr != null) {
			return srchMbr;
		}
		
		//DI로 찾기
		if (EgovStringUtil.isNotEmpty(diKey)) {
			paramMap = new HashMap<String, Object>();
			paramMap.put("srchDiKey", diKey);
			//paramMap.put("srchMbrStts", stts); //srchMbrStts가 null이면 EXIT를 제외한 회원 조회
			srchMbr = selectMbr(paramMap);
			if (srchMbr != null) {
				return srchMbr;
			}
		}
		
		return null;
	}
	
	/*
	 * 탈퇴한 바인딩 가능 회원 반환 (탈퇴한지 7일 지났는지 체크용)
	 */
	private MbrVO getBindingExitMbr(String ciKey, String diKey) throws Exception {
		
		//CI로 찾기
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchCiKey", ciKey);
		paramMap.put("srchMbrStts", "EXIT");
		List<MbrVO> srchMbr = selectMbrListAll(paramMap);
		if (srchMbr != null && srchMbr.size() > 0) {
			//가장 최근에 탈퇴한 바인딩 회원 반환
			return srchMbr.get(0);
		}
		
		//DI로 찾기
		if (EgovStringUtil.isNotEmpty(diKey)) {
			paramMap = new HashMap<String, Object>();
			paramMap.put("srchDiKey", diKey);
			paramMap.put("srchMbrStts", "EXIT");
			srchMbr = selectMbrListAll(paramMap);
			if (srchMbr != null && srchMbr.size() > 0) {
				//가장 최근에 탈퇴한 바인딩 회원 반환
				return srchMbr.get(0);
			}
		}
		
		return null;
	}
	
	
	/**
	 * sns 회원정보와 회원 바인딩 처리(세션에 저장된 임시 회원을 바인딩 처리)
	 */
	public Map<String, Object> bindMbrWithTempMbr(HttpSession session) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", false);
		
		//비정상적인 요청 차단
		if (mbrSession == null || EgovStringUtil.isEmpty(mbrSession.getUniqueId()) || mbrSession.isLoginCheck() == true) {
			resultMap.put("msg", "잘못된 접근입니다.");
			return resultMap;
		}
		
		//회원 조회
		try {
			MbrVO srchMbrVO = selectMbrByUniqueId(mbrSession.getUniqueId());
			if (srchMbrVO == null) {
				resultMap.put("msg", "연결할 계정이 존재하지 않습니다.");
				return resultMap;
			}
			
			//로그인할 때 외부에서 받은 회원 정보(임시 세션)
			MbrVO tempMbrVO = mbrSession;
			
			//회원 인증정보 등록
			mbrAuthService.insertMbrAuthWithMbrVO(tempMbrVO);
			
			//최근 접속일 갱신
			updateRecentDtAndLgnTy(srchMbrVO.getUniqueId(), srchMbrVO, tempMbrVO.getJoinTy());
			
			//로그인 처리
			mbrSession.setParms(srchMbrVO, true);
			mbrSession.setMbrInfo(session, mbrSession);
			
		} catch (Exception ex) {
			log.error("------- 계정연결 오류 ---------", ex);
			resultMap.put("msg", "계정 연결중 오류가 발생하였습니다.");
			return resultMap;
		}
		
		resultMap.put("success", true);
		return resultMap;
	}
	
	/**
	 * 이미 존재하는 소셜 계정 안내 메세지 반환
	 */
	private String getAlreadyMbrMsg(MbrAuthVO mbrAuthInfo) {
		String msg = "이미 가입된 소셜 계정이 있습니다.";
		if ("K".equals(mbrAuthInfo.getJoinTy())) {
			String snsInfo = mbrAuthInfo.getEml() != null ? mbrAuthInfo.getEml() : mbrAuthInfo.getMblTelno();
			if (EgovStringUtil.isNotEmpty(snsInfo)) {
				msg += "\\n카카오 : " + snsInfo;
			} else {
				msg = "이미 가입된 카카오 계정이 있습니다.";
			}
		} else if ("N".equals(mbrAuthInfo.getJoinTy())) {
			String snsEml = mbrAuthInfo.getEml();
			if (EgovStringUtil.isNotEmpty(snsEml)) {
				msg += "\\n네이버 : " + snsEml;
			} else {
				msg = "이미 가입된 네이버 계정이 있습니다.";
			}
		} else {
			msg = "이미 이로움ON에 가입된 계정이 있습니다.\\n아이디 : " + mbrAuthInfo.getMbrId();
		}
		return msg;
	}
}