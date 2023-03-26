package icube.manage.gds.stock.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;
import icube.manage.gds.gds.biz.GdsVO;

@Repository("gdsStockDAO")
public class GdsStockDAO extends CommonAbstractMapper {

	public CommonListVO gdsStockListVO(CommonListVO listVO) throws Exception {
		return selectListVO("gds.gds.selectGdsStockCount", "gds.gds.selectGdsStockListVO", listVO);
	}

	public void updateGdsStock(Map<String, Object> paramMap) throws Exception {
		update("gds.gds.updateGdsStock",paramMap);
	}

	public List<GdsVO> gdsStockListAll(Map<String, Object> reqMap) throws Exception {
		return selectList("gds.gds.gdsStockListAll", reqMap);
	}

}