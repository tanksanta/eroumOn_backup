package icube.manage.stats.sales.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("statsSalesDAO")
public class StatsSalesDAO extends CommonAbstractMapper {

	// 판매실적
	public List<StatsSalesVO> selectPrfmncList(Map<String, Object> paramMap) throws Exception {
		return selectList("stats.sales.selectPrfmncList", paramMap);
	}

	// 판매상품
	public List<StatsSalesVO> selectGoodsList(Map<String, Object> paramMap) throws Exception {
		return selectList("stats.sales.selectGoodsList", paramMap);
	}

	// 성별/연령별
	public List<StatsSalesVO> selectTrprList(Map<String, Object> paramMap) throws Exception {
		return selectList("stats.sales.selectTrprList", paramMap);
	}

	// 파트너별
	public List<StatsSalesVO> selectPartnerList(Map<String, Object> paramMap) throws Exception {
		return selectList("stats.sales.selectPartnerList", paramMap);
	}

	// 마일리지
	public List<StatsSalesVO> selectMlgList(Map<String, Object> paramMap) throws Exception {
		return selectList("stats.sales.selectMlgList", paramMap);
	}

	// 포인트
	public List<StatsSalesVO> selectPointList(Map<String, Object> paramMap) throws Exception {
		return selectList("stats.sales.selectPointList", paramMap);
	}

	// 결제수단
	public List<StatsSalesVO> selectStlmTyList(Map<String, Object> paramMap) throws Exception {
		return selectList("stats.sales.selectStlmTyList", paramMap);
	}

	// 카드회사
	public List<StatsSalesVO> selectCardCoList(Map<String, Object> paramMap) throws Exception {
		return selectList("stats.sales.selectCardCoList", paramMap);
	}

	// 카드회사 목록
	public List<Map<String, Object>> selectCardCoNmList() throws Exception {
		return selectList("stats.sales.selectCardCoNmList");
	}

}
