package icube.manage.dashboard;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.manage.dashboard.biz.DashboardService;
import icube.manage.ordr.ordr.biz.OrdrService;
import icube.manage.sysmng.menu.biz.MngMenuService;
import icube.manage.sysmng.menu.biz.MngMenuVO;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Controller
public class MDashboardController extends CommonAbstractController {

	@Resource(name = "dashboardService")
	private DashboardService dashboardService;

	@Resource(name = "ordrService")
	private OrdrService ordrService;
	
	@Resource(name="mngMenuService")
	private MngMenuService mngMenuService;
	
	@Autowired
	private MngrSession mngrSession;

	@RequestMapping(value = "/_mng/intro")
	public String intro(
			HttpServletRequest request) throws Exception {
		List<MngMenuVO> mngMenuList = mngrSession.getMngMenuList();
		
		Map<String, Boolean> menuAuthMap = new HashMap<>();
		for (MngMenuVO menuVO : mngMenuList) {
			switch (menuVO.getMenuNm()) {
				case "대시보드" : menuAuthMap.put("대시보드", true); break;
				case "회원" : menuAuthMap.put("회원", true); break;
				case "상품" : menuAuthMap.put("상품", true); break;
				case "주문" : menuAuthMap.put("주문", true); break;
				case "전시" : menuAuthMap.put("전시", true); break;
				case "프로모션" : menuAuthMap.put("프로모션", true); break;
				case "고객상담" : menuAuthMap.put("고객상담", true); break;
				case "시스템" : menuAuthMap.put("시스템", true); break;
				case "통계" : menuAuthMap.put("통계", true); break;
				case "멤버스" : menuAuthMap.put("멤버스", true); break;
				case "정산" : menuAuthMap.put("정산", true); break;
				default : break;
			}
		}
		
		request.setAttribute("menuAuthMap", menuAuthMap);
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
