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
import icube.common.util.WebUtil;
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

			// 상품 등록
			if(mainMngVO.getThemaTy().equals("G")) {
				mainMngService.insertMainGds(mainMngVO, reqMap);
			}

			fileService.creatFileInfo(fileMap, mainMngVO.getMainNo(), "MAIN", reqMap);

			javaScript.setMessage(getMsg("action.complete.insert"));
			javaScript.setLocation("./list?" + pageParam);

			break;
		case UPDATE:
			mainMngService.updateMainMng(mainMngVO);

			/*상품 노출형*/
			String delAttachFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delAttachFileNo"));
			String[] arrDelAttachFile = delAttachFileNo.split(",");
			if (!EgovStringUtil.isEmpty(arrDelAttachFile[0]))
				fileService.deleteFilebyNo(arrDelAttachFile, mainMngVO.getMainNo(), "MAIN", "ATTACH");

			if(EgovStringUtil.isNotEmpty((String)reqMap.get("gdsNo"))){
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("mainNo", mainMngVO.getMainNo());
				paramMap.put("gdsNos", (String)reqMap.get("gdsNo"));
				mainGdsMngService.updateMainGdsMng(paramMap);
			}
			/*상품 노출형// */

			/*배너형PC*/
			String delAttachPcFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delAttachPcFileNo"));
			String[] arrDelAttachPcFile = delAttachPcFileNo.split(",");
			if (!EgovStringUtil.isEmpty(arrDelAttachPcFile[0]))
				fileService.deleteFilebyNo(arrDelAttachPcFile, mainMngVO.getMainNo(), "MAIN", "PC");

			/*배너형 모바일*/
			String delAttachMobileFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delAttachMobileFileNo"));
			String[] arrDelAttachMobileFile = delAttachMobileFileNo.split(",");
			if (!EgovStringUtil.isEmpty(arrDelAttachMobileFile[0]))
				fileService.deleteFilebyNo(arrDelAttachMobileFile, mainMngVO.getMainNo(), "MAIN", "MOBILE");

			/*배너하프형 모바일*/
			String delAttachHalfFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delAttachHalfFileNo"));
			String[] arrDelAttachHalfFile = delAttachHalfFileNo.split(",");
			if (!EgovStringUtil.isEmpty(arrDelAttachHalfFile[0]))
				fileService.deleteFilebyNo(arrDelAttachHalfFile, mainMngVO.getMainNo(), "MAIN", "HALF");

			fileService.creatFileInfo(fileMap, mainMngVO.getMainNo(), "MAIN", reqMap);

			/* 대체 텍스트 배너형 PC */
			String updtImgFileDc = WebUtil.clearSqlInjection((String) reqMap.get("updtAttachPcFileDc"));
			if(EgovStringUtil.isNotEmpty(updtImgFileDc)) {
				fileService.updateFileDc("MAIN", mainMngVO.getMainNo(), 1, "PC", updtImgFileDc);
			}

			/* 대체 텍스트 배너형 MOBILE */
			String updtImgMobileFileDc = WebUtil.clearSqlInjection((String) reqMap.get("updtMobileFileDc"));
			if(EgovStringUtil.isNotEmpty(updtImgFileDc)) {
				fileService.updateFileDc("MAIN", mainMngVO.getMainNo(), 1, "MOBILE", updtImgMobileFileDc);
			}

			/* 대체 텍스트 배너형 HALF */
			String updtImgHalfFileDc = WebUtil.clearSqlInjection((String) reqMap.get("updtHlafFileDc"));
			if(EgovStringUtil.isNotEmpty(updtImgFileDc)) {
				fileService.updateFileDc("MAIN", mainMngVO.getMainNo(), 1, "HALF", updtImgHalfFileDc);
			}


			javaScript.setMessage(getMsg("action.complete.update"));
			javaScript.setLocation("./list?" + pageParam);

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
			int mainNo = EgovStringUtil.string2integer(item.split("/")[0]);
			int sortNo = EgovStringUtil.string2integer(item.split("/")[1]);

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
