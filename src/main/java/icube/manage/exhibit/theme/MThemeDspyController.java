package icube.manage.exhibit.theme;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.util.HtmlUtils;

import icube.common.file.biz.FileService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.CommonUtil;
import icube.common.util.StringUtil;
import icube.common.util.WebUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.exhibit.recommend.biz.GdsRcmdService;
import icube.manage.exhibit.theme.biz.ThemeDspyGdsService;
import icube.manage.exhibit.theme.biz.ThemeDspyGdsVO;
import icube.manage.exhibit.theme.biz.ThemeDspyService;
import icube.manage.exhibit.theme.biz.ThemeDspyVO;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Controller
@RequestMapping("/_mng/exhibit/theme")
public class MThemeDspyController extends CommonAbstractController {

	@Resource(name = "themeDspyService")
	private ThemeDspyService themeDspyService;

	@Resource(name = "gdsRcmdService")
	private GdsRcmdService gdsRcmdService;

	@Resource(name = "themeDspyGdsService")
	private ThemeDspyGdsService themeDspyGdsService;

	@Resource(name = "fileService")
	private FileService fileService;

	@Autowired
	private MngrSession mngrSession;

	private static String[] targetParams = {"curPage", "cntPerPage", "srchText", "sortBy", "srchYn", "srchBgngDt", "srchEndDt"};

	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = themeDspyService.themeDspyListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("useYn", CodeMap.USE_YN);

		return "/manage/exhibit/theme/list";
	}

	@RequestMapping(value="form")
	public String form(
			ThemeDspyVO themeDspyVO
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception{

		int themeDspyNo = EgovStringUtil.string2integer((String) reqMap.get("themeDspyNo"));

		if(themeDspyNo == 0){
			themeDspyVO.setCrud(CRUD.CREATE);
		}else{
			themeDspyVO = themeDspyService.selectThemeDspy(themeDspyNo);
			themeDspyVO.setCrud(CRUD.UPDATE);
			List<ThemeDspyGdsVO> itemList = themeDspyGdsService.selectGdsList(themeDspyNo);
			model.addAttribute("itemList", itemList);
		}

		model.addAttribute("themeDspyVO", themeDspyVO);
		model.addAttribute("param", reqMap);
		model.addAttribute("useYn", CodeMap.USE_YN);
		model.addAttribute("dspyYnCode", CodeMap.DSPY_YN);


		return "/manage/exhibit/theme/form";
	}


	@RequestMapping(value="action")
	public View action(
			ThemeDspyVO themeDspyVO
			, @RequestParam Map<String,Object> reqMap
			, MultipartHttpServletRequest multiReq
			, HttpSession session
			, HttpServletRequest request) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));
		Map<String, MultipartFile> fileMap = multiReq.getFileMap();

		String gdsNo = request.getParameter("gdsNo");

		// 관리자정보
		themeDspyVO.setRegUniqueId(mngrSession.getUniqueId());
		themeDspyVO.setRegId(mngrSession.getMngrId());
		themeDspyVO.setRgtr(mngrSession.getMngrNm());
		themeDspyVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		themeDspyVO.setMdfcnId(mngrSession.getMngrId());
		themeDspyVO.setMdfr(mngrSession.getMngrNm());

		switch (themeDspyVO.getCrud()) {
			case CREATE:

				themeDspyService.insertThemeDspy(themeDspyVO);

				fileService.creatFileInfo(fileMap, themeDspyVO.getThemeDspyNo(), "THEME", reqMap);

				if( gdsNo != null) {
					String[] itemList = ((request.getParameter("gdsNo")).replace(" ", "")).split(",");
					themeDspyGdsService.insertGds(itemList, reqMap, themeDspyVO);
					}

				javaScript.setMessage(getMsg("action.complete.insert"));
				javaScript.setLocation("./list?" + pageParam);
				break;

			case UPDATE:
				// 첨부파일 수정
				String delAttachFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delAttachFileNo"));
				String[] arrDelAttachFile = delAttachFileNo.split(",");
				if (!EgovStringUtil.isEmpty(arrDelAttachFile[0])) {
					fileService.deleteFilebyNo(arrDelAttachFile, themeDspyVO.getThemeDspyNo(), "THEME", "ATTACH");
				}

				// file upload & data insert
				fileService.creatFileInfo(fileMap, themeDspyVO.getThemeDspyNo(), "THEME", reqMap);

				themeDspyService.updateThemeDspy(themeDspyVO);

				// file description update
				String updtImgFileDc = WebUtil.clearSqlInjection((String) reqMap.get("updtImgFileDc"));

				if (!"".equals(updtImgFileDc)) {
					String[] arrUptImgFileDc = updtImgFileDc.split(",");
					for (String uptImgFileDcNm : arrUptImgFileDc) {
						String[] uptImgFileElm = uptImgFileDcNm.split("FileDc");
						fileService.updateFileDc("THEME", themeDspyVO.getThemeDspyNo(), StringUtil.nvl(uptImgFileElm[1], 0),
								"ATTACH", (String) reqMap.get(uptImgFileDcNm));
					}
				}

				if( gdsNo != null) {
					String[] itemList = ((request.getParameter("gdsNo")).replace(" ", "")).split(",");
					themeDspyGdsService.insertGds(itemList, reqMap, themeDspyVO);
				}else {
					themeDspyGdsService.deleteGds( themeDspyVO.getThemeDspyNo());
				}

				javaScript.setMessage(getMsg("action.complete.update"));
				javaScript.setLocation(
					"./form?themeDspyNo=" + themeDspyVO.getThemeDspyNo() + ("".equals(pageParam) ? "" : "&" + pageParam));
				break;

			default:
				break;
		}

		return new JavaScriptView(javaScript);
	}




}
