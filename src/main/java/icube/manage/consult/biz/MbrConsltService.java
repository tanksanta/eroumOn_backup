package icube.manage.consult.biz;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import icube.common.api.biz.BiztalkConsultService;
import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.mail.MailService;
import icube.common.util.DateUtil;
import icube.common.util.FileUtil;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.mbr.recipients.biz.MbrRecipientsGdsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsGdsVO;
import icube.manage.mbr.recipients.biz.MbrRecipientsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;

@Service("mbrConsltService")
public class MbrConsltService extends CommonAbstractServiceImpl {

	@Resource(name = "mbrService")
	private MbrService mbrService;
	
	@Resource(name = "biztalkConsultService")
	private BiztalkConsultService biztalkConsultService;
	
	@Resource(name = "mailService")
	private MailService mailService;
	
	@Resource(name="mbrConsltDAO")
	private MbrConsltDAO mbrConsltDAO;

	@Resource(name="mbrConsltResultDAO")
	private MbrConsltResultDAO mbrConsltResultDAO;
	
	@Resource(name="mbrConsltMemoDAO")
	private MbrConsltMemoDAO mbrConsltMemoDAO;
	
	@Resource(name="mbrConsltChgHistDAO")
	private MbrConsltChgHistDAO mbrConsltChgHistDAO;

	@Resource(name= "mbrRecipientsService")
	private MbrRecipientsService mbrRecipientsService;
	
	@Resource(name= "mbrRecipientsGdsService")
	private MbrRecipientsGdsService mbrRecipientsGdsService;
	
	@Resource(name = "mbrConsltGdsService")
	private MbrConsltGdsService mbrConsltGdsService;
	
	@Value("#{props['Mail.Username']}")
	private String sendMail;
	
	@Value("#{props['Mail.Form.FilePath']}")
	private String mailFormFilePath;
	
	@Value("#{props['Profiles.Active']}")
	private String activeMode;
	
	@Value("#{props['Mail.Testuser']}")
	private String mailTestuser;
	
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
	
	
	@SuppressWarnings("unchecked")
	public CommonListVO selectMbrConsltListVO(CommonListVO listVO) throws Exception {

		listVO = mbrConsltDAO.selectMbrConsltListVO(listVO);

		List<MbrConsltVO> consltList = listVO.getListObject();
		for(MbrConsltVO mbrConsltVO : consltList) {
			int yyyy =  EgovStringUtil.string2integer(mbrConsltVO.getBrdt().substring(0, 4));
			int mm =  EgovStringUtil.string2integer(mbrConsltVO.getBrdt().substring(4, 6));
			int dd =  EgovStringUtil.string2integer(mbrConsltVO.getBrdt().substring(6, 8));
			mbrConsltVO.setAge(DateUtil.getRealAge(yyyy, mm, dd));
		}

		return listVO;
	}

	public Integer updateUseYn(int consltNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("consltNo", consltNo);
		paramMap.put("useYn", "N");
		return mbrConsltDAO.updateUseYn(paramMap);
	}

	public MbrConsltVO selectMbrConslt(Map<String, Object> paramMap) throws Exception {
		return mbrConsltDAO.selectMbrConslt(paramMap);
	}
	
	public MbrConsltVO selectMbrConsltByConsltNo(int consltNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("consltNo", consltNo);
		return mbrConsltDAO.selectMbrConslt(paramMap);
	}
	
	public List<MbrConsltVO> selectMbrConsltByRecipientsNo(int recipientsNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchRecipientsNo", recipientsNo);
		return mbrConsltDAO.selectMbrConsltAll(paramMap);
	}

	public Integer insertMbrConslt(MbrConsltVO mbrConsltVO) throws Exception {
		return mbrConsltDAO.insertMbrConslt(mbrConsltVO);
	}

	public Integer updateMbrConslt(MbrConsltVO mbrConsltVO) throws Exception {
		return mbrConsltDAO.updateMbrConslt(mbrConsltVO);
	}


	public int updateCanclConslt(Map<String, Object> paramMap) throws Exception {
		// 관리자에서 취소시 사업소 지정된 데이터도 취소 처리
		// updateCanclConslt
		if (paramMap.containsKey("bplcConsltNo")) {
			mbrConsltResultDAO.updateCanclConslt(paramMap);
		}
		return mbrConsltDAO.updateCanclConslt(paramMap); // 상담취소;
	}
	
	public Integer updateMbrConsltByMngr(MbrConsltVO mbrConsltVO) throws Exception {
		return mbrConsltDAO.updateMbrConsltByMngr(mbrConsltVO);
	}
	
	public int updateMngMemo(Map<String, Object> paramMap) throws Exception {
		return mbrConsltDAO.updateMngMemo(paramMap);
	}
	
	public int updateCurConsltResultNo(int consltNo, int curConsltResultNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("curConsltResultNo", curConsltResultNo);
		paramMap.put("consltNo", consltNo);
		return mbrConsltDAO.updateCurConsltResultNo(paramMap);
	}

	public List<MbrConsltVO> selectListForExcel(Map<String, Object> paramMap) throws Exception {
		return mbrConsltDAO.selectListForExcel(paramMap);
	}

	public Integer insertMbrConsltMemo(MbrConsltMemoVO mbrConsltMemoVO) throws Exception {
		return mbrConsltMemoDAO.insertMbrConsltMemo(mbrConsltMemoVO);
	}

	public MbrConsltVO selectLastMbrConsltForCreate(Map<String, Object> paramMap) throws Exception {
		return mbrConsltDAO.selectLastMbrConsltForCreate(paramMap);
	}
	
	public MbrConsltVO selectConsltInProcess(String uniqueId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("srchUniqueId", uniqueId);
		return mbrConsltDAO.selectConsltInProcess(param);
	}
	
	public Integer insertMbrConsltChgHist(MbrConsltChgHistVO mbrConsltChgHistVO) throws Exception {
		return mbrConsltChgHistDAO.insertMbrConsltChgHist(mbrConsltChgHistVO);
	}
	
	public List<MbrConsltMemoVO> selectMbrConsltMemo(Map<String, Object> paramMap) throws Exception {
		return mbrConsltMemoDAO.selectMbrConsltMemo(paramMap);
	}
	
	public List<MbrConsltChgHistVO> selectMbrConsltChgHist(Map<String, Object> paramMap) throws Exception {
		return mbrConsltChgHistDAO.selectMbrConsltChgHist(paramMap);
	}
	
	public MbrConsltChgHistVO selectMbrConsltChgHistByChgNo(int chgNo) throws Exception {
		Map<String, Object> srchParam = new HashMap<String, Object>();
		srchParam.put("srchChgNo", chgNo);
		
		List<MbrConsltChgHistVO> chgHistList = mbrConsltChgHistDAO.selectMbrConsltChgHist(srchParam);
		if (chgHistList.size() > 0) {
			return chgHistList.get(0);
		} else {
			return null;
		}
	}
	
	public MbrConsltVO selectRecentConsltByRecipientsNo(int RecipientsNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchRecipientsNo", RecipientsNo);
		return mbrConsltDAO.selectRecentConsltByRecipientsNo(paramMap);
	}
	
	public MbrConsltVO selectRecentConsltByRecipientsNo(int RecipientsNo, String prevPath) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchRecipientsNo", RecipientsNo);
		paramMap.put("srchPREV_PATH", prevPath);
		return mbrConsltDAO.selectRecentConsltByRecipientsNo(paramMap);
	}
	

	/* 
		MbrsInfoController.getRecipientConsltSttus 대체
	*/
	public Map <String, Object> selectRecipientConsltSttus(String uniqueId, int recipientsNo, String prevPath) throws Exception {
		Map <String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("isLogin", true);/* MbrsInfoController.getRecipientConsltSttus 와 구조를 맞추기 위해서 값을 넣어줌*/

		//내 수급자 정보 체크가 아니면 그냥 리턴
		MbrRecipientsVO srchRecipient;
		srchRecipient = mbrRecipientsService.selectMbrRecipientsByRecipientsNo(recipientsNo);
		if (srchRecipient == null || !EgovStringUtil.equals(srchRecipient.getMbrUniqueId(), uniqueId)){
			resultMap.put("noRecipient", true);
			return resultMap;
		}

		//수급자 최근 상담 조회(진행 중인 상담 체크)
		MbrConsltVO recipientConslt = this.selectRecentConsltByRecipientsNo(recipientsNo, prevPath);
		if (recipientConslt != null && (
				!"CS03".equals(recipientConslt.getConsltSttus()) &&
				!"CS04".equals(recipientConslt.getConsltSttus()) &&
				!"CS09".equals(recipientConslt.getConsltSttus()) &&
				!"CS06".equals(recipientConslt.getConsltSttus())
				)) {
			resultMap.put("isExistRecipientConslt", true);
		} else {
			resultMap.put("isExistRecipientConslt", false);
		}

		return resultMap;
	}
	
	/**
	 * 상담신청 이메일 발송
	 */
	public void sendConsltRequestEmail(MbrConsltVO mbrConsltVO) throws Exception {
		String MAIL_FORM_PATH = mailFormFilePath;
		String mailForm = FileUtil.readFile(MAIL_FORM_PATH + "mail_conslt.html");
		String mailSj = "[이로움 ON] 신규상담건 문의가 접수되었습니다.";
		String putEml = "thkc_cx@thkc.co.kr";
		
		mailForm = mailForm.replace("((mbr_id))", mbrConsltVO.getRegUniqueId());
		mailForm = mailForm.replace("((mbr_telno))", mbrConsltVO.getMbrTelno());
		mailForm = mailForm.replace("((conslt_ty))", CodeMap.PREV_PATH.get(mbrConsltVO.getPrevPath()));
		mailForm = mailForm.replace("((conslt_date))", simpleDateFormat.format(new Date()));

		if ("real".equals(activeMode)) {
			mailService.sendMail(sendMail, putEml, mailSj, mailForm);
		} else {
			mailService.sendMail(sendMail, this.mailTestuser, mailSj, mailForm);
		}
	}
	
	/**
	 * 회원 상담취소 이메일 발송
	 */
	public void sendCancelConsltEmail(MbrConsltVO mbrConsltVO) throws Exception {
		String MAIL_FORM_PATH = mailFormFilePath;
		String mailForm = FileUtil.readFile(MAIL_FORM_PATH + "mail_conslt_cancel.html");
		String mailSj = "[이로움 ON] 상담이 취소되었습니다.";
		String putEml = "thkc_cx@thkc.co.kr";
		
		mailForm = mailForm.replace("((mbr_nm))", mbrConsltVO.getRgtr());
		mailForm = mailForm.replace("((mbr_id))", mbrConsltVO.getRegUniqueId());
		mailForm = mailForm.replace("((mbr_telno))", mbrConsltVO.getMbrTelno());
		mailForm = mailForm.replace("((cancel_date))", simpleDateFormat.format(new Date()));

		if ("real".equals(activeMode)) {
			mailService.sendMail(sendMail, putEml, mailSj, mailForm);
		} else {
			mailService.sendMail(sendMail, this.mailTestuser, mailSj, mailForm);
		}
	}
	
	
	/**
	 * 진행중인 상담 리스트 반환
	 */
	public List<MbrConsltVO> getConsltInProgress(int recipientsNo) throws Exception {
		List<MbrConsltVO> result = new ArrayList<>();
		
		List<MbrConsltVO> mbrConsltList = selectMbrConsltByRecipientsNo(recipientsNo);
		if (mbrConsltList.size() > 0) {
			for (MbrConsltVO consltVO : mbrConsltList) {
				if ("CS01".equals(consltVO.getConsltSttus()) ||
					"CS02".equals(consltVO.getConsltSttus()) ||
					"CS05".equals(consltVO.getConsltSttus()) ||
					"CS07".equals(consltVO.getConsltSttus()) ||
					"CS08".equals(consltVO.getConsltSttus())) {
					result.add(consltVO);
				}
			}
		}
		
		return result;
	}
	
	/**
	 * 상담 신청
	 * mbrConsltVO : 신청하는 상담 정보
	 * saveRecipientInfo : 상담 정보로 수급자 정보 수정할지 여부
	 * sessionVO : 회원 세션 정보
	 */
	public Map<String, Object> addMbrConslt(MbrConsltVO mbrConsltVO, Boolean saveRecipientInfo, MbrVO sessionVO) {
		Map <String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", false);
		
		try {
			//복지용구상담인데 선택한 복지용구 품목이 없는 경우
			if ("equip_ctgry".equals(mbrConsltVO.getPrevPath())) {
				List<MbrRecipientsGdsVO> recipientsGdsList = mbrRecipientsGdsService.selectMbrRecipientsGdsByRecipientsNo(mbrConsltVO.getRecipientsNo());
				
				if (recipientsGdsList == null || recipientsGdsList.size() == 0) {
	                resultMap.put("msg", "관심 복지용구를 선택하세요");
	                return resultMap;
				}
			}
			
			MbrVO mbrVO = mbrService.selectMbrByUniqueId(sessionVO.getUniqueId());
			List<MbrRecipientsVO> mbrRecipientList = mbrVO.getMbrRecipientsList();
			MbrRecipientsVO mbrRecipient = mbrRecipientList.stream().filter(f -> f.getRecipientsNo() == mbrConsltVO.getRecipientsNo()).findAny().orElse(null);
			if (mbrRecipient == null) {
				resultMap.put("msg", "등록되지 않은 수급자입니다.");
                return resultMap;
			}
			//해당 수급자가 본인인 경우 회원의 정보로 상담정보 저장
			if ("007".equals(mbrRecipient.getRelationCd())) {
				mbrConsltVO.setRelationCd(mbrRecipient.getRelationCd());
				mbrConsltVO.setMbrNm(mbrVO.getMbrNm());
				mbrConsltVO.setMbrTelno(mbrVO.getMblTelno());
				mbrConsltVO.setAddr(mbrVO.getAddr());
				if (mbrVO.getBrdt() != null) {
					mbrConsltVO.setBrdt(dateFormat.format(mbrVO.getBrdt()));
				}
				mbrConsltVO.setGender(mbrVO.getGender());
			}
			//가족 인경우 수급자 정보로 상담정보 저장(입력 받는 것 제외)
			else {
				mbrConsltVO.setRelationCd(mbrRecipient.getRelationCd());
				mbrConsltVO.setMbrNm(mbrRecipient.getRecipientsNm());
			}
			
			//수급자 정보 저장동의시 수급자명을 다른 수급자와 똑같이 등록하려는 경우
			if (saveRecipientInfo) {
	            if (mbrRecipientList.stream().filter(f -> mbrConsltVO.getMbrNm().equals(f.getRecipientsNm()) && f.getRecipientsNo() != mbrConsltVO.getRecipientsNo()).count() > 0) {
	                resultMap.put("msg", "이미 등록한 수급자입니다 (수급자명을 확인하세요)");
	                return resultMap;
	            }
			}
			
			//같은 상담(prev_path)중 진행중인 상담이 있다면 불가능
			//수급자 최근 상담 조회(진행 중인 상담 체크)
			MbrConsltVO recipientConslt = selectRecentConsltByRecipientsNo(mbrRecipient.getRecipientsNo(), mbrConsltVO.getPrevPath());
			if (recipientConslt != null && (
					!"CS03".equals(recipientConslt.getConsltSttus()) &&
					!"CS04".equals(recipientConslt.getConsltSttus()) &&
					!"CS09".equals(recipientConslt.getConsltSttus()) &&
					!"CS06".equals(recipientConslt.getConsltSttus())
					)) {
				resultMap.put("msg", "진행중인 " + CodeMap.PREV_PATH.get(mbrConsltVO.getPrevPath()) + "이 있습니다.");
				return resultMap;
			}
			
			//요양인정번호를 입력한 경우 조회 가능한지 유효성 체크
			// if (EgovStringUtil.isNotEmpty(mbrConsltVO.getRcperRcognNo())) {
			// 	Map<String, Object> returnMap = tilkoApiService.getRecipterInfo(mbrConsltVO.getMbrNm(), mbrConsltVO.getRcperRcognNo(), true);
				
			// 	Boolean result = (Boolean) returnMap.get("result");
			// 	if (result == false) {
			// 		resultMap.put("msg", "유효한 요양인정번호가 아닙니다.");
			// 		return resultMap;
			// 	}
			// }
			
			
			//기존에 L번호가 있는 수급자였다면 L번호 포함 상담정보 저장
			if ("Y".equals(mbrRecipient.getRecipientsYn())) {
				mbrConsltVO.setRcperRcognNo(mbrRecipient.getRcperRcognNo());
			}
			
			mbrConsltVO.setRegId(mbrVO.getMbrId());
			mbrConsltVO.setRegUniqueId(mbrVO.getUniqueId());
			mbrConsltVO.setRgtr(mbrVO.getMbrNm());

			if(EgovStringUtil.isNotEmpty(mbrConsltVO.getBrdt())) {
				mbrConsltVO.setBrdt(mbrConsltVO.getBrdt().replace("/", ""));
			}

			int insertCnt = insertMbrConslt(mbrConsltVO);

			if (insertCnt > 0) {
				//수급자 정보 저장동의시 저장
				if (saveRecipientInfo) {
					mbrRecipient.setRelationCd(mbrConsltVO.getRelationCd());
					mbrRecipient.setRecipientsNm(mbrConsltVO.getMbrNm());
					if (EgovStringUtil.isNotEmpty(mbrConsltVO.getRcperRcognNo())) {
						mbrRecipient.setRcperRcognNo(mbrConsltVO.getRcperRcognNo());
						mbrRecipient.setRecipientsYn("Y");
					} else {
						mbrRecipient.setRecipientsYn("N");
					}
					mbrRecipient.setTel(mbrConsltVO.getMbrTelno());
					mbrRecipient.setSido(mbrConsltVO.getZip());
					mbrRecipient.setSigugun(mbrConsltVO.getAddr());
					mbrRecipient.setDong(mbrConsltVO.getDaddr());
					mbrRecipient.setBrdt(mbrConsltVO.getBrdt());
					mbrRecipient.setGender(mbrConsltVO.getGender());
					mbrRecipientsService.updateMbrRecipients(mbrRecipient);
				}
				
				//1:1 상담신청 이력 추가
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("srchRgtr", mbrConsltVO.getRgtr());
				paramMap.put("srchUniqueId", mbrConsltVO.getRegUniqueId());
				MbrConsltVO srchMbrConslt = selectLastMbrConsltForCreate(paramMap);
				
				MbrConsltChgHistVO mbrConsltChgHistVO = new MbrConsltChgHistVO();
				mbrConsltChgHistVO.setConsltNo(srchMbrConslt.getConsltNo());
				mbrConsltChgHistVO.setConsltSttusChg(srchMbrConslt.getConsltSttus());
				mbrConsltChgHistVO.setResn(CodeMap.CONSLT_STTUS_CHG_RESN.get("접수"));
				mbrConsltChgHistVO.setMbrUniqueId(mbrVO.getUniqueId());
				mbrConsltChgHistVO.setMbrId(mbrVO.getMbrId());
				mbrConsltChgHistVO.setMbrNm(mbrVO.getMbrNm());
				insertMbrConsltChgHist(mbrConsltChgHistVO);
				
				
				//복지용구상담인 경우 선택 복지용구 정보 추가 저장
				if ("equip_ctgry".equals(mbrConsltVO.getPrevPath())) {
					mbrConsltGdsService.insertMbrConsltGds(srchMbrConslt.getRecipientsNo(), srchMbrConslt.getConsltNo(), mbrVO);
				}
				
				
				//1:1 상담신청시 관리자에게 알림 메일 발송
				sendConsltRequestEmail(mbrConsltVO);
			}

			biztalkConsultService.sendOnTalkCreated(mbrVO, mbrRecipient, insertCnt); 

			resultMap.put("success", true);
		} catch (Exception ex) {
			resultMap.put("success", false);
			resultMap.put("msg", "상담신청에 실패하였습니다");
		}
		return resultMap;
	}
}