
package icube.market.mypage.info;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import com.ibm.icu.text.SimpleDateFormat;

import icube.common.file.biz.FileService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.WebUtil;
import icube.common.values.CodeMap;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.mbr.recipter.biz.RecipterInfoService;
import icube.manage.mbr.recipter.biz.RecipterInfoVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 마이페이지 > 회원정보 > 회원정보 수정
 */
@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/mypage/info")
public class MyInfoController extends CommonAbstractController{

	@Resource(name="mbrService")
	private MbrService mbrService;

	@Resource(name="fileService")
	private FileService fileService;

	@Resource(name = "recipterInfoService")
	private RecipterInfoService recipterInfoService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	@Value("#{props['Globals.Nonmember.session.key']}")
	private String NONMEMBER_SESSION_KEY;

	@Value("#{props['Globals.Server.Dir']}")
	private String serverDir;

	@Value("#{props['Globals.File.Upload.Dir']}")
	private String fileUploadDir;



	/**
	 * 비밀번호 확인
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model
			)throws Exception {


		return "/market/mypage/info/pw_chk";
	}

	/**
	 * 비밀번호 확인
	 * @param request
	 * @param session
	 * @param model
	 * @param pswd
	 * @return
	 */
	@RequestMapping(value="action")
	@SuppressWarnings({"rawtypes","unchecked"})
	public View action(
			HttpServletRequest request
			, HttpSession session
			, Model model
			, @RequestParam(value="pswd", required=true) String pswd
			) throws Exception {

		JavaScript javaScript = new JavaScript();
		String loginPwd="";

		Map paramMap = new HashMap();
		paramMap.put("srchUniqueId",mbrSession.getUniqueId());

		MbrVO mbrVO = mbrService.selectMbr(paramMap);

		if(EgovStringUtil.isNotEmpty(pswd)) {
			loginPwd = WebUtil.clearSqlInjection(pswd);
		}

		if(mbrVO != null) {
			if(BCrypt.checkpw(loginPwd, mbrVO.getPswd())) {
				session.setAttribute("infoStepChk", pswd);
				session.setMaxInactiveInterval(60*60);

				javaScript.setLocation("/"+ marketPath + "/mypage/info/form");
			}else {

				javaScript.setMessage("비밀번호가 일치하지 않습니다.");
				javaScript.setMethod("window.history.back()");
			}
		}

		return new JavaScriptView(javaScript);
	}

	/**
	 * 정보 변경
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="form")
	public String form(
			HttpServletRequest request
			, HttpSession session
			, Model model
			, MbrVO mbrVO
			)throws Exception {

		if(session.getAttribute("infoStepChk") == null) {
			return "redirect:/"+ marketPath +"/mypage/info/list";
		}

		mbrVO = mbrService.selectMbrByUniqueId(mbrSession.getUniqueId());

		model.addAttribute("genderCode", CodeMap.GENDER);
		model.addAttribute("expirationCode", CodeMap.EXPIRATION);
		model.addAttribute("recipterYnCode", CodeMap.RECIPTER_YN);
		model.addAttribute("mbrVO", mbrVO);

		return "/market/mypage/info/mdfr_info";
	}

	/**
	 * 정보 변경 처리
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="infoAction")
	public View infoAction(
			HttpServletRequest request
			, Model model
			, MbrVO mbrVO
			, MultipartHttpServletRequest multiReq
			, HttpSession session
			, @RequestParam (value="rcperRcognNo", required=false) String rcperRcognNo
			, @RequestParam (value="rcognGrad", required=false) String rcognGrad
			, @RequestParam (value="selfBndRt", required=false) String selfBndRt
			, @RequestParam (value="vldBgngYmd", required=false) String vldBgngYmd
			, @RequestParam (value="vldEndYmd", required=false) String vldEndYmd
			, @RequestParam (value="aplcnBgngYmd", required=false) String aplcnBgngYmd
			, @RequestParam (value="aplcnEndYmd", required=false) String aplcnEndYmd
			, @RequestParam (value="sprtAmt", required=false) String sprtAmt
			, @RequestParam (value="bnefBlce", required=false) String bnefBlce
			) throws Exception {

		JavaScript javaScript = new JavaScript();
		Map<String, MultipartFile> fileMap = multiReq.getFileMap();
		String profileImg = "";

		try {
			// 프로필 이미지
			// 등록
			if (!fileMap.get("uploadFile").isEmpty()) {
				profileImg = fileService.uploadFile(fileMap.get("uploadFile"), serverDir.concat(fileUploadDir),
						"PROFL",fileMap.get("uploadFile").getOriginalFilename());
				mbrVO.setProflImg(profileImg);
				// 삭제
			} else if (EgovStringUtil.equals("Y", mbrVO.getDelProflImg())) {
				mbrVO.setProflImg(null);
				// NOT
			}else if(mbrVO.getProflImg() != null){
				mbrVO.setProflImg(mbrVO.getProflImg());
			}else {
				mbrVO.setProflImg(null);
			}

			// 회원정보
			mbrService.updateMbrInfo(mbrVO);

			// 세션 정보
			mbrSession.setProflImg(mbrVO.getProflImg());

			// 수급자 정보
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");


			if(mbrVO.getRecipterYn().equals("Y")) {
				RecipterInfoVO recipterInfoVO = new RecipterInfoVO();
				String uniqueId = mbrSession.getUniqueId();
				recipterInfoVO.setUniqueId(uniqueId);
				recipterInfoVO.setRcperRcognNo(rcperRcognNo);
				recipterInfoVO.setRcognGrad(rcognGrad);

				/*String[] selfBnd = (selfBndRt.replace(" ", "")).split(",");
				recipterInfoVO.setSelfBndRt(EgovStringUtil.string2integer(selfBnd[0]));
				recipterInfoVO.setSelfBndMemo(selfBnd[1]);*/
				recipterInfoVO.setSelfBndRt(EgovStringUtil.string2integer(selfBndRt));
				recipterInfoVO.setVldBgngYmd(formatter.parse(vldBgngYmd));
				recipterInfoVO.setVldEndYmd(formatter.parse(vldEndYmd));
				recipterInfoVO.setAplcnBgngYmd(formatter.parse(aplcnBgngYmd));
				recipterInfoVO.setAplcnEndYmd(formatter.parse(aplcnEndYmd));
				recipterInfoVO.setBnefBlce(EgovStringUtil.string2integer(bnefBlce));
				recipterInfoVO.setSprtAmt(EgovStringUtil.string2integer(sprtAmt));
				recipterInfoService.mergeRecipter(recipterInfoVO);
			}else {
				recipterInfoService.deleteRecipter(mbrVO.getUniqueId());
			}

			//수급자 정보 reSetting
			mbrVO = mbrService.selectMbrByUniqueId(mbrVO.getUniqueId());

			mbrSession.setParms(mbrVO, true);
			if("Y".equals(mbrVO.getRecipterYn())){
				mbrSession.setPrtcrRecipter(mbrVO.getRecipterInfo(), mbrVO.getRecipterYn(), 0);
			}else {
				RecipterInfoVO recipterInfoVO = new RecipterInfoVO();
				recipterInfoVO.setUniqueId(mbrVO.getUniqueId());
				recipterInfoVO.setMbrId(mbrVO.getMbrId());
				recipterInfoVO.setMbrNm(mbrVO.getMbrNm());
				recipterInfoVO.setProflImg(mbrVO.getProflImg());
				recipterInfoVO.setMberSttus(mbrVO.getMberSttus());
				recipterInfoVO.setMberGrade(mbrVO.getMberGrade());
				mbrSession.setPrtcrRecipter(recipterInfoVO, mbrVO.getRecipterYn(), 0);
			}


			mbrSession.setMbrInfo(session, mbrSession);




			javaScript.setMessage(getMsg("action.complete.update"));
			javaScript.setLocation("/"+ marketPath + "/mypage/index");
		}catch(Exception e) {
			log.debug("MYPAGE UPDATE INFO ERROR");
			e.printStackTrace();
		}

		return new JavaScriptView(javaScript);
	}

	/**
	 * 비밀번호 변경
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="pswd")
	public String pswd(
			HttpServletRequest request
			, HttpSession session
			, Model model
			, MbrVO mbrVO
			)throws Exception {

		if(session.getAttribute("infoStepChk") == null) {
			return "redirect:/"+ marketPath +"/mypage/info/list";
		}


		return "/market/mypage/info/mdfr_pw";
	}

	/**
	 * 비밀번호 변경 처리
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="pwdAction")
	public View pwdAction(
			HttpServletRequest request
			, Model model
			, MbrVO mbrVO
			) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pwd ="";

		String pswd = mbrVO.getPswd();

		try {
			if(EgovStringUtil.isNotEmpty(pswd)) {
				pwd = WebUtil.clearSqlInjection(pswd);
			}

			//비밀번호 암호화
			String encPswd = BCrypt.hashpw(pwd, BCrypt.gensalt());
			mbrVO.setPswd(encPswd);

			mbrService.updateMbrPswd(mbrVO);

			javaScript.setMessage(getMsg("action.complete.newPswd"));
			javaScript.setLocation("/" + marketPath + "/mypage/index");
		}catch(Exception e) {
			e.printStackTrace();
			log.debug("MYPAGE PASSWORD CHANGE ERROR");
		}


		return new JavaScriptView(javaScript);
	}

}
