package icube.manage.ordr.chghist.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("ordrChgHistDAO")
public class OrdrChgHistDAO extends CommonAbstractMapper {

	public List<OrdrChgHistVO> selectOrdrChgHistList(Map<String, Object> paramMap) throws Exception {
		return selectList("ordr.chg.selectOrdrChgHistListAll", paramMap);
	}

	public OrdrChgHistVO selectOrdrChgHist(Map<String, Object> paramMap) throws Exception {
		return selectOne("ordr.chg.selectOrdrChgHist", paramMap);
	}

	public int insertOrdrChgHist(OrdrChgHistVO ordrChgHistVO) throws Exception {
		return insert("ordr.chg.insertOrdrChgHist", ordrChgHistVO);
	}

	// public void deleteOrdrChgHist(int chgNo) throws Exception {
	// 	delete("ordr.chg.deleteOrdrChgHist", chgNo);
	// }



}
