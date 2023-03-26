package icube.manage.stats.sales.biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;

@Service("statsSalesService")
public class StatsSalesService extends CommonAbstractServiceImpl {

	@Resource(name = "statsSalesDAO")
	private StatsSalesDAO statsSalesDAO;

	public List<StatsSalesVO> selectPrfmncList(Map<String, Object> paramMap) throws Exception {
		return statsSalesDAO.selectPrfmncList(paramMap);
	}

	public List<StatsSalesVO> selectGoodsList(Map<String, Object> paramMap) throws Exception {
		return statsSalesDAO.selectGoodsList(paramMap);
	}

	public List<StatsSalesVO> selectTrprList(Map<String, Object> paramMap) throws Exception {
		return statsSalesDAO.selectTrprList(paramMap);
	}

	public List<StatsSalesVO> selectPartnerList(Map<String, Object> paramMap) throws Exception {
		return statsSalesDAO.selectPartnerList(paramMap);
	}

	public List<StatsSalesVO> selectMlgList(Map<String, Object> paramMap) throws Exception {
		return statsSalesDAO.selectMlgList(paramMap);
	}

	public List<StatsSalesVO> selectPointList(Map<String, Object> paramMap) throws Exception {
		return statsSalesDAO.selectPointList(paramMap);
	}

	public List<StatsSalesVO> selectStlmTyList(Map<String, Object> paramMap) throws Exception {
		return statsSalesDAO.selectStlmTyList(paramMap);
	}

	public List<StatsSalesVO> selectCardCoList(Map<String, Object> paramMap) throws Exception {
		return statsSalesDAO.selectCardCoList(paramMap);
	}

	public List<Map<String, Object>> selectCardCoNmList() throws Exception {
		return statsSalesDAO.selectCardCoNmList();
	}
}
