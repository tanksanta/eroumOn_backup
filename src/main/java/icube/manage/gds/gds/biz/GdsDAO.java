package icube.manage.gds.gds.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("gdsDAO")
public class GdsDAO extends CommonAbstractMapper {

	public CommonListVO gdsListVO(CommonListVO listVO) throws Exception {
		return selectListVO("gds.gds.selectGdsCount", "gds.gds.selectGdsListVO", listVO);
	}

	public GdsVO selectGds(int gdsNo) throws Exception {
		return (GdsVO)selectOne("gds.gds.selectGds", gdsNo);
	}

	public GdsVO selectGdsByFilter(Map<String, Object> paramMap) throws Exception {
		return (GdsVO)selectOne("gds.gds.selectGds", paramMap);
	}

	public void insertGds(GdsVO gdsVO) throws Exception {
		insert("gds.gds.insertGds", gdsVO);
	}

	public void updateGds(GdsVO gdsVO) throws Exception {
		update("gds.gds.updateGds", gdsVO);
	}

	public void deleteGds(int gdsNo) throws Exception {
		delete("gds.gds.deleteGds", gdsNo);
	}

	public Integer updateGdsUseYn(Map<String, Object> paramMap) throws Exception {
		return update("gds.gds.updateGdsUseYn", paramMap);
	}

	public Integer updateGdsListUseYn(GdsVO gdsVO) throws Exception {
		return update("gds.gds.updateGdsListUseYn", gdsVO);
	}

	public List<GdsVO> selectGdsListAll(Map<String, Object> paramMap) throws Exception {
		return selectList("gds.gds.selectGdsListAll", paramMap);
	}

	public void updateGdsStockQy(Map<String, Object> stockQyPlus) throws Exception {
		selectList("gds.gds.updateGdsStockQy", stockQyPlus);
	}

	public void updateInqcnt(GdsVO gdsVO) throws Exception {
		update("gds.gds.updateInqcnt", gdsVO);
	}

	public int selectGdsCnt(Map<String, Object> paramMap) throws Exception {
		return selectOne("gds.gds.selectGdsCount", paramMap);
	}

	public void updateGdsUseNStock(Map<String, Object> paramMap) throws Exception {
		update("gds.gds.updateGdsUseNStock",paramMap);
	}

	public void updateEroumGds(Map<String, Object> paramMap) throws Exception {
		update("gds.gds.updateEroumGds",paramMap);
	}

	public void updateGdsTag(Map<String, Object> paramMap) throws Exception {
		update("gds.gds.updateGdsTag",paramMap);
	}

}