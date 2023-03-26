package icube.manage.sysmng.mngr.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@SuppressWarnings("rawtypes")
@Repository("mngrDAO")
public class MngrDAO extends CommonAbstractMapper {

	public CommonListVO selectMngrListVO(CommonListVO listVO) throws Exception {
		return selectListVO("sysmng.mngr.selectCount", "sysmng.mngr.selectListVO", listVO);
	}

	public List selectMenuMngrList(Map paramMap) throws Exception{
		return selectList("sysmng.mngr.selectMenuMngrList", paramMap);
	}

	public MngrVO selectMngr(Map<String, String> paramMap) throws Exception {
		return (MngrVO) selectOne("sysmng.mngr.selectMngr", paramMap);
	}

	public void insertMngr(MngrVO mngrVO) throws Exception {
		insert("sysmng.mngr.insertMngr", mngrVO);
	}

	public void updateMngr(MngrVO mngrVO) throws Exception {
		update("sysmng.mngr.updateMngr", mngrVO);
	}

	public Map mngrIdCheck(Map paramMap) throws Exception {
		return (Map) selectOne("sysmng.mngr.selectMngrIdCheck", paramMap);
	}

	public MngrVO selectMngrByUniqueId(String uniqueId) throws Exception {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("uniqueId", uniqueId);
		return (MngrVO)selectOne("sysmng.mngr.selectMngr", paramMap);
	}

	public String selectMngrPwCheck(String mngrId, String mngrPassword) throws Exception {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("mngrId", mngrId);
		paramMap.put("mngrPassword", mngrPassword);
		return (String)selectOne("sysmng.mngr.selectMngrPwCheck", paramMap);
	}

	public int selectFailedLoginCount(MngrVO mngrVO) {
		return selectOne("sysmng.mngr.selectFailedLoginCount", mngrVO);
	}

	public int updateFailedLoginCountUp(MngrVO mngrVO) {
		return update("sysmng.mngr.updateFailedLoginCountUp", mngrVO);
	}

	public int updateFailedLoginCountReset(MngrVO mngrVO) {
		return update("sysmng.mngr.updateFailedLoginCountReset", mngrVO);
	}

	public int updateMngrPswd(MngrVO mngrVO) throws Exception {
		return update("sysmng.mngr.updateMngrPswd", mngrVO);
	}

	public void updateMngrProflImg(MngrVO mngrVO) throws Exception {
		update("sysmng.mngr.updateMngrProflImg", mngrVO);
	}
}
