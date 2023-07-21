package icube.main.inquiry;

import java.io.File;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import icube.common.file.biz.FileService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.mail.MailService;
import icube.common.util.FileUtil;
import icube.common.util.ValidatorUtil;

/** 제휴, 입점 문의 **/
@Controller
@RequestMapping(value="#{props['Globals.Main.path']}/inqry")
public class MainInqryController extends CommonAbstractController {

	@Resource(name = "mailService")
	private MailService mailService;

	@Resource(name = "fileService")
	private FileService fileService;

	@Value("#{props['Mail.Form.FilePath']}")
	private String mailFormFilePath;

	@Value("#{props['Mail.Username']}")
	private String sendMail;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;

	@Value("#{props['Globals.Main.path']}")
	private String mainPath;

	@Value("#{props['Globals.Server.Dir']}")
	private String serverDir;

	@Value("#{props['Globals.File.Upload.Dir']}")
	private String fileUploadDir;

	@RequestMapping(value = "list")
	public String inquiry(
			HttpServletRequest request
			, Model model
			)throws Exception {

		return "/main/inqry/list";
	}

	@RequestMapping(value = "action")
	public View action(
			@RequestParam(value="bsnsNm", required=true) String bsnsNm // 회사명
			, @RequestParam(value="cntntsNm", required=true) String cntntsNm // 이름
			, @RequestParam(value="cntntsEml", required=true) String cntntsEml // 이메일
			, @RequestParam(value="cntntsSj", required=true) String cntntsSj // 제목
			, @RequestParam(value="cntnts", required=true) String cntnts // 내용
			, @RequestParam(value="inqryTy", required=true) String inqryTy // 유형
			, MultipartHttpServletRequest multiReq
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

				// 첨부파일 업로드
				Map<String, MultipartFile> fileMap = multiReq.getFileMap();
				String fileName = fileService.uploadFile(fileMap.get("attachFile"), serverDir.concat(fileUploadDir), "MAIL_ATTACH", fileMap.get("attachFile").getOriginalFilename());
				String filePath = serverDir.concat(fileUploadDir)  + File.separator + "MAIL_ATTACH" + File.separator + fileName;

				mailService.sendMail(sendMail, putEml, mailSj, mailForm, filePath);

				javaScript.setMessage(getMsg("action.complete.insert"));

			}
		}catch(Exception e) {
			e.printStackTrace();
			log.debug("mail_business send Error : " + e.toString());
			javaScript.setMessage("문의 등록에 실패하였습니다. 관리자에게 문의바랍니다.");
		}

		javaScript.setLocation("/" + mainPath);

		return new JavaScriptView(javaScript);
	}

}
