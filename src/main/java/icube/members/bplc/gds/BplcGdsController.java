package icube.members.bplc.gds;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.ArrayUtil;
import icube.common.vo.CommonListVO;
import icube.manage.gds.ctgry.biz.GdsCtgryService;
import icube.manage.gds.ctgry.biz.GdsCtgryVO;
import icube.manage.gds.gds.biz.GdsService;
import icube.manage.gds.gds.biz.GdsVO;
import icube.manage.members.bplc.biz.BplcService;
import icube.manage.members.bplc.biz.BplcVO;
import icube.members.biz.PartnersSession;
import icube.members.bplc.mng.biz.BplcGdsService;

/**
 * 사업소 > 상품
 */

@Controller
@RequestMapping(value="#{props['Globals.Members.path']}/{bplcUrl}/gds")
public class BplcGdsController extends CommonAbstractController {

	@Resource(name = "bplcGdsService")
	private BplcGdsService bplcGdsService;

	@Resource(name = "gdsCtgryService")
	private GdsCtgryService gdsCtgryService;

	@Resource(name = "bplcService")
	private BplcService bplcService;

	@Resource(name = "gdsService")
	private GdsService gdsService;

	@Value("#{props['Globals.Members.path']}")
	private String membersPath;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	@Autowired
	private PartnersSession partnersSession;


	@RequestMapping(value = {"", "list"})
	public String bplcIndex(
			@PathVariable String bplcUrl
			, HttpSession session
			, HttpServletRequest request
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {

		// 카테고리 정보 S
		List<GdsCtgryVO> gdsCtgryList = gdsCtgryService.selectGdsCtgryList(-1, "Y");
		// 카테고리 정보 E
		String rtnUrl = "/" + membersPath;

		for(GdsCtgryVO gdsCtgryVO : gdsCtgryList) {
			if(gdsCtgryVO.getUpCtgryNo() == 1) {
				rtnUrl = "/" + membersPath + "/" + bplcUrl + "/gds/" + gdsCtgryVO.getCtgryNo() + "/list";
				break;
			}
		}

		return "redirect:"+ rtnUrl;
	}

	/**
	 * 상품 목록 컨테이너
	 * @param upCtgryNo
	 * @param ctgryNo
	 */
	@RequestMapping(value = {"{upCtgryNo}/list", "{upCtgryNo}/{ctgryNo}/list"})
	public String list(
			@PathVariable String bplcUrl
			, @PathVariable int upCtgryNo // 카테고리 1
			, @PathVariable(required = false) Optional<Integer> ctgryNo // 카테고리 2
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchBplcId", bplcUrl);
		int curPage = EgovStringUtil.string2integer((String) reqMap.get("curPage"), 1);
		int cntPerPage = EgovStringUtil.string2integer(request.getParameter("cntPerPage"), 12);;

		BplcVO bplcSetupVO = bplcService.selectBplc(paramMap);
		CommonListVO listVO = new CommonListVO(request, curPage, cntPerPage);
		listVO.setParam("bplcUniqueId", bplcSetupVO.getUniqueId());
		listVO.setParam("srchUseYn", "Y");
		listVO = bplcGdsService.bplcGdsListVO(listVO);

		// 카테고리 정보 S
		List<GdsCtgryVO> gdsCtgryList = gdsCtgryService.selectGdsCtgryList(-1, "Y");
		Map<Integer, String> gdsCtgryListMap = gdsCtgryService.selectGdsCtgryListToMap(-1);
		model.addAttribute("_gdsCtgryList", gdsCtgryList);
		model.addAttribute("_gdsCtgryListMap", gdsCtgryListMap);
		// 카테고리 정보 E


		model.addAttribute("listVO", listVO);

		model.addAttribute("upCtgryNo", upCtgryNo);
		model.addAttribute("ctgryNo", ctgryNo.orElse(0));
		model.addAttribute("bplcUrl", bplcUrl);
		model.addAttribute("_marketPath", "/" + marketPath);

		return "/members/bplc/gds/list";
	}

	/**
	 * 상품 목록
	 * @param upCtgryNo : 카테고리
	 */
	@RequestMapping(value = {"{upCtgryNo}/srchList"})
	public String srchList(
			@PathVariable String bplcUrl
			, @PathVariable int upCtgryNo // 카테고리
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {


		int curPage = EgovStringUtil.string2integer((String) reqMap.get("curPage"), 1);
		int cntPerPage = EgovStringUtil.string2integer((String) reqMap.get("cntPerPage"), 12);
		String[] srchCtgryNos = {};
		if(EgovStringUtil.isNotEmpty((String) reqMap.get("srchCtgryNos"))) {
			srchCtgryNos = EgovStringUtil.getStringArray((String) reqMap.get("srchCtgryNos"), "|");
		}

		String[] srchGdsTys = {};
		if(EgovStringUtil.isNotEmpty((String) reqMap.get("srchGdsTys"))) {
			srchGdsTys = EgovStringUtil.getStringArray((String) reqMap.get("srchGdsTys"), "|");
		}

		CommonListVO listVO = new CommonListVO(request, curPage, cntPerPage);
		listVO.setParam("srchUseYn", "Y"); // 사용중
		listVO.setParam("srchDspyYn", "Y"); // 전시중
		listVO.setParam("srchUpCtgryNo", upCtgryNo); //1depth
		listVO.setParam("srchCtgryNos", srchCtgryNos); //2depth
		listVO.setParam("srchGdsTys", srchGdsTys); //gds_ty

		listVO = gdsService.gdsListVO(listVO);

		for(Object o : listVO.getListObject()) { // 상품태그 처리
			GdsVO temp = (GdsVO) o;
			if(EgovStringUtil.isNotEmpty(temp.getGdsTagVal())) {
				temp.setGdsTag(ArrayUtil.stringToArray(temp.getGdsTagVal()));
			}
		}

		model.addAttribute("listVO", listVO);
		model.addAttribute("_marketPath", "/"+marketPath);
		model.addAttribute("upCtgryNo", upCtgryNo);

		return "/members/bplc/gds/include/srch_list";
	}

}
