package icube.planner.inquiry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.mail.MailService;
import icube.common.util.FileUtil;
import icube.common.util.ValidatorUtil;

/** 제휴, 입점 문의 **/
@Controller
@RequestMapping(value="#{props['Globals.Planner.path']}/inqry")
public class PlannerInqryController extends CommonAbstractController {

	@Resource(name = "mailService")
	private MailService mailService;

	@Value("#{props['Mail.Form.FilePath']}")
	private String mailFormFilePath;

	@Value("#{props['Mail.Username']}")
	private String sendMail;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;

	@Value("#{props['Globals.Planner.path']}")
	private String plannerPath;

	@RequestMapping(value = "list")
	public String inquiry(
			HttpServletRequest request
			, Model model
			)throws Exception {

		return "/planner/inqry/list";
	}

	@RequestMapping(value = "action")
	public View action(
			@RequestParam(value="bsnsNm", required=true) String bsnsNm // 회사명
			, @RequestParam(value="cntntsNm", required=true) String cntntsNm // 이름
			, @RequestParam(value="cntntsEml", required=true) String cntntsEml // 이메일
			, @RequestParam(value="cntntsSj", required=true) String cntntsSj // 제목
			, @RequestParam(value="cntnts", required=true) String cntnts // 내용
			, @RequestParam(value="inqryTy", required=true) String inqryTy // 유형
			, HttpServletRequest request
			, Model model
			)throws Exception {

		JavaScript javaScript = new JavaScript();

		try {
			if(ValidatorUtil.isEmail(cntntsEml)) {
				String MAIL_FORM_PATH = mailFormFilePath;
				String mailForm = FileUtil.readFile(MAIL_FORM_PATH + "mail_business.html");
				String mailSj = "[이로움ON]" + inqryTy + " 문의가 등록되었습니다.";
				String putEml = "biz@thkc.co.kr";

				mailForm = mailForm.replace("{inqryTy}", inqryTy);
				mailForm = mailForm.replace("{bsnsNm}", bsnsNm);
				mailForm = mailForm.replace("{cntntsNm}", cntntsNm);
				mailForm = mailForm.replace("{cntntsEml}", cntntsEml);
				mailForm = mailForm.replace("{cntntsSj}", cntntsSj);
				mailForm = mailForm.replace("{cntnts}", cntnts);

				if(EgovStringUtil.equals(inqryTy, "마켓입점")) {
					putEml = "bizmarket@thkc.co.kr";
				}

				//mailService.sendMail(cntntsEml, putEml, mailSj, mailForm);
				//TODO 수신자 바꾸기
				mailService.sendMail(sendMail, "gyoh@icubesystems.co.kr", mailSj, mailForm);

				javaScript.setMessage(getMsg("action.complete.insert"));

			}
		}catch(Exception e) {
			e.printStackTrace();
			log.debug("mail_business send Error : " + e.toString());
			javaScript.setMessage("문의 등록에 실패하였습니다. 관리자에게 문의바랍니다.");
		}

		javaScript.setLocation("/" + plannerPath);

		return new JavaScriptView(javaScript);
	}

}
