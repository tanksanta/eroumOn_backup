package icube.common.api;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.manage.sysmng.test.biz.MMngTestService;

/**
 * 장기요양 예상등급 TEST 설정 정보 요청 api
 */
@Controller
@RequestMapping(value = "/api")
public class BokjiTestApiController {
	
	@Resource(name="mMngTestService")
	private MMngTestService mMngTestService;
	
	@ResponseBody
	@RequestMapping(value="/test/info", produces="application/json;charset=UTF-8")
	public String getScoreData() throws Exception {
		return getTestDataJson("점수");
	}
	
	@ResponseBody
	@RequestMapping(value="/physical", produces="application/json;charset=UTF-8")
	public String getPhysicalData() throws Exception {
		return getTestDataJson("신체기능");
	}
	
	@ResponseBody
	@RequestMapping(value="/cognitive", produces="application/json;charset=UTF-8")
	public String getCognitiveData() throws Exception {
		return getTestDataJson("인지기능");
	}
	
	@ResponseBody
	@RequestMapping(value="/behavior", produces="application/json;charset=UTF-8")
	public String getBehaviorData() throws Exception {
		return getTestDataJson("행동변화");
	}
	
	@ResponseBody
	@RequestMapping(value="/nurse", produces="application/json;charset=UTF-8")
	public String getNurseData() throws Exception {
		return getTestDataJson("간호처치");
	}
	
	@ResponseBody
	@RequestMapping(value="/rehabilitate", produces="application/json;charset=UTF-8")
	public String getRehabilitateData() throws Exception {
		return getTestDataJson("재활");
	}
	
	@ResponseBody
	@RequestMapping(value="/disease", produces="application/json;charset=UTF-8")
	public String getDiseaseData() throws Exception {
		return getTestDataJson("질병");
	}
	
	private String getTestDataJson(String testNm) {
		String result = "{}";
		
		//Test DB 조회
		List<Map<String, String>> testList = mMngTestService.selectAllTestMng();
		
		Map<String, String> findScoreTest = testList.stream().filter(f -> testNm.equals(f.get("test_nm"))).findFirst().orElse(null);
		if (findScoreTest != null) {
			result = findScoreTest.get("data");
		}
		return result;
	}
}
