package icube.manage.sysmng.entrps.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("entrpsDlvyGrpDAO")
public class EntrpsDlvyGrpDAO extends CommonAbstractMapper {

	public CommonListVO entrpsDlvyGrpListVO(CommonListVO listVO) throws Exception {
		return selectListVO("entrps.dlvygrp.selectEntrpsDlvyGrpCount", "entrps.dlvygrp.selectEntrpsDlvyGrpListVO", listVO);
	}

	public EntrpsVO selectEntrpsDlvyGrp(int entrpsDlvyGrpNo) throws Exception {
		return (EntrpsVO)selectOne("entrps.dlvygrp.selectEntrpsDlvyGrp", entrpsDlvyGrpNo);
	}

	public List<EntrpsVO> selectEntrpsDlvyGrpListAll(Map<String, Object> paramMap) throws Exception {
		return selectList("entrps.dlvygrp.selectEntrpsDlvyGrpListAll",paramMap);
	}
		
	// public EntrpsVO selectEntrpsByGdsNo(int gdsNo) throws Exception {
	// 	Map<String, Object> paramMap = new HashMap<String, Object>();
	// 	paramMap.put("srchGdsNo", gdsNo);
	// 	return (EntrpsVO)selectOne("entrps.selectEntrpsDlvyGrpByGdsNo", paramMap);
	// }

	// public void insertEntrps(EntrpsVO entrpsVO) throws Exception {
	// 	insert("entrps.insertEntrps", entrpsVO);
	// }

	// public void updateEntrps(EntrpsVO entrpsVO) throws Exception {
	// 	update("entrps.updateEntrps", entrpsVO);
	// }

	// public void deleteEntrps(int entrpsNo) throws Exception {
	// 	delete("entrps.deleteEntrps", entrpsNo);
	// }

	

}