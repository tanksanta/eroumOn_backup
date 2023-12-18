package icube.manage.sysmng.entrps.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("entrpsDlvygrpDAO")
public class EntrpsDlvygrpDAO extends CommonAbstractMapper {

	public CommonListVO entrpsDlvyGrpListVO(CommonListVO listVO) throws Exception {
		return selectListVO("entrps.dlvygrp.selectEntrpsDlvyGrpCount", "entrps.dlvygrp.selectEntrpsDlvyGrpListVO", listVO);
	}

	public EntrpsVO selectEntrpsDlvyGrp(int entrpsDlvygrpNo) throws Exception {
		return (EntrpsVO)selectOne("entrps.dlvygrp.selectEntrpsDlvyGrp", entrpsDlvygrpNo);
	}

	// public List<EntrpsVO> selectEntrpsDlvyGrpListAll(Map<String, Object> paramMap) throws Exception {
	// 	return selectList("entrps.dlvygrp.selectEntrpsDlvyGrpListAll",paramMap);
	// }
		
	public EntrpsDlvygrpVO selectEntrpsDlvyGrpByNo(int entrpsDlvygrpNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchEntrpsDlvygrpNo", entrpsDlvygrpNo);
		return (EntrpsDlvygrpVO)selectOne("entrps.dlvygrp.selectEntrpsDlvyGrpByNo", paramMap);
	}

	public void insertEntrpsDlvyGrp(EntrpsDlvygrpVO entrpsDlvygrpVO) throws Exception {
		insert("entrps.dlvygrp.insertEntrpsDlvyGrp", entrpsDlvygrpVO);
	}

	public void updateEntrpsDlvyGrp(EntrpsDlvygrpVO entrpsDlvygrpVO) throws Exception {
		update("entrps.dlvygrp.updateEntrpsDlvyGrp", entrpsDlvygrpVO);
	}

	public void deleteEntrpsDlvyGrp(int entrpsNo, int entrpsDlvygrpNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("entrpsNo", entrpsNo);
		paramMap.put("entrpsDlvygrpNo", entrpsDlvygrpNo);

		delete("entrps.dlvygrp.deleteEntrpsDlvyGrp", paramMap);
	}

	

}