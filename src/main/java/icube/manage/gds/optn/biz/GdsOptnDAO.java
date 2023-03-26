package icube.manage.gds.optn.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("gdsOptnDAO")
public class GdsOptnDAO extends CommonAbstractMapper {

	public List<GdsOptnVO> selectGdsOptnList(Map<String, Object> paramMap) throws Exception {
		return selectList("gds.optn.selectGdsOptnList", paramMap);
	}

	public void updateGdsOptn(GdsOptnVO gdsOptnVO) throws Exception {
		insert("gds.optn.updateGdsOptn", gdsOptnVO);
	}

	public void insertGdsOptn(GdsOptnVO gdsOptnVO) throws Exception {
		update("gds.optn.insertGdsOptn", gdsOptnVO);
	}

	public void deleteGdsOptn(Map<String, Object> paramMap) throws Exception {
		delete("gds.optn.deleteGdsOptn", paramMap);
	}

	public void updateGdsOptnStockQy(Map<String, Object> paramMap) throws Exception {
		update("gds.optn.updateGdsOptnStockQy", paramMap);

	}

	public void updateOptnUseNStock(Map<String, Object> paramMap) throws Exception {
		update("gds.optn.updateOptnUseNStock",paramMap);
	}

	public GdsOptnVO selectGdsOptn(Map<String, Object> optnMap) throws Exception {
		return selectOne("gds.optn.selectGdsOptn",optnMap);
	}

	public void updateOptnStockQy(Map<String, Object> paramMap) throws Exception {
		update("gds.optn.updateOptnStockQy",paramMap);
	}


}
