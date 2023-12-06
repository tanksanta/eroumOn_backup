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

import icube.common.api.biz.NaverApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 네이버 간편 로그인
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="#{props['Globals.Membership.path']}/naver")
public class MbrsNaverController extends CommonAbstractController{

	@Resource(name = "naverApiService")
	private NaverApiService naverApiService;

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Main.path']}")
	private String mainPath;

	@Value("#{props['Globals.Membership.path']}")
	private String membershipPath;

	@RequestMapping(value = "/get")
	public View get() throws Exception {
		JavaScript javaScript = new JavaScript();
		String getUrl = naverApiService.getUrl();

		javaScript.setLocation(getUrl);
		return new JavaScriptView(javaScript);
	}

	@RequestMapping(value = "/auth")
	public View auth(
			HttpServletRequest request
			, HttpSession session
			, Model model
			, @RequestParam(value = "code", required=false) String code
			, @RequestParam(value = "state", required=false) String state
			, @RequestParam(value = "error", required=false) String error
			) throws Exception {

		JavaScript javaScript = new JavaScript();

		//로그인 실패오류 또는 동의하지 않은 경우
		if ("access_denied".equals(error)) {
			javaScript.setLocation("/" + mainPath + "/login");
			return new JavaScriptView(javaScript);
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("code", code);
		paramMap.put("state", state);

		int resultCnt = -1;
		try {
			resultCnt = naverApiService.mbrAction(paramMap, session);
		} catch (Exception ex) {
			javaScript.setMessage("네이버로부터 로그인정보를 받아오지 못하였습니다.");
			javaScript.setLocation("/" + mainPath + "/login");
			return new JavaScriptView(javaScript);
		}

		String returnUrl = (String)session.getAttribute("returnUrl");

		if(resultCnt == 0) {// 오류
			javaScript.setMessage(getMsg("fail.common.network"));
			javaScript.setLocation("/" + mainPath + "/login");
		}else if(resultCnt == 1){//성공
			mbrService.updateRecentDt(mbrSession.getUniqueId());

			javaScript.setLocation("/" + membershipPath + "/sns/regist?uid=" + mbrSession.getUniqueId());
			session.removeAttribute("returnUrl");
		}else if(resultCnt == 2) {// 카카오 로그인
			if (mbrSession.getSnsRegistDt() == null) {
				javaScript.setMessage("현재 카카오 계정으로 간편 가입 진행 중입니다.");
				javaScript.setLocation("/" + membershipPath + "/regist");
			} else {
				javaScript.setMessage("카카오 계정으로 가입된 회원입니다.");
				javaScript.setLocation("/" + mainPath + "/login");
			}
		}else if(resultCnt == 3) {// 네이버
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
		}else if(resultCnt == 4) {// 이로움
			javaScript.setMessage("이로움 계정으로 가입된 회원입니다.");
			javaScript.setLocation("/" + membershipPath + "/login");
		}else if(resultCnt == 5) {// 2건
			javaScript.setMessage("동일한 가입 정보가 1건 이상 존재합니다. 관리자에게 문의바랍니다.");
			javaScript.setLocation("/" + mainPath);
		}else if(resultCnt == 6 || resultCnt == 7) {// 등록 완료
			javaScript.setMessage("간편 회원가입이 완료되었습니다.");
			if(EgovStringUtil.isNotEmpty(returnUrl)) {
				javaScript.setLocation(returnUrl);
			}else {
				javaScript.setLocation("/" + mainPath);
			}
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
			, HttpSession session
			) throws Exception {
		
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
		
		String naverUrl = naverApiService.getNaverReAuth();

		javaScript.setLocation(naverUrl);
		return new JavaScriptView(javaScript);
	}
}
