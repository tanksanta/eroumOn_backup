package icube.manage.exhibit.main;

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
import org.springframework.web.servlet.View;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.exhibit.main.biz.MainMngService;

@Controller
@RequestMapping(value="/_mng/exhibit/main")
public class MMainMngController extends CommonAbstractController{

	@Resource(name = "mainMngService")
	private MainMngService mainMngService;

	@RequestMapping(value = "list")
	public String list(
			HttpServletRequest request
			, Model model
			)throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = mainMngService.mainMngListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("useYnCode", CodeMap.USE_YN);
		model.addAttribute("mainTyCode", CodeMap.MAIN_TY);

		return "/manage/exhibit/main/list";
	}

	@RequestMapping(value = "form")
	public String form(
			HttpServletRequest request
			, Model model
			)throws Exception {

		return "/manage/exhibit/main/list";
	}

	@RequestMapping(value = "action")
	public View action(
			HttpServletRequest request
			, Model model
			)throws Exception {
		JavaScript javaScript = new JavaScript();


		return new JavaScriptView(javaScript);
	}

	@RequestMapping(value = "deleteMain.json")
	@ResponseBody
	public Map<String, Object> deleteMain(
			@RequestParam(value = "mainNos", required=true) String mainNos
			)throws Exception{
		boolean result = false;
		int resultCnt = 0;

		String[] mainNoList = mainNos.replace(" ", "").split(",");
		for(String mainNo : mainNoList) {
			resultCnt += mainMngService.updateMainUseYn(EgovStringUtil.string2integer(mainNo));
		}

		if(resultCnt > 0) {
			result = true;
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}

	@RequestMapping(value = "sortSave.json")
	@ResponseBody
	public Map<String, Object> sortSave(
			@RequestParam(value = "sortNos", required=true) String sortNos
			)throws Exception{
		boolean result = false;
		int resultCnt = 0;

		String[] sortNoList = sortNos.replace(" ", "").split(",");
		for(String item : sortNoList) {
			int mainNo = EgovStringUtil.string2integer(item.split(",")[0]);
			int sortNo = EgovStringUtil.string2integer(item.split(",")[2]);

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("mainNo", mainNo);
			paramMap.put("sortNo", sortNo);

			resultCnt += mainMngService.updateMainSortNo(paramMap);
		}

		if(resultCnt > 0) {
			result = true;
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}

}
