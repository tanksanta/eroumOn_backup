package icube.manage.mbr.recipients.biz;

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

	public List<MbrRecipientsVO> selectMbrRecipientsByMbrUniqueId(String srchMbrUniqueId) throws Exception {
		return mbrRecipientsDAO.selectMbrRecipientsByMbrUniqueId(srchMbrUniqueId);
	}
	
	public void insertMbrRecipients(MbrRecipientsVO mbrRecipientsVO) {
		mbrRecipientsDAO.insertMbrRecipients(mbrRecipientsVO);
	}
	
	public void updateMbrRecipients(MbrRecipientsVO mbrRecipientsVO) {
		mbrRecipientsDAO.updateMbrRecipients(mbrRecipientsVO);
	}
}
