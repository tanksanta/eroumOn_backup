package icube.manage.mbr.mbr.biz;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("mbrAgreementDAO")
public class MbrAgreementDAO extends CommonAbstractMapper {
	
	public void insertMbrAgreement(MbrAgreementVO mbrAgreementVO) throws Exception {
		insert("mbr.agreement.insertMbrAgreement", mbrAgreementVO);
	}
}
