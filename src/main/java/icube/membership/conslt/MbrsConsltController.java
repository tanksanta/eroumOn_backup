package icube.membership.conslt;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CRUD;
import icube.common.vo.CommonListVO;
import icube.manage.consult.biz.GdsQaVO;
import icube.manage.consult.biz.MbrConsltResultService;
import icube.manage.consult.biz.MbrConsltResultVO;
import icube.manage.consult.biz.MbrConsltService;
import icube.market.mbr.biz.MbrSession;

@Controller
@RequestMapping(value="#{props['Globals.Membership.path']}/conslt/appl")
public class MbrsConsltController extends CommonAbstractController {

	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;

	@Resource(name = "mbrConsltResultService")
	private MbrConsltResultService mbrConsltResultService;

	@Autowired
	private MbrSession mbrSession;

	// 상담 신청목록
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("srchUseYn", "Y");
		listVO.setParam("srchUniqueId", mbrSession.getUniqueId());
		listVO = mbrConsltService.selectMbrConsltListVO(listVO);

		model.addAttribute("listVO", listVO);

		return "/membership/conslt/appl/list";
	}

	// 재상담 신청
	@ResponseBody
	@RequestMapping(value="reConslt.json")
	public Map<String, Object> reConslt(
			@RequestParam(value="consltNo", required=true) int consltNo
			, @RequestParam(value="reconsltResn", required=true) String reconsltResn
			, @RequestParam(value="bplcUniqueId", required=true) String bplcUniqueId
			, @RequestParam(value="bplcConsltNo", required=true) int bplcConsltNo

			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request) throws Exception {

		boolean result = false;

		try {
			MbrConsltResultVO mbrConsltResultVO = new MbrConsltResultVO();
			mbrConsltResultVO.setConsltNo(consltNo);
			mbrConsltResultVO.setReconsltResn(reconsltResn);
			mbrConsltResultVO.setBplcUniqueId(bplcUniqueId);
			mbrConsltResultVO.setBplcConsltNo(bplcConsltNo);

			mbrConsltResultService.updateReConslt(mbrConsltResultVO);

			result = true;

		} catch (Exception e) {
			result = false;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}

	// 상담 취소
	@RequestMapping(value = "canclConslt.json")
	@ResponseBody
	public Map<String, Object> cancelConslt(
			@RequestParam(value = "consltNo", required=true) int consltNo
			, @RequestParam(value = "canclResn", required=true) String canclResn
			, HttpServletRequest request
			) throws Exception {

		boolean result = false;

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("consltSttus", "CS03"); //상담자 취소
		paramMap.put("canclResn", canclResn);
		paramMap.put("consltNo", consltNo);

		int resultCnt = mbrConsltService.updateCanclConslt(paramMap);

		if(resultCnt > 0) {
			result = true;
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}
}
