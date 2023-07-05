package icube.main;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.api.biz.BokjiApiService;
import icube.common.api.biz.BokjiServiceVO;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.vo.CommonListVO;
import icube.main.biz.MainService;
import icube.members.stdg.biz.StdgCdService;
import icube.members.stdg.biz.StdgCdVO;

/**
 * 랜딩 페이지
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="#{props['Globals.Main.path']}")
public class MainController extends CommonAbstractController  {
	
	@Resource(name = "mainService")
	private MainService mainService;
	
	@Resource(name = "stdgCdService")
	private StdgCdService stdgCdService;
	
	@Resource(name="bokjiService")
	private BokjiApiService bokjiService;
	
	/*@Autowired
	private MbrSession mbrSession;*/
	
	@RequestMapping(value = {"","index"})
	public String list(
		HttpServletRequest request
		, Model model
			) throws Exception {
		
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
			prvdCnt = bokjiService.getBokjisCnt(prvdUrl);
		}catch(Exception e) {
			log.debug(e.getMessage());
		}

		int total = bokjisCnt + prvdCnt;

		model.addAttribute("total", total);
		
		return "/main/main";
	}
	
	@RequestMapping(value = "searchBokji")
	public String searchBokji(
		HttpServletRequest reqeust
		, Model model
			) throws Exception {
		
		// 행정구역 목록
		List<StdgCdVO> stdgCdList = stdgCdService.selectStdgCdListAll(1);
		model.addAttribute("stdgCdList", stdgCdList);
		model.addAttribute("isIndex", true);

		// 복지 제도 개수
		String bokjisUrl = "/api/partner/v2/bokjis/count";
		String prvdUrl = "/api/partner/v2/providers/count";

		int bokjisCnt = 0;
		int prvdCnt = 0;

		try {// 첫화면 부터 에러나지 않도록..
			bokjisCnt = bokjiService.getBokjisCnt(bokjisUrl);
			prvdCnt = bokjiService.getBokjisCnt(prvdUrl);
		}catch(Exception e) {
			log.debug(e.getMessage());
		}

		int total = bokjisCnt + prvdCnt;

		model.addAttribute("total", total);
		
		return "/main/searchBokji";
	}
	
	@RequestMapping(value="include/srchSrvcList")
	public String srchSrvc(
			@RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {

		int curPage = EgovStringUtil.string2integer((String) reqMap.get("curPage"), 1);
		String sido = (String) reqMap.get("sido");
		String gugun = (String) reqMap.get("gugun");
		String category = ((String) reqMap.get("category")).replace("|", ",");
		if(category.contains("지원")) {
			category = category.replace("지원", "지원금품");
		}

		CommonListVO listVO = new CommonListVO(request, curPage, 8);
		listVO.setParam("sprName", sido);
		listVO.setParam("cityName", gugun);
		listVO.setParam("categoryList", category);

		try {// 첫화면 부터 에러나지 않도록..
			listVO = bokjiService.getSrvcList(listVO);
		} catch (Exception e) {
			log.debug(e.getMessage());
		}

		model.addAttribute("listVO", listVO);

		return "/main/include/srch_srvc_list";
	}


	@RequestMapping(value="srvcDtl")
	public String modalSrvcDetail(
			@RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {

		String resultCode = "FAIL";

		int bokjiId = EgovStringUtil.string2integer((String) reqMap.get("bokjiId"), 0);

		BokjiServiceVO bokjiServiceVO = null;
		if(bokjiId > 0) {
			try {
				bokjiServiceVO = bokjiService.getSrvcDtl(bokjiId);

				// 로그인 체크> availableKeyword : true
				/*if(bokjiServiceVO.isAvailableKeyword() && !mbrSession.isLoginCheck()) {
					resultCode = "LOGIN";
				} else {
					resultCode = "SUCCESS";
					model.addAttribute("bokjiVO", bokjiServiceVO);
				}*/
				resultCode = "SUCCESS";
				model.addAttribute("bokjiVO", bokjiServiceVO);
			} catch (Exception e) {
				log.debug(e.getMessage());
			}
		}

		model.addAttribute("bokjiId", bokjiId);
		model.addAttribute("resultCode", resultCode);

		return "/main/include/modal_srvc_detail";
	}

	/**
	 * 복지시설 목록
	 */
	@ResponseBody
	@RequestMapping(value="srchInstList.json")
	public Map<String, Object> srchInst(
			@RequestParam(value="srchMode", required=false) String srchMode
			, @RequestParam(value="sido", required=false) String sido
			, @RequestParam(value="gugun", required=false) String gugun

			, @RequestParam(value="isAllow", required=false) boolean isAllow
			, @RequestParam(value="lat", required=false) String lat
			, @RequestParam(value="lot", required=false) String lot
			, @RequestParam(value="dist", required=false) int dist
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request) throws Exception {


		return mainService.srchInst(isAllow, reqMap, request);
	}

}
