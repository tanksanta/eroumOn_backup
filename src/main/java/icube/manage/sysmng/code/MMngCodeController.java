package icube.manage.sysmng.code;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CodeMap;
import icube.manage.sysmng.code.biz.CodeService;
import icube.manage.sysmng.code.biz.CodeVO;

@Controller
@RequestMapping(value = "/_mng/code")
public class MMngCodeController  extends CommonAbstractController {

	@Resource(name = "codeService")
	private CodeService codeService;

	@RequestMapping(value="form")
	public String form(
			CodeVO codeVO
			, HttpServletRequest request
			, Model model) throws Exception{

		model.addAttribute("useYnCode", CodeMap.USE_YN);
		model.addAttribute("codeVO", codeVO);

		return "/manage/sysmng/code/form";
	}


	@RequestMapping(value={"action.json"})
	@ResponseBody
	public Map<String, Object> action(
			CodeVO codeVO
			, HttpSession session) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		String result = "N";

		switch (codeVO.getCrud()) {
		case CREATE:
			codeService.insertCode(codeVO);

			result = "Y";
			resultMap.put("msg", getMsg("action.complete.insert"));
			break;

		case UPDATE:
			codeService.updateCode(codeVO);

			result = "Y";
			resultMap.put("msg", getMsg("action.complete.update"));
			break;

		case DELETE:
			codeService.deleteCode(codeVO);

			result = "Y";
			resultMap.put("msg", getMsg("action.complete.delete"));
			break;

		default:
			break;
		}

		resultMap.put("result", result);

		return resultMap;
	}


	@ResponseBody
	@RequestMapping("setNewCode.json")
	public Map<String, Object> setNewMenu(
			CodeVO codeVO
			, @RequestParam Map<String, String> reqMap
			, HttpServletRequest request
			, HttpSession session) throws Exception {

		Map<String, Object> resMap = new HashMap<String, Object>();

		codeService.insertCode(codeVO);

		resMap.put("oldId", reqMap.get("id"));
		resMap.put("vo", codeVO);

		return resMap;
	}


	@ResponseBody
	@RequestMapping("setCodeName.json")
	public Map<String, Object> setMenuName(
			@RequestParam(required = true) String codeId
			, @RequestParam(required = false) String upperCodeId
			, @RequestParam(required = true) String codeNm
			, HttpServletRequest request) throws Exception {

		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put("codeId", codeId);
		resMap.put("upperCodeId", upperCodeId);
		resMap.put("codeNm", codeNm);

		int result = codeService.updateCodeNm(resMap);
		resMap.put("result", result == 1);
		return resMap;
	}


	@ResponseBody
	@RequestMapping("moveCode.json")
	public Map<String, Object> moveMenu(
			@RequestParam(required = true) String codeId
			, @RequestParam(required = true) String upperCodeId
			, @RequestParam(required = true) int sortNo
			, @RequestParam(required = true) String sortSeq
			, HttpServletRequest request) throws Exception {

		CodeVO codeVO = new CodeVO();
		codeVO.setCodeId(codeId);
		codeVO.setUpperCodeId(upperCodeId);
		codeVO.setSortNo(sortNo);

		boolean ok = false;
		try {
			codeService.moveCode(codeVO, sortSeq);
			ok = true;
		} catch (Exception e) {
			log.debug(e.getMessage());
		}

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("result", ok);

		return result;
	}


	@RequestMapping("getCode.json")
	public CodeVO getCode(
			@RequestParam(required = true, value="upperCodeId") String upperCodeId
			, @RequestParam(required = true, value="codeId") String codeId) throws Exception{

		CodeVO codeVO = codeService.selectCode(upperCodeId, codeId);

		return codeVO;
	}


	@RequestMapping("getCodeList.json")
	public @ResponseBody List<CodeVO> getCodeList(
			HttpServletRequest request) throws Exception {

		List<CodeVO> codeList = codeService.selectCodeList();

		return codeList;
	}

}
