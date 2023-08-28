package icube.main.test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.main.test.biz.MbrTestResultVO;
import icube.main.test.biz.MbrTestService;
import icube.main.test.biz.MbrTestVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 테스트 페이지
 */
@Controller
@RequestMapping(value="test")
public class MainTestController extends CommonAbstractController {

    @Autowired
    private MbrSession mbrSession;
    
    @Resource(name="mbrTestService")
    private MbrTestService mbrTestService;
	
    @Value("#{props['Globals.Main.path']}")
	private String mainPath;
    
	@RequestMapping(value = "{pageName}")
	public String page(
			@PathVariable String pageName
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {

		if(!mbrSession.isLoginCheck()) {
			session.setAttribute("returnUrl", "/test/index");
			return "redirect:" + "/"+mainPath+"/login?returnUrl=/test/index";
		}
		
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		
		return "/test/" + pageName;
	}
	
	/**
	 * 회원의 장기요양테스트 결과 정보 조회
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value="/result.json", produces="application/json;charset=UTF-8")
	public String getTestResult() {
		JSONObject resultJson = new JSONObject();
        if (!mbrSession.isLoginCheck()) {
            resultJson.put("success", false);
            return resultJson.toJSONString();
        }
        
        Map<String, String> paramMap = new HashMap<>();
    	paramMap.put("srchUniqueId", mbrSession.getUniqueId());
    	MbrTestVO srchMbrTestVO = mbrTestService.selectMbrTest(paramMap);
    	
    	if(srchMbrTestVO == null) {
    		resultJson.put("success", false);
            return resultJson.toJSONString();
    	}
    	
    	JSONObject dataJson = new JSONObject();
    	dataJson.put("mbrTestNo", srchMbrTestVO.getMbrTestNo());
    	dataJson.put("uniqueId", srchMbrTestVO.getUniqueId());
    	dataJson.put("grade", srchMbrTestVO.getGrade());
    	dataJson.put("score", srchMbrTestVO.getScore());
    	
    	dataJson.put("physicalSelect", convertSelectStrToJsonArray(srchMbrTestVO.getPhysicalSelect()));
    	dataJson.put("physicalScore", srchMbrTestVO.getPhysicalScore());
    	
    	dataJson.put("cognitiveSelect", convertSelectStrToJsonArray(srchMbrTestVO.getCognitiveSelect()));
    	dataJson.put("cognitiveScore", srchMbrTestVO.getCognitiveScore());
    	
    	dataJson.put("behaviorSelect", convertSelectStrToJsonArray(srchMbrTestVO.getBehaviorSelect()));
    	dataJson.put("behaviorScore", srchMbrTestVO.getBehaviorScore());
    	
    	dataJson.put("nurseSelect", convertSelectStrToJsonArray(srchMbrTestVO.getNurseSelect()));
    	dataJson.put("nurseScore", srchMbrTestVO.getNurseScore());
    	
    	dataJson.put("rehabilitateSelect", convertSelectStrToJsonArray(srchMbrTestVO.getRehabilitateSelect()));
    	dataJson.put("rehabilitateScore", srchMbrTestVO.getRehabilitateScore());
    	
    	dataJson.put("diseaseSelect1", convertSelectStrToJsonArray(srchMbrTestVO.getDiseaseSelect1()));
    	dataJson.put("diseaseScore1", srchMbrTestVO.getDiseaseScore1());
    	
    	dataJson.put("diseaseSelect2", convertSelectStrToJsonArray(srchMbrTestVO.getDiseaseSelect2()));
    	dataJson.put("diseaseScore2", srchMbrTestVO.getDiseaseScore2());
    	
    	dataJson.put("diagramBehaviorScore", srchMbrTestVO.getDiagramBehaviorScore());
    	dataJson.put("diagramCleanScore", srchMbrTestVO.getDiagramCleanScore());
    	dataJson.put("diagramExcretionScore", srchMbrTestVO.getDiagramExcretionScore());
    	dataJson.put("diagramFunctionalScore", srchMbrTestVO.getDiagramFunctionalScore());
    	dataJson.put("diagramIndirectScore", srchMbrTestVO.getDiagramIndirectScore());
    	dataJson.put("diagramMealScore", srchMbrTestVO.getDiagramMealScore());
    	dataJson.put("diagramNurseScore", srchMbrTestVO.getDiagramNurseScore());
    	dataJson.put("diagramRehabilitateScore", srchMbrTestVO.getDiagramRehabilitateScore());
    	
    	resultJson.put("success", true);
    	resultJson.put("mbrTestResult", dataJson.toJSONString());
    	return resultJson.toJSONString();
	}
	
    /**
     * 회원의 장기오양테스트 결과 정보 저장
     * @param mbrTestVO : 시험 결과 VO
     */
    @SuppressWarnings("unchecked")
    @ResponseBody
    @RequestMapping(value="/result/save.json", produces="application/json;charset=UTF-8")
    public String saveTest(
    		@RequestBody MbrTestResultVO mbrTestResultVO
    	) {
        JSONObject resultJson = new JSONObject();
        if (!mbrSession.isLoginCheck()) {
            resultJson.put("success", false);
            return resultJson.toJSONString();
        }
        
        MbrTestVO mbrTestVO = mbrTestResultVO.getMbrTestVO();
        String testNm = mbrTestResultVO.getTestNm();
        mbrTestVO.setUniqueId(mbrSession.getUniqueId());
        
        try {
        	Map<String, String> paramMap = new HashMap<>();
        	paramMap.put("srchUniqueId", mbrSession.getUniqueId());
        	MbrTestVO srchMbrTestVO = mbrTestService.selectMbrTest(paramMap);
        	
        	//생성
        	if (srchMbrTestVO == null) {
        		mbrTestService.insertMbrTest(mbrTestVO);
        	}
        	//업데이트
        	else {
        		switch(testNm) {
        			case "physical": {
        				srchMbrTestVO.setPhysicalSelect(mbrTestVO.getPhysicalSelect());
        				srchMbrTestVO.setPhysicalScore(mbrTestVO.getPhysicalScore());
        				break;
        			}
        			case "cognitive": {
        				srchMbrTestVO.setCognitiveSelect(mbrTestVO.getCognitiveSelect());
        				srchMbrTestVO.setCognitiveScore(mbrTestVO.getCognitiveScore());
        				break;
        			}
        			case "behavior": {
        				srchMbrTestVO.setBehaviorSelect(mbrTestVO.getBehaviorSelect());
        				srchMbrTestVO.setBehaviorScore(mbrTestVO.getBehaviorScore());
        				break;
        			}
        			case "nurse": {
        				srchMbrTestVO.setNurseSelect(mbrTestVO.getNurseSelect());
        				srchMbrTestVO.setNurseScore(mbrTestVO.getNurseScore());
        				break;
        			}
        			case "rehabilitate": {
        				srchMbrTestVO.setRehabilitateSelect(mbrTestVO.getRehabilitateSelect());
        				srchMbrTestVO.setRehabilitateScore(mbrTestVO.getRehabilitateScore());
        				break;
        			}
        			case "disease": {
        				srchMbrTestVO.setGrade(mbrTestVO.getGrade());
        				srchMbrTestVO.setScore(mbrTestVO.getScore());
        				
        				srchMbrTestVO.setDiseaseSelect1(mbrTestVO.getDiseaseSelect1());
        				srchMbrTestVO.setDiseaseScore1(mbrTestVO.getDiseaseScore1());
        				srchMbrTestVO.setDiseaseSelect2(mbrTestVO.getDiseaseSelect2());
        				srchMbrTestVO.setDiseaseScore2(mbrTestVO.getDiseaseScore2());
        				
        				srchMbrTestVO.setDiagramBehaviorScore(mbrTestVO.getDiagramBehaviorScore());
        				srchMbrTestVO.setDiagramCleanScore(mbrTestVO.getDiagramCleanScore());
        				srchMbrTestVO.setDiagramExcretionScore(mbrTestVO.getDiagramExcretionScore());
        				srchMbrTestVO.setDiagramFunctionalScore(mbrTestVO.getDiagramFunctionalScore());
        				srchMbrTestVO.setDiagramIndirectScore(mbrTestVO.getDiagramIndirectScore());
        				srchMbrTestVO.setDiagramMealScore(mbrTestVO.getDiagramMealScore());
        				srchMbrTestVO.setDiagramNurseScore(mbrTestVO.getDiagramNurseScore());
        				srchMbrTestVO.setDiagramRehabilitateScore(mbrTestVO.getDiagramRehabilitateScore());
        				break;
        			}
        			default : break;
        		}
        		
        		mbrTestService.updateMbrTest(srchMbrTestVO);
        	}
            
            resultJson.put("success", true);
        } catch (Exception ex) {
            resultJson.put("success", false);
        }
        
        return resultJson.toJSONString();
    }
    
    @SuppressWarnings("unchecked")
	private JSONArray convertSelectStrToJsonArray(String selectStr) {
    	if (EgovStringUtil.isEmpty(selectStr)) {
    		return null;
    	}
    	List<Integer> list = new ArrayList<Integer>();
    	JSONArray jArray = new JSONArray();
    	String[] strArray = selectStr.split(",");
    	if (strArray.length == 0) {
    		jArray.addAll(list);
    		return jArray;
    	}
    	
    	for (int i = 0; i < strArray.length; i++) {
    		list.add(Integer.parseInt(strArray[i]));
    	}
    	jArray.addAll(list);
    	return jArray;
    }
}
