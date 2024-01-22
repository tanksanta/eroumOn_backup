package icube.membership;

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
import org.springframework.web.servlet.View;

import icube.common.api.biz.BootpayApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.StringUtil;
import icube.manage.mbr.mbr.biz.MbrAuthService;
import icube.manage.mbr.mbr.biz.MbrAuthVO;
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

	@Resource(name = "mbrAuthService")
	private MbrAuthService mbrAuthService;
	
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
	 * 회원 아이디 찾기 처리 ajax (본인 인증 또는 회원 정보로 찾기)
	 */
	@ResponseBody
	@RequestMapping(value="srchId.json")
	public Map<String, Object> srchIdAction(
			@RequestParam (value="receiptId", required=false) String receiptId
			, @RequestParam (value="mbrNm", required=false) String mbrNm
			, @RequestParam (value="eml", required=false) String eml
			, @RequestParam (value="mblTelno", required=false) String mblTelno
			, HttpSession session
		) throws Exception{
		
		Map <String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", false);
		boolean isUserAuth = false;
		
		try {
			Map<String, Object> paramMap = new HashMap<>();
			MbrVO srchMbrVO = null;
			
			//본인 인증 검증
			if (EgovStringUtil.isNotEmpty(receiptId)) {
				//본인인증 체크
				Map<String, Object> certResultMap = mbrService.certificateBootpay(receiptId);
				if ((boolean)certResultMap.get("valid") == false) {
					certResultMap.put("msg", (String)certResultMap.get("msg"));
					return certResultMap;
				}
				
				MbrVO certMbrInfoVO = (MbrVO)certResultMap.get("certMbrInfoVO");
				
				srchMbrVO = mbrService.getBindingMbr(certMbrInfoVO.getCiKey(), certMbrInfoVO.getDiKey());
				
				//원래 ci값이 없는 회원이였으면 ci업데이트
				if (srchMbrVO != null && EgovStringUtil.isEmpty(srchMbrVO.getCiKey())) {
					srchMbrVO.setCiKey(certMbrInfoVO.getCiKey());
					mbrService.updateMbr(srchMbrVO);
				}
				
				isUserAuth = true;
			}
			//회원 정보로 검색
			else {
				paramMap.put("srchMbrName", mbrNm);
				if(EgovStringUtil.isNotEmpty(mblTelno)) {
					//아이디 && 휴대폰 번호
					paramMap.put("srchMblTelno", mblTelno);
				} else {
					//아이디 && 이메일
					paramMap.put("srchEml", eml);
				}
				
				srchMbrVO = mbrService.selectMbr(paramMap);
			}
			

			//검색된 아이디가 없는 경우
			if (srchMbrVO == null) {
				resultMap.put("msg", "해당 회원이 존재하지 않습니다.");
				return resultMap;
			}
			
			List<MbrAuthVO> authList = mbrAuthService.selectMbrAuthByMbrUniqueId(srchMbrVO.getUniqueId());
			if (authList == null || authList.size() == 0) {
				resultMap.put("msg", "해당 회원 인증이 존재하지 않습니다.");
				return resultMap;
			}

			//본인인증을 통한 찾기가 아닌 경우에 ID, 이메일, 전화번호 마스킹 처리 
			if (!isUserAuth) {
				for (MbrAuthVO authInfo : authList) {
					authInfo.setMbrId(StringUtil.idMasking(authInfo.getMbrId()));
					authInfo.setEml(StringUtil.emlMasking(authInfo.getEml()));
					authInfo.setMblTelno(StringUtil.phoneMasking(authInfo.getMblTelno()));
				}
			}
			
			srchMbrVO.setMbrAuthList(authList);
			mbrSession.setParms(srchMbrVO, false);

			session.setAttribute(NONMEMBER_SESSION_KEY, mbrSession);
			session.setMaxInactiveInterval(60*60);
			
			resultMap.put("success", true);
		} catch (Exception ex) {
			resultMap.put("msg", "아이디 찾기 중 오류가 발생하였습니다.");
		}
		
		return resultMap;
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

		MbrAuthVO eroumAuthInfo = mbrVO.getMbrAuthList().stream().filter(f -> "E".equals(f.getJoinTy())).findAny().orElse(null);
		MbrAuthVO kakaoAuthInfo = mbrVO.getMbrAuthList().stream().filter(f -> "K".equals(f.getJoinTy())).findAny().orElse(null);
		MbrAuthVO naverAuthInfo = mbrVO.getMbrAuthList().stream().filter(f -> "N".equals(f.getJoinTy())).findAny().orElse(null);
		
		model.addAttribute("mbrVO", mbrVO);
		model.addAttribute("eroumAuthInfo", eroumAuthInfo);
		model.addAttribute("kakaoAuthInfo", kakaoAuthInfo);
		model.addAttribute("naverAuthInfo", naverAuthInfo);

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
	 * 회원 비밀번호 찾기 처리 ajax
	 */
	@ResponseBody
	@RequestMapping(value="srchPswd.json")
	public Map<String, Object> srchPswdAction(
			@RequestParam(value="mbrId", required=true) String mbrId
			, @RequestParam(value="receiptId", required=true) String receiptId
			, HttpSession session) throws Exception {

		Map <String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", false);

		try {

			//본인인증 체크
			Map<String, Object> certResultMap = mbrService.certificateBootpay(receiptId);
			if ((boolean)certResultMap.get("valid") == false) {
				certResultMap.put("msg", (String)certResultMap.get("msg"));
				return certResultMap;
			}
			
			MbrVO certMbrInfoVO = (MbrVO)certResultMap.get("certMbrInfoVO");
			
			//본인인증 정보로 회원 검색
			MbrVO srchMbrVO = mbrService.getBindingMbr(certMbrInfoVO.getCiKey(), certMbrInfoVO.getDiKey());
			if(srchMbrVO == null) {
				resultMap.put("msg", "해당 회원이 존재하지 않습니다.");
				return resultMap;
			}
			
			List<MbrAuthVO> authList = mbrAuthService.selectMbrAuthByMbrUniqueId(srchMbrVO.getUniqueId());
			MbrAuthVO eroumAuthInfo = authList.stream().filter(f -> "E".equals(f.getJoinTy())).findAny().orElse(null);
			if(eroumAuthInfo == null) {
				resultMap.put("msg", "해당 이로움 계정이 존재하지 않습니다.");
				return resultMap;
			}
			
			if(!mbrId.equals(eroumAuthInfo.getMbrId())) {
				resultMap.put("msg", "이로움ON 아이디가 일치하지 않습니다.");
				return resultMap;
			}
			
			mbrSession.setParms(srchMbrVO, false);

			session.setAttribute(NONMEMBER_SESSION_KEY, mbrSession);
			session.setMaxInactiveInterval(60*60);
			session.setAttribute("pswdChangeAuthNo", eroumAuthInfo.getAuthNo());
			resultMap.put("success", true);
		} catch (Exception ex) {
			resultMap.put("msg", "비밀번호 찾기 중 오류가 발생하였습니다.");
		}

		return resultMap;
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

		Integer authNo = (Integer) session.getAttribute("pswdChangeAuthNo");
		if(authNo == null) { //임시세션 값이 없으면 패스워드 찾기로
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
			, HttpSession session)
		throws Exception {

		JavaScript javaScript = new JavaScript();
		
		Integer authNo = (Integer) session.getAttribute("pswdChangeAuthNo");
		if(authNo == null) { //임시세션 값이 없으면 패스워드 찾기로
			javaScript.setMessage("세션이 만료되었습니다. 다시 진행해주세요");
			javaScript.setMethod("window.history.back()");
			return new JavaScriptView(javaScript);
		}
		
		String encPswd = BCrypt.hashpw(pswd, BCrypt.gensalt());
		mbrAuthService.updatePswd(authNo, encPswd);
		mbrService.updateFailedLoginCountReset(mbrSession);
		
		javaScript.setMessage("비밀번호 변경이 완료되었습니다.");
		javaScript.setLocation("/membership/login");
		session.removeAttribute("pswdChangeAuthNo");

		return new JavaScriptView(javaScript);
	}
}
