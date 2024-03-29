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
	
	public List<MbrRecipientsVO> selectMbrRecipientsByMbrUniqueId(String srchMbrUniqueId) throws Exception {
		return mbrRecipientsDAO.selectMbrRecipientsByMbrUniqueId(srchMbrUniqueId);
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
}
