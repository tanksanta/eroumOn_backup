package icube.manage.ordr.ordr.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("ordrDAO")
public class OrdrDAO extends CommonAbstractMapper {

	public CommonListVO ordrListVO(CommonListVO listVO) throws Exception {
		return selectListVO("ordr.selectOrdrCount", "ordr.selectOrdrListVO", listVO);
	}

	public CommonListVO ordrMyListVO(CommonListVO listVO) throws Exception {
		return selectListVO("mbr.buy.gds.selectOrdrMyCount", "mbr.buy.gds.selectOrdrMyListVO", listVO);
	}

	public OrdrVO selectOrdr(Map<String, Object> paramMap) throws Exception {
		return (OrdrVO)selectOne("ordr.selectOrdr", paramMap);
	}

	public void insertOrdr(OrdrVO ordrVO) throws Exception {
		insert("ordr.insertOrdr", ordrVO);
	}

	public void updateOrdr(OrdrVO ordrVO) throws Exception {
		update("ordr.updateOrdr", ordrVO);
	}

	public void deleteOrdr(int ordrNo) throws Exception {
		delete("ordr.deleteOrdr", ordrNo);
	}

	public Integer updateDlvyInfo(Map<String, Object> paramMap) throws Exception {
		return update("ordr.updateDlvyInfo", paramMap);
	}

	public void updateStlmAmt(OrdrVO ordrVO) throws Exception {
		update("ordr.updateStlmAmt", ordrVO);
	}
	
	public void updateUseMlg(OrdrVO ordrVO) throws Exception {
		update("ordr.updateUseMlg", ordrVO);
	}
	
	public void updateUsePoint(OrdrVO ordrVO) throws Exception {
		update("ordr.updateUsePoint", ordrVO);
	}

	public Map<String, Integer> selectSttsTyCnt(Map<String, Object> paramMap) throws Exception {
		return selectOne("ordr.selectSttsTyCnt", paramMap);
	}

	public List<OrdrVO> selectOrdrList(Map<String, Object> paramMap) throws Exception {
		return selectList("ordr.selectOrdrList",paramMap);
	}

	public void updateStlmYn(Map<String, Object> paramMap) throws Exception {
		update("ordr.updateStlmYn", paramMap);
	}

	public List<OrdrVO> selectOrdrSttsList(Map<String, Object> paramMap) throws Exception {
		return selectList("ordr.selectOrdrSttsList", paramMap);
	}

	public void updateBillingCancel(Map<String, Object> paramMap) throws Exception {
		update("ordr.updateBillingCancel", paramMap);
	}

	public void updateBillingChg(Map<String, Object> paramMap) throws Exception {
		update("ordr.updateBillingChg",paramMap);
	}

	public void updateOrdrByMap(Map<String, Object> paramMap) throws Exception {
		update("ordr.updateOrdrByMap",paramMap);
	}

	public List<OrdrVO> selectOrdrListAll(Map<String, Object> paramMap) throws Exception {
		return selectList("ordr.selectOrdrListAll",paramMap);
	}

}