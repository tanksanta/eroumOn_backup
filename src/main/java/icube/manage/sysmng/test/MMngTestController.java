package icube.manage.sysmng.test;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import icube.common.util.ExcelUtil;
import icube.manage.sysmng.test.biz.MMngTestService;

@Controller
@RequestMapping(value="/_mng/sysmng/test")
public class MMngTestController {
	
	@Resource(name="mMngTestService")
	private MMngTestService mMngTestService;
	
	
	/**
	 * 시스템 관리 > 테스트 관리 > 리스트
	 */
	@RequestMapping(value="list")
	public String list() {
		return "/manage/sysmng/test/list";
	}
	
	/**
	 * 시스템 관리 > 테스트 관리 > 테스트 엑셀 업로드
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "modalFileUpload")
	public String modalFileUpload(
		HttpServletRequest request
		, Model model)throws Exception {
		return "/manage/sysmng/test/include/excel-file-upload";
	}
	
	/**
	 * 시스템 관리 > 테스트 관리 > 테스트 엑셀 업로드 처리
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "excelUpload.json")
	public Map<String, String> UploadExcel(
		HttpServletRequest request
		, Model model)throws Exception {
		
		Map<String, String> resMap = new HashMap<String, String>();
		
		try {
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;
			
			MultipartFile excelFile = multiRequest.getFile("excel");
			
			//Excel 읽기
			Map<String, List<List<String>>> excelData = ExcelUtil.readExcel(excelFile);
			Set<String> keys = excelData.keySet();
			
			//기존 Test DB 조회
			List<Map<String, String>> testList = mMngTestService.selectAllTestMng();
			
			//Sheet 순회
			Iterator iter = keys.iterator();
			while (iter.hasNext()) {
				String sheetName = (String) iter.next();
				List<List<String>> rowsData = excelData.get(sheetName);
				
				JSONObject jsonObject = null;
				
				if ("신체기능".equals(sheetName)) {
					jsonObject = getPysicalQuestionJson(rowsData);
				} else if ("인지기능".equals(sheetName)) {
					jsonObject = getJsonForCasesData(rowsData, "Q13. 해당하는 모든 증상을 선택해 주세요.");
				} else if ("행동변화".equals(sheetName)) {
					jsonObject = getJsonForCasesData(rowsData, "Q14. 해당하는 모든 증상을 선택해 주세요.");
				} else if ("간호처치".equals(sheetName)) {
					jsonObject = getJsonForCasesData(rowsData, "Q15. 해당하는 모든 증상을 선택해 주세요.");
				} else if ("재활".equals(sheetName)) {
					jsonObject = getRehabilitateQuestionJson(rowsData);
				} else if ("질병".equals(sheetName)) {
					jsonObject = getJsonForCasesData(rowsData, "Q26. 어르신이 현재 앓고 있는 질병 또는 증상을 모두 선택해 주세요.", false);
				}
				
				if (jsonObject != null && !jsonObject.isEmpty()) {
					//DB 저장
					Map<String, String> testVoMap = new HashMap();
					testVoMap.put("test_nm", sheetName);
					testVoMap.put("data", jsonObject.toJSONString());
					
					Map<String, String> findTest = testList.stream().filter(f -> sheetName.equals(f.get("test_nm"))).findFirst().orElse(null);
					if (findTest == null) {
						mMngTestService.insertTestMng(testVoMap);
					} else {
						mMngTestService.updateTestMng(testVoMap);
					}
				}
			}
			
			//점수 Sheet는 제일 마지막에 저장
			List<List<String>> scoreSheetData = excelData.get("점수");
			if (scoreSheetData != null) {
				//위에 영역 저장된 데이터 재조회
				testList = mMngTestService.selectAllTestMng();
				
				//각 영역 질문지 수
				int pysicalCnt = getQuestionCount(testList, "신체기능");
				int cognitiveCnt = getCaseCount(testList, "인지기능", true);
				int behaviorCnt = getCaseCount(testList, "행동변화", true);
				int nurseCnt = getCaseCount(testList, "간호처치", true);
				int rehabilitateCnt = getQuestionCount(testList, "재활");
				int diseaseCnt = getCaseCount(testList, "질병", false);
				
				//점수 JsonData 만들기
				JSONObject jsonData = new JSONObject();
				JSONArray rankRanges = new JSONArray();
				for (int rowIndex = 1; rowIndex < scoreSheetData.size(); rowIndex++) {
					List<String> row = scoreSheetData.get(rowIndex);
					
					JSONObject rankRangeJson = new JSONObject();
					String rank = row.get(0);
					String min = row.get(1);
					String max = null;
					if (row.size() > 2) {
						max = row.get(2);
					}
					
					rankRangeJson.put("rank", EgovStringUtil.isNotEmpty(rank) ? (int) Double.parseDouble(rank) : null);
					rankRangeJson.put("min", EgovStringUtil.isNotEmpty(min) ? (int) Double.parseDouble(min) : null);
					rankRangeJson.put("max", EgovStringUtil.isNotEmpty(max) ? (int) Double.parseDouble(max) : null);
					rankRanges.add(rankRangeJson);
				}
				jsonData.put("rankRanges", rankRanges);
				jsonData.put("physicalCount", pysicalCnt);
				jsonData.put("cognitiveCount", cognitiveCnt);
				jsonData.put("behaviorCount", behaviorCnt);
				jsonData.put("nurseCount", nurseCnt);
				jsonData.put("rehabilitateCount", rehabilitateCnt);
				jsonData.put("diseaseCount", diseaseCnt);
				
				Map<String, String> testVoMap = new HashMap();
				testVoMap.put("test_nm", "점수");
				testVoMap.put("data", jsonData.toJSONString());
				
				//점수 정보 DB 저장
				Map<String, String> findScoreTest = testList.stream().filter(f -> "점수".equals(f.get("test_nm"))).findFirst().orElse(null);
				if (findScoreTest == null) {
					mMngTestService.insertTestMng(testVoMap);
				} else {
					mMngTestService.updateTestMng(testVoMap);
				}
			}
			
		} catch (Exception e) {
			resMap.put("result", "N");
			resMap.put("msg", "파일이 올바르지 않습니다.");
			resMap.put("error", e.getMessage());
			return resMap;
		}
		
		resMap.put("result", "Y");
		resMap.put("msg", "업로드 완료");
		return resMap;
	}
	
	
	/**
	 * 신체기능 영역 json 데이터 리턴
	 */
	@SuppressWarnings("unchecked")
	private JSONObject getPysicalQuestionJson(List<List<String>> rowsData) {
		JSONObject jsonObject = new JSONObject();
		JSONArray questions = new JSONArray();
		JSONArray scoreEvaluations = new JSONArray();
		
		//공통으로 들어가는 cases 정의
		JSONArray cases = new JSONArray();
		JSONObject case1 = new JSONObject();
		case1.put("content", "혼자서 가능");
		case1.put("score", 1);
		cases.add(case1);
		JSONObject case2 = new JSONObject();
		case2.put("content", "일부 도움 필요");
		case2.put("score", 2);
		cases.add(case2);
		JSONObject case3 = new JSONObject();
		case3.put("content", "완전히 도움 필요");
		case3.put("score", 3);
		cases.add(case3);
		
		boolean isScoreArea = false;
		
		for (int rowIndex = 1; rowIndex < rowsData.size(); rowIndex++) {
			List<String> row = rowsData.get(rowIndex);
			
			String firstCellValue = row.get(0);
			if ("점수".equals(firstCellValue)) {
				isScoreArea = true;
				continue;
			}
			if (isScoreArea) {
				//평가 점수 데이터
				JSONObject scoreEvaluationJson = new JSONObject();
				Double score = Double.parseDouble(row.get(0));
				Double evaluation = Double.parseDouble(row.get(1));
				
				scoreEvaluationJson.put("score", score);
				scoreEvaluationJson.put("evaluation", evaluation);
				scoreEvaluations.add(scoreEvaluationJson);
			} else {
				//질문지 데이터
				JSONObject questionJson = new JSONObject();
				String question = row.get(0);
				
				questionJson.put("question", question);
				questionJson.put("type", "radio");
				questionJson.put("cases", cases);
				questions.add(questionJson);
			}
		}
		jsonObject.put("questions", questions);
		jsonObject.put("scoreEvaluations", scoreEvaluations);
		return jsonObject;
	}
	
	/**
	 * cases에 질문이 들어가는 영역 json 데이터 리턴
	 */
	@SuppressWarnings("unchecked")
	private JSONObject getJsonForCasesData(List<List<String>> rowsData, String question) {
		return getJsonForCasesData(rowsData, question, true);
	}
	
	/**
	 * cases에 질문이 들어가는 영역 json 데이터 리턴
	 */
	@SuppressWarnings("unchecked")
	private JSONObject getJsonForCasesData(List<List<String>> rowsData, String question, boolean noCaseAdd) {
		JSONObject jsonObject = new JSONObject();
		JSONArray questions = new JSONArray();
		JSONObject questionJson = new JSONObject();
		questionJson.put("question", question);
		questionJson.put("type", "checkbox");
		
		//질문 리스트 case
		JSONArray cases = new JSONArray();
		JSONArray scoreEvaluations = new JSONArray();
		
		boolean isScoreArea = false;
		
		for (int rowIndex = 1; rowIndex < rowsData.size(); rowIndex++) {
			List<String> row = rowsData.get(rowIndex);
			
			String firstCellValue = row.get(0);
			if ("점수".equals(firstCellValue)) {
				isScoreArea = true;
				continue;
			}
			if (isScoreArea) {
				//평가 점수 데이터
				JSONObject scoreEvaluationJson = new JSONObject();
				Double score = Double.parseDouble(row.get(0));
				Double evaluation = Double.parseDouble(row.get(1));
				
				scoreEvaluationJson.put("score", score);
				scoreEvaluationJson.put("evaluation", evaluation);
				scoreEvaluations.add(scoreEvaluationJson);
			} else {
				//질문지 데이터
				String caseString = row.get(0);
				JSONObject caseJson = new JSONObject();
				caseJson.put("score", 1);
				caseJson.put("content", caseString);
				cases.add(caseJson);
			}
		}
		if (noCaseAdd) {
			JSONObject noCaseJson = new JSONObject();
			noCaseJson.put("score", 0);
			noCaseJson.put("content", "해당하는 증상이 없다.");
			cases.add(noCaseJson);
		}
		
		questionJson.put("cases", cases);
		questions.add(questionJson);
		jsonObject.put("questions", questions);
		jsonObject.put("scoreEvaluations", scoreEvaluations);	
		return jsonObject;
	}
	
	/**
	 * 재활 영역 json 데이터 리턴
	 */
	@SuppressWarnings("unchecked")
	private JSONObject getRehabilitateQuestionJson(List<List<String>> rowsData) {
		JSONObject jsonObject = new JSONObject();
		JSONArray questions = new JSONArray();
		JSONArray scoreEvaluations = new JSONArray();
		
		//운동장애 cases 정의
		JSONArray disabilityCases = new JSONArray();
		JSONObject disabilityCase1 = new JSONObject();
		disabilityCase1.put("content", "운동장애 없음");
		disabilityCase1.put("score", 1);
		disabilityCases.add(disabilityCase1);
		JSONObject disabilityCase2 = new JSONObject();
		disabilityCase2.put("content", "불완전 운동장애");
		disabilityCase2.put("score", 2);
		disabilityCases.add(disabilityCase2);
		JSONObject disabilityCase3 = new JSONObject();
		disabilityCase3.put("content", "완전 운동장애");
		disabilityCase3.put("score", 3);
		disabilityCases.add(disabilityCase3);
		
		//운동제한 case 정의
		JSONArray restrictionsCases = new JSONArray();
		JSONObject restrictionsCase1 = new JSONObject();
		restrictionsCase1.put("content", "제한 없음");
		restrictionsCase1.put("score", 1);
		restrictionsCases.add(restrictionsCase1);
		JSONObject restrictionsCase2 = new JSONObject();
		restrictionsCase2.put("content", "한쪽관절 제한");
		restrictionsCase2.put("score", 2);
		restrictionsCases.add(restrictionsCase2);
		JSONObject restrictionsCase3 = new JSONObject();
		restrictionsCase3.put("content", "양쪽관절 제한");
		restrictionsCase3.put("score", 3);
		restrictionsCases.add(restrictionsCase3);
		
		boolean isScoreArea = false;
		boolean isRestrictionsArea = false;
		
		int idIndex = 0;
		for (int rowIndex = 1; rowIndex < rowsData.size(); rowIndex++) {
			List<String> row = rowsData.get(rowIndex);
			
			String firstCellValue = row.get(0);
			if ("점수".equals(firstCellValue)) {
				isScoreArea = true;
				continue;
			}
			if (isScoreArea) {
				//평가 점수 데이터
				JSONObject scoreEvaluationJson = new JSONObject();
				Double score = Double.parseDouble(row.get(0));
				Double evaluation = Double.parseDouble(row.get(1));
				
				scoreEvaluationJson.put("score", score);
				scoreEvaluationJson.put("evaluation", evaluation);
				scoreEvaluations.add(scoreEvaluationJson);
			} else {
				//질문지 데이터
				JSONObject questionJson = new JSONObject();
				String type = row.get(0);
				String question = row.get(1);
				
				questionJson.put("id", idIndex);
				questionJson.put("question", question);
				if("title".equals(type.trim())) {
					//타이틀 정보
					questionJson.put("type", "title");
					questionJson.put("cases", new JSONArray());
					questions.add(questionJson);
					
					if ("운동제한 정도".equals(question.trim())) {
						isRestrictionsArea = true;
					}
				} else {
					//질문 정보
					questionJson.put("type", "radio");

					if (row.size() > 2) {
						questionJson.put("img", row.get(2));
					}
					
					if (isRestrictionsArea) {
						questionJson.put("cases", restrictionsCases);
					} else {
						questionJson.put("cases", disabilityCases);
					}
					
					questions.add(questionJson);
					//질문 정보만 id값 증가
					idIndex++;
				}
				
			}
		}
		jsonObject.put("questions", questions);
		jsonObject.put("scoreEvaluations", scoreEvaluations);
		return jsonObject;
	}
	
	/**
	 * jsonString 안에 질문지 수 구하기
	 */
	private int getQuestionCount (List<Map<String, String>> testList, String testNm) throws Exception {
		JSONParser parser = new JSONParser();
		int count = 0;
		
		Map<String, String> findPysicalTest = testList.stream().filter(f -> testNm.equals(f.get("test_nm"))).findFirst().orElse(null);
		if (findPysicalTest != null) {
			String jsonData = findPysicalTest.get("data");

			JSONObject jsonObject = (JSONObject) parser.parse(jsonData);
			JSONArray questions = (JSONArray) jsonObject.get("questions");
			for(int i = 0; i < questions.size(); i++) {
				JSONObject question = (JSONObject) questions.get(i);
				
				if ("radio".equals(question.get("type"))) {
					count++;
				}
			}
		}
		return count;
	}
	
	/**
	 * jsonString 안에 케이스 수 구하기
	 */
	private int getCaseCount (List<Map<String, String>> testList, String testNm, boolean isNoCaseExist) throws Exception {
		JSONParser parser = new JSONParser();
		
		Map<String, String> findCognitiveTest = testList.stream().filter(f -> testNm.equals(f.get("test_nm"))).findFirst().orElse(null);
		if (findCognitiveTest != null) {
			String jsonData = findCognitiveTest.get("data");

			JSONObject jsonObject = (JSONObject) parser.parse(jsonData);
			JSONArray questions = (JSONArray) jsonObject.get("questions");
			if (questions.size() > 0) {
				JSONObject question = (JSONObject) questions.get(0);
				JSONArray cases = (JSONArray) question.get("cases");
				
				//해당 증상 없음은 빼고 계산
				if (isNoCaseExist) {
					return cases.size() - 1;
				} else {
					return cases.size();
				}
			}
		}
		return 0;
	}
}
