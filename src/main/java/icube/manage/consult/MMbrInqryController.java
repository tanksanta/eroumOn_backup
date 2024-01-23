package icube.manage.consult;

import java.text.SimpleDateFormat;
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
import org.springframework.web.util.HtmlUtils;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.mail.MailService;
import icube.common.util.CommonUtil;
import icube.common.util.FileUtil;
import icube.common.util.StringUtil;
import icube.common.util.ValidatorUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.consult.biz.MbrInqryService;
import icube.manage.consult.biz.MbrInqryVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Controller
@RequestMapping(value="/_mng/consult/mbrInqry")
public class MMbrInqryController extends CommonAbstractController {

	@Resource(name = "mbrInqryService")
	private MbrInqryService mbrInqryService;

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name="mailService")
	private MailService mailService;

	@Value("#{props['Mail.Form.FilePath']}")
	private String mailFormFilePath;

	@Value("#{props['Mail.Username']}")
	private String sendMail;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;

	@Value("#{props['Mail.Testuser']}")
	private String testUser;

	@Autowired
	private MngrSession mngrSession;

	private static String[] targetParams = {"curPage", "cntPerPage", "sortBy","srchRegBgng","srchRegEnd","srchId","srchName","srchInqryTy","srchAns","inqryNo","ansYn"};

	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("srchUseYn", "Y");
		listVO = mbrInqryService.mbrInqryListVO(listVO);
		
		for(Object vo : listVO.getListObject()) {
			MbrInqryVO mbrInqryVO = (MbrInqryVO)vo;
			//마스킹
			mbrInqryVO.setRgtr(StringUtil.nameMasking(mbrInqryVO.getRgtr()));
		}

		model.addAttribute("listVO", listVO);
		model.addAttribute("ansYn", CodeMap.ANS_YN);
		model.addAttribute("inqryTyNo1", CodeMap.INQRY_TY_NO1);
		model.addAttribute("inqryTyNo2", CodeMap.INQRY_TY_NO2);


		return "/manage/consult/mbr_inqry/list";
	}

	@RequestMapping(value="form")
	public String form(
			MbrInqryVO mbrInqryVO
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception{

		int inqryNo = EgovStringUtil.string2integer((String) reqMap.get("inqryNo"));

		String ansYn = (String) reqMap.get("ansYn");

		if(ansYn.equals("N")){
			mbrInqryVO = mbrInqryService.selectMbrInqry(inqryNo);
			mbrInqryVO.setCrud(CRUD.CREATE);
		}else{
			mbrInqryVO = mbrInqryService.selectMbrInqry(inqryNo);
			mbrInqryVO.setCrud(CRUD.UPDATE);
		}

		model.addAttribute("mbrInqryVO", mbrInqryVO);
		model.addAttribute("param", reqMap);
		model.addAttribute("useYn", CodeMap.USE_YN);
		model.addAttribute("ansYn", CodeMap.ANS_YN);
		model.addAttribute("inqryTyCode", CodeMap.INQRY_TY_NO1);
		model.addAttribute("inqryDtlTyCode", CodeMap.INQRY_TY_NO2);

		return "/manage/consult/mbr_inqry/form";
	}

	@RequestMapping(value="ansAction")
	public View ansAction(
			MbrInqryVO mbrInqryVO
			, @RequestParam Map<String,Object> reqMap
			, HttpSession session) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));


		// 관리자정보
		mbrInqryVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		mbrInqryVO.setMdfcnId(mngrSession.getMngrId());
		mbrInqryVO.setMdfr(mngrSession.getMngrNm());

		// 답변자 정보
		mbrInqryVO.setAnsUniqueId(mngrSession.getUniqueId());
		mbrInqryVO.setAnsId(mngrSession.getMngrId());
		mbrInqryVO.setAnswr(mngrSession.getMngrNm());


		switch (mbrInqryVO.getCrud()) {
			case CREATE:
				//답변자 등록
				mbrInqryVO.setAnsYn("Y");
				mbrInqryService.updateAnsInqry(mbrInqryVO);

				javaScript.setMessage(getMsg("action.complete.insert"));
				javaScript.setLocation("./form?" + pageParam);
				break;

			case UPDATE:
				mbrInqryVO.setAnsYn("Y");
				mbrInqryService.updateAnsInqry(mbrInqryVO);

				javaScript.setMessage(getMsg("action.complete.update"));
				javaScript.setLocation(
					"./form?"+ ("".equals(pageParam) ? "" : "&" + pageParam));
				break;


			default:
				break;
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		SimpleDateFormat  formatter = new SimpleDateFormat ("yyyy.MM.dd HH:mm");
		MbrInqryVO inqryVO = mbrInqryService.selectMbrInqry(mbrInqryVO.getInqryNo());



		try {
			if(ValidatorUtil.isEmail(inqryVO.getEml())) {
				String MAIL_FORM_PATH = mailFormFilePath;
				String mailForm = FileUtil.readFile(MAIL_FORM_PATH+"mail/mbr/mail_inqry.html");

				/* body */
				mailForm = mailForm.replace("{mbrNm}", inqryVO.getMbrNm()); // 회원 이름
				mailForm = mailForm.replace("{inqryTy}", CodeMap.INQRY_TY_NO1.get(inqryVO.getInqryTy())); // 문의 유형
				mailForm = mailForm.replace("{ordrCd}", inqryVO.getOrdrCd()); //주문번호
				mailForm = mailForm.replace("{regDt}", formatter.format(inqryVO.getRegDt()));  //문의 등록일
				mailForm = mailForm.replace("{ttl}", inqryVO.getTtl()); // 문의 제목
				mailForm = mailForm.replace("{cn}", inqryVO.getCn()); // 문의 내용
				mailForm = mailForm.replace("{ansDt}", formatter.format(inqryVO.getAnsDt())); // 답변 일
				mailForm = mailForm.replace("{ansCn}", inqryVO.getAnsCn()); // 답변 내용


				// 메일 발송
				String mailSj = "[이로움ON] 1:1문의에 대한 답변이 등록되었습니다";
				if(!EgovStringUtil.equals("local", activeMode)) {
					mailService.sendMail(sendMail, inqryVO.getEml(), mailSj, mailForm);
				}else {
					mailService.sendMail(sendMail, testUser, mailSj, mailForm); //테스트
				}
			} else {
				log.debug("관리자 1:1 문의 답변 알림 EMAIL 전송 실패 :: 이메일 체크 " + inqryVO.getEml());
				resultMap.put("reason", inqryVO.getEml());
			}
		} catch (Exception e) {
			log.debug("관리자 1:1 문의 답변 알림 EMAIL 전송 실패 :: " + e.toString());
			resultMap.put("reason", e.toString());
		}

		return new JavaScriptView(javaScript);
	}

}
