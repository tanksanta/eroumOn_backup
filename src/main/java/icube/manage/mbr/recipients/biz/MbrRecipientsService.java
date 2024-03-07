package icube.manage.mbr.recipients.biz;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Service;


import icube.common.vo.CommonCheckVO;
import icube.manage.consult.biz.MbrConsltService;
import icube.manage.consult.biz.MbrConsltVO;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.common.framework.abst.CommonAbstractServiceImpl;

@Service("mbrRecipientsService")
public class MbrRecipientsService extends CommonAbstractServiceImpl {
	
	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;
	
	@Resource(name="mbrRecipientsDAO")
	private MbrRecipientsDAO mbrRecipientsDAO;
	
	
	public List<MbrRecipientsVO> selectMbrRecipientsList(Map<String, Object> paramMap) throws Exception {
		return mbrRecipientsDAO.selectMbrRecipientsList(paramMap);
	}

	public MbrRecipientsVO selectMbrRecipientsByRecipientsNo(int recipientsNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("srchRecipientsNo", recipientsNo);
		return mbrRecipientsDAO.selectMbrRecipients(paramMap);
	}
	
	public MbrRecipientsVO selectMainMbrRecipientsByMbrUniqueId(String srchMbrUniqueId) throws Exception {
		if (EgovStringUtil.isEmpty(srchMbrUniqueId)){
			return null;
		}

		List<MbrRecipientsVO> mbrRecipientList = mbrRecipientsDAO.selectMbrRecipientsByMbrUniqueId(srchMbrUniqueId);

		MbrRecipientsVO recipient = mbrRecipientList.stream().filter(f -> "Y".equals(f.getMainYn())).findAny().orElse(null);
		if (recipient == null && mbrRecipientList.size() > 0){
			recipient = mbrRecipientList.get(0);
		}

		return recipient;
	}
	
	public MbrRecipientsVO selectMbrRecipientsByNoOrMain(String mbrUniqueId, Integer recipientsNo) throws Exception {
		MbrRecipientsVO mbrRecipientsVO = null;

		if (recipientsNo != null && recipientsNo != 0) {
			mbrRecipientsVO = this.selectMbrRecipientsByRecipientsNo(recipientsNo);
		}

		if (mbrRecipientsVO != null){
			return mbrRecipientsVO;
		}

		return this.selectMainMbrRecipientsByMbrUniqueId(mbrUniqueId);
	}

	public List<MbrRecipientsVO> selectMbrRecipientsByMbrUniqueId(String srchMbrUniqueId) throws Exception {
		return mbrRecipientsDAO.selectMbrRecipientsByMbrUniqueId(srchMbrUniqueId);
	}

	public int selectCountMbrRecipientsByMbrUniqueId(String srchMbrUniqueId) throws Exception {
		List<MbrRecipientsVO> recipientsList = this.selectMbrRecipientsByMbrUniqueId(srchMbrUniqueId);

		return recipientsList.size();
	}
	
	public CommonCheckVO insertCheckMbrRecipients(String mbrUniqueId, Map<String,Object> reqMap) throws Exception {
		CommonCheckVO checkVO = new CommonCheckVO();
		checkVO.setSuccess(false);

		if (mbrUniqueId == null || mbrUniqueId.length() < 3){
			checkVO.setErrorMsg("로그인 이후 이용가능합니다");
			return checkVO;
		}


		List<MbrRecipientsVO> mbrRecipientList = mbrRecipientsDAO.selectMbrRecipientsByMbrUniqueId(mbrUniqueId);

		if (mbrRecipientList.size() > 3) {
			checkVO.setErrorMsg("더 이상 수급자(어르신)를 등록할 수 없습니다");
			return checkVO;
		}

		if (reqMap.get("relationCd") != null && reqMap.get("relationCd").toString().length() > 0){
			String relationCd = reqMap.get("relationCd").toString();

			//본인은 한명만 등록이 가능
			if ("007".equals(relationCd)) {
				boolean alreadyExistMe = mbrRecipientList.stream().anyMatch(mr -> "007".equals(mr.getRelationCd()));
				if (alreadyExistMe) {
					checkVO.setErrorMsg("이미 본인으로 등록한 수급자(어르신)가 존재합니다");
					return checkVO;
				}
			}
	
			//배우자는 한명만 등록이 가능
			if ("001".equals(relationCd)) {
				boolean alreadyExistSpouse = mbrRecipientList.stream().anyMatch(mr -> "001".equals(mr.getRelationCd()));
				if (alreadyExistSpouse) {
					checkVO.setErrorMsg("이미 배우자로 등록한 수급자(어르신)가 존재합니다");
					return checkVO;
				}
			}
		}
		
		
		if (reqMap.get("recipientsNm") != null && reqMap.get("recipientsNm").toString().length() > 0){
			String recipientsNm = reqMap.get("recipientsNm").toString();
			
			if (mbrRecipientList.stream().filter(f -> recipientsNm.equals(f.getRecipientsNm())).count() > 0) {
				checkVO.setErrorMsg("이미 등록한 다른 수급자(어르신) 성함으로 변경할 수 없습니다");
				return checkVO;
			}
		}

		checkVO.setSuccess(true);
		return checkVO;
	}
	
	public void insertMbrRecipients(MbrRecipientsVO mbrRecipientsVO) {
		mbrRecipientsDAO.insertMbrRecipients(mbrRecipientsVO);
	}
	
	public void insertMbrRecipients(MbrRecipientsVO[] mbrRecipientsArray) {
		int lenth = mbrRecipientsArray.length > 4 ? 4 : mbrRecipientsArray.length;
		
		//최대 4명까지 수급자 등록 가능
		for (int i = 0; i < lenth; i++) {
			mbrRecipientsDAO.insertMbrRecipients(mbrRecipientsArray[i]);
		}
	}
	
	public void updateMbrRecipients(MbrRecipientsVO mbrRecipientsVO) {
		mbrRecipientsDAO.updateMbrRecipients(mbrRecipientsVO);
	}
	
	
	//대표 수급자 변경
	public Map<String, Object> updateMainRecipient(String uniqueId, Integer recipientsNo) {
		Map <String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<MbrRecipientsVO> mbrRecipientList = selectMbrRecipientsByMbrUniqueId(uniqueId);
			MbrRecipientsVO srchRecipient = mbrRecipientList.stream().filter(f -> f.getRecipientsNo() == recipientsNo).findAny().orElse(null);
			if (srchRecipient == null) {
				resultMap.put("success", false);
				resultMap.put("msg", "회원에 등록되지 않은 수급자입니다");
				return resultMap;
			}
			
			for (MbrRecipientsVO mbrRecipient : mbrRecipientList) {
				if (mbrRecipient.getRecipientsNo() == recipientsNo) {
					mbrRecipient.setMainYn("Y");
				} else {
					mbrRecipient.setMainYn("N");
				}
				updateMbrRecipients(mbrRecipient);
			}
			resultMap.put("success", true);
		} catch (Exception ex) {
			resultMap.put("success", false);
			resultMap.put("msg", "메인 수급자 변경 중 오류가 발생하였습니다");
		}
		
		return resultMap;
	}
	
	//수급자 삭제(update)
	public Map<String, Object> removeMbrRecipient(int recipientsNo, MbrVO sessionVO) {
		Map <String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			//삭제전에 1:1 상담중인지 검사
			MbrConsltVO mbrConslt = mbrConsltService.selectRecentConsltByRecipientsNo(recipientsNo);
			if (mbrConslt != null && 
					("CS01".equals(mbrConslt.getConsltSttus()) ||
					"CS02".equals(mbrConslt.getConsltSttus()) ||
					"CS05".equals(mbrConslt.getConsltSttus()) ||
					"CS07".equals(mbrConslt.getConsltSttus()) ||
					"CS08".equals(mbrConslt.getConsltSttus()))) {
				resultMap.put("success", false);
				resultMap.put("msg", "진행중인 상담이 있습니다");
				return resultMap;
			}
			
			List<MbrRecipientsVO> mbrRecipientList = selectMbrRecipientsByMbrUniqueId(sessionVO.getUniqueId());
			MbrRecipientsVO mbrRecipient = mbrRecipientList.stream().filter(f -> f.getRecipientsNo() == recipientsNo).findAny().orElse(null);
			
			//삭제처리
			mbrRecipient.setDelDt(new Date());
			mbrRecipient.setDelYn("Y");
			mbrRecipient.setDelMbrUniqueId(sessionVO.getUniqueId());
			
			updateMbrRecipients(mbrRecipient);
			
			resultMap.put("success", true);
		} catch (Exception ex) {
			resultMap.put("success", false);
			resultMap.put("msg", "수급자 삭제 중 오류가 발생하였습니다");
		}
		
		return resultMap;
	}
}
