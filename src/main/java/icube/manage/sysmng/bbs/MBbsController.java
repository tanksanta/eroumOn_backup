package icube.manage.sysmng.bbs;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovDateUtil;
import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
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
import icube.common.util.DateUtil;
import icube.common.util.HtmlUtil;
import icube.common.util.WebUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.sysmng.bbs.biz.BbsService;
import icube.manage.sysmng.bbs.biz.BbsSetupService;
import icube.manage.sysmng.bbs.biz.BbsSetupVO;
import icube.manage.sysmng.bbs.biz.BbsVO;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Controller
@RequestMapping(value = "/_mng/sysmng/bbs")
public class MBbsController extends CommonAbstractController {

	@Resource(name = "bbsService")
	private BbsService bbsService;

	@Resource(name = "bbsSetupService")
	private BbsSetupService bbsSetupService;

	@Resource(name = "fileService")
	private FileService fileService;

	@Autowired
	private MngrSession mngrSession;

	// Page Parameter Keys
	private static String[] targetParams = { "curPage", "cntPerPage", "srchDelYn", "srchTarget", "srchText", "srchBbsNo", "srchWrtYmdBgng", "srchWrtYmdEnd" };

	@RequestMapping(value = "list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = bbsService.selectNttListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("boardTyCode", CodeMap.BBS_TY);
		model.addAttribute("useYnCode", CodeMap.USE_YN);

		return "/manage/sysmng/bbs/bbs/list";
	}


	@RequestMapping(value = "view")
	public String view(
			@RequestParam(value="bbsNo", required=true) int bbsNo
			, @RequestParam(value="nttNo", required=true) int nttNo
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {

		BbsSetupVO bbsSetupVO = (BbsSetupVO) request.getAttribute("bbsSetupVO");

		BbsVO nttVO = bbsService.selectNtt(bbsNo, nttNo);

		if (nttVO == null) {
			model.addAttribute("alertMsg", getMsg("alert.author.common"));
			return "/common/msg";
		}

		// 조회수 증가
		bbsService.updateInqcnt(nttVO.getNttNo());

		// 이전글/다음글
		//List<Map<String, Object>> prevNextList = bbsService.selectNttPrevNext(nttVO.getNttNo());

		// 에디터를 사용하지 않는 게시판일 경우 <br> 처리
		if (EgovStringUtil.equals("N", bbsSetupVO.getEditrUseYn())) {
			nttVO.setCn(HtmlUtil.enterToBr(nttVO.getCn()));
			nttVO.setAnsCn(HtmlUtil.enterToBr(nttVO.getAnsCn()));
		}

		model.addAttribute("nttVO", nttVO);
		//model.addAttribute("prevNextList", prevNextList);
		model.addAttribute("boardTyCode", CodeMap.BBS_TY);
		model.addAttribute("param", reqMap);

		return "/manage/sysmng/bbs/bbs/view";
	}


	@RequestMapping(value = "form")
	public String form(
			@RequestParam(required = false, defaultValue = "0") int bbsNo
			, @RequestParam(required = false, defaultValue = "0") int nttNo
			, @RequestParam(required = false, defaultValue = "0") int nttGrp
			, @RequestParam(required = false, defaultValue = "0") int nttOrdr
			, @RequestParam(required = false, defaultValue = "0") int nttLevel
			, BbsVO nttVO
			, HttpServletRequest request
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {

		BbsSetupVO bbsSetupVO = (BbsSetupVO) request.getAttribute("bbsSetupVO");

		if (nttNo == 0) {
			nttVO.setCrud(CRUD.CREATE);
			if (bbsSetupVO != null) {
				nttVO.setBbsNo(bbsSetupVO.getBbsNo());
			} else {
				nttVO.setBbsNo(bbsNo);
			}
			nttVO.setAnsYmd(DateUtil.convertDate(EgovDateUtil.getCurrentDateAsString(), "yyyy-MM-dd"));
			nttVO.setWrtId(mngrSession.getMngrId());
			nttVO.setWrtr(mngrSession.getMngrNm());
			nttVO.setNttGrp(nttGrp);

			if (nttGrp == 0) { // 원글일 경우
				nttVO.setCrud(CRUD.CREATE);
				nttVO.setNttOrdr(1);
				nttVO.setNttLevel(0);
			} else { // 답변글일 경우
				nttVO.setCrud(CRUD.REPLY);
				nttVO.setNttOrdr(nttOrdr);
				nttVO.setNttLevel(nttLevel);
			}

		} else {

			nttVO = bbsService.selectNtt(bbsNo, nttNo);
			if (nttVO == null) {
				model.addAttribute("alertMsg", getMsg("alert.author.common"));
				return "/common/msg";
			}

			// 에디터를 사용하지 않는 게시판일 경우 태그 제거
			if (EgovStringUtil.equals("N", bbsSetupVO.getEditrUseYn())) {
				nttVO.setCn(HtmlUtil.clean(nttVO.getCn()));
				nttVO.setAnsCn(HtmlUtil.clean(nttVO.getAnsCn()));
			}

			nttVO.setCrud(CRUD.UPDATE);
		}


		// return value
		model.addAttribute("nttVO", nttVO);
		model.addAttribute("boardTyCode", CodeMap.BBS_TY);
		model.addAttribute("param", reqMap);

		return "/manage/sysmng/bbs/bbs/form";
	}


	@RequestMapping(value = "answer")
	public String answer(
			@RequestParam(required = false, defaultValue = "0") int bbsNo
			, @RequestParam(required = false, defaultValue = "0") int nttNo
			, BbsVO nttVO
			, HttpServletRequest request
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {

		BbsSetupVO bbsSetupVO = (BbsSetupVO) request.getAttribute("bbsSetupVO");

		if (nttNo == 0 || !"5".equals(bbsSetupVO.getBbsTy())) {// TYPE 4
			// Q&A의 답변글.. 원글이 없으면 오류
			model.addAttribute("alertMsg", getMsg("alert.author.common"));
			return "/common/msg";
		} else {

			nttVO = bbsService.selectNtt(bbsNo, nttNo);
			if (nttVO == null) {
				model.addAttribute("alertMsg", getMsg("alert.author.common"));
				return "/common/msg";
			}

			// 에디터를 사용하지 않는 게시판일 경우 <br> 처리
			if (EgovStringUtil.equals("N", bbsSetupVO.getEditrUseYn())) {
				nttVO.setCn(HtmlUtil.enterToBr(nttVO.getCn()));
			}

			if (EgovStringUtil.isEmpty(nttVO.getAnsYmd())) {
				nttVO.setAnsYmd(DateUtil.convertDate(EgovDateUtil.getCurrentDateAsString(), "yyyy-MM-dd"));
			}
			if (EgovStringUtil.isEmpty(nttVO.getAnswr()) || EgovStringUtil.isEmpty(nttVO.getAnsId())) {
				nttVO.setAnsId(mngrSession.getUniqueId());
				nttVO.setAnsId(mngrSession.getMngrId());
				nttVO.setAnswr(mngrSession.getMngrNm());
			}
			nttVO.setCrud(CRUD.ANSWER);
		}

		// return value
		model.addAttribute("nttVO", nttVO);
		model.addAttribute("boardTyCode", CodeMap.BBS_TY);
		model.addAttribute("param", reqMap);

		return "/manage/sysmng/bbs/bbs/answer";
	}


	@RequestMapping(value = "action")
	public View action(
			BbsVO nttVO
			, MultipartHttpServletRequest multiReq
			, @RequestParam Map<String,Object> reqMap
			, HttpSession session) throws Exception {
		log.debug("@@@@@@@@@@@@@ 가나다라 : " + nttVO.getCrud());

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils
				.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));

		// 비밀글일 경우
		if (EgovStringUtil.equals("Y", nttVO.getSecretYn())) {
			nttVO.setPswd(BCrypt.hashpw(nttVO.getPswd(), BCrypt.gensalt()));
		}

		// 사용자 정보 설정
		// nttVO.setWrterId(mngrSession.getMngrId()); 페이지에서 받음 >> 비회원 게시판일 경우
		// nttVO.setWrter(mngrSession.getMngrNm()); 페이지에서 받음 >> 비회원 게시판일 경우
		nttVO.setRegUniqueId(mngrSession.getUniqueId());
		nttVO.setRegId(mngrSession.getMngrId());
		nttVO.setRgtr(mngrSession.getMngrNm());
		nttVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		nttVO.setMdfcnId(mngrSession.getMngrId());
		nttVO.setMdfr(mngrSession.getMngrNm());

		//답변
		nttVO.setAnsId(mngrSession.getMngrId());
		nttVO.setAnswr(mngrSession.getMngrNm());

		Map<String, MultipartFile> fileMap = multiReq.getFileMap();

		switch (nttVO.getCrud()) {
		case CREATE:
			// IP
			nttVO.setIp(WebUtil.getIp(multiReq));

			bbsService.insertNtt(nttVO);
			fileService.creatFileInfo(fileMap, nttVO.getNttNo(), "BBS");

			javaScript.setLocation("./list?" + pageParam);
			javaScript.setMessage(getMsg("action.complete.save"));
			break;

		case UPDATE:

			bbsService.updateNtt(nttVO);

			// 썸네일 삭제
			String delThumbFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delThumbFileNo"));
			String[] arrDelThumbFile = delThumbFileNo.split(",");
			if (!EgovStringUtil.isEmpty(arrDelThumbFile[0])) {
				fileService.deleteFilebyNo(arrDelThumbFile, nttVO.getNttNo(), "BBS", "THUMB");
			}

			// 첨부파일 삭제
			String delAttachFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delAttachFileNo"));
			String[] arrDelAttachFile = delAttachFileNo.split(",");
			if (!EgovStringUtil.isEmpty(arrDelAttachFile[0])) {
				fileService.deleteFilebyNo(arrDelAttachFile, nttVO.getNttNo(), "BBS", "ATTACH");
			}

			fileService.creatFileInfo(fileMap, nttVO.getNttNo(), "BBS");

			javaScript.setMessage(getMsg("action.complete.save"));
			javaScript.setLocation("./view?bbsNo=" + nttVO.getBbsNo() + "&nttNo=" + nttVO.getNttNo()
					+ ("".equals(pageParam) ? "" : "&" + pageParam));
			break;

		case REPLY:
			bbsService.insertReplyNtt(nttVO);

			javaScript.setMessage(getMsg("action.complete.save"));
			javaScript.setLocation("./list?" + pageParam);
			break;

		case ANSWER:

			bbsService.updateAnswer(nttVO);

			// TO-DO : 답변이 달릴경우 SMS or Email

			javaScript.setMessage(getMsg("action.complete.save"));
			javaScript.setLocation("./view?bbsNo=" + nttVO.getBbsNo() + "&nttNo=" + nttVO.getNttNo()
					+ ("".equals(pageParam) ? "" : "&" + pageParam));
			break;

		case DELETE:
			bbsService.updateDelNtt(nttVO.getBbsNo(), nttVO.getNttNo());

			javaScript.setMessage(getMsg("action.complete.delete"));
			javaScript.setLocation("./list?" + pageParam);
			break;

		default:
			break;
		}

		return new JavaScriptView(javaScript);
	}


	@ResponseBody
	@RequestMapping("blindChg.json")
	public Map<String, Object> blindChg(
			@RequestParam(value="bbsNo", required=true) int bbsNo
			, @RequestParam(value="nttNo", required=true) int nttNo
			, @RequestParam(value="sttsTy", required=true) String sttsTy) throws Exception {

		boolean result = false;

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bbsNo", bbsNo);
		paramMap.put("nttNo", nttNo);
		paramMap.put("sttsTy", sttsTy);

		Integer resultCnt = bbsService.updateNttSttsTy(paramMap);

		if (resultCnt == 1) {
			result = true;
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);

		return resultMap;
	}

	@ResponseBody
	@RequestMapping("deleteAnswer.json")
	public Map<String, Object> deleteAnswer(
			@RequestParam(value="bbsNo", required=true) int bbsNo
			, @RequestParam(value="nttNo", required=true) int nttNo) throws Exception {

		boolean result = false;

		Integer resultCnt = bbsService.updateDelAnswer(bbsNo, nttNo);
		if (resultCnt == 1) {
			result = true;
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);

		return resultMap;
	}

}
