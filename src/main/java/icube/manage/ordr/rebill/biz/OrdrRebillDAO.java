package icube.manage.ordr.rebill.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;
import icube.manage.ordr.ordr.biz.OrdrVO;

@Repository("ordrRebillDAO")
public class OrdrRebillDAO extends CommonAbstractMapper {

	public CommonListVO ordrRebillListVO(CommonListVO listVO) throws Exception {
		return selectListVO("ordr.rebill.selectOrdrRebillCount", "ordr.rebill.selectOrdrRebillListVO", listVO);
	}

	public List<OrdrRebillVO> selectOrdrRebillListAll(Map<String, Object> paramMap) throws Exception {
		return selectList("ordr.rebill.selectOrdrRebillListAll", paramMap);
	}

	public OrdrRebillVO selectOrdrRebill(Map<String, Object> paramMap) throws Exception {
		return selectOne("ordr.rebill.selectOrdrRebill", paramMap);
	}

	public void insertOrdrRebill(OrdrRebillVO ordrRebillVO) throws Exception {
		insert("ordr.rebill.insertOrdrRebill", ordrRebillVO);
	}

	public List<OrdrVO> selectRebillList(Map<String, Object> paramMap) throws Exception {
		return selectList("ordr.rebill.selectRebillList", paramMap);
	}



}
