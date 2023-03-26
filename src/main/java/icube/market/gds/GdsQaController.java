package icube.market.gds;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.HtmlUtil;
import icube.common.values.CRUD;
import icube.common.vo.CommonListVO;
import icube.manage.consult.biz.GdsQaService;
import icube.manage.consult.biz.GdsQaVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 상품문의
 * @author kkm
 */
@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/gds/qa")
public class GdsQaController extends CommonAbstractController  {

	@Resource(name = "gdsQaService")
	private GdsQaService gdsQaService;

	@Autowired
	private MbrSession mbrSession;

	@SuppressWarnings("unchecked")
	@RequestMapping(value="list")
	public String list(
			@RequestParam(value="srchGdsCd", required=true) String srchGdsCd
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {

		int curPage = EgovStringUtil.string2integer((String) reqMap.get("curPage"), 1);
		int cntPerPage = EgovStringUtil.string2integer((String) reqMap.get("cntPerPage"), 5);

		CommonListVO listVO = new CommonListVO(request, curPage, cntPerPage);
		listVO.setParam("srchGdsCd", srchGdsCd);
		listVO = gdsQaService.gdsQaListVO(listVO);

		List<GdsQaVO> resultList = listVO.getListObject();
		for(int i=0; i < resultList.size(); i++){
			resultList.get(i).setQestnCn(HtmlUtil.enterToBr(resultList.get(i).getQestnCn()));
			resultList.get(i).setAnsCn(HtmlUtil.enterToBr(resultList.get(i).getAnsCn()));
			resultList.get(i).setEnterCnt(EgovStringUtil.countOf(resultList.get(i).getAnsCn(), "<br>"));//답변 br 카운트
		}
		listVO.setListObject(resultList);

		model.addAttribute("listVO", listVO);

		return "/market/gds/include/qa_list";
	}


	@ResponseBody
	@RequestMapping(value="getQa.json")
	public Map<String, Object> getQaData(
			@RequestParam(value="qaNo", required=true) int qaNo
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request) throws Exception {

		String rtnMsg = "success";
		Map<String, Object> resultMap = new HashMap<String, Object>();

		GdsQaVO gdsQaVO = gdsQaService.selectGdsQa(qaNo);
		if(gdsQaVO != null) {
			if(!EgovStringUtil.equals(mbrSession.getUniqueId(), gdsQaVO.getRegUniqueId())) {
				rtnMsg = "denied";
			} else {
				resultMap.put("vo", gdsQaVO);
			}
		} else {
			rtnMsg = "nodata";
		}

		resultMap.put("rtnMsg", rtnMsg);

		return resultMap;
	}


	@ResponseBody
	@RequestMapping(value="rmQa.json")
	public Map<String, Object> rmQaData(
			@RequestParam(value="qaNo", required=true) int qaNo
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request) throws Exception {

		String rtnMsg = "success";
		Map<String, Object> resultMap = new HashMap<String, Object>();

		GdsQaVO gdsQaVO = gdsQaService.selectGdsQa(qaNo);
		if(gdsQaVO != null) {
			if(!EgovStringUtil.equals(mbrSession.getUniqueId(), gdsQaVO.getRegUniqueId())) {
				rtnMsg = "denied";
			} else {
				gdsQaService.deleteGdsQa(qaNo); //삭제
			}
		} else {
			rtnMsg = "nodata";
		}
		resultMap.put("rtnMsg", rtnMsg);
		return resultMap;
	}


	@ResponseBody
	@RequestMapping(value="action.json")
	public Map<String, Object> action(
			@RequestParam(value="crud", required=true) String crud
			, @RequestParam(value="qaNo", required=true) int qaNo
			, @RequestParam(value="gdsNo", required=true) int gdsNo
			, @RequestParam(value="gdsCd", required=true) String gdsCd
			, @RequestParam(value="qestnCn", required=true) String qestnCn
			, @RequestParam(value="secretYn", required=true) String secretYn
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request) throws Exception {

		boolean result = false;

		try {
			GdsQaVO gdsQaVO = new GdsQaVO();
			gdsQaVO.setQaNo(qaNo);
			gdsQaVO.setGdsNo(gdsNo);
			gdsQaVO.setGdsCd(gdsCd);
			gdsQaVO.setQestnCn(qestnCn);
			gdsQaVO.setSecretYn(secretYn);

			// 로그인 정보
			gdsQaVO.setRegUniqueId(mbrSession.getUniqueId());
			gdsQaVO.setRegId(mbrSession.getMbrId());
			gdsQaVO.setRgtr(mbrSession.getMbrNm());
			gdsQaVO.setMdfcnUniqueId(mbrSession.getUniqueId());
			gdsQaVO.setMdfcnId(mbrSession.getMbrId());
			gdsQaVO.setMdfr(mbrSession.getMbrNm());
			gdsQaVO.setCrud(CRUD.valueOf(crud));

			switch (gdsQaVO.getCrud()) {
				case CREATE:
					gdsQaService.insertGdsQa(gdsQaVO);
					break;
				case UPDATE:
					gdsQaService.updateGdsQa(gdsQaVO);
				default:
					break;
			}
			result = true;

		} catch (Exception e) {
			result = false;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}


}
