package icube.manage.dashboard.biz;

import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("dashboardDAO")
public class DashboardDAO extends CommonAbstractMapper {

	// 카운트 맵
	public Map<String, Object> selectTotalCount() throws Exception {
		return selectOne("dsbd.selectTotalCount");
	}

	// 차트 데이터 맵
	public Map<String, Object> selectChartData() throws Exception {
		return selectOne("dsbd.selectChartData");
	}


}