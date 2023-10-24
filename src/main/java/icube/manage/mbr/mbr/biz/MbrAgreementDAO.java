package icube.manage.mbr.mbr.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("mbrAgreementDAO")
public class MbrAgreementDAO extends CommonAbstractMapper {
	
	public List<MbrAgreementVO> selectMbrAgreementListAll(Map<String, Object> paramMap) throws Exception {
		return selectList("mbr.agreement.selectMbrAgreement", paramMap);
	}
	
	public MbrAgreementVO selectMbrAgreementByMbrUniqueId(String uniqueId) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("srchMbrUniqueId", uniqueId);
		return selectOne("mbr.agreement.selectMbrAgreement", paramMap);
	}
	
	public void insertMbrAgreement(MbrAgreementVO mbrAgreementVO) throws Exception {
		insert("mbr.agreement.insertMbrAgreement", mbrAgreementVO);
	}
}
