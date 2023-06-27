package icube.membership;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
			, @RequestParam(value = "code", required=true) String code
			, @RequestParam(value = "state", required=false) String state
			) throws Exception {
		JavaScript javaScript = new JavaScript();

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("code", code);
		paramMap.put("state", state);

		int resultCnt = naverApiService.mbrAction(paramMap, session);

		if(resultCnt == 0) {// 오류
			javaScript.setMessage(getMsg("fail.common.network"));
			javaScript.setLocation("/" + mainPath + "/login");
		}else if(resultCnt == 1){//성공
			mbrService.updateRecentDt(mbrSession.getUniqueId());
			
			javaScript.setMessage("회원가입이 완료되었습니다.");
			javaScript.setLocation("/" + mainPath);
		}else if(resultCnt == 2) {// 카카오 로그인
			javaScript.setMessage("카카오 계정으로 가입된 회원입니다.");
			javaScript.setLocation("/" + mainPath + "/login");
		}else if(resultCnt == 3) {// 네이버
			// 최근 일시 업데이트
			mbrService.updateRecentDt(mbrSession.getUniqueId());
			javaScript.setLocation("/" + mainPath);
		}else if(resultCnt == 4) {// 이로움
			javaScript.setMessage("이로움 계정으로 가입된 회원입니다.");
			javaScript.setLocation("/" + membershipPath + "/login");
		}else if(resultCnt == 5) {// 2건
			javaScript.setMessage("동일한 가입 정보가 1건 이상 존재합니다. 관리자에게 문의바랍니다.");
			javaScript.setLocation("/" + mainPath);
		}else if(resultCnt == 6 || resultCnt == 7) {// 등록 완료
			javaScript.setMessage("간편 회원가입이 완료되었습니다.");
			javaScript.setLocation("/" + mainPath);
		}else if(resultCnt == 8) {
			javaScript.setMessage("일시 정지된 회원입니다. 관리자에게 문의바랍니다.");
			javaScript.setLocation("/" + mainPath);
		}else if(resultCnt == 9) {
			javaScript.setMessage("휴면 회원입니다. 휴면 해제 페이지로 이동합니다.");
			javaScript.setLocation("/" + membershipPath + "/drmt/view?mbrId=" + mbrSession.getMbrId());
		}else {
			javaScript.setMessage("탈퇴한 회원입니다. 탈퇴일로부터 7일 후 재가입 가능합니다.");
			javaScript.setLocation("/" + mainPath);
		}

		return new JavaScriptView(javaScript);
	}

}
