package icube.manage.consult;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.vo.CommonListVO;
import icube.manage.consult.biz.MbrConsltService;

/**
 * 장기요양 상담 신청
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="/#{props['Globals.Manager.path']}/consult/recipter")
public class MMbrConsltController extends CommonAbstractController{

	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;

	@RequestMapping(value = "list")
	public String list(
		HttpServletRequest request
		, Model model
		) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("srchUseYn", "Y");
		listVO = mbrConsltService.selectMbrConsltListVO(listVO);
		listVO = mbrConsltService.formatMbrConsltVO(listVO);

		model.addAttribute("listVO", listVO);

		return "/manage/consult/recipter/list";
	}

	@RequestMapping(value = "delConslt.json")
	@ResponseBody
	public Map<String, Object> delConslt(
			@RequestParam(value = "arrDelConslt[]", required=true) String[] consltList
			, HttpServletRequest request
			) throws Exception {

		boolean result = false;
		int resultCnt = 0;

		try {
			for(String consltNo : consltList) {
				resultCnt += mbrConsltService.updateUseYn(EgovStringUtil.string2integer(consltNo));
			}

			if(resultCnt > 0) {
				result = true;
			}

		}catch(Exception e) {
			e.printStackTrace();
			log.debug("delConslt.Json Error : " + e.getMessage());
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}
}
