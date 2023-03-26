package icube.manage.dashboard;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.manage.dashboard.biz.DashboardService;
import icube.manage.ordr.ordr.biz.OrdrService;

@Controller
public class MDashboardController extends CommonAbstractController {

	@Resource(name = "dashboardService")
	private DashboardService dashboardService;

	@Resource(name = "ordrService")
	private OrdrService ordrService;

	@RequestMapping(value = "/_mng/intro")
	public String intro(
			HttpServletRequest request) throws Exception {

		return "/manage/dashboard/intro";
	}


	/**
	 * 관리자 대쉬보드
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/_mng/dashboard")
	public String dashboard(
			HttpServletRequest request
			, Model model
			) throws Exception {

		Map<String, Object> dsbdCount = dashboardService.selectTotalCount();

		// 전체 회원 누계
		String mbrTotal = EgovStringUtil.long2string((long)dsbdCount.get("mberTotal"));
		String mTotal = EgovStringUtil.lPad(mbrTotal, 8, '_');
		dsbdCount.put("mbrTotal",mTotal);

		// 전체 사업소 누계
		String bplcTotal = EgovStringUtil.long2string((long)dsbdCount.get("bplcTotals"));
		String bTotal = EgovStringUtil.lPad(bplcTotal, 7, '_');
		dsbdCount.put("bplcTotal",bTotal);

		// 최근 1개월 주문과정
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchDate", "1");
		Map<String, Integer> ordrCnt = ordrService.selectSttsTyCnt(paramMap);

		model.addAttribute("dsbdCount", dsbdCount);
		model.addAttribute("ordrCnt", ordrCnt);

		return "/manage/dashboard/dashboard";
	}

	/**
	 * 차트 데이터
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/_mng/dashboard/chartData")
	@ResponseBody
	public Map<String, Object> charMap(
			HttpServletRequest request
			, Model model
			)throws Exception {

		Map<String, Object> resultMap = dashboardService.selectChartData();


		return resultMap;
	}


	//임시페이지
	@RequestMapping(value = "/_mng/comment")
	public String comment(
			HttpServletRequest request) throws Exception {


		return "/manage/dashboard/comment";
	}
}
