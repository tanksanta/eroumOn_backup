package icube.app.matching.simpletest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.app.matching.membership.mbr.biz.MatMbrSession;
import icube.common.framework.abst.CommonAbstractController;
import icube.manage.mbr.recipients.biz.MbrRecipientsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;

@Controller
@RequestMapping(value={"#{props['Globals.Matching.path']}/simpletest"})
public class SimpleTestController  extends CommonAbstractController {
    @Autowired
	private MatMbrSession matMbrSession;

	@Resource(name= "mbrRecipientsService")
	private MbrRecipientsService mbrRecipientsService;
	
	@Resource(name= "simpleTestService")
	private SimpleTestService simpleTestService;

	@Value("#{props['Globals.Matching.path']}")
	private String matchingPath;

	@RequestMapping(value={"/simple/intro"})
	public String simpleIntro(
		Model model) throws Exception {
		
		boolean isLogin = true;
        if(!matMbrSession.isLoginCheck()) {
            isLogin = false;
        }

		if (isLogin){
			model.addAttribute("recipientsCnt", mbrRecipientsService.selectCountMbrRecipientsByMbrUniqueId(matMbrSession.getUniqueId()));
		}

		model.addAttribute("isLogin", isLogin);

        return "/app/matching/simpletest/simple_intro";
    }

	@RequestMapping(value={"/simple/start"})
	public String simpleStart(
		Model model) throws Exception {

		boolean isLogin = true;
        if(!matMbrSession.isLoginCheck()) {
            isLogin = false;
        }

		if (isLogin){
			MbrRecipientsVO recipient = mbrRecipientsService.selectMainMbrRecipientsByMbrUniqueId(matMbrSession.getUniqueId());

			if (recipient != null){
				model.addAttribute("recipientsNo", recipient.getRecipientsNo());
			}
		}
		
		model.addAttribute("isLogin", isLogin);

        return "/app/matching/simpletest/simple_start";
    }

	@RequestMapping(value={"/simple/result"})
	public String simpleResult(
		@RequestParam Map<String,Object> reqMap
		, @RequestParam(required = true) Integer recipientsNo/*수급자 번호*/
		, Model model) throws Exception {

		model.addAttribute("addTitle", "테스트 결과");

		MbrRecipientsVO mbrRecipientsVO = mbrRecipientsService.selectMbrRecipientsByRecipientsNo(recipientsNo);
		model.addAttribute("mbrRecipientsVO", mbrRecipientsVO);

		SimpleTestVO simpleTestVO = simpleTestService.selectSimpleTestByRecipientsNo(matMbrSession.getUniqueId(), recipientsNo, "simple");//"MBR_00000091", recipient.getRecipientsNo()
		
		if (simpleTestVO == null || EgovStringUtil.equals(simpleTestVO.getGrade().toString(), "0")){
			return "/app/matching/simpletest/notsupport_result";
		}

		model.addAttribute("simpleTestVO", simpleTestVO);

        return "/app/matching/simpletest/simple_result";
    }

	protected List<String> SIMPLE_TEST_STEP(){
		return new ArrayList<String>() {{
            add("100");
            add("200");
            add("300");
            add("400");
			add("500");
			add("600");
        }};
	}

	protected List<String> testStepChoiceListValues(String step){
		if (EgovStringUtil.equals("100", step) || EgovStringUtil.equals("200", step)
			|| EgovStringUtil.equals("300", step) || EgovStringUtil.equals("600", step)){
			return new ArrayList<String>() {{
				add("1");
				add("0");
			}};
		}else{
			return new ArrayList<String>() {{
				add("0");
				add("1");
			}};
		}
	}

	protected List<String> testStepChoiceListTexts(String step){
		if (EgovStringUtil.equals("100", step) || EgovStringUtil.equals("200", step)){
			return new ArrayList<String>() {{
				add("도움필요");
				add("도움 없이가능");
			}};
		}else{
			return new ArrayList<String>() {{
				add("네");
				add("아니오");
			}};
		}
		
	}

	@RequestMapping(value={"/test/{step}"})
	public String test(
		@PathVariable String step
		, @RequestParam(required = true) String testTy /*simple, care 구분*/
		, @RequestParam(required = true) Integer recipientsNo/*수급자 번호*/

		, @RequestParam Map<String,Object> reqMap
		
		, HttpServletResponse response
		, Model model) throws Exception {

		List<String> list = this.SIMPLE_TEST_STEP();
		if (list.indexOf(step) < 0){//404오류 해당하는 스텝이 없다
			return "";
		}

		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);

		
		List<String> listValues = new ArrayList<>();
		List<String> listTexts = new ArrayList<>();
		listValues.add("1"); listTexts.add("도움필요");
		listValues.add("0"); listTexts.add("도움 없이가능");


		model.addAttribute("stepIdx", (list.indexOf(step)+1));
		model.addAttribute("step", step);
		model.addAttribute("testTy", testTy);

		Map<String, String> stepValues = SIMPLE_TEST_STEP_VALUES.get(step);

		model.addAttribute("subjectMk", stepValues.get("subjectMk"));
		model.addAttribute("subjectNormal", stepValues.get("subjectNormal"));
		model.addAttribute("imgFileNm", stepValues.get("imgFileNm"));
		model.addAttribute("listValues", this.testStepChoiceListValues(step));
		model.addAttribute("listTexts", this.testStepChoiceListTexts(step));
		model.addAttribute("nextStepUrl", this.nextStepUrl(testTy, step));

        return "/app/matching/simpletest/test_step";
    }

	protected String nextStepUrl(String testTy, String step)throws Exception{

		List<String> list = this.SIMPLE_TEST_STEP();

		String url;
		if (EgovStringUtil.equals(step, "600")){
			url = "/matching/simpletest/"+testTy + "/result";
		}else{
			url = "/matching/simpletest/test/";
			int idx = list.indexOf(step);
			if (idx >= 0){
				url += list.get(idx+1);
			}else{
				throw new Exception();
			}
		}

		return url;
	}
	
    /**
	 * 간편테스트 결과 저장
	 */
    @ResponseBody
	@RequestMapping(value = "test/save.json")
	public Map<String, Object> testSave(
		@RequestParam Map<String,Object> reqMap
		, @RequestParam(required = true) String testTy /*simple, care 구분*/
		, @RequestParam(required = true) Integer recipientsNo/*수급자 번호*/
		, Model model) throws Exception {

        Map<String, Object> resultMap = new HashMap<String, Object>();

		int mbrSimpletestNo = simpleTestService.insertSimpleTest(recipientsNo, reqMap);

		resultMap.put("success", true);
		resultMap.put("mbrSimpletestNo", mbrSimpletestNo);
		
		return resultMap;
	}

	@RequestMapping(value={"/care/intro"})
	public String careIntro(
		Model model) throws Exception {

		boolean isLogin = true;
        if(!matMbrSession.isLoginCheck()) {
            isLogin = false;
        }

		if (isLogin){
			model.addAttribute("recipientsCnt", mbrRecipientsService.selectCountMbrRecipientsByMbrUniqueId(matMbrSession.getUniqueId()));
		}

		model.addAttribute("isLogin", isLogin);

        return "/app/matching/simpletest/care_intro";
    }

	@RequestMapping(value={"/care/time"})
	public String careTime(
		@RequestParam(required = true) Integer recipientsNo/*수급자 번호*/
		, Model model) throws Exception {

		model.addAttribute("recipientsNo", recipientsNo);

		return "/app/matching/simpletest/care_time";
    }

	// @RequestMapping(value={"/care/start"})
	// public String careStart(
	// 	Model model) throws Exception {

	// 	MbrRecipientsVO recipient = mbrRecipientsService.selectMainMbrRecipientsByMbrUniqueId(matMbrSession.getUniqueId());

	// 	if (recipient != null){
	// 		model.addAttribute("recipientsNo", recipient.getRecipientsNo());
	// 	}

    //     return "/app/matching/simpletest/care_start";
    // }

	@RequestMapping(value={"/care/result"})
	public String careResult(
		@RequestParam Map<String,Object> reqMap
		, @RequestParam(required = true) Integer recipientsNo/*수급자 번호*/
		, Model model) throws Exception {

		model.addAttribute("addTitle", "어르신 돌봄");
		
		MbrRecipientsVO mbrRecipientsVO = mbrRecipientsService.selectMbrRecipientsByRecipientsNo(recipientsNo);
		model.addAttribute("mbrRecipientsVO", mbrRecipientsVO);

		SimpleTestVO simpleTestVO = simpleTestService.selectSimpleTestByRecipientsNo(matMbrSession.getUniqueId(), recipientsNo, "care");//"MBR_00000091"
		
		if (simpleTestVO == null || EgovStringUtil.equals(simpleTestVO.getGrade().toString(), "0")){
			return "/app/matching/simpletest/notsupport_result";
		}

		model.addAttribute("simpleTestVO", simpleTestVO);

        return "/app/matching/simpletest/care_result";
    }

	
	protected static final HashMap<String, HashMap<String, String>> SIMPLE_TEST_STEP_VALUES= new LinkedHashMap<String, HashMap<String, String>>() {
		private static final long serialVersionUID = 3678269337053606770L;
		{
			put("100",new LinkedHashMap<String, String>(){
				private static final long serialVersionUID = 3678269337053606771L;
				{
					put("subjectMk","혼자서 식사를");
					put("subjectNormal","하실 수 있나요?");
					put("imgFileNm","easy_03.svg");
				}		
			});
			put("200",new LinkedHashMap<String, String>(){
				private static final long serialVersionUID = 3678269337053606772L;
				{
					put("subjectMk","혼자서 양치나 세수가");
					put("subjectNormal","가능하신가요?");
					put("imgFileNm","easy_04.svg");
				}		
			});
			put("300",new LinkedHashMap<String, String>(){
				private static final long serialVersionUID = 3678269337053606773L;
				{
					put("subjectMk","팔 또는 다리를");
					put("subjectNormal","움직이기 힘드세요?");
					put("imgFileNm","easy_05.svg");
				}		
			});
			put("400",new LinkedHashMap<String, String>(){
				private static final long serialVersionUID = 3678269337053606774L;
				{
					put("subjectMk","혼자서 앉거나 방 밖");
					put("subjectNormal","으로 나가실 수 있나요?");
					put("imgFileNm","easy_06.svg");
				}		
			});
			put("500",new LinkedHashMap<String, String>(){
				private static final long serialVersionUID = 3678269337053606775L;
				{
					put("subjectMk","스스로 대소변 조절이");
					put("subjectNormal","가능한가요?");
					put("imgFileNm","easy_07.svg");
				}		
			});
			put("600",new LinkedHashMap<String, String>(){
				private static final long serialVersionUID = 3678269337053606776L;
				{
					put("subjectMk","치매 판정을");
					put("subjectNormal","받으셨나요?");
					put("imgFileNm","easy_08.svg");
				}		
			});
		}
	};
	
}
