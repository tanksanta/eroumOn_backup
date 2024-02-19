package icube.app.matching.simpletest;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.app.matching.membership.mbr.biz.MatMbrSession;
import icube.common.framework.abst.CommonAbstractController;

@Controller
@RequestMapping(value={"#{props['Globals.Matching.path']}/simpletest"})
public class SimpleTestController  extends CommonAbstractController {
    @Autowired
	private MatMbrSession matMbrSession;

	@Value("#{props['Globals.Matching.path']}")
	private String matchingPath;

	@RequestMapping(value={"/simple/intro"})
	public String simpleIntro(
		HttpSession session
		, HttpServletRequest request
		, HttpServletResponse response
		, Model model) throws Exception {

		//로그인이 안 되어 있으면 loginn으로 redirect
		// if (!matMbrSession.isLoginCheck()) {
		// 	return "redirect:/" + matchingPath + "/login";
		// }

        return "/app/matching/simpletest/simple_intro";
    }
	@RequestMapping(value={"/simple/start"})
	public String simpleStart(
		HttpSession session
		, HttpServletRequest request
		, HttpServletResponse response
		, Model model) throws Exception {


        return "/app/matching/simpletest/simple_start";
    }

	@RequestMapping(value={"/simple/result"})
	public String simpleResult(
		HttpSession session
		, HttpServletRequest request
		, HttpServletResponse response
		, Model model) throws Exception {


        return "/app/matching/simpletest/simple_result";
    }
	
	
	@RequestMapping(value={"/test/{step}"})
	public String test(
		@PathVariable String step
		, @RequestParam(required = true) String testTy /*simple, care 구분*/
		, @RequestParam(required = true) String selValue/*이전 화면에서 선택된 값*/
		, @RequestParam(required = true) Integer recipientsNo/*수급자 번호*/
		
		, HttpSession session
		, HttpServletRequest request
		, HttpServletResponse response
		, Model model) throws Exception {

		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);

		
		List<String> listValues = new ArrayList<>();
		List<String> listTexts = new ArrayList<>();
		listValues.add("1"); listTexts.add("도움필요");
		listValues.add("2"); listTexts.add("도움 없이가능");


		model.addAttribute("step", step);
		model.addAttribute("testTy", testTy);
		model.addAttribute("selValue", selValue);

		model.addAttribute("title", "title");
		model.addAttribute("img", "image");
		model.addAttribute("listValues", listValues);
		model.addAttribute("listTexts", listTexts);
		model.addAttribute("selectedValue", "selectedValue");
		model.addAttribute("nextStepUrl", this.nextStepUrl(testTy, step));

        return "/app/matching/simpletest/test_step";
    }

	protected String nextStepUrl(String testTy, String step)throws Exception{

		List<String> list = new ArrayList<String>() {{
            add("100");
            add("200");
            add("300");
            add("400");
			add("500");
			add("600");
        }};

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

	@RequestMapping(value={"/care/intro"})
	public String careIntro(
		HttpSession session
		, HttpServletRequest request
		, HttpServletResponse response
		, Model model) throws Exception {


        return "/app/matching/simpletest/care_intro";
    }

	@RequestMapping(value={"/care/start"})
	public String careStart(
		HttpSession session
		, HttpServletRequest request
		, HttpServletResponse response
		, Model model) throws Exception {


        return "/app/matching/simpletest/care_start";
    }

	@RequestMapping(value={"/care/result"})
	public String careResult(
		HttpSession session
		, HttpServletRequest request
		, HttpServletResponse response
		, Model model) throws Exception {


        return "/app/matching/simpletest/care_result";
    }

}
