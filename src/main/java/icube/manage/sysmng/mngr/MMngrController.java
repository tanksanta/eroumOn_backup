package icube.manage.sysmng.mngr;

import java.net.URI;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
import icube.common.util.MapUtil;
import icube.common.util.ValidatorUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.common.vo.DataTablesVO;
import icube.manage.sysmng.auth.biz.MngAuthrtService;
import icube.manage.sysmng.auth.biz.MngAuthrtVO;
import icube.manage.sysmng.auth.biz.MngrAuthLogService;
import icube.manage.sysmng.entrps.biz.EntrpsService;
import icube.manage.sysmng.entrps.biz.EntrpsVO;
import icube.manage.sysmng.menu.biz.MngMenuService;
import icube.manage.sysmng.menu.biz.MngMenuVO;
import icube.manage.sysmng.mngr.biz.MngrService;
import icube.manage.sysmng.mngr.biz.MngrSession;
import icube.manage.sysmng.mngr.biz.MngrVO;

@Controller
@RequestMapping(value = "/_mng/sysmng/mngr")
public class MMngrController  extends CommonAbstractController {

	@Resource(name="mngrService")
	private MngrService mngrService;

	@Resource(name="mngAuthrtService")
	private MngAuthrtService mngAuthrtService;

	@Resource(name="mngMenuService")
	private MngMenuService mngMenuService;

	@Resource(name = "mngrAuthLogService")
	private MngrAuthLogService mngrAuthLogService;

	@Resource(name="fileService")
	private FileService fileService;
	
	@Resource(name = "entrpsService")
	private EntrpsService entrpsService;

	@Autowired
	private MngrSession mngrSession;

	@Value("#{props['Globals.Server.Dir']}")
	private String serverDir;

	@Value("#{props['Globals.File.Upload.Dir']}")
	private String fileUploadDir;


	// Page Parameter Keys
	private static String[] targetParams = {"curPage", "cntPerPage", "srchTarget", "srchText", "sortBy", "srchAuthTy", "srchUseYn", "srchMngrNm", "srchTelno"};

	@RequestMapping({"list"})
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = mngrService.selectMngrListVO(listVO);

		model.addAttribute("listVO", listVO);

		model.addAttribute("useYnCode", CodeMap.USE_YN);
		model.addAttribute("authrtTyCode", CodeMap.MNGR_AUTH_TY);
		model.addAttribute("jobTyCode", CodeMap.MNGR_JOB_TY);

		return "/manage/sysmng/mngr/list";
	}

	@RequestMapping("form")
	public String form(
			@RequestParam(required=false, defaultValue="") String uniqueId
			, @RequestParam(required=false, defaultValue="Y") String srchUseYn
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {

		MngrVO mngrVO = null;
		List<MngMenuVO> mngMenuList = null;

		int passCk = 0;

		if ("".equals(uniqueId)) {
			mngrVO = new MngrVO();
			mngrVO.setCrud(CRUD.CREATE);
			mngrVO.setAuthrtTy("2");
			mngMenuList = mngMenuService.selectMngMenuList();
		} else {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("uniqueId", uniqueId);
			paramMap.put("srchUseYn", srchUseYn);
			mngrVO = mngrService.selectMngrById(paramMap);
			passCk = mngrService.selectFailedLoginCount(mngrVO);
			mngrVO.setCrud(CRUD.UPDATE);

			mngMenuList = mngMenuService.selectMngMenuAuthList(mngrVO.getAuthrtNo(), "");
		}

		List<MngAuthrtVO> authrtList = mngAuthrtService.mngAuthrtListAll();

		//입점업체 호출
		List<EntrpsVO> entrpsList = entrpsService.selectEntrpsListAll(new HashMap<String, Object>());
		model.addAttribute("entrpsList", entrpsList);
		
		model.addAttribute("mngMenuList", mngMenuList);

		model.addAttribute("useYnCode", CodeMap.USE_YN);
		model.addAttribute("authrtTyCode", CodeMap.MNGR_AUTH_TY);
		model.addAttribute("jobTyCode", CodeMap.MNGR_JOB_TY);

		model.addAttribute("authrtList", authrtList);
		model.addAttribute("passCk", passCk);
		model.addAttribute("mngrVO", mngrVO);

		return "/manage/sysmng/mngr/form";
	}

	@RequestMapping("action")
	public View action(
			MngrVO mngrVO
			, @RequestParam(value="authMenus", required=false) String authMenus
			, @RequestParam(value="authMngMenus", required=false) String authMngMenus
			, HttpServletRequest request
			, @RequestParam Map<String,Object> reqMap
			, MultipartHttpServletRequest multiReq
			, HttpSession session) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));
		String returnUrl = "";
		String profileImg = "";

		boolean changedPswd = false;

		if (EgovStringUtil.isEmpty(mngrVO.getMngrId()) || EgovStringUtil.isEmpty(mngrVO.getMngrNm())
				|| !ValidatorUtil.isValidId(mngrVO.getMngrId())) {

			javaScript.setMessage("담당자 계정 신청에 실패하였습니다. 다시 시도하시기 바랍니다.[아이디는 5~25자리, 영문소문자, 숫자만 가능]");
			javaScript.setMethod("window.history.back()");
			return new JavaScriptView(javaScript);
		}

		// 비밀번호 암호화
		if (EgovStringUtil.isNotEmpty(mngrVO.getNewPswd())) {
			if (!ValidatorUtil.isValidPassword(mngrVO.getNewPswd())) {
				javaScript.setMessage("담당자 계정 신청에 실패하였습니다. 다시 시도하시기 바랍니다.[비밀번호는 8~25자리, 알파벳, 숫자, 특수문자로 구성된 문자열만 가능]");
				javaScript.setMethod("window.history.back()");
				return new JavaScriptView(javaScript);
			}
			String encPswd = BCrypt.hashpw(mngrVO.getNewPswd(), BCrypt.gensalt());

			mngrVO.setMngrPswd(encPswd);
			changedPswd = true;
		}

		/** 관리자 정보 */
		mngrVO.setRegUniqueId(mngrSession.getUniqueId());
		mngrVO.setRegId(mngrSession.getMngrId());
		mngrVO.setRgtr(mngrSession.getMngrNm());
		mngrVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		mngrVO.setMdfcnId(mngrSession.getMngrId());
		mngrVO.setMdfr(mngrSession.getMngrNm());

		MngAuthrtVO mngAuthrtVO = new MngAuthrtVO();


		Map<String, MultipartFile> fileMap = multiReq.getFileMap();

		switch (mngrVO.getCrud()) {
		case CREATE:
			// 중복확인
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("mngrId", mngrVO.getMngrId());
			Map<String, Object> resultMap = mngrService.mngrIdCheck(paramMap);
			if (resultMap != null) {
				javaScript.setMessage(getMsg("errors.duplicate.id"));
				javaScript.setMethod("window.history.back()");
				return new JavaScriptView(javaScript);
			}

			// 관리자별로 관리그룹을 생성하고 개별로 관리함
			mngAuthrtVO.setAuthrtNm(mngrVO.getMngrNm() + "-" + CodeMap.MNGR_AUTH_TY.get(mngrVO.getAuthrtTy()));
			mngAuthrtVO.setAuthrtTy(mngrVO.getAuthrtTy());
			mngAuthrtVO.setMemo(mngrVO.getMngrNm() + "의 관리 권한설정을 위한 그룹");
			mngAuthrtService.insertMngAuthrt(mngAuthrtVO);

			mngrVO.setAuthrtNo(mngAuthrtVO.getAuthrtNo());
			// 관리그룹 END

			mngrService.insertMngr(mngrVO);

			// 프로필 이미지 업로드
			if (!fileMap.get("profileImg").isEmpty()) {
				profileImg = fileService.uploadFileNFixFileName(fileMap.get("profileImg"), serverDir.concat(fileUploadDir),
						"PROFL", mngrVO.getUniqueId());
				mngrVO.setProflImg(profileImg);
			}
			mngrService.updateMngrProflImg(mngrVO); //이미지정보 업데이트
			// 프로필 이미지 END


			mngAuthrtService.executeMngAuthrtMenu(mngAuthrtVO.getAuthrtNo(), authMngMenus);

			mngrAuthLogService.insertMngrAuthLog(mngrVO, "CM", "");

			javaScript.setMessage(getMsg("action.complete.insert"));
			javaScript.setLocation("./list?" + pageParam); //uniqueid를 가져올수 없음
			//javaScript.setLocation("./form?uniqueId=" + mngrVO.getUniqueId() + ("".equals(pageParam) ? "" : "&" + pageParam));
			break;

		case UPDATE:

			boolean updatedAuthrtTy = false;
			StringBuffer logtext = new StringBuffer();

			MngrVO oldMngrVO = mngrService.selectMngrByUniqueId(mngrVO.getUniqueId());

			// 프로필 이미지 업로드
			if (!fileMap.get("profileImg").isEmpty()) {
				profileImg = fileService.uploadFileNFixFileName(fileMap.get("profileImg"), serverDir.concat(fileUploadDir),
						"PROFL", mngrVO.getUniqueId());
				mngrVO.setProflImg(profileImg);
			} else if (EgovStringUtil.equals("Y", mngrVO.getDelProfileImg())) {
				mngrVO.setProflImg(null);
			} else {
				mngrVO.setProflImg(oldMngrVO.getProflImg());
			}
			// 프로필 이미지 END

			mngrService.updateMngr(mngrVO);

			if (!StringUtils.equals(oldMngrVO.getAuthrtTy(), mngrVO.getAuthrtTy())) {
				updatedAuthrtTy = true;
				logtext.append("권한등급 변경 : ");
				logtext.append(CodeMap.MNGR_AUTH_TY.get(oldMngrVO.getAuthrtTy()) + " > "
						+ CodeMap.MNGR_AUTH_TY.get(mngrVO.getAuthrtTy()));
				logtext.append("\r\n");
			}

			// 관리자별로 관리그룹을 생성하고 개별로 관리함
			mngAuthrtVO.setAuthrtNm(mngrVO.getMngrNm() + "-" + CodeMap.MNGR_AUTH_TY.get(mngrVO.getAuthrtTy()));
			mngAuthrtVO.setAuthrtTy(mngrVO.getAuthrtTy());
			mngAuthrtVO.setAuthrtNo(mngrVO.getAuthrtNo());
			mngAuthrtVO.setMemo(mngrVO.getMngrNm() + "의 관리 권한설정을 위한 그룹");
			mngAuthrtService.updateMngAuthrt(mngAuthrtVO);

			if (mngAuthrtService.diffMngAuthrtMenu(mngAuthrtVO.getAuthrtNo(), authMngMenus)) {
				updatedAuthrtTy = true;
				logtext.append("관리자메뉴 설정 변경");
				logtext.append("\r\n");
			}
			mngAuthrtService.executeMngAuthrtMenu(mngAuthrtVO.getAuthrtNo(), authMngMenus);

			mngrAuthLogService.insertMngrAuthLog(mngrVO, "UM" + (updatedAuthrtTy ? ",UA" : "") + (changedPswd ? ",UP" : ""), StringUtils.stripToEmpty(logtext.toString()));
			javaScript.setMessage(getMsg("action.complete.update"));
			javaScript.setLocation("./form?uniqueId=" + mngrVO.getUniqueId() + ("".equals(pageParam) ? "" : "&" + pageParam));

			break;

		case DELETE:
			// 완전삭제 로직 없음
			mngrAuthLogService.insertMngrAuthLog(mngrVO, "DM", "");
			javaScript.setMessage(getMsg("action.complete.delete"));
			javaScript.setLocation("./list?" + pageParam);
			break;

		default:
			break;
		}

		String refererURI = new URI(request.getHeader("referer")).getPath();

		if (EgovStringUtil.equals(mngrVO.getMngrId(), mngrSession.getMngrId())) {
			// session reset
			mngrSession.setUniqueId(mngrVO.getUniqueId());
			mngrSession.setMngrId(mngrVO.getMngrId());
			mngrSession.setMngrNm(mngrVO.getMngrNm());
			mngrSession.setAuthrtTy(mngrVO.getAuthrtTy());
			mngrSession.setAuthrtTyNm(CodeMap.MNGR_AUTH_TY.get(mngrVO.getAuthrtTy()));
			mngrSession.setAuthrtNo(mngrVO.getAuthrtNo());
			mngrSession.setAuthrtNm(mngrVO.getAuthrtNm());

			if(EgovStringUtil.isNotEmpty(profileImg)) {
				mngrSession.setProflImg(profileImg);
			}

			if("2".equals(mngrVO.getAuthrtTy())) {
				List<MngMenuVO> mngMenuList = mngMenuService.selectMngMenuAuthList(mngrVO.getAuthrtNo(), "Y");
				mngrSession.setMngMenuList(mngMenuList);
			}
			mngrSession.setLoginCheck(true);
		}

		if (refererURI.contains("myProfile")) { // 본인정보 수정페이지에서 넘어올 경우
			returnUrl = refererURI + "?uniqueId=" + mngrVO.getUniqueId();
			javaScript.setLocation(returnUrl);
		}

		return new JavaScriptView(javaScript);
	}


	@RequestMapping("mngrIdCheck.json")
	@ResponseBody
	public Map<String, Object> magrIdCheck(
			@RequestParam(value="mngrId", required=true) String mngrId) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("mngrId", mngrId);

		Map<String, Object> resultMap = mngrService.mngrIdCheck(paramMap);
		if (resultMap == null) {
			paramMap.put("isUsed", false);
		} else {
			paramMap.put("isUsed", true);
		}

		return paramMap;
	}


	@RequestMapping("popup/myProfile")
	public String myProfile(
			MngrVO mngrVO
			, HttpServletRequest request
			, HttpSession session
			, Model model) throws Exception {

		mngrVO = mngrService.selectMngrByUniqueId(mngrSession.getUniqueId());
		mngrVO.setCrud(CRUD.UPDATE);

		model.addAttribute("authTyNm", CodeMap.MNGR_AUTH_TY.get(mngrVO.getAuthrtTy()));
		model.addAttribute("mngrVO", mngrVO);

		return "/manage/sysmng/mngr/popup/myProfile";
	}

	//@RequestMapping("changePswd.json")
	//@ResponseBody
	@RequestMapping("changePswd")
	//public Map<String, Object> changeMngrPswd(
	public View changeMngrPswd(
			MngrVO mngrVO
			, HttpServletRequest request
			, MultipartHttpServletRequest multiReq
			, Model model) throws Exception {

		JavaScript javaScript = new JavaScript();

		//Map<String, Object> resMap = new HashMap<String, Object>();

		MngrVO mngrDB = mngrService.selectMngrByUniqueId(mngrVO.getUniqueId());

		if(mngrDB != null) {

			//비밀번호 암호화
			if( EgovStringUtil.isNotEmpty(mngrVO.getNewPswd()) ) {
				if(!ValidatorUtil.isValidPassword(mngrVO.getNewPswd())){
					//resMap.put("result", false);
					//resMap.put("msg", "비밀번호가 유효하지 않습니다. 확인 후 다시 시도해주세요.");

					javaScript.setMethod("history.back()");
					javaScript.setMessage("비밀번호가 유효하지 않습니다. 확인 후 다시 시도해주세요.");
				}

				if(BCrypt.checkpw(mngrVO.getNowPswd(), mngrDB.getMngrPswd())) {
					mngrVO.setMngrId(mngrDB.getMngrId());
					String encPswd = BCrypt.hashpw(mngrVO.getNewPswd(), BCrypt.gensalt());
					mngrVO.setMngrPswd(encPswd);
					mngrVO.setMdfcnId(mngrSession.getMngrId());
					mngrVO.setMdfr(mngrSession.getMngrNm());

					int resultCnt = mngrService.updateMngrPswd(mngrVO);

					if(resultCnt>0) {
						//resMap.put("result", true);
						//resMap.put("msg", "관리자 정보가 변경되었습니다.");

						javaScript.setMethod("window.close()");
						javaScript.setMessage("관리자 정보가 변경되었습니다.");
					} else {
						//resMap.put("result", false);
						//resMap.put("msg", "비밀번호 변경 중 오류가 발생했습니다.");

						javaScript.setMethod("history.back()");
						javaScript.setMessage("비밀번호 변경 중 오류가 발생했습니다.");
					}

				} else {
					//resMap.put("result", false);
					//resMap.put("msg", "기존 비밀번호가 일치하지 않습니다. 확인 후 다시 시도해주세요.");

					javaScript.setMethod("history.back()");
					javaScript.setMessage("기존 비밀번호가 일치하지 않습니다. 확인 후 다시 시도해주세요.");
				}
			}

			Map<String, MultipartFile> fileMap = multiReq.getFileMap();
			// 프로필 이미지
			if (!fileMap.get("profileImg").isEmpty()) {
				String profileImg = fileService.uploadFile(fileMap.get("profileImg"), serverDir.concat(fileUploadDir),
						"PROFL", mngrSession.getUniqueId());
				mngrVO.setProflImg(profileImg);
				mngrVO.setMngrId(mngrSession.getMngrId());
				mngrService.updateMngrProflImg(mngrVO);

				mngrSession.setProflImg(profileImg);

				// resMap.put("result", true);
				// resMap.put("msg", "관리자 정보가 변경되었습니다.");
				javaScript.setMethod("opener.location.reload();window.close()");
				javaScript.setMessage("관리자 정보가 변경되었습니다.");
			} else if (EgovStringUtil.equals("Y", mngrVO.getDelProfileImg())) {

				mngrVO.setProflImg(null);
				mngrVO.setMngrId(mngrSession.getMngrId());
				mngrService.updateMngrProflImg(mngrVO);

				mngrSession.setProflImg(null);

				javaScript.setMethod("opener.location.reload();window.close()");
				javaScript.setMessage("관리자 정보가 변경되었습니다.");
			}

		}

		//return resMap;
		return new JavaScriptView(javaScript);
	}


	@RequestMapping("mngrSearchList.json")
	@ResponseBody
	public DataTablesVO<MngrVO> mngrSearchList(
			@RequestParam Map<String, Object> reqMap,
			HttpServletRequest request) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = mngrService.selectMngrListVO(listVO);

		// DataTable
		DataTablesVO<MngrVO> dataTableVO = new DataTablesVO<MngrVO>();
		dataTableVO.setsEcho(MapUtil.getString(reqMap, "sEcho"));
		dataTableVO.setiTotalRecords(listVO.getTotalCount());
		dataTableVO.setiTotalDisplayRecords(listVO.getTotalCount());
		dataTableVO.setAaData(listVO.getListObject());

		return dataTableVO;
	}


	@RequestMapping("getMngrAuthrtInfo.json")
	@ResponseBody
	public Map<String, List<String>> getMngrAuthrtInfo(
			@RequestParam(value="authrtNo", required=true) int authrtNo,
			@RequestParam(value="authrtTy", required=true) String authrtTy,
			HttpServletRequest request) throws Exception {

		List<MngMenuVO> mngMenuList = mngMenuService.selectMngMenuAuthList(authrtNo, "Y");
		List<String> mngMenus  = new ArrayList<String>();
		if(mngMenuList!=null && !mngMenuList.isEmpty()) {
			for(MngMenuVO vo : mngMenuList) {
				mngMenus.add(""+vo.getMenuNo());
			}
		}
		Map<String, List<String>> map = new HashMap<String, List<String>>();
		map.put("mngMenu", mngMenus);
		return map;
	}


	@ResponseBody
	@RequestMapping("check.json")
	public Map<String, Object> loginCheck(
			HttpSession session) throws Exception {

		Map<String, Object> rtnMap = new HashMap<String, Object>();

		rtnMap.put("loginCheck", mngrSession.isLoginCheck());
		rtnMap.put("uniqueId", mngrSession.getUniqueId());
		rtnMap.put("mngrId", mngrSession.getMngrId());
		rtnMap.put("mngrNm", mngrSession.getMngrNm());
		rtnMap.put("proflImg", mngrSession.getProflImg());

		return rtnMap;
	}

}
