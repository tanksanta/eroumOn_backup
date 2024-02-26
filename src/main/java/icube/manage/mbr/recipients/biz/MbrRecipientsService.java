package icube.manage.mbr.recipients.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;

@Service("mbrRecipientsService")
public class MbrRecipientsService extends CommonAbstractServiceImpl {
	
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
		List<MbrRecipientsVO> mbrRecipientList = mbrRecipientsDAO.selectMbrRecipientsByMbrUniqueId(srchMbrUniqueId);

		MbrRecipientsVO recipient = mbrRecipientList.stream().filter(f -> "Y".equals(f.getMainYn())).findAny().orElse(null);
		if (recipient == null){
			recipient = mbrRecipientList.get(0);
		}

		return recipient;
	}
	
	public List<MbrRecipientsVO> selectMbrRecipientsByMbrUniqueId(String srchMbrUniqueId) throws Exception {
		return mbrRecipientsDAO.selectMbrRecipientsByMbrUniqueId(srchMbrUniqueId);
	}

	public int selectCountMbrRecipientsByMbrUniqueId(String srchMbrUniqueId) throws Exception {
		List<MbrRecipientsVO> recipientsList = this.selectMbrRecipientsByMbrUniqueId(srchMbrUniqueId);

		return recipientsList.size();
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
}
