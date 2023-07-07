package icube.manage.sysmng.entrps.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	public EntrpsVO selectEntrpsByGdsNo(int gdsNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchGdsNo", gdsNo);
		return (EntrpsVO)selectOne("entrps.selectEntrpsByGdsNo", paramMap);
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

	public List<EntrpsVO> selectEntrpsListAll(Map<String, Object> paramMap) throws Exception {
		return selectList("entrps.selectEntrpsListAll",paramMap);
	}

}