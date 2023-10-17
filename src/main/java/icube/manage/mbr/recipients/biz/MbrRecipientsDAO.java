package icube.manage.mbr.recipients.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("mbrRecipientsDAO")
public class MbrRecipientsDAO extends CommonAbstractMapper {
	
	public List<MbrRecipientsVO> selectMbrRecipientsList(Map<String, Object> paramMap) throws Exception {
		return selectList("mbr.recipients.selectMbrRecipients", paramMap);
	}

	public List<MbrRecipientsVO> selectMbrRecipientsByMbrUniqueId(String srchMbrUniqueId) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("srchMbrUniqueId", srchMbrUniqueId);
		return selectMbrRecipientsList(paramMap);
	}
	
	public void insertMbrRecipients(MbrRecipientsVO mbrRecipientsVO) {
		insert("mbr.recipients.insertMbrRecipients", mbrRecipientsVO);
	}
	
	public void updateMbrRecipients(MbrRecipientsVO mbrRecipientsVO) {
		update("mbr.recipients.updateMbrRecipients", mbrRecipientsVO);
	}
}
