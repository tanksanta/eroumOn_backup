package icube.manage.sysmng.bbs.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("bbsSetupDAO")
public class BbsSetupDAO extends CommonAbstractMapper {

	public CommonListVO selectBbsSetupListVO(CommonListVO listVO) throws Exception {
		return selectListVO("sysmng.bbs.setup.selectBbsSetupCount", "sysmng.bbs.setup.selectBbsSetupListVO", listVO);
	}

	public BbsSetupVO selectBbsSetup(Map<String, Object> paramMap) throws Exception {
		return selectOne("sysmng.bbs.setup.selectBbsSetup", paramMap);
	}

	public void insertBbsSetup(BbsSetupVO bbsSetupVO) throws Exception {
		insert("sysmng.bbs.setup.insertBbsSetup", bbsSetupVO);
	}

	public void updateBbsSetup(BbsSetupVO bbsSetupVO) throws Exception {
		update("sysmng.bbs.setup.updateBbsSetup", bbsSetupVO);
	}

	public void deleteBbsSetup(int bbsNo) throws Exception {
		delete("sysmng.bbs.setup.deleteBbsSetup", bbsNo);
	}

	public Integer updateBbsSetupUseYn(Map<String, Object> paramMap) throws Exception {
		return update("sysmng.bbs.setup.updateBbsSetupUseYn", paramMap);
	}

	/* Category Start */
	public void executeBbsCtgry(List<BbsCtgryVO> ctgryList) throws Exception {

		for (BbsCtgryVO ctgry : ctgryList) {
			switch (ctgry.getCrud()) {
			case CREATE:
				insert("bbs.ctgry.insertBbsCtgry", ctgry);
				break;
			case UPDATE:
				update("bbs.ctgry.updateBbsCtgry", ctgry);
				break;
			default:
				break;
			}
		}
	}

	public List<BbsCtgryVO> listCtgry(int bbsNo, String prefix, String useTy) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bbsNo", bbsNo);
		paramMap.put("prefix", prefix);
		paramMap.put("ctgryUseTy", useTy);
		return selectList("bbs.ctgry.listCtgry", paramMap);
	}
	/* Category End */

	/*
	public List<BbsSetupVO> selectAllBbsSetupList() throws Exception {
		return selectList("sysmng.bbs.setup.selectAllBbsSetupList");
	}
	*/

}
