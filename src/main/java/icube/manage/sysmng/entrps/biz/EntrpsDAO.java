package icube.manage.sysmng.entrps.biz;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("entrpsDAO")
public class EntrpsDAO extends CommonAbstractMapper {

	public CommonListVO entrpsListVO(CommonListVO listVO) throws Exception {
		return selectListVO("entrps.selectEntrpsCount", "entrps.selectEntrpsListVO", listVO);
	}

	public EntrpsVO selectEntrps(int entrpsNo) throws Exception {
		return (EntrpsVO)selectOne("entrps.selectEntrps", entrpsNo);
	}

	public void insertEntrps(EntrpsVO entrpsVO) throws Exception {
		insert("entrps.insertEntrps", entrpsVO);
	}

	public void updateEntrps(EntrpsVO entrpsVO) throws Exception {
		update("entrps.updateEntrps", entrpsVO);
	}

	public void deleteEntrps(int entrpsNo) throws Exception {
		delete("entrps.deleteEntrps", entrpsNo);
	}

}