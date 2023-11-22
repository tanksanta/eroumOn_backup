package icube.main;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.common.api.biz.BokjiApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.members.stdg.biz.StdgCdService;
import icube.members.stdg.biz.StdgCdVO;

/**
 * URL 최초 요청 시 표출(Home 랜딩 페이지)
 */
@Controller
public class HomeController extends CommonAbstractController {
	
	@Resource(name = "stdgCdService")
	private StdgCdService stdgCdService;
	
	@Resource(name="bokjiService")
	private BokjiApiService bokjiService;
	
	// INDEX
	@RequestMapping(value={"/", "index"})
	public String index(
			HttpServletRequest request
			, Model model) throws Exception {
		
		// 행정구역 목록
		List<StdgCdVO> stdgCdList = stdgCdService.selectStdgCdListAll(1);
		model.addAttribute("stdgCdList", stdgCdList);
		
		// 복지 제도 개수
		String bokjisUrl = "/api/partner/v2/bokjis/count";
		String prvdUrl = "/api/partner/v2/providers/count";

		int bokjisCnt = 0;
		int prvdCnt = 0;

		try {// 첫화면 부터 에러나지 않도록..
			bokjisCnt = bokjiService.getBokjisCnt(bokjisUrl);
			//prvdCnt = bokjiService.getBokjisCnt(prvdUrl);
		}catch(Exception e) {
			log.debug(e.getMessage());
		}

		int total = bokjisCnt + prvdCnt;

		model.addAttribute("total", total);
		
		return "/main/main";
	}
}
