package icube.manage.consult;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;
import org.springframework.web.util.HtmlUtils;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.mail.MailService;
import icube.common.util.CommonUtil;
import icube.common.util.FileUtil;
import icube.common.util.HtmlUtil;
import icube.common.util.ValidatorUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.consult.biz.GdsQaService;
import icube.manage.consult.biz.GdsQaVO;
import icube.manage.gds.gds.biz.GdsService;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Controller
@RequestMapping(value="/_mng/consult/gdsQa")
public class MGdsQaController extends CommonAbstractController {

	@Resource(name = "gdsQaService")
	private GdsQaService gdsQaService;

	@Resource(name = "gdsService")
	private GdsService gdsService;

	@Resource(name="mailService")
	private MailService mailService;

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Value("#{props['Mail.Form.FilePath']}")
	private String mailFormFilePath;

	@Value("#{props['Mail.Testuser']}")
	private String testUser;

	@Value("#{props['Mail.Username']}")
	private String sendMail;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;

	@Autowired
	private MngrSession mngrSession;

	// Page Parameter Keys
	private static String[] targetParams = {"curPage", "cntPerPage", "sortBy","srchRegYmdBgng","srchRegYmdEnd","srchRgtrId", "srchRgtr","srchQestnCn","srchUseYn","srchAnsYn"};

    /**
     * 상품 Q&A 리스트
     */
	@RequestMapping(value="list")
	@SuppressWarnings("unchecked")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = gdsQaService.gdsQaListVO(listVO);

		// 답변 내용 태그 처리
		List<GdsQaVO> qaList = listVO.getListObject();
		for(GdsQaVO gdsQaVO : qaList) {
			gdsQaVO.setAnsCn(HtmlUtil.clean(gdsQaVO.getAnsCn()));
		}

		model.addAttribute("listVO", listVO);
		model.addAttribute("useYnCode", CodeMap.USE_YN);
		model.addAttribute("ansYnCode", CodeMap.ANS_YN);

		return "/manage/consult/gds_qa/list";
	}

	/**
	 * 상품 Q&A 답변 폼
	 */
	@RequestMapping(value="form")
	public String form(
			GdsQaVO gdsQaVO
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception{

		int gdsQaNo = EgovStringUtil.string2integer((String)reqMap.get("qaNo"));

		String ansUniqueId = (String) reqMap.get("ansUniqueId");

		gdsQaVO = gdsQaService.selectGdsQa(gdsQaNo);

		if(ansUniqueId ==  null){
			gdsQaVO.setCrud(CRUD.CREATE);
		}else{
			gdsQaVO.setCrud(CRUD.UPDATE);
		}

		model.addAttribute("gdsQaVO", gdsQaVO);
		model.addAttribute("useYnCode", CodeMap.USE_YN);
		model.addAttribute("ansYnCode", CodeMap.ANS_YN);
		model.addAttribute("param", reqMap);

		return "/manage/consult/gds_qa/form";
	}


	@RequestMapping(value="action")
	public View action(
			GdsQaVO gdsQaVO
			, @RequestParam Map<String,Object> reqMap
			) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));


		// 관리자정보
		gdsQaVO.setAnsId(mngrSession.getMngrId());
		gdsQaVO.setAnsUniqueId(mngrSession.getUniqueId());
		gdsQaVO.setAnswr(mngrSession.getMngrNm());

		switch (gdsQaVO.getCrud()) {
			case CREATE:
				gdsQaService.updateGdsQaAns(gdsQaVO);

				javaScript.setMessage(getMsg("action.complete.insert"));
				javaScript.setLocation("./form?qaNo=" +gdsQaVO.getQaNo() + "&" + pageParam);
				break;

			case UPDATE:
				gdsQaService.updateGdsQaAns(gdsQaVO);

				javaScript.setMessage(getMsg("action.complete.update"));
				javaScript.setLocation("./form?qaNo=" +gdsQaVO.getQaNo() + "&" + pageParam);
				break;

			default:
				break;
		}

		//답변 이메일 발송
		try {
			GdsQaVO qaVO = gdsQaService.selectGdsQa(gdsQaVO.getQaNo());

			if(ValidatorUtil.isEmail(qaVO.getEml())) {
				SimpleDateFormat  formatter = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");

				String MAIL_FORM_PATH = mailFormFilePath;
				String mailForm = FileUtil.readFile(MAIL_FORM_PATH+"mail_qna.html");

				/* body */
				mailForm = mailForm.replace("{mbrNm}", qaVO.getRgtr()); // 회원 이름
				mailForm = mailForm.replace("{gdsNm}", qaVO.getGdsNm()); // 상품 이름

				mailForm = mailForm.replace("{regDt}", formatter.format(qaVO.getRegDt()));  //문의 등록일
				mailForm = mailForm.replace("{cn}", qaVO.getQestnCn()); // 문의 내용
				mailForm = mailForm.replace("{ansDt}", formatter.format(qaVO.getAnsDt())); // 답변 일
				mailForm = mailForm.replace("{ansCn}", qaVO.getAnsCn()); // 답변 내용

				/* footer */
				mailForm = mailForm.replace("{company}", "㈜티에이치케이컴퍼니");
				mailForm = mailForm.replace("{name}", "이로움마켓");
				mailForm = mailForm.replace("{addr}", "부산시 금정구 중앙대로 1815, 5층(가루라빌딩)");
				mailForm = mailForm.replace("{brno}", "617-86-14330");
				mailForm = mailForm.replace("{telno}", "2016-부산금정-0114");


				// 메일 발송
				String mailSj = "[이로움ON] 상품문의에 대한 답변이 등록되었습니다";
				if(!EgovStringUtil.equals("local", activeMode)) {
					mailService.sendMail(sendMail, qaVO.getEml(), mailSj, mailForm);
				}else {
					mailService.sendMail(sendMail, testUser, mailSj, mailForm); //테스트
				}
			} else {
				log.debug("관리자 상품 QnA 답변 알림 EMAIL 전송 실패 :: 이메일 체크 " + qaVO.getEml());
			}
		} catch (Exception e) {
			log.debug("관리자 상품 QnA 문의 답변 알림 EMAIL 전송 실패 :: " + e.toString());
		}

		return new JavaScriptView(javaScript);
	}

}
