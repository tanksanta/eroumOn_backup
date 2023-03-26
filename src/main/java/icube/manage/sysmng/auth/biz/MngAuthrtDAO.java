package icube.manage.sysmng.auth.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("mngAuthrtDAO")
public class MngAuthrtDAO extends CommonAbstractMapper {

	public CommonListVO selectMngAuthrtListVO(CommonListVO listVO) throws Exception {
		return selectListVO("sysmng.authrt.selectMngAuthrtListCount", "sysmng.authrt.selectMngAuthrtList", listVO);
	}

	public MngAuthrtVO selectMngAuthrt(int authrtNo) throws Exception {
		return (MngAuthrtVO)selectOne("sysmng.authrt.selectMngAuthrt", authrtNo);
	}

	public void insertMngAuthrt(MngAuthrtVO mngAuthrtVO) throws Exception {
		insert("sysmng.authrt.insertMngAuthrt", mngAuthrtVO);
	}

	public void updateMngAuthrt(MngAuthrtVO mngAuthrtVO) throws Exception {
		update("sysmng.authrt.updateMngAuthrt", mngAuthrtVO);
	}

	public void deleteMngAuthrt(Map<String, Object> paramMap) throws Exception {
		delete("sysmng.authrt.deleteMngAuthrt", paramMap);
	}

	public void deleteMngAuthrtMenu(Map<String, Object> paramMap) throws Exception {
		delete("sysmng.authrt.deleteMngAuthrtMenu", paramMap);
	}

	public void insertMngAuthrtMenu(MngAuthrtMenuVO mngAuthrtMenuVO) throws Exception {
		insert("sysmng.authrt.insertMngAuthrtMenu", mngAuthrtMenuVO);
	}

	public String selectMngAuthrtMenuGroup(Map<String, Object> paramMap) throws Exception {
		return selectOne("sysmng.authrt.selectMngAuthrtMenuGroup", paramMap);
	}

	public void deleteMngAuthrtMngMenu(Map<String, Object> paramMap) throws Exception {
		delete("sysmng.authrt.deleteMngAuthrtMngMenu", paramMap);
	}

	public void insertMngAuthrtMngMenu(MngAuthrtMenuVO mngAuthrtMenuVO) throws Exception {
		insert("sysmng.authrt.insertMngAuthrtMngMenu", mngAuthrtMenuVO);
	}

	public List<MngAuthrtVO> selectMngAuthrtListAll() throws Exception{
		return selectList("sysmng.authrt.selectMngAuthrtListAll");
	}
}
