package icube.manage.mbr.recipients.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("mbrRecipientsGdsDAO")
public class MbrRecipientsGdsDAO extends CommonAbstractMapper {
	public List<MbrRecipientsGdsVO> selectMbrRecipientsGds(Map<String, Object> paramMap) throws Exception {
		return selectList("mbr.recipients.gds.selectMbrRecipientsGds", paramMap);
	}
	
	public Integer insertMbrRecipientsGds(MbrRecipientsGdsVO mbrRecipientsGdsVO) throws Exception {
		return insert("mbr.recipients.gds.insertMbrRecipientsGds", mbrRecipientsGdsVO);
	}
	
	public Integer deleteMbrRecipientsGds(Map<String, Object> paramMap) throws Exception {
		return delete("mbr.recipients.gds.deleteMbrRecipientsGds", paramMap);
	}
}
