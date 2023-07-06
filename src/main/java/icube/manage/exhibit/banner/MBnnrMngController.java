package icube.manage.exhibit.banner;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
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
import icube.manage.exhibit.banner.biz.BnnrMngService;
import icube.manage.exhibit.banner.biz.BnnrMngVO;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Controller
@RequestMapping(value="/_mng/exhibit/banner")
public class MBnnrMngController extends CommonAbstractController {

	@Resource(name = "bnnrMngService")
	private BnnrMngService bnnrMngService;

	@Resource(name = "fileService")
	private FileService fileService;

	@Autowired
	private MngrSession mngrSession;

	private static String[] targetParams = {"curPage", "cntPerPage", "srchUseYn", "srchBannerNm", "sortBy","srchBannerTy","srchBgngDt", "srchEndDt"};

	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("srchUseYn", "Y");
		listVO = bnnrMngService.bnnrMngListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("bannerTyCode", CodeMap.BANNER_TY);
		model.addAttribute("useYnCode", CodeMap.USE_YN);

		return "/manage/exhibit/banner/list";
	}

	@RequestMapping(value="form")
	public String form(
			BnnrMngVO bnnrMngVO
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception{

		int bannerNo = EgovStringUtil.string2integer((String) reqMap.get("bannerNo"));

		if(bannerNo == 0){
			bnnrMngVO.setCrud(CRUD.CREATE);
		}else{
			bnnrMngVO = bnnrMngService.selectBnnrMng(bannerNo);
			bnnrMngVO.setCrud(CRUD.UPDATE);
		}

		model.addAttribute("bnnrMngVO", bnnrMngVO);
		model.addAttribute("useYnCode", CodeMap.USE_YN);
		model.addAttribute("bannerTyCode", CodeMap.BANNER_TY);
		model.addAttribute("linkTyCode", CodeMap.POPUP_LINK_TY);

		return "/manage/exhibit/banner/form";
	}


	@RequestMapping(value="action")
	public View action(
			BnnrMngVO bnnrMngVO
			, @RequestParam Map<String,Object> reqMap
			, MultipartHttpServletRequest multiReq
			, HttpServletRequest request
			, HttpSession session) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));
		Map<String, MultipartFile> fileMap = multiReq.getFileMap();


		// 관리자정보
		bnnrMngVO.setRegUniqueId(mngrSession.getUniqueId());
		bnnrMngVO.setRegId(mngrSession.getMngrId());
		bnnrMngVO.setRgtr(mngrSession.getMngrNm());
		bnnrMngVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		bnnrMngVO.setMdfcnId(mngrSession.getMngrId());
		bnnrMngVO.setMdfr(mngrSession.getMngrNm());

		// 날짜 시간
		String Bdate = request.getParameter("bgngDt");
		String Btime = request.getParameter("bgngTime");
		String Edate = request.getParameter("endDt");
		String Etime = request.getParameter("endTime");

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date bgngDt = formatter.parse(Bdate + " " + Btime);
		Date endDt = formatter.parse(Edate + " " + Etime);

		bnnrMngVO.setBgngDt(bgngDt);
		bnnrMngVO.setEndDt(endDt);

		switch (bnnrMngVO.getCrud()) {
			case CREATE:
				bnnrMngService.insertBnnrMng(bnnrMngVO);

				fileService.creatFileInfo(fileMap, bnnrMngVO.getBannerNo(), "BANNER", reqMap);

				javaScript.setMessage(getMsg("action.complete.insert"));
				javaScript.setLocation("./list?" + pageParam);
				break;

			case UPDATE:
				bnnrMngService.updateBnnrMng(bnnrMngVO);

				// PC 수정
				String delMobileFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delMobileFileNo"));
				String[] arrDelMobileFile = delMobileFileNo.split(",");
				if (!EgovStringUtil.isEmpty(arrDelMobileFile[0])) {
					fileService.deleteFilebyNo(arrDelMobileFile, bnnrMngVO.getBannerNo(), "BANNER", "MOBILE");
				}

				// 모바일 수정
				String delPcFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delPcFileNo"));
				String[] arrDelPcFile = delPcFileNo.split(",");
				if (!EgovStringUtil.isEmpty(arrDelPcFile[0])) {
					fileService.deleteFilebyNo(arrDelPcFile, bnnrMngVO.getBannerNo(), "BANNER", "PC");
				}

				fileService.creatFileInfo(fileMap, bnnrMngVO.getBannerNo(), "BANNER", reqMap);

				String updtPcFileDc = WebUtil.clearSqlInjection((String) reqMap.get("updtPcFileDc"));
				if(EgovStringUtil.isNotEmpty(updtPcFileDc)) {
					fileService.updateFileDc("BANNER", bnnrMngVO.getBannerNo(), 1,"PC", updtPcFileDc);
				}

				String updtMobileFileDc = WebUtil.clearSqlInjection((String) reqMap.get("updtMobileFileDc"));
				if(EgovStringUtil.isNotEmpty(updtMobileFileDc)) {
					fileService.updateFileDc("BANNER", bnnrMngVO.getBannerNo(), 1,"MOBILE", updtMobileFileDc);
				}

				javaScript.setMessage(getMsg("action.complete.update"));
				javaScript.setLocation(
					"./form?bannerNo=" + bnnrMngVO.getBannerNo() + ("".equals(pageParam) ? "" : "&" + pageParam));
				break;

			default:
				break;
		}

		return new JavaScriptView(javaScript);
	}


	@ResponseBody
	@RequestMapping(value = "deleteBanner.json")
	public Map<String, Object> delBanner(
			@RequestParam(value = "bannerNos", required=true) String bannerNos
			) throws Exception {
		boolean result = false;
		int resultCnt = 0;

		String[] bannerNoList = bannerNos.replace(" ", "").split(",");
		for(String bannerNo : bannerNoList) {
			resultCnt += bnnrMngService.updateBnnrUseYn(EgovStringUtil.string2integer(bannerNo));
		}

		if(resultCnt > 0) {
			result = true;
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}

	@ResponseBody
	@RequestMapping(value = "updateSortNo.json")
	public Map<String, Object> updateSortNo(
			@RequestParam(value = "arrSortNo", required=true) String sortNos
			)throws Exception {
		boolean result = false;
		int resultCnt = 0;

		String[] arrSortNo = sortNos.replace(" ","").split(",");
		for(String item : arrSortNo) {
			int bannerNo = EgovStringUtil.string2integer(item.split("/")[0]);
			int sortNo = EgovStringUtil.string2integer(item.split("/")[1]);

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("srchBannerNo", bannerNo);
			paramMap.put("sortNo", sortNo);
			resultCnt += bnnrMngService.updateSortNo(paramMap);
		}

		if(resultCnt > 0) {
			result = true;
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}

}
