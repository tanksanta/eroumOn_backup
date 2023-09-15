package icube.main;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.mail.MailService;
import icube.common.util.FileUtil;
import icube.common.values.CodeMap;
import icube.main.biz.MainService;
import icube.manage.consult.biz.MbrConsltChgHistVO;
import icube.manage.consult.biz.MbrConsltService;
import icube.manage.consult.biz.MbrConsltVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.members.bplc.biz.BplcService;
import icube.manage.members.bplc.biz.BplcVO;
import icube.market.mbr.biz.MbrSession;

@Controller
@RequestMapping(value="#{props['Globals.Main.path']}/conslt")
public class MainConsltController extends CommonAbstractController{

	@Resource(name = "mainService")
	private MainService mainService;

	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "bplcService")
	private BplcService bplcService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Main.path']}")
	private String mainPath;

	@Resource(name = "mailService")
	private MailService mailService;

	@Value("#{props['Mail.Form.FilePath']}")
	private String mailFormFilePath;

	@Value("#{props['Mail.Username']}")
	private String sendMail;

	@Autowired
	private Environment environment;
	
	@RequestMapping(value = "form")
	public String form(
			HttpServletRequest request
			, Model model
			, HttpSession session
			, MbrConsltVO mbrConsltVO
			)throws Exception {

		if(!mbrSession.isLoginCheck()) {
			session.setAttribute("returnUrl", "/"+mainPath+"/conslt/form");
			return "redirect:" + "/membership/login?returnUrl=/"+mainPath+"/conslt/form";
		}

		model.addAttribute("mbrConsltVO", mbrConsltVO);
		model.addAttribute("genderCode", CodeMap.GENDER);

		return "/main/conslt/form";
	}

	@RequestMapping(value = "action")
	public View action(
			HttpServletRequest request
			, Model model
			, MbrConsltVO mbrConsltVO
			)throws Exception {

		JavaScript javaScript = new JavaScript();

		mbrConsltVO.setRegId(mbrSession.getMbrId());
		mbrConsltVO.setRegUniqueId(mbrSession.getUniqueId());
		mbrConsltVO.setRgtr(mbrConsltVO.getMbrNm());

		if(EgovStringUtil.isNotEmpty(mbrConsltVO.getBrdt())) {
			mbrConsltVO.setBrdt(mbrConsltVO.getBrdt().replace("/", ""));
		}

		int insertCnt = mbrConsltService.insertMbrConslt(mbrConsltVO);

		if (insertCnt > 0) {
			//1:1 상담신청 이력 추가
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("srchRgtr", mbrConsltVO.getRgtr());
			paramMap.put("srchUniqueId", mbrConsltVO.getRegUniqueId());
			MbrConsltVO srchMbrConslt = mbrConsltService.selectLastMbrConsltForCreate(paramMap);
			
			MbrConsltChgHistVO mbrConsltChgHistVO = new MbrConsltChgHistVO();
			mbrConsltChgHistVO.setConsltNo(srchMbrConslt.getConsltNo());
			mbrConsltChgHistVO.setConsltSttusChg(srchMbrConslt.getConsltSttus());
			mbrConsltChgHistVO.setResn(CodeMap.CONSLT_STTUS_CHG_RESN.get("접수"));
			mbrConsltChgHistVO.setMbrUniqueId(mbrSession.getUniqueId());
			mbrConsltChgHistVO.setMbrId(mbrSession.getMbrId());
			mbrConsltChgHistVO.setMbrNm(mbrSession.getMbrNm());
			mbrConsltService.insertMbrConsltChgHist(mbrConsltChgHistVO);
			
			
			//1:1 상담신청시 관리자에게 알림 메일 발송
			String MAIL_FORM_PATH = mailFormFilePath;
			String mailForm = FileUtil.readFile(MAIL_FORM_PATH + "mail_conslt.html");
			String mailSj = "[이로움 ON] 장기요양테스트 신규상담건 문의가 접수되었습니다.";
			String putEml = "help@thkc.co.kr";

			if (Arrays.asList(environment.getActiveProfiles()).stream().anyMatch(profile -> "real".equals(profile) || "test".equals(profile))) {
				mailService.sendMail(sendMail, putEml, mailSj, mailForm);
			}
		}

		javaScript.setMessage(getMsg("action.complete.insert"));
		javaScript.setLocation("/"+mainPath+"/conslt/view");
		return new JavaScriptView(javaScript);
	}

	@RequestMapping(value = "view")
	public String view(
			HttpServletRequest request
			, Model model
			)throws Exception {

		return "/main/conslt/view";
	}

	// 추천 멤버스 리스트
	@RequestMapping(value="include/popup")
	public String popup(
			Model model
			)throws Exception  {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchAprvTy", "C");
		paramMap.put("srchUseYn", "Y");
		paramMap.put("srchDspyYn", "Y");
		List<BplcVO> bplcList = bplcService.selectBplcList(paramMap);

		model.addAttribute("bplcList", bplcList);

		return "/main/conslt/include/popup";
	}
}
