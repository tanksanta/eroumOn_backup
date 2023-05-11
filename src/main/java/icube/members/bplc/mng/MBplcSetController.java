package icube.members.bplc.mng;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
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
import icube.common.util.WebUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.members.bplc.biz.BplcService;
import icube.manage.members.bplc.biz.BplcVO;
import icube.members.biz.PartnersSession;
import icube.members.bplc.mng.biz.BplcBbsService;
import icube.members.bplc.mng.biz.BplcBbsVO;

/**
 * 사업소 관리자 > 사업소관리
 */
@Controller
@RequestMapping(value = "#{props['Globals.Members.path']}/{bplcUrl}/mng/set")
public class MBplcSetController extends CommonAbstractController {

	@Resource(name = "bplcService")
	private BplcService bplcService;

	@Resource(name = "bplcBbsService")
	private BplcBbsService bplcBbsService;

	@Resource(name = "fileService")
	private FileService fileService;

	@Autowired
	private PartnersSession partnersSession;

	@Value("#{props['Globals.Members.path']}")
	private String membersPath;

	@Value("#{props['Globals.Server.Dir']}")
	private String serverDir;

	@Value("#{props['Globals.File.Upload.Dir']}")
	private String fileUploadDir;

	// Page Parameter Keys
	private static String[] targetParams = { "curPage", "cntPerPage"};

	/**
	 * 사업소 안내
	 */
	@RequestMapping(value = { "guide" })
	public String guide(
			@PathVariable String bplcUrl
			, HttpSession session
			, HttpServletRequest request
			, BplcVO bplcVO
			, Model model) throws Exception {

		BplcVO bplcSetupVO = (BplcVO) request.getAttribute("bplcSetupVO");

		bplcVO.setCrud(CRUD.UPDATE);

		model.addAttribute("bplcRstdeCode", CodeMap.BPLC_RSTDE);
		model.addAttribute("parkngYnCode", CodeMap.PARKNG_YN);
		model.addAttribute("bplcVO", bplcSetupVO);

		return "/members/bplc/mng/mng/guide";
	}

	/**
	 * 사업소 안내 > 등록
	 */
	@RequestMapping(value = { "action" })
	public View guideAction(
			@PathVariable String bplcUrl
			, HttpSession session
			, HttpServletRequest request
			, BplcVO bplcVO
			, Model model
			, MultipartHttpServletRequest multiReq
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		JavaScript javaScript = new JavaScript();

		BplcVO bplcSetupVO = (BplcVO) request.getAttribute("bplcSetupVO");

		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));

		Map<String, MultipartFile> fileMap = multiReq.getFileMap();
		String profileImg = "";

		// 수정자 정보
		bplcVO.setMdfcnId(partnersSession.getPartnersId());
		bplcVO.setMdfcnUniqueId(partnersSession.getUniqueId());
		bplcVO.setMdfr(partnersSession.getPartnersNm());

		if (bplcSetupVO != null) {

			// 대표이미지 삭제
			if (!fileMap.get("attachFile").isEmpty()) {
				profileImg = fileService.uploadFile(fileMap.get("attachFile"), serverDir.concat(fileUploadDir),
						"PROFL",fileMap.get("attachFile").getOriginalFilename());
				bplcVO.setProflImg(profileImg);
			} else if (EgovStringUtil.equals("Y", bplcVO.getDelProflImg())) {
				bplcVO.setProflImg(null);
			}
			bplcService.updateBplc(bplcVO);

			partnersSession.setProflImg(bplcVO.getProflImg());

			javaScript.setMessage(getMsg("action.complete.save"));
			javaScript.setLocation("/"+membersPath+"/" + bplcUrl + "/mng/set/guide?" + pageParam);
		} else {
			javaScript.setMessage(getMsg("alert.author.common"));
			javaScript.setLocation("/"+membersPath+"/" + bplcUrl + "/mng/index?" + pageParam);
		}
		return new JavaScriptView(javaScript);
	}

	/**
	 * 사업소 공지사항
	 */
	@RequestMapping(value = "ntceList")
	public String ntceList(
			@PathVariable String bplcUrl
			, HttpSession session
			, HttpServletRequest request
			, Model model) throws Exception {

		BplcVO bplcSetupVO = (BplcVO) request.getAttribute("bplcSetupVO");

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("bplcUniqueId", bplcSetupVO.getUniqueId());
		listVO.setParam("srchUseYn", "Y");
		listVO = bplcBbsService.bplcBbsListVO(listVO);

		model.addAttribute("listVO", listVO);

		return "/members/bplc/mng/mng/ntce_list";
	}

	// 상세
	@RequestMapping(value = "ntceForm")
	public String ntceForm(
			@PathVariable String bplcUrl
			, HttpSession session
			, BplcBbsVO bbsVO
			, HttpServletRequest request
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception {

		BplcVO bplcSetupVO = (BplcVO) request.getAttribute("bplcSetupVO");

		int nttNo = EgovStringUtil.string2integer((String) reqMap.get("nttNo"));

		if(nttNo == 0) {
			bbsVO.setCrud(CRUD.CREATE);
		}else {
			bbsVO = bplcBbsService.selectBplcBbs(bplcSetupVO.getUniqueId(), nttNo);
			bbsVO.setCrud(CRUD.UPDATE);
		}

		model.addAttribute("bplcBbsVO", bbsVO);
		model.addAttribute("bplcVO", bplcSetupVO);
		model.addAttribute("useYnCode", CodeMap.USE_YN);

		return "/members/bplc/mng/mng/ntce_form";
	}

	// 처리
	@RequestMapping(value = "ntceAction")
	public View action(
			@PathVariable String bplcUrl
			, HttpSession session
			, HttpServletRequest request
			, BplcVO bplcVO
			, BplcBbsVO bbsVO
			, MultipartHttpServletRequest multiReq
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception {

		BplcVO bplcSetupVO = (BplcVO) request.getAttribute("bplcSetupVO");

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));

		Map<String, MultipartFile> fileMap = multiReq.getFileMap();

		bbsVO.setRegUniqueId(partnersSession.getUniqueId());
		bbsVO.setRegId(partnersSession.getPartnersId());
		bbsVO.setRgtr(partnersSession.getPartnersNm());
		bbsVO.setMdfcnUniqueId(partnersSession.getUniqueId());
		bbsVO.setMdfcnId(partnersSession.getPartnersId());
		bbsVO.setMdfr(partnersSession.getPartnersNm());

		bbsVO.setBplcUniqueId(partnersSession.getUniqueId());
		bbsVO.setIp(WebUtil.getIp(request));
		bbsVO.setUseYn((String)reqMap.get("useYn"));

		switch (bbsVO.getCrud()) {
		case CREATE:

			// 정보 등록
			bplcBbsService.insertBplcBbs(bbsVO);

			// 첨부파일 등록
			fileService.creatFileInfo(fileMap, bbsVO.getNttNo(), "BPLCBBS", reqMap);

			javaScript.setMessage(getMsg("action.complete.insert"));
			javaScript.setLocation("/"+membersPath+"/"+bplcUrl+"/mng/set/ntceList?nttNo=" + bbsVO.getNttNo()+"&"+pageParam);
			break;

		case UPDATE:

			// 첨부파일 수정
			String delAttachFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delAttachFileNo"));
			String[] arrDelAttachFile = delAttachFileNo.split(",");
			if (!EgovStringUtil.isEmpty(arrDelAttachFile[0])) {
				fileService.deleteFilebyNo(arrDelAttachFile, bbsVO.getNttNo(), "BPLCBBS", "ATTACH");
			}

			fileService.creatFileInfo(fileMap, bbsVO.getNttNo(), "BPLCBBS", reqMap);

			// 정보 수정
			bbsVO.setUseYn((String)reqMap.get("useYn"));
			bplcBbsService.updateBplcBbs(bbsVO);

			javaScript.setMessage(getMsg("action.complete.update"));
			javaScript.setLocation("/"+membersPath+"/"+bplcUrl+"/mng/set/ntceList?nttNo=" + bbsVO.getNttNo()+"&"+pageParam);
			break;

		case DELETE:
			bplcBbsService.deleteBbs(bplcSetupVO.getUniqueId(), bbsVO.getNttNo());
			javaScript.setMessage(getMsg("action.complete.delete"));
			javaScript.setLocation("/"+membersPath+"/"+bplcUrl+"/mng/set/ntceList?" + pageParam);
		default:
			break;

		}
		return new JavaScriptView(javaScript);
	}

	/**
	 * 오시는길
	 */
	@RequestMapping(value = "place")
	public String place(
			@PathVariable String bplcUrl
			, HttpSession session
			, HttpServletRequest request
			, Model model
			, BplcVO bplcVO
			)throws Exception {

		BplcVO setupVO = (BplcVO) request.getAttribute("bplcSetupVO");

		model.addAttribute("bplcVO", setupVO);

		return "/members/bplc/mng/mng/place";
	}

	//정보처리
	@RequestMapping(value = { "placeAction" })
	public View placeAction(
			@PathVariable String bplcUrl
			, HttpSession session
			, HttpServletRequest request
			, BplcVO bplcVO) throws Exception {

		JavaScript javaScript = new JavaScript();

		bplcVO.setMdfcnId(partnersSession.getPartnersId());
		bplcVO.setMdfcnUniqueId(partnersSession.getUniqueId());
		bplcVO.setMdfr(partnersSession.getPartnersNm());


		bplcService.updateBplc(bplcVO);

		javaScript.setMessage(getMsg("action.complete.update"));
		javaScript.setLocation("/"+membersPath+"/" + bplcUrl + "/mng/set/place");

		return new JavaScriptView(javaScript);
	}
}
