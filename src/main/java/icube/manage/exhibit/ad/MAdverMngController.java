package icube.manage.exhibit.ad;

import java.text.SimpleDateFormat;
import java.util.Date;
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
import icube.manage.exhibit.ad.biz.AdverMngService;
import icube.manage.exhibit.ad.biz.AdverMngVO;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Controller
@RequestMapping(value="/_mng/exhibit/ad")
public class MAdverMngController extends CommonAbstractController {

	@Resource(name = "adverMngService")
	private AdverMngService adverMngService;

	@Resource(name = "fileService")
	private FileService fileService;

	@Autowired
	private MngrSession mngrSession;

	private static String[] targetParams = {"curPage", "cntPerPage", "srchYn", "srchCn", "sortBy","srchArea","srchBgngDt", "srchEndDt"};

	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = adverMngService.adverMngListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("adverArea", CodeMap.ADVER_AREA);
		model.addAttribute("useYn", CodeMap.USE_YN);

		return "/manage/exhibit/ad/list";
	}

	@RequestMapping(value="form")
	public String form(
			AdverMngVO adverMngVO
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception{

		int adverNo = EgovStringUtil.string2integer((String) reqMap.get("adverNo"));

		if(adverNo == 0){
			adverMngVO.setCrud(CRUD.CREATE);
		}else{
			adverMngVO = adverMngService.selectAdverMng(adverNo);
			adverMngVO.setCrud(CRUD.UPDATE);
		}

		model.addAttribute("adverMngVO", adverMngVO);
		model.addAttribute("param", reqMap);
		model.addAttribute("useYn", CodeMap.USE_YN);
		model.addAttribute("area", CodeMap.ADVER_AREA);
		model.addAttribute("link", CodeMap.POPUP_LINK_TY);

		return "/manage/exhibit/ad/form";
	}


	@RequestMapping(value="action")
	public View action(
			AdverMngVO adverMngVO
			, @RequestParam Map<String,Object> reqMap
			, MultipartHttpServletRequest multiReq
			, HttpServletRequest request
			, HttpSession session) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));
		Map<String, MultipartFile> fileMap = multiReq.getFileMap();


		// 관리자정보
		adverMngVO.setRegUniqueId(mngrSession.getUniqueId());
		adverMngVO.setRegId(mngrSession.getMngrId());
		adverMngVO.setRgtr(mngrSession.getMngrNm());
		adverMngVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		adverMngVO.setMdfcnId(mngrSession.getMngrId());
		adverMngVO.setMdfr(mngrSession.getMngrNm());

		// 날짜 시간
		String Bdate = request.getParameter("bgngDt");
		String Btime = request.getParameter("bgngTime");
		String Edate = request.getParameter("endDt");
		String Etime = request.getParameter("endTime");

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date bgngDt = formatter.parse(Bdate + " " + Btime);
		Date endDt = formatter.parse(Edate + " " + Etime);

		adverMngVO.setBgngDt(bgngDt);
		adverMngVO.setEndDt(endDt);

		switch (adverMngVO.getCrud()) {
			case CREATE:
				adverMngService.insertAdverMng(adverMngVO);

				fileService.creatFileInfo(fileMap, adverMngVO.getAdverNo(), "ADVER", reqMap);

				javaScript.setMessage(getMsg("action.complete.insert"));
				javaScript.setLocation("./list?" + pageParam);
				break;

			case UPDATE:

				// 첨부파일 수정
				String delAttachFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delAttachFileNo"));
				String[] arrDelAttachFile = delAttachFileNo.split(",");
				if (!EgovStringUtil.isEmpty(arrDelAttachFile[0])) {
					fileService.deleteFilebyNo(arrDelAttachFile, adverMngVO.getAdverNo(), "ADVER", "ATTACH");
				}

				fileService.creatFileInfo(fileMap, adverMngVO.getAdverNo(), "ADVER", reqMap);

				adverMngService.updateAdverMng(adverMngVO);

				String updtImgFileDc = WebUtil.clearSqlInjection((String) reqMap.get("updtImgFileDc"));

				if (!"".equals(updtImgFileDc)) {
					String[] arrUptImgFileDc = updtImgFileDc.split(",");
					for (String uptImgFileDcNm : arrUptImgFileDc) {
						String[] uptImgFileElm = uptImgFileDcNm.split("FileDc");
						fileService.updateFileDc("ADVER", adverMngVO.getAdverNo(), StringUtil.nvl(uptImgFileElm[1], 0),
								"ATTACH", (String) reqMap.get(uptImgFileDcNm));
					}
				}

				javaScript.setMessage(getMsg("action.complete.update"));
				javaScript.setLocation(
					"./form?adverNo=" + adverMngVO.getAdverNo() + ("".equals(pageParam) ? "" : "&" + pageParam));
				break;

			default:
				break;
		}

		return new JavaScriptView(javaScript);
	}


}
