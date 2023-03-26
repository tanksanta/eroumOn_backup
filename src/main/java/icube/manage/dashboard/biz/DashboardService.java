package icube.manage.dashboard.biz;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;

@Service("dashboardService")
public class DashboardService extends CommonAbstractServiceImpl {

	@Resource(name = "dashboardDAO")
	private DashboardDAO dashboardDAO;

	/**
	 * 카운트 맵
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectTotalCount() throws Exception{
		return dashboardDAO.selectTotalCount();
	}

	/**
	 * 차트 데이터
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectChartData() throws Exception {
		return dashboardDAO.selectChartData();
	}

}