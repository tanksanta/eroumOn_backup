package icube.manage.sysmng.entrps.biz;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("entrpsDlvyGrpDAO")
public class EntrpsDlvyGrpDAO extends CommonAbstractMapper {

	public CommonListVO entrpsDlvyGrpListVO(CommonListVO listVO) throws Exception {
		return selectListVO("entrps.dlvygrp.selectEntrpsDlvyGrpCount", "entrps.dlvygrp.selectEntrpsDlvyGrpListVO", listVO);
	}

	public EntrpsVO selectEntrpsDlvyGrp(int entrpsDlvygrpNo) throws Exception {
		return (EntrpsVO)selectOne("entrps.dlvygrp.selectEntrpsDlvyGrp", entrpsDlvygrpNo);
	}

	// public List<EntrpsVO> selectEntrpsDlvyGrpListAll(Map<String, Object> paramMap) throws Exception {
	// 	return selectList("entrps.dlvygrp.selectEntrpsDlvyGrpListAll",paramMap);
	// }
		
	public EntrpsDlvyGrpVO selectEntrpsDlvyGrpByNo(int entrpsDlvygrpNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchEntrpsDlvygrpNo", entrpsDlvygrpNo);
		return (EntrpsDlvyGrpVO)selectOne("entrps.dlvygrp.selectEntrpsDlvyGrpByNo", paramMap);
	}

	public void insertEntrpsDlvyGrp(EntrpsDlvyGrpVO entrpsDlvygrpVO) throws Exception {
		insert("entrps.dlvygrp.insertEntrpsDlvyGrp", entrpsDlvygrpVO);
	}

	public void updateEntrpsDlvyGrp(EntrpsDlvyGrpVO entrpsDlvygrpVO) throws Exception {
		update("entrps.dlvygrp.updateEntrpsDlvyGrp", entrpsDlvygrpVO);
	}

	public void deleteEntrpsDlvyGrp(EntrpsDlvyGrpVO entrpsDlvygrpVO) throws Exception {
		delete("entrps.dlvygrp.deleteEntrpsDlvyGrp", entrpsDlvygrpVO);
	}

	

}