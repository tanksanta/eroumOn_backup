
package icube.membership;

import java.security.PrivateKey;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import com.ibm.icu.text.SimpleDateFormat;

import icube.common.api.biz.BootpayApiService;
import icube.common.file.biz.FileService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.ArrayUtil;
import icube.common.util.RSA;
import icube.common.util.WebUtil;
import icube.common.values.CodeMap;
import icube.manage.mbr.itrst.biz.CartService;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.mbr.recipter.biz.RecipterInfoService;
import icube.manage.mbr.recipter.biz.RecipterInfoVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 마이페이지 > 회원정보 > 회원정보 수정
 */
@Controller
@RequestMapping(value = "#{props['Globals.Membership.path']}/mypage")
public class MbrsInfoController extends CommonAbstractController{

	@Resource(name="mbrService")
	private MbrService mbrService;

	@Resource(name="fileService")
	private FileService fileService;

	@Resource(name = "recipterInfoService")
	private RecipterInfoService recipterInfoService;

	@Resource(name = "bootpayApiService")
	private BootpayApiService bootpayApiService;

	@Resource(name = "cartService")
	private CartService cartService;

	@Value("#{props['Globals.Membership.path']}")
	private String membershipPath;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	@Value("#{props['Globals.Main.path']}")
	private String mainPath;

	@Value("#{props['Globals.Nonmember.session.key']}")
	private String NONMEMBER_SESSION_KEY;

	@Value("#{props['Globals.Server.Dir']}")
	private String serverDir;

	@Value("#{props['Globals.File.Upload.Dir']}")
	private String fileUploadDir;

	@Autowired
	private MbrSession mbrSession;

	private static final String RSA_MEMBERSHIP_KEY = "__rsaMembersKey__";



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
			, HttpSession session
			, Model model
			, @RequestParam(value = "returnUrl", required=false) String returnUrl
			)throws Exception {

		if(!mbrSession.isLoginCheck()) {
			return "redirect:/"+ mainPath;
		}

		if(!mbrSession.getJoinTy().equals("E")) {
			session.setAttribute("infoStepChk", "EASYLOGIN");
			session.setMaxInactiveInterval(60*60);

			if(EgovStringUtil.isNotEmpty(returnUrl)) {
				return "redirect:/"+ membershipPath + "/mypage/form?returnUrl=" + returnUrl;
			}else {
				return "redirect:/"+ membershipPath + "/mypage/form";
			}

		}

		//암호화
		RSA rsa = RSA.getEncKey();
		request.setAttribute("publicKeyModulus", rsa.getPublicKeyModulus());
		request.setAttribute("publicKeyExponent", rsa.getPublicKeyExponent());
		session.setAttribute(RSA_MEMBERSHIP_KEY, rsa.getPrivateKey());

		return "/membership/mypage/mypage_confirm";
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
			, @RequestParam(value="encPw", required=true) String encPw
			, @RequestParam(value="returnUrl", required=false) String returnUrl
			) throws Exception {

		JavaScript javaScript = new JavaScript();
		String loginPswd="";

		Map paramMap = new HashMap();
		paramMap.put("srchUniqueId",mbrSession.getUniqueId());

		MbrVO mbrVO = mbrService.selectMbr(paramMap);

		if(EgovStringUtil.isNotEmpty(encPw)) {
			loginPswd = RSA.decryptRsa((PrivateKey) request.getSession().getAttribute(RSA_MEMBERSHIP_KEY), encPw); //암호화된 비밀번호를 복호화한다.
		}

		if(mbrVO != null) {
			if(BCrypt.checkpw(loginPswd, mbrVO.getPswd())) {
				session.setAttribute("infoStepChk", encPw);
				session.setMaxInactiveInterval(60*60);

				if(EgovStringUtil.isNotEmpty(returnUrl)) {
					javaScript.setLocation("/"+ membershipPath + "/mypage/form?returnUrl="+ returnUrl);
				}else {
					javaScript.setLocation("/"+ membershipPath + "/mypage/form");
				}
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
			return "redirect:/"+ membershipPath +"/mypage/list";
		}

		mbrVO = mbrService.selectMbrByUniqueId(mbrSession.getUniqueId());

		model.addAttribute("genderCode", CodeMap.GENDER);
		model.addAttribute("expirationCode", CodeMap.EXPIRATION);
		model.addAttribute("recipterYnCode", CodeMap.RECIPTER_YN);
		model.addAttribute("itrstCode", CodeMap.ITRST_FIELD);
		model.addAttribute("mbrVO", mbrVO);

		return "/membership/mypage/mypage_info";
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
			, @RequestParam (value="itrstField", required=false) String[] itrstFeild
			, @RequestParam (value="testName", required=false) String testName
			, @RequestParam (value="returnUrl", required=false) String returnUrl
			) throws Exception {

		JavaScript javaScript = new JavaScript();
		Map<String, MultipartFile> fileMap = multiReq.getFileMap();
		String profileImg = "";

		// 관심 분야
		String field = ArrayUtil.arrayToString(itrstFeild, ",");
		mbrVO.setItrstField(field);

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
				recipterInfoVO.setTestName(testName);
				recipterInfoService.mergeRecipter(recipterInfoVO);
			}else {
				recipterInfoService.deleteRecipter(mbrVO.getUniqueId());

				// 급여 장바구니 삭제
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("srchUniqueId", mbrVO.getUniqueId());
				paramMap.put("srchCartTy", "R");
				cartService.deleteCart(paramMap);
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
			if(EgovStringUtil.isNotEmpty(returnUrl)) {
				javaScript.setLocation(returnUrl);
			}else {
				javaScript.setLocation("/"+ mainPath + "/index");
			}

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

		// 간편 회원 체크
		if(!mbrSession.getJoinTy().equals("E")) {
			model.addAttribute("alertMsg", "간편가입 회원은 비밀번호 변경을 이용하실 수 없습니다.");
			return "/common/msg";
		}

		if(session.getAttribute("infoStepChk") == null) {
			return "redirect:/"+ membershipPath +"/mypage/pswd";
		}

		return "/membership/mypage/mypage_pw";
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
			, @RequestParam(value="returnUrl", required=false) String returnUrl
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

			if(EgovStringUtil.isNotEmpty(returnUrl)) {
				javaScript.setLocation(returnUrl);
			}else {
				javaScript.setLocation("/" + mainPath + "/index");
			}
		}catch(Exception e) {
			e.printStackTrace();
			log.debug("MYPAGE PASSWORD CHANGE ERROR");
		}


		return new JavaScriptView(javaScript);
	}

	/**
	 * 본인인증 조회
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "getMbrTelno.json")
	public Map<String, Object> getMbrTelno (
		@RequestParam(value="receiptId", required=true) String receiptId
		, @RequestParam Map<String, Object> reqMap
		, HttpServletRequest request
		)throws Exception {

		// 본인인증정보 체크
		HashMap<String, Object> res = bootpayApiService.certificate(receiptId);

		String authData =String.valueOf(res.get("authenticate_data"));
		String[] spAuthData = authData.substring(1, authData.length()-1).split(",");

		HashMap<String, String> authMap = new HashMap<String, String>();
		for(String auth : spAuthData) {
			System.out.println("spAuthData: " + auth.trim());
			String[] spTmp = auth.trim().split("=", 2);
			authMap.put(spTmp[0], spTmp[1]); //key:value
		}

		Map <String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("mblTelno", authMap.get("phone"));
		resultMap.put("diKey", authMap.get("di"));
		return resultMap;
	}

}
