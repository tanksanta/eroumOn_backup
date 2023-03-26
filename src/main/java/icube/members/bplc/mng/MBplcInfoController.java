package icube.members.bplc.mng;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import icube.common.file.biz.FileService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.manage.members.bplc.biz.BplcService;
import icube.manage.members.bplc.biz.BplcVO;
import icube.members.biz.PartnersSession;

/**
 * 사업소 관리자 > 정보변경, 비밀번호 변경
 */
@Controller
@RequestMapping(value="#{props['Globals.Members.path']}/{bplcUrl}/mng/info")
public class MBplcInfoController extends CommonAbstractController {

	@Resource(name = "bplcService")
	private BplcService bplcService;

	@Resource(name = "fileService")
	private FileService fileService;

	@Autowired
	private PartnersSession partnersSession;

	@Value("#{props['Globals.Server.Dir']}")
	private String serverDir;

	@Value("#{props['Globals.File.Upload.Dir']}")
	private String fileUploadDir;

	@Value("#{props['Globals.Members.path']}")
	private String membersPath;

	//정보변경
	@RequestMapping(value = {"view"})
	public String bplcIndex(
			@PathVariable String bplcUrl
			, HttpSession session
			, HttpServletRequest request
			, Model model) throws Exception {

		BplcVO bplcSetupVO = (BplcVO) request.getAttribute("bplcSetupVO");

		model.addAttribute("bplcVO", bplcSetupVO);

		return "/members/bplc/mng/info/view";
	}

	//정보변경 처리
	@RequestMapping(value="action")
	public View action(
			@PathVariable String bplcUrl
			, HttpSession session
			, HttpServletRequest request
			, BplcVO bplcVO
			, MultipartHttpServletRequest multiReq
			) throws Exception {

		JavaScript javaScript = new JavaScript();
		Map<String, MultipartFile> fileMap = multiReq.getFileMap();
		String bsnmOffcs = "";

		// 수정자 정보
		bplcVO.setMdfcnUniqueId(partnersSession.getUniqueId());
		bplcVO.setMdfcnId(partnersSession.getPartnersId());
		bplcVO.setMdfr(partnersSession.getPartnersNm());

		switch (bplcVO.getCrud()) {
			case UPDATE:

				// 사업자 직인 삭제
				if (!fileMap.get("bsnmOffcs1").isEmpty()) {
					bsnmOffcs = fileService.uploadFile(fileMap.get("bsnmOffcs1"), serverDir.concat(fileUploadDir),
							"OFFCS", fileMap.get("bsnmOffcs1").getOriginalFilename());
					bplcVO.setBsnmOffcs(bsnmOffcs);
				} else if (EgovStringUtil.equals("Y", bplcVO.getDelBsnmOffcs())) {
					bplcVO.setBsnmOffcs(null);
				}

				bplcService.updateBplc(bplcVO);

				javaScript.setMessage(getMsg("action.complete.update"));
				javaScript.setLocation("/"+membersPath+"/"+bplcUrl+"/mng/info/view");
				break;

			default:
				break;
		}

		return new JavaScriptView(javaScript);
	}

	/**
	 * 비밀번호 변경 확인
	 */
	@RequestMapping(value = {"newPswd"})
	public String pswdCf(
			@PathVariable String bplcUrl
			, HttpSession session
			, HttpServletRequest request
			, Model model
			, BplcVO bplcVO
			) throws Exception {


		return "/members/bplc/mng/info/pswd_cf";
	}

	/**
	 * 비밀번호 확인 처리
	 */
	@RequestMapping(value = {"pswdAction"})
	public View pswdAction(
			@PathVariable String bplcUrl
			, HttpSession session
			, HttpServletRequest request
			, BplcVO bplcVO
			)throws Exception {

		JavaScript javaScript = new JavaScript();

		BplcVO setupVO = (BplcVO)request.getAttribute("bplcSetupVO");

		//아이디 확인
		if(bplcVO.getBplcId().equals(setupVO.getBplcId())){
			//비밀번호 확인
			if(BCrypt.checkpw(bplcVO.getBplcPswd(), setupVO.getBplcPswd())){
				javaScript.setLocation("/"+membersPath+"/"+bplcUrl+"/mng/info/pswdChg");
			}else {
				//비밀번호가 틀린 경우
				javaScript.setMessage(getMsg("login.fail.pwsearch"));
				javaScript.setMethod("window.history.back()");
			}
		}else {
			//아이디가 틀린 경우
			javaScript.setMessage(getMsg("login.fail.idsearch"));
			javaScript.setMethod("window.history.back()");
		}

		return new JavaScriptView(javaScript);

	}

	/**
	 * 비밀번호 변경
	 */
	@RequestMapping(value = {"pswdChg"})
	public String pswdChg(
			@PathVariable String bplcUrl
			, HttpSession session
			, HttpServletRequest request
			, Model model
			, BplcVO bplcVO
			) throws Exception {


		return "/members/bplc/mng/info/pswd_chg";
	}

	/**
	 * 비밀번호 변경 처리
	 */
	@RequestMapping(value = {"newPswdAction"})
	public View newPswdAction(
			@PathVariable String bplcUrl
			, HttpSession session
			, HttpServletRequest request
			, BplcVO bplcVO
			)throws Exception {

		JavaScript javaScript = new JavaScript();

		BplcVO setupVO = (BplcVO)request.getAttribute("bplcSetupVO");

		//암호화
		String encPswd = BCrypt.hashpw(bplcVO.getBplcPswd(), BCrypt.gensalt());

		bplcService.updateBplcPswd(setupVO.getUniqueId(), encPswd );

		javaScript.setMessage(getMsg("action.complete.newPswd"));
		javaScript.setLocation("/"+membersPath+"/"+bplcUrl+"/mng/index");

		return new JavaScriptView(javaScript);

	}
}
