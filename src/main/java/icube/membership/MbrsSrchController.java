package icube.membership;

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
import org.springframework.web.servlet.View;

import icube.common.api.biz.BootpayApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 회원가입
 * @author ogy
 *
 */
@Controller
@RequestMapping(value = "#{props['Globals.Membership.path']}")
public class MbrsSrchController extends CommonAbstractController{

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "bootpayApiService")
	private BootpayApiService bootpayApiService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Membership.path']}")
	private String membershipPath;

	@Value("#{props['Globals.Planner.path']}")
	private String plannerPath;

	@Value("#{props['Globals.Main.path']}")
	private String mainPath;

	@Value("#{props['Globals.Nonmember.session.key']}")
	private String NONMEMBER_SESSION_KEY;

	/**
	 * 회원 아이디 찾기
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="srchId")
	public String srchId(
			HttpServletRequest request
			, Model model
			)throws Exception {

		return "/membership/info/srch_id";
	}


	/**
	 * 회원 아이디 찾기 처리
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="srchIdAction")
	@SuppressWarnings({"rawtypes","unchecked"})
	public View srchIdAction(
			HttpServletRequest request
			, HttpSession session
			, Model model
			, @RequestParam (value="mbrNm", required=true) String mbrNm
			, @RequestParam (value="mblTelno", required=false) String mblTelno
			, @RequestParam (value="eml", required=false) String eml
			) throws Exception{

		JavaScript javaScript = new JavaScript();
		Map paramMap = new HashMap();
		paramMap.put("srchMbrNm", mbrNm);


		if(!EgovStringUtil.isNull(mblTelno)) {
			//아이디 && 휴대폰 번호
			paramMap.put("srchMblTelno", mblTelno);
		}else {
			//아이디 && 이메일
			paramMap.put("emlByEml", eml);
		}

		MbrVO mbrVO = mbrService.selectMbr(paramMap);

		if(mbrVO != null) {
			mbrSession.setParms(mbrVO, false);

			session.setAttribute(NONMEMBER_SESSION_KEY, mbrSession);
			session.setMaxInactiveInterval(60*60);

			javaScript.setLocation("/"+membershipPath + "/srchIdConfirm");
		}else {
			javaScript.setMessage(getMsg("login.fail.idsearch"));
			javaScript.setMethod("window.history.back()");
		}

		return new JavaScriptView(javaScript);
	}

	/**
	 * 회원 아이디 찾기 완료
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="srchIdConfirm")
	public String srchIdConfirm(
			HttpServletRequest request
			, Model model
			, HttpSession session
			)throws Exception {


		MbrVO mbrVO = (MbrVO) session.getAttribute(NONMEMBER_SESSION_KEY);

		if(mbrVO == null) { //임시세션 값이 없으면 아이디 찾기로
			return  "redirect:/" + membershipPath + "/srchId";
		}

		model.addAttribute("mbrVO", mbrVO);

		return "/membership/info/srch_id_confirm";
	}

	/**
	 * 회원 비밀번호 찾기
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="srchPswd")
	public String srchPswd(
			HttpServletRequest request
			, Model model
			)throws Exception {

		// 로그인 체크
		if(mbrSession.isLoginCheck()){
			return  "redirect:/" + mainPath + "/index";
		}

		return "/membership/info/srch_pswd";
	}

	/**
	 * 회원 비밀번호 찾기 처리
	 * @param request
	 * @param session
	 * @param model
	 * @param mbrId
	 * @param mbrNm
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="srchPswdAction")
	public View srchPswdAction(
			@RequestParam(value="mbrId", required=true) String mbrId
			, @RequestParam(value="receiptId", required=true) String receiptId
			, HttpServletRequest request
			, HttpSession session
			, Model model)throws Exception {

		JavaScript javaScript = new JavaScript();

		// 본인인증정보 체크
		if(receiptId != "") {
			HashMap<String, Object> res = bootpayApiService.certificate(receiptId);

			String authData =String.valueOf(res.get("authenticate_data"));
			String[] spAuthData = authData.substring(1, authData.length()-1).split(",");

			HashMap<String, String> authMap = new HashMap<String, String>();
			for(String auth : spAuthData) {
				String[] spTmp = auth.trim().split("=", 2);
				authMap.put(spTmp[0], spTmp[1]); //key:value
			}

			String mbrNm = authMap.get("name");
			String diKey = authMap.get("di");
	        String mblTelno = authMap.get("phone");
	        mblTelno = mblTelno.substring(0, 3) + "-" + mblTelno.substring(3, 7) +"-"+ mblTelno.substring(7, 11);

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("srchMbrId", mbrId);
			paramMap.put("srchMbrNm", mbrNm);
			paramMap.put("srchMblTelno", mblTelno);
			paramMap.put("srchDiKey", diKey);

			MbrVO mbrVO = mbrService.selectMbr(paramMap);


			if(mbrVO != null) {
				// 간편 가입 회원 체크
				if(!mbrVO.getJoinTy().equals("E")){
					javaScript.setMessage("간편 회원가입 회원은 비밀번호 찾기를 이용하실 수 없습니다.");
					javaScript.setLocation("/"+mainPath);
				}else {
					mbrSession.setParms(mbrVO, false);
					session.setAttribute(NONMEMBER_SESSION_KEY, mbrSession);
					session.setMaxInactiveInterval(60*5);

					javaScript.setLocation("/"+membershipPath+"/srchPswdConfirm");
				}
			}else {
				javaScript.setMessage(getMsg("login.fail.find.pwsd"));
				javaScript.setMethod("window.history.back()");
			}
		}else {
			javaScript.setMessage(getMsg("alert.author.common"));
			javaScript.setMethod("window.history.back()");
		}

		return new JavaScriptView(javaScript);

	}

	/**
	 * 회원 비밀번호 변경
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="srchPswdConfirm")
	public String srchPswdConfirm(
			HttpServletRequest request
			, HttpSession session
			, Model model)throws Exception {

		// 로그인 체크
		if(mbrSession.isLoginCheck()){
			return  "redirect:/" + mainPath + "/index";
		}

		MbrVO mbrVO = (MbrVO) session.getAttribute(NONMEMBER_SESSION_KEY);
		if(EgovStringUtil.isEmpty(mbrVO.getMbrId())) { //임시세션 값이 없으면 아이디 찾기로
			return  "redirect:/" + membershipPath + "/srchPswd";
		}

		return "/membership/info/srch_pswd_confirm";
	}

	/**
	 * 회원 비밀번호 변경 처리
	 */
	@RequestMapping(value="srchPswdChg")
	public View srchPswdChg(
			@RequestParam(value="pswd", required=true) String pswd
			, HttpServletRequest request
			, HttpSession session
			, Model model)throws Exception {

		JavaScript javaScript = new JavaScript();

		//본인인증 정보
		MbrVO mbrVO = (MbrVO) session.getAttribute(NONMEMBER_SESSION_KEY);

		if(EgovStringUtil.isEmpty(mbrVO.getMbrId())) {
			javaScript.setLocation("redirect:/" + membershipPath + "/srchPswd");
		}else if((mbrVO.getMbrId()).equals(pswd)) { // id = pw
			javaScript.setMessage(getMsg("error.duplicate.id"));
			javaScript.setMethod("window.history.back()");
		}else {
			//암호화
			String encPswd = BCrypt.hashpw(pswd, BCrypt.gensalt());
			mbrVO.setPswd(encPswd);

			mbrService.updateMbrPswd(mbrVO);
			mbrService.updateFailedLoginCountReset(mbrVO);

			javaScript.setMessage(getMsg("action.complete.update"));
			javaScript.setLocation("/"+ mainPath +"/login");
		}

		return new JavaScriptView(javaScript);
	}

	@ResponseBody
	@RequestMapping(value = "checkEasyMbr.json")
	public Map<String, Object> checkEasyMbr (
			@RequestParam(value = "mbrId", required=true) String mbrId
			) throws Exception {
		boolean result = true;

		MbrVO mbrVO = mbrService.selectMbrIdByOne(mbrId);

		if(mbrVO != null) {
			if(!EgovStringUtil.equals("E", mbrVO.getJoinTy())) {
				result = false;
			}
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}


}
