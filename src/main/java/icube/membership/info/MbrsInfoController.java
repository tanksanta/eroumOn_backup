
package icube.membership.info;

import java.security.PrivateKey;
import java.util.HashMap;
import java.util.List;
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
import icube.manage.mbr.recipients.biz.MbrRecipientsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;
import icube.manage.mbr.recipter.biz.RecipterInfoService;
import icube.manage.mbr.recipter.biz.RecipterInfoVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 마이페이지 > 회원정보 > 회원정보 수정
 */
@Controller
@RequestMapping(value = "#{props['Globals.Membership.path']}/info/myinfo")
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
	
	@Resource(name= "mbrRecipientsService")
	private MbrRecipientsService mbrRecipientsService;

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
	@RequestMapping(value="confirm")
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
				return "redirect:/"+ membershipPath + "/info/myinfo/form?returnUrl=" + returnUrl;
			}else {
				return "redirect:/"+ membershipPath + "/info/myinfo/form";
			}

		}

		//암호화
		RSA rsa = RSA.getEncKey();
		request.setAttribute("publicKeyModulus", rsa.getPublicKeyModulus());
		request.setAttribute("publicKeyExponent", rsa.getPublicKeyExponent());
		session.setAttribute(RSA_MEMBERSHIP_KEY, rsa.getPrivateKey());

		return "/membership/info/myinfo/confirm";
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
					javaScript.setLocation("/"+ membershipPath + "/info/myinfo/form?returnUrl="+ returnUrl);
				}else {
					javaScript.setLocation("/"+ membershipPath + "/info/myinfo/form");
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
			return "redirect:/"+ membershipPath +"/info/myinfo/confirm";
		}

		mbrVO = mbrService.selectMbrByUniqueId(mbrSession.getUniqueId());
		List<MbrRecipientsVO> mbrRecipientList = mbrRecipientsService.selectMbrRecipientsByMbrUniqueId(mbrSession.getUniqueId());

		model.addAttribute("genderCode", CodeMap.GENDER);
		model.addAttribute("expirationCode", CodeMap.EXPIRATION);
		model.addAttribute("recipterYnCode", CodeMap.RECIPTER_YN);
		model.addAttribute("itrstCode", CodeMap.ITRST_FIELD);
		model.addAttribute("mbrVO", mbrVO);
		model.addAttribute("mbrRecipientList", mbrRecipientList);

		return "/membership/info/myinfo/info";
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
			, HttpSession session
			, @RequestParam (value="returnUrl", required=false) String returnUrl
			) throws Exception {

		JavaScript javaScript = new JavaScript();

		try {
			// 회원정보 수정
			MbrVO srchMbr = mbrService.selectMbrByUniqueId(mbrSession.getUniqueId());
			srchMbr.setMblTelno(mbrVO.getMblTelno());
			srchMbr.setEml(mbrVO.getEml());
			srchMbr.setZip(mbrVO.getZip());
			srchMbr.setAddr(mbrVO.getAddr());
			srchMbr.setDaddr(mbrVO.getDaddr());
			
			srchMbr.setSmsRcptnYn(mbrVO.getSmsRcptnYn());
			srchMbr.setSmsRcptnDt(mbrVO.getSmsRcptnDt());
			srchMbr.setEmlRcptnYn(mbrVO.getEmlRcptnYn());
			srchMbr.setEmlRcptnDt(mbrVO.getEmlRcptnDt());
			srchMbr.setTelRecptnYn(mbrVO.getTelRecptnYn());
			srchMbr.setTelRecptnDt(mbrVO.getTelRecptnDt());
			mbrService.updateMbrInfo(srchMbr);
			
			mbrSession.setParms(srchMbr, true);
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
			return "redirect:/"+ membershipPath +"/info/myinfo/confirm";
		}

		return "/membership/info/myinfo/pw";
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
