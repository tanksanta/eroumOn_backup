package icube.manage.exhibit.main;

import java.util.ArrayList;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.util.HtmlUtils;

import icube.common.file.biz.FileService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.CommonUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.exhibit.main.biz.MainGdsMngService;
import icube.manage.exhibit.main.biz.MainMngService;
import icube.manage.exhibit.main.biz.MainMngVO;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Controller
@RequestMapping(value="/_mng/exhibit/main")
public class MMainMngController extends CommonAbstractController{

	@Resource(name = "mainMngService")
	private MainMngService mainMngService;

	@Resource(name = "mainGdsMngService")
	private MainGdsMngService mainGdsMngService;

	@Resource(name = "fileService")
	private FileService fileService;

	@Autowired
	private MngrSession mngrSession;

	private static String[] targetParams = { "curPage", "cntPerPage", "srchUseYn", "srchText", "sortBy", "srchThemaTy"};

	@RequestMapping(value = "list")
	public String list(
			HttpServletRequest request
			, Model model
			)throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("srchUseYn", "Y");
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
			, MainMngVO mainMngVO
			, @RequestParam(value = "mainNo", required=false) String mainNo
			)throws Exception {

		List<MainMngVO> itemList = new ArrayList<MainMngVO>();

		if(EgovStringUtil.isEmpty(mainNo)) {
			mainMngVO.setCrud(CRUD.CREATE);
		}else {
			mainMngVO = mainMngService.selectMainMng(EgovStringUtil.string2integer(mainNo));
			mainMngVO.setCrud(CRUD.UPDATE);

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("srchMainNo", mainMngVO.getMainNo());
			itemList = mainGdsMngService.selectMainGdsMngList(paramMap);

		}

		model.addAttribute("useYnCode", CodeMap.USE_YN);
		model.addAttribute("mainTyCode", CodeMap.MAIN_TY);
		model.addAttribute("dspyYnCode", CodeMap.DSPY_YN);

		model.addAttribute("mainMngVO", mainMngVO);
		model.addAttribute("itemList", itemList);



		return "/manage/exhibit/main/form";
	}

	@RequestMapping(value = "action")
	public View action(
			HttpServletRequest request
			, Model model
			, MainMngVO mainMngVO
			, @RequestParam Map<String, Object> reqMap
			, MultipartHttpServletRequest multiReq
			)throws Exception {
		JavaScript javaScript = new JavaScript();
		Map<String, MultipartFile> fileMap = multiReq.getFileMap();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));

		// 관리자정보
		mainMngVO.setRegUniqueId(mngrSession.getUniqueId());
		mainMngVO.setRegId(mngrSession.getMngrId());
		mainMngVO.setRgtr(mngrSession.getMngrNm());
		mainMngVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		mainMngVO.setMdfcnId(mngrSession.getMngrId());
		mainMngVO.setMdfr(mngrSession.getMngrNm());

		switch(mainMngVO.getCrud()) {
		case CREATE:
			mainMngService.insertMainMng(mainMngVO);
			String srvc = "";

			switch(mainMngVO.getThemaTy()) {
			case"G":
				 // 첨부파일
				srvc = "MAIN";

				// 상품 등록
				mainMngService.insertMainGds(mainMngVO, reqMap);
				break;
			case"B":
				srvc = "MAIN";
				break;
			case"H":
				srvc = "HALF";
				break;
			default:
				srvc = "ATTACH";
				break;
			}
			fileService.creatFileInfo(fileMap, mainMngVO.getMainNo(), srvc, reqMap);

			javaScript.setMessage(getMsg("action.complete.insert"));
			javaScript.setLocation("./list?" + pageParam);

			break;
		case UPDATE:
			break;
		default:
			javaScript.setMessage(getMsg("action.complete.insert"));
			javaScript.setLocation("./list?" + pageParam);
			break;
		}


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
			int mainNo = EgovStringUtil.string2integer(item.split("|")[0]);
			int sortNo = EgovStringUtil.string2integer(item.split("|")[2]);

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
