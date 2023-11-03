package icube.membership;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;

import icube.common.api.biz.KakaoApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 카카오 간편 로그인
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="#{props['Globals.Membership.path']}/kakao")
public class MbrsKaKaoController extends CommonAbstractController{

	@Resource(name = "kakaoApiService")
	private KakaoApiService kakaoApiService;

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Main.path']}")
	private String mainPath;

	@Value("#{props['Globals.Membership.path']}")
	private String membershipPath;

	@RequestMapping(value = "/auth")
	public View auth(
			HttpServletRequest request
			, Model model
			)throws Exception {

		JavaScript javaScript = new JavaScript();
		String kakaoUrl = kakaoApiService.getKakaoUrl();

		javaScript.setLocation(kakaoUrl);
		return new JavaScriptView(javaScript);
	}

	@RequestMapping(value = "/getToken")
	public View getKakaoUserInfo(
			HttpServletRequest request
			, HttpSession session
			, Model model
			, @RequestParam(value="code", required=true) String code
			)throws Exception {

		JavaScript javaScript = new JavaScript();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int resultCnt = 0;

		String returnUrl = (String)session.getAttribute("returnUrl");
		try {
			resultMap = kakaoApiService.mbrAction(code, session);
			resultCnt = (Integer)resultMap.get("result");
		} catch (Exception ex) {
			javaScript.setMessage("카카오로부터 로그인정보를 받아오지 못하였습니다.");
			javaScript.setLocation("/" + mainPath + "/login");
			return new JavaScriptView(javaScript);
		}
		

		if(resultCnt == 0) {// 오류
			javaScript.setMessage(getMsg("fail.common.network"));
			javaScript.setLocation("/" + mainPath + "/login");
		}else if(resultCnt == 1){//성공
			mbrService.updateRecentDt(mbrSession.getUniqueId());

			javaScript.setLocation("/" + membershipPath + "/sns/regist?uid=" + mbrSession.getUniqueId());
			session.removeAttribute("returnUrl");
		}else if(resultCnt == 2) {// 카카오 로그인
			// 최근 일시 업데이트
			mbrService.updateRecentDt(mbrSession.getUniqueId());
			
			MbrVO srchMbr = mbrService.selectMbrByUniqueId(mbrSession.getUniqueId());
			
			if (EgovStringUtil.isNotEmpty(srchMbr.getDiKey())) {
				if(EgovStringUtil.isNotEmpty(returnUrl)) {
					javaScript.setLocation(returnUrl);
				}else {
					javaScript.setLocation("/" + mainPath);
				}
				session.removeAttribute("returnUrl");
			} else {
				javaScript.setLocation("/" + membershipPath + "/sns/regist?uid=" + mbrSession.getUniqueId());
			}
		}else if(resultCnt == 3) {// 네이버
			javaScript.setMessage("네이버 계정으로 가입된 회원입니다.");
			javaScript.setLocation("/" + mainPath + "/login");
		}else if(resultCnt == 4) {// 이로움
			javaScript.setMessage("이로움 계정으로 가입된 회원입니다.");
			javaScript.setLocation("/" + membershipPath + "/login");
		}else if(resultCnt == 5) {// 2건
			javaScript.setMessage("동일한 가입 정보가 1건 이상 존재합니다. 관리자에게 문의바랍니다.");
			javaScript.setLocation("/" + mainPath);
		}else if(resultCnt == 6 || resultCnt == 7) {// 등록 완료
			javaScript.setLocation("/" + membershipPath + "/sns/regist?uid=" + mbrSession.getUniqueId());
		}else if(resultCnt == 8) {
			javaScript.setMessage("일시 정지된 회원입니다. 관리자에게 문의바랍니다.");
			javaScript.setLocation("/" + mainPath);
		}else if(resultCnt == 9) {
			javaScript.setMessage("휴면 회원입니다. 휴면 해제 페이지로 이동합니다.");
			javaScript.setLocation("/" + membershipPath + "/drmt/view?mbrId=" + mbrSession.getMbrId());
		}else if(resultCnt == 11) {
			session.setAttribute("infoStepChk", "EASYLOGIN");
			
			String requestView = (String)session.getAttribute("requestView");
			if (EgovStringUtil.isNotEmpty(requestView) && "whdwl".equals(requestView)) {
				String resnCn = (String)session.getAttribute("resnCn");
				String whdwlEtc = (String)session.getAttribute("whdwlEtc");
				
				javaScript.setLocation("/" + membershipPath + "/info/whdwl/action?resnCn=" + resnCn + "&whdwlEtc=" + whdwlEtc);
			} else {
				javaScript.setLocation("/" + membershipPath + "/info/myinfo/form");
			}
		}else if(resultCnt == 12) {
			javaScript.setMessage("소셜 정보가 불일치 합니다. 인증에 실패하였습니다.");
			javaScript.setLocation("/" + membershipPath + "/info/myinfo/confirm");
		}else {
			javaScript.setMessage("탈퇴한 회원입니다. 탈퇴일로부터 7일 후 재가입 가능합니다.");
			javaScript.setLocation("/" + mainPath);
		}

		return new JavaScriptView(javaScript);
	}


	@RequestMapping(value = "/reAuth")
	public View reAuth(
			@RequestParam(required = false) String requestView
			, @RequestParam(required = false) String resnCn
			, @RequestParam(required = false) String whdwlEtc
			, HttpServletRequest request
			, Model model
			, HttpSession session
			)throws Exception {

		JavaScript javaScript = new JavaScript();

		if (EgovStringUtil.isNotEmpty(requestView)) {
			session.setAttribute("requestView", requestView);
			session.setAttribute("resnCn", resnCn);
			session.setAttribute("whdwlEtc", whdwlEtc);
		} else {
			session.setAttribute("requestView", null);
			session.setAttribute("resnCn", null);
			session.setAttribute("whdwlEtc", null);
		}
		
		String kakaoUrl = kakaoApiService.getKakaoReAuth();

		javaScript.setLocation(kakaoUrl);
		return new JavaScriptView(javaScript);
	}


}
