package icube.members.bplc.mng;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.MapUtil;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.common.vo.DataTablesVO;
import icube.manage.gds.ctgry.biz.GdsCtgryService;
import icube.manage.gds.ctgry.biz.GdsCtgryVO;
import icube.manage.gds.gds.biz.GdsService;
import icube.manage.gds.gds.biz.GdsVO;
import icube.members.biz.PartnersSession;
import icube.members.bplc.mng.biz.BplcGdsService;
import icube.members.bplc.mng.biz.BplcGdsVO;

/**
 * 사업소 관리자 > 상품관리
 *
 */
@Controller
@RequestMapping(value="#{props['Globals.Members.path']}/{bplcUrl}/mng/gds")
public class MBplcGdsController extends CommonAbstractController {

	@Resource(name = "bplcGdsService")
	private BplcGdsService bplcGdsService;

	@Resource(name = "gdsService")
	private GdsService gdsService;

	@Resource(name = "gdsCtgryService")
	private GdsCtgryService gdsCtgryService;

	@Autowired
	private PartnersSession partnersSession;

	@Value("#{props['Globals.Members.path']}")
	private String membersPath;

	@RequestMapping(value = "list")
	public String list(
			@PathVariable String bplcUrl
			, HttpSession session
			, HttpServletRequest request
			, Model model) throws Exception {

		//목록
		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("bplcUniqueId", partnersSession.getUniqueId());
		listVO = bplcGdsService.bplcGdsListVO(listVO);

		//카테고리 호출
		List<GdsCtgryVO> gdsCtgryList = gdsCtgryService.selectGdsCtgryList(1);
		model.addAttribute("gdsCtgryList", gdsCtgryList);

		//전체 목록
		List<GdsVO> bplcGdsList = bplcGdsService.selectBplcGdsListAll(partnersSession.getUniqueId());
		model.addAttribute("bplcGdsList", bplcGdsList);

		model.addAttribute("dspyYnCode", CodeMap.DSPY_YN);
		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("gdsTagCode", CodeMap.GDS_TAG);

		model.addAttribute("listVO", listVO);

		return "/members/bplc/mng/gds/list";
	}


	/**
	 * 상품 저장
	 * @param arrGdsNo
	 * @param useYn
	 * @param reqMap
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("bplcGdsSave.json")
	public Map<String, Object> bplcGdsSave(
			@RequestParam(value="arrGdsNo[]", required=false) String[] arrGdsNo
			, @RequestParam Map<String, Object> reqMap) throws Exception {

		boolean result = false;
		Integer resultCnt = 0;

		try {
			// 삭제bplcGdsVO
			bplcGdsService.deleteBplcGdsByUniqueId(partnersSession.getUniqueId());

			if(arrGdsNo != null) {
				for(int i=0; i<arrGdsNo.length; i++) {
					BplcGdsVO bplcGdsVO = new BplcGdsVO();
					bplcGdsVO.setUniqueId(partnersSession.getUniqueId());
					bplcGdsVO.setGdsNo(EgovStringUtil.string2integer(arrGdsNo[i]));

					resultCnt += bplcGdsService.insertBplcGds(bplcGdsVO);
				}
			}
			result = true;
		} catch (Exception e) {
			result = false;
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);

		return resultMap;
	}

	/**
	 * 상품 목록 선택 삭제
	 * @param arrGdsNo
	 * @param reqMap
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("listAction.json")
	public Map<String, Object> listAction(
			@RequestParam(value="arrGdsNo[]", required=false) String[] arrGdsNo
			, @RequestParam Map<String, Object> reqMap) throws Exception {

		boolean result = false;

		BplcGdsVO bplcGdsVO = new BplcGdsVO();
		bplcGdsVO.setUniqueId(partnersSession.getUniqueId());
		bplcGdsVO.setArrGdsNo(arrGdsNo);

		try {
			bplcGdsService.deleteBplcGds(bplcGdsVO);
			result = true;
		} catch (Exception e) {
			result = false;
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);

		return resultMap;
	}


	/**
	 * 상품검색(급여상품) data tables
	 * @param reqMap
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("gdsSearchList.json")
	@ResponseBody
	public DataTablesVO<GdsVO> gdsSearchList(
			@RequestParam Map<String, Object> reqMap,
			HttpServletRequest request) throws Exception {

		String[] srchGdsTys = {"R","L"}; //급여(판매+대여)
		CommonListVO listVO = new CommonListVO(request);
		String srchUseYn = EgovStringUtil.null2string((String) reqMap.get("srchUseYn"), "Y");
		listVO.setParam("srchUseYn", srchUseYn);
		listVO.setParam("srchGdsTys", srchGdsTys);
		listVO = gdsService.gdsListVO(listVO);

		// DataTable
		DataTablesVO<GdsVO> dataTableVO = new DataTablesVO<GdsVO>();
		dataTableVO.setsEcho(MapUtil.getString(reqMap, "sEcho"));
		dataTableVO.setiTotalRecords(listVO.getTotalCount());
		dataTableVO.setiTotalDisplayRecords(listVO.getTotalCount());
		dataTableVO.setAaData(listVO.getListObject());

		return dataTableVO;
	}


	/**
	 * 상품 카테고리
	 * @param upCtgryNo
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("getGdsCtgryListByFilter.json")
	public Map<Integer, String> getGdsCtgryListByFilter(
			@RequestParam(required = true, value="upCtgryNo") int upCtgryNo
			, HttpServletRequest request) throws Exception {

		Map<Integer, String> gdsCtgryList = gdsCtgryService.selectGdsCtgryListToMap(upCtgryNo);
		return gdsCtgryList;
	}
}
