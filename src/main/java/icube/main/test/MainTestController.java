package icube.main.test;

import java.util.ArrayList;
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
import icube.common.mail.MailService;
import icube.common.util.FileUtil;
import icube.main.test.biz.MbrTestResultVO;
import icube.main.test.biz.MbrTestService;
import icube.main.test.biz.MbrTestVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.sysmng.mngr.biz.MngrSession;
import icube.market.mbr.biz.MbrSession;

/**
 * 테스트 페이지
 */
@Controller
@RequestMapping(value="test")
public class MainTestController extends CommonAbstractController {

    @Autowired
    private MbrSession mbrSession;
    
    @Autowired
    private MngrSession mngrSession;
    
    @Resource(name="mbrTestService")
    private MbrTestService mbrTestService;
    
    @Resource(name = "mbrService")
	private MbrService mbrService;
	
    @Value("#{props['Mail.Form.FilePath']}")
	private String mailFormFilePath;

    @Value("#{props['Globals.Membership.path']}")
	private String membershipPath;
    
    @Resource(name = "mailService")
	private MailService mailService;
    
    @Value("#{props['Mail.Username']}")
	private String sendMail;
    
    @Value("#{props['Globals.EroumCare.PrivateKey']}")
	private String eroumCarePrivateKey;
    
	@RequestMapping(value = "{pageName}")
	public String page(
			@PathVariable String pageName
			, @RequestParam(required = false) Integer recipientsNo
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {

		//로그인을 안해도 테스트 가능하다.
//		if(!mbrSession.isLoginCheck()) {
//			String returnUrl = "/test/physical";
//			session.setAttribute("returnUrl", returnUrl);
//			return "redirect:" + "/"+ membershipPath + "/login?returnUrl=" + returnUrl;
//		}
		
		//테스트 시작 화면에서 로그인되어 있을 시 수급자 정보 매핑
		if ("physical".equals(pageName) && mbrSession.isLoginCheck()) {
			model.addAttribute("recipientsNo", recipientsNo);
		} else if ("physical".equals(pageName)) {
			model.addAttribute("recipientsNo", 0);
		}
		
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		
		
		//채널톡 연동 데이터 셋팅
		mbrService.setChannelTalk(request);
		
		return "/test/" + pageName;
	}
	
	/**
	 * 회원의 장기요양테스트 결과 정보 조회
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value="/result.json", produces="application/json;charset=UTF-8")
	public String getTestResult(@RequestParam Integer recipientsNo) {
		JSONObject resultJson = new JSONObject();
        if (!mbrSession.isLoginCheck()) {
            resultJson.put("success", false);
            return resultJson.toJSONString();
        }
        
        Map<String, Object> paramMap = new HashMap<>();
    	paramMap.put("srchUniqueId", mbrSession.getUniqueId());
    	paramMap.put("srchRecipientsNo", recipientsNo);
    	MbrTestVO srchMbrTestVO = mbrTestService.selectMbrTest(paramMap);
    	
    	if(srchMbrTestVO == null) {
    		resultJson.put("success", false);
            return resultJson.toJSONString();
    	}
    	
    	JSONObject dataJson = new JSONObject();
    	dataJson.put("mbrTestNo", srchMbrTestVO.getMbrTestNo());
    	dataJson.put("uniqueId", srchMbrTestVO.getUniqueId());
    	dataJson.put("recipientsNo", srchMbrTestVO.getRecipientsNo());
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
        	Map<String, Object> paramMap = new HashMap<>();
        	paramMap.put("srchUniqueId", mbrSession.getUniqueId());
        	paramMap.put("srchRecipientsNo", mbrTestVO.getRecipientsNo());
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
    
    /**
     * 회원의 장기요양테스트 결과를 이메일로 발송
     */
    @SuppressWarnings("unchecked")
    @ResponseBody
    @RequestMapping(value="/send/email.json", produces="application/json;charset=UTF-8")
    public String sendTestResult(
    		@RequestParam String email,
    		@RequestParam Integer recipientsNo,
    		HttpServletRequest request) {
        JSONObject resultJson = new JSONObject();
        if (!mbrSession.isLoginCheck()) {
            resultJson.put("success", false);
            return resultJson.toJSONString();
        }
            
        try {
        	String mailForm = getTestResultMailForm(request, recipientsNo);
			
			String mailSj = "[이로움ON] 장기요양 인정등급 예상 테스트 결과";
			String putEml = email;

			//장기요양테스트 결과 이메일 발송
			mailService.sendMail(sendMail, putEml, mailSj, mailForm);
        	
        	resultJson.put("success", true);
        } catch (Exception ex) {
            resultJson.put("success", false);
        }
        
        return resultJson.toJSONString();
    }
    
    
    /**
     * 이로움케어, 이로움관리자에서 요양테스트 결과 폼을 보기 위한 API (email 폼 사용)
     */
    @ResponseBody
    @RequestMapping(value="/result.html", produces="text/html;charset=UTF-8")
    public String getTestResultForm(
    		@RequestParam Integer recipientsNo,
    		HttpServletRequest request) {
        
    	//이로움케어에서 사용하기도 하고 이로움온 관리자에서도 사용함
    	String eroumApikey = request.getHeader("eroumAPI_Key");
    	if (eroumCarePrivateKey.equals(eroumApikey)) {
    	} else if (mngrSession.isLoginCheck()) {
    	} else if (mbrSession.isLoginCheck()) {
    	} else {
    		return getTestResultErrorForm(request);
    	}
    
        try {
         	String mailForm = getTestResultMailForm(request, recipientsNo);
         	//모달 폼에서는 이로움On 바로가기, Footer 숨기기
         	mailForm = mailForm.replace("id=\"goEroum\" style=\"padding: 15px 50px;", "id=\"goEroum\" style=\"display:none; padding: 15px 50px;");
         	mailForm = mailForm.replace("id=\"footerTable\" style=\"font-family", "id=\"footerTable\" style=\"display:none; font-family");
         	
        	return mailForm;
        } catch (Exception ex) {
            log.error("======= 테스트 결과 오류", ex);
            
            if ("테스트 항목이 모두 완료되지 않음".equals(ex.getMessage())) {
            	return getTestResultErrorForm(request);
            }
        }
        return getTestResultErrorForm(request);
    }
    
    
    private String getTestResultMailForm(HttpServletRequest request, Integer recipientsNo) throws Exception {
    	Map<String, Object> paramMap = new HashMap<>();
    	if (EgovStringUtil.isNotEmpty(mbrSession.getUniqueId())) {
    		paramMap.put("srchUniqueId", mbrSession.getUniqueId());
    	}
    	paramMap.put("srchRecipientsNo", recipientsNo);
    	MbrTestVO srchMbrTestVO = mbrTestService.selectMbrTest(paramMap);
    	
    	//테스트 결과가 모두 작성되었는지 체크
    	if (srchMbrTestVO == null 
    		|| srchMbrTestVO.getGrade() == null
    		|| srchMbrTestVO.getScore() == null
    		|| EgovStringUtil.isEmpty(srchMbrTestVO.getPhysicalSelect())
    		|| EgovStringUtil.isEmpty(srchMbrTestVO.getCognitiveSelect())
    		|| EgovStringUtil.isEmpty(srchMbrTestVO.getBehaviorSelect())
    		|| EgovStringUtil.isEmpty(srchMbrTestVO.getNurseSelect())
    		|| EgovStringUtil.isEmpty(srchMbrTestVO.getRehabilitateSelect())
    		|| EgovStringUtil.isEmpty(srchMbrTestVO.getDiseaseSelect1())
    		|| EgovStringUtil.isEmpty(srchMbrTestVO.getDiseaseSelect2())) {
    		throw new Exception("테스트 항목이 모두 완료되지 않음");
    	}
    	
    	
    	//이메일 폼 로딩
		String MAIL_FORM_PATH = mailFormFilePath;
		String mailForm = FileUtil.readFile(MAIL_FORM_PATH + "mail_test_result.html");
		
		//등급, 점수, 설명 부분 수정
		boolean isDementia = srchMbrTestVO.getDiseaseSelect1().startsWith("1") || srchMbrTestVO.getDiseaseSelect2().startsWith("1");
		String gradeAndScoreTemplete = getGradeAndScoreTemplete(srchMbrTestVO.getGrade(), srchMbrTestVO.getScore(), isDementia);
		mailForm = mailForm.replace("((gradeAndScoreTemplete))", gradeAndScoreTemplete);
		
		//신체기능 부분 수정
		String physicalSelectTemplete  = getPhysicalSelectTemplete(srchMbrTestVO.getPhysicalSelect());
		mailForm = mailForm.replace("((physicalSelectTemplete))", physicalSelectTemplete);
		
		//인지능력 부분 수정
		String[] cognitiveQuestions = new String[] {
			"방금 전에 들었던 이야기나 일을 잊는다.",
  			"오늘이 몇 년, 몇 월, 몇 일인지 모른다.",
  			"자신이 있는 장소를 알지 못한다.",
  			"자신의 나이와 생일을 모른다.",
  			"지시를 이해하지 못한다.",
  			"주어진 상황에 대한 판단력이 떨어져 있다.",
  			"의사소통이나 전달에 장애가 있다."
		};
		String cognitiveTemplete = getCheckSelectTemplete(srchMbrTestVO.getCognitiveSelect(), cognitiveQuestions);
		mailForm = mailForm.replace("((cognitiveTemplete))", cognitiveTemplete);
		
		//행동변화 부분 수정
		String[] behaviorQuestions = new String[] {
			"사람들이 무엇을 훔쳤다고 믿거나, 자기를 해하려 한다고 잘못 믿고 있다.",
			"헛것을 보거나 환청을 듣는다.",
			"슬퍼 보이거나 기분이 처져 있으며 때로 울기도 한다.",
			"밤에 자다가 일어나 주위 사람을 깨우거나 아침에 너무 일찍 일어난다. 또는 낮에는 지나치게 잠을 자고 밤에는 잠을 이루지 못한다.",
			"주위사람이 도와주려 할 때 도와주는 것에 저항한다.",
			"한군데 가만히 있지 못하고 서성거리거나 왔다 갔다 하며 안절부절 못한다.",
			"길을 잃거나 헤맨 적이 있다. 외출하면 집이나 병원, 시설로 혼자 들어올 수 없다.",
			"화를 내며 폭언이나 폭행을 하는 등 위협적인 행동을 보인다.",
			"혼자서 밖으로 나가려고 해서 눈을 뗄 수가 없다.",
			"물건을 망가뜨리거나 부순다.",
			"의미 없거나 부적절한 행동을 자주 보인다.",
			"돈이나 물건을 장롱같이 찾기 어려운 곳에 감춘다.",
			"옷을 부적절하게 입는다.",
			"대소변을 벽이나 옷에 바르는 등의 행위를 한다."
		};
		String behaviorTemplete = getCheckSelectTemplete(srchMbrTestVO.getBehaviorSelect(), behaviorQuestions);
		mailForm = mailForm.replace("((behaviorTemplete))", behaviorTemplete);
		
		//간호처치 부분 수정
		String nurseTemplete = getNurseSelectTemplete(srchMbrTestVO.getNurseSelect());
		mailForm = mailForm.replace("((nurseTemplete))", nurseTemplete);
		
		//재활 부분 수정
		String rehabilitateTemplete  = getRehabilitateSelectTemplete(srchMbrTestVO.getRehabilitateSelect());
		mailForm = mailForm.replace("((rehabilitateTemplete))", rehabilitateTemplete);
		
		//질병 부분 수정
		String disease1Templete = getDiseaseSelectTemplete(srchMbrTestVO.getDiseaseSelect1());
		mailForm = mailForm.replace("((disease1Templete))", disease1Templete);
		String disease2Templete = getDiseaseSelectTemplete(srchMbrTestVO.getDiseaseSelect2());
		mailForm = mailForm.replace("((disease2Templete))", disease2Templete);
		
		//도메인 입력
		String host = request.getRequestURL().toString().replace(request.getRequestURI(), "");
		mailForm = mailForm.replace("((domain))", host);
		
		return mailForm;
    }
    
    private String getTestResultErrorForm(HttpServletRequest request) {
    	String MAIL_FORM_PATH = mailFormFilePath;
		String mailForm = FileUtil.readFile(MAIL_FORM_PATH + "mail_test_result_error.html");
		
		//도메인 입력
		String host = request.getRequestURL().toString().replace(request.getRequestURI(), "");
		mailForm = mailForm.replace("((domain))", host);
		
		return mailForm;
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
    
    private String getGradeAndScoreTemplete(Integer grade, Float score, boolean isDementia) {
    	String gradeAndScoreTemplete = "                       <td\r\n"
				+ "                                                style=\"text-align: center; padding: 10px; border: 1px solid #e7e7e7; color: #fff; font-weight: bold; font-size: 20px; background-color: #EF7F1A;\">\r\n"
				+ "                                          " + grade.toString() + "등급\r\n"
				+ "                                            </td>\r\n"
				+ "                                            <td\r\n"
				+ "                                                style=\"text-align: center; padding: 10px; border: 1px solid #e7e7e7; color: #fff; font-weight: bold; font-size: 20px; background-color: #424242;\">\r\n"
				+ "                                          " + score.toString() + "점\r\n"
				+ "                                            </td>\r\n";
    	
		switch(grade) {
			case 1 : {
				gradeAndScoreTemplete += "                             <td\r\n"
						+ "                                                style=\"text-align: left; padding: 10px; border: 1px solid #e7e7e7; color: #333;\">\r\n"
						+ "                                                <ul>\r\n"
						+ "                                                    <li>\r\n"
						+ "                                                        <span style=\"padding: 0px 2px; border-radius: 5px; background: #FFF5ED; font-size: 20px; font-weight: bold; color: #EF7D1A;\">\r\n"
						+ "                                                            연 160만원\r\n"
						+ "                                                        </span> 내에서 거동, 생활 보조 용품(복지용구)을 신청할 수 있어요.\r\n"
						+ "                                                    </li>\r\n"
						+ "                                                    <li>\r\n"
						+ "                                                        <span style=\"padding: 0px 2px; border-radius: 5px; background: #FFF5ED; font-size: 20px; font-weight: bold; color: #EF7D1A;\">\r\n"
						+ "                                                            월 188만원\r\n"
						+ "                                                        </span> 내에서 방문 요양보호사 또는 주야간센터를 이용할 수 있어요.\r\n"
						+ "                                                    </li>\r\n"
						+ "                                                    <br>\r\n"
						+ "                                                    <li>6~15%의 본인부담금이 발생해요.</li>\r\n"
						+ "                                                    <li>1~2등급 어르신은 요양보호사 방문 대신 시설 입소를 선택할 수 있어요.</li>\r\n"
						+ "                                                    <li>시설에 모시는 어르신은 복지용구를 신청할 수 없어요.</li>\r\n"
						+ "                                                </ul>\r\n"
						+ "                                            </td>";
				break;
			}
			case 2 : {
				gradeAndScoreTemplete += "                             <td\r\n"
						+ "                                                style=\"text-align: left; padding: 10px; border: 1px solid #e7e7e7; color: #333;\">\r\n"
						+ "                                                <ul>\r\n"
						+ "                                                    <li>\r\n"
						+ "                                                        <span style=\"padding: 0px 2px; border-radius: 5px; background: #FFF5ED; font-size: 20px; font-weight: bold; color: #EF7D1A;\">\r\n"
						+ "                                                            연 160만원\r\n"
						+ "                                                        </span> 내에서 거동, 생활 보조 용품(복지용구)을 신청할 수 있어요.\r\n"
						+ "                                                    </li>\r\n"
						+ "                                                    <li>\r\n"
						+ "                                                        <span style=\"padding: 0px 2px; border-radius: 5px; background: #FFF5ED; font-size: 20px; font-weight: bold; color: #EF7D1A;\">\r\n"
						+ "                                                            월 169만원\r\n"
						+ "                                                        </span> 내에서 방문 요양보호사 또는 주야간센터를 이용할 수 있어요.\r\n"
						+ "                                                    </li>\r\n"
						+ "                                                    <br>\r\n"
						+ "                                                    <li>6~15%의 본인부담금이 발생해요.</li>\r\n"
						+ "                                                    <li>1~2등급 어르신은 요양보호사 방문 대신 시설 입소를 선택할 수 있어요.</li>\r\n"
						+ "                                                    <li>시설에 모시는 어르신은 복지용구를 신청할 수 없어요.</li>\r\n"
						+ "                                                </ul>\r\n"
						+ "                                            </td>";
				break;
			}
			case 3 : {
				gradeAndScoreTemplete += "                             <td\r\n"
						+ "                                                style=\"text-align: left; padding: 10px; border: 1px solid #e7e7e7; color: #333;\">\r\n"
						+ "                                                <ul>\r\n"
						+ "                                                    <li>\r\n"
						+ "                                                        <span style=\"padding: 0px 2px; border-radius: 5px; background: #FFF5ED; font-size: 20px; font-weight: bold; color: #EF7D1A;\">\r\n"
						+ "                                                            연 160만원\r\n"
						+ "                                                        </span> 내에서 거동, 생활 보조 용품(복지용구)을 신청할 수 있어요.\r\n"
						+ "                                                    </li>\r\n"
						+ "                                                    <li>\r\n"
						+ "                                                        <span style=\"padding: 0px 2px; border-radius: 5px; background: #FFF5ED; font-size: 20px; font-weight: bold; color: #EF7D1A;\">\r\n"
						+ "                                                            월 141만원\r\n"
						+ "                                                        </span> 내에서 방문 요양보호사 또는 주야간센터를 이용할 수 있어요.\r\n"
						+ "                                                    </li>\r\n"
						+ "                                                    <br>\r\n"
						+ "                                                    <li>6~15%의 본인부담금이 발생해요.</li>\r\n"
						+ "                                                    <li>조건에 부합하는 어르신은 요양보호사 방문 대신 시설 입소를 선택할 수 있어요.</li>\r\n"
						+ "                                                    <li>시설에 모시는 어르신은 복지용구를 신청할 수 없어요.</li>\r\n"
						+ "                                                </ul>\r\n"
						+ "                                            </td>";
				break;
			}
			case 4 : {
				gradeAndScoreTemplete += "                             <td\r\n"
						+ "                                                style=\"text-align: left; padding: 10px; border: 1px solid #e7e7e7; color: #333;\">\r\n"
						+ "                                                <ul>\r\n"
						+ "                                                    <li>\r\n"
						+ "                                                        <span style=\"padding: 0px 2px; border-radius: 5px; background: #FFF5ED; font-size: 20px; font-weight: bold; color: #EF7D1A;\">\r\n"
						+ "                                                            연 160만원\r\n"
						+ "                                                        </span> 내에서 거동, 생활 보조 용품(복지용구)을 신청할 수 있어요.\r\n"
						+ "                                                    </li>\r\n"
						+ "                                                    <li>\r\n"
						+ "                                                        <span style=\"padding: 0px 2px; border-radius: 5px; background: #FFF5ED; font-size: 20px; font-weight: bold; color: #EF7D1A;\">\r\n"
						+ "                                                            월 130만원\r\n"
						+ "                                                        </span> 내에서 방문 요양보호사 또는 주야간센터를 이용할 수 있어요.\r\n"
						+ "                                                    </li>\r\n"
						+ "                                                    <br>\r\n"
						+ "                                                    <li>6~15%의 본인부담금이 발생해요.</li>\r\n"
						+ "                                                    <li>조건에 부합하는 어르신은 요양보호사 방문 대신 시설 입소를 선택할 수 있어요.</li>\r\n"
						+ "                                                    <li>시설에 모시는 어르신은 복지용구를 신청할 수 없어요.</li>\r\n"
						+ "                                                </ul>\r\n"
						+ "                                            </td>";
				break;
			}
			case 5 : {
				gradeAndScoreTemplete += "                             <td\r\n"
						+ "                                                style=\"text-align: left; padding: 10px; border: 1px solid #e7e7e7; color: #333;\">\r\n"
						+ "                                                <ul>\r\n"
						+ "                                                    <li>\r\n"
						+ "                                                        <span style=\"padding: 0px 2px; border-radius: 5px; background: #FFF5ED; font-size: 20px; font-weight: bold; color: #EF7D1A;\">\r\n"
						+ "                                                            연 160만원\r\n"
						+ "                                                        </span> 내에서 거동, 생활 보조 용품(복지용구)을 신청할 수 있어요.\r\n"
						+ "                                                    </li>\r\n"
						+ "                                                    <li>\r\n"
						+ "                                                        <span style=\"padding: 0px 2px; border-radius: 5px; background: #FFF5ED; font-size: 20px; font-weight: bold; color: #EF7D1A;\">\r\n"
						+ "                                                            월 112만원\r\n"
						+ "                                                        </span> 내에서 방문 요양보호사 또는 주야간센터를 이용할 수 있어요.\r\n"
						+ "                                                    </li>\r\n"
						+ "                                                    <br>\r\n"
						+ "                                                    <li>6~15%의 본인부담금이 발생해요.</li>\r\n"
						+ "                                                    <li>조건에 부합하는 어르신은 요양보호사 방문 대신 시설 입소를 선택할 수 있어요.</li>\r\n"
						+ "                                                    <li>시설에 모시는 어르신은 복지용구를 신청할 수 없어요.</li>\r\n"
						+ "                                                </ul>\r\n"
						+ "                                            </td>";
				break;
			}
			default : {
				//치매를 선택한 경우
				if (isDementia) {
					gradeAndScoreTemplete += "                             <td\r\n"
							+ "                                                style=\"text-align: left; padding: 10px; border: 1px solid #e7e7e7; color: #333;\">\r\n"
							+ "                                                <ul>\r\n"
							+ "                                                    <li>\r\n"
							+ "                                                        <span style=\"padding: 0px 2px; border-radius: 5px; background: #FFF5ED; font-size: 20px; font-weight: bold; color: #EF7D1A;\">\r\n"
							+ "                                                            연 160만원\r\n"
							+ "                                                        </span> 내에서 거동, 생활 보조 용품(복지용구)을 신청할 수 있어요.\r\n"
							+ "                                                    </li>\r\n"
							+ "                                                    <li>\r\n"
							+ "                                                        <span style=\"padding: 0px 2px; border-radius: 5px; background: #FFF5ED; font-size: 20px; font-weight: bold; color: #EF7D1A;\">\r\n"
							+ "                                                            월 62만원\r\n"
							+ "                                                        </span> 내에서 방문 요양보호사 또는 주야간센터를 이용할 수 있어요.\r\n"
							+ "                                                    </li>\r\n"
							+ "                                                    <br>\r\n"
							+ "                                                    <li>6~15%의 본인부담금이 발생해요.</li>\r\n"
							+ "                                                </ul>\r\n"
							+ "                                            </td>";
				} else {
					gradeAndScoreTemplete += "                             <td\r\n"
							+ "                                                style=\"text-align: left; padding: 10px; border: 1px solid #e7e7e7; color: #333;\">\r\n"
							+ "                                                <ul>\r\n"
							+ "                                                    <li>\r\n"
							+ "                                                        장기요양보험 혜택 불가\r\n"
							+ "                                                    </li>\r\n"
							+ "                                                    <br>\r\n"
							+ "                                                    <li>등급판정은 건강이 매우 안좋다, 큰 병에 걸렸다. 등과 같은 주관적인 개념이 아니에요</li>\r\n"
							+ "                                                    <li>심신의 기능에 따라 일상생활에서 도움이 얼마나 필요한가?를 기준으로 판단해요.</li>\r\n"
							+ "                                                </ul>\r\n"
							+ "                                            </td>";
				}
				break;
			}
		}
		return gradeAndScoreTemplete;
    }
    
    /**
     * 신체기능에 대한 템플릿
     */
    private String getPhysicalSelectTemplete(String selectStr) {
    	String[] physicalQuestions = new String[] {
				"옷 벗고 입기",
				"세수하기",
				"양치질하기",
				"목욕하기",
				"식사하기",
				"체위 변경하기",
				"일어나 앉기",
				"옮겨앉기",
				"방 밖으로 나오기",
				"화장실 사용하기",
				"대변 조절하기",
				"소변 조절하기"
			};
		String[] physicalAnswers = new String[] {"혼자서 가능", "일부 도움 필요", "완전히 도움 필요"}; 
    	
		
		String templete = "";
		String[] split = selectStr.split(",");
		for (int i = 0; i < split.length; i++) {
			Integer index = Integer.valueOf(split[i]) - 1;
			
			templete += "      <tr>\r\n"
					+ "            <td\r\n"
					+ "                style=\"text-align: left;  padding: 10px; border-right: 1px solid #fff;  border-bottom: 1px solid #e7e7e7; color: #333; \">\r\n"
					+ "                " + physicalQuestions[i] + "</td>\r\n"
					+ "            <td\r\n"
					+ "                style=\"text-align: left; padding: 10px; border: 1px solid #e7e7e7; color: #333; text-align: right;\">\r\n"
					+ "                <span\r\n"
					+ "                    style=\"background-color: #EAF6F9; padding: 5px 20px; border-radius: 30px;\">\r\n"
					+ "                    "+ physicalAnswers[index] +"<span>\r\n"
					+ "            </td>\r\n"
					+ "        </tr>";
		}
    	return templete;
    }
    
    /**
     * check답변에 대한 템플릿(인지기능, 행동변화)
     */
    private String getCheckSelectTemplete(String selectStr, String[] questions) {
    	String[] split = selectStr.split(",");
    	List<Integer> selectedIndexList = new ArrayList<>();
    	for (int i = 0; i < split.length; i++) {
    		if ("1".equals(split[i])) {
    			selectedIndexList.add(i);
    		}
    	}
    	
    	String templete = "";
    	boolean isSelect = false;
    	for (int i = 0; i < selectedIndexList.size(); i++) {
    		isSelect = true;
    		Integer index = selectedIndexList.get(i);
    		
    		templete += "                                      <tr>\r\n";
    		templete += "                                            <td\r\n"
        			+ "                                                style=\"text-align: left; padding: 10px; border: 1px solid #e7e7e7; color: #333; background-color: #FFFBF6;\">\r\n"
        			+ "                                                " + questions[index] + "</td>\r\n";
    		templete += "                                      </tr>";
    	}
    	
    	if (isSelect == false) {
			templete += "                                      <tr>\r\n"
					+ "                                            <td\r\n"
					+ "                                                style=\"text-align: left; padding: 10px; border: 1px solid #e7e7e7; color: #333; background-color: #FFFBF6;\">\r\n"
	            	+ "                                                해당하는 증상이 없다.</td>\r\n"
					+ "                                        </tr>";
		}
    	return templete;
    }
    
    /**
     * 간호처치에 대한 템플릿
     */
    private String getNurseSelectTemplete(String selectStr) {
    	String[] title = new String[] {
    		"기관지 절개관",
    		"흡인",
    		"산소요법",
    		"욕창간호",
    		"경관 영양",
    		"암성통증",
    		"도뇨관리",
    		"장루",
    		"투석"
    	};
    	String[] description = new String[] {
    		"기관지를 절개하여 인공기도를 확보하는 간호",
    		"카테터 등으로 인위적으로 분비물을 제거하여 기도유지",
    		"저산소증이나 저산소혈증을 치료, 감소 시키기 위해 산소공급장치를 통해 추가적인 산소 공급",
    		"장기적인 고정체위로 인해 압박 부위의 피부와 하부조직 손상되어 지속적인 드레싱과 체위변경 처치",
    		"구강으로 음식섭취가 어려워 관을 통해서 위, 십이지장 등에 직접 영양을 공급해야 하는 경우",
    		"암의 진행을 억제하지 못하여 극심한 통증에 발생",
    		"배뇨가 자율적으로 관리가 불가능하여 인위적으로 방광을 비우거나 관리",
    		"인공항문을 통해 체외로 대변을 배설 시킴으로 부착장치의 지속적인 관리",
    		"장기적인 신부전증으로 인해 혈액 투석이 필요한 경우"
    	};
    	
    	String templete = "";
		String[] split = selectStr.split(",");
		boolean isSelect = false;
		for (int i = 0; i < split.length; i++) {
			if ("1".equals(split[i])) {
				isSelect = true;
				templete += "                                      <tr>\r\n"
						+ "                                            <th\r\n"
						+ "                                                style=\"text-align: left;  padding: 10px; border-right: 1px solid #fff;  border-bottom: 1px solid #e7e7e7; color: color: #333;\">\r\n"
						+ "                                                " + title[i] + " </th>\r\n"
						+ "                                            <td\r\n"
						+ "                                                style=\"text-align: left; padding: 10px; border: 1px solid #e7e7e7; color: #333;\">\r\n"
						+ "                                                <span\r\n"
						+ "                                                    style=\"background-color: #FBF5F4; padding: 5px 20px; border-radius: 30px;\">\r\n"
						+ "                                                    " + description[i] + "</span>\r\n"
						+ "                                            </td>\r\n"
						+ "                                        </tr>";
			}
		}
		
		if (isSelect == false) {
			templete += "                                      <tr>\r\n"
					+ "                                            <td style=\"text-align: left; padding: 10px; border: 1px solid #e7e7e7; color: #333;\"\r\n"
					+ "                                                colspan=\"2\"><span\r\n"
					+ "                                                    style=\"background-color: #FBF5F4; padding: 5px 20px; border-radius: 30px;\">해당하는\r\n"
					+ "                                                    증상이 없다.</span></td>\r\n"
					+ "                                        </tr>";
		}
    	return templete;
    }
    
    /**
     * 재활에 대한 템플릿
     */
    private String getRehabilitateSelectTemplete(String selectStr) {
    	String[] rehabilitateQuestions = new String[] {
			"오른쪽 상지(손, 팔, 어깨)가 의지대로 움직이시나요?",
			"오른쪽 하지(발, 다리)가 의지대로 움직이시나요?",
			"왼쪽 상지(손, 팔, 어깨)가 의지대로 움직이시나요?",
			"왼쪽 하지(발, 다리)가 의지대로 움직이시나요?",
			"어깨관절이 자유롭게 움직이시나요?",
			"팔꿈치관절이 자유롭게 움직이시나요?",
			"손목 및 손관절이 자유롭게 움직이시나요?",
			"고관절(엉덩이관절)이 자유롭게 움직이시나요?",
			"무릎관절이 자유롭게 움직이시나요?",
			"발목관절이 자유롭게 움직이시나요?"
		};
		String[] rehabilitateAnswers = new String[] {"운동장애 없음", "불완전 운동장애", "완전 운동장애"};
		String[] rehabilitateAnswers2 = new String[] {"제한 없음", "한쪽관절 제한", "양쪽관절 제한"};
		
		String templete = "";
		String[] split = selectStr.split(",");
		for (int i = 0; i < split.length; i++) {
			Integer index = Integer.valueOf(split[i]) - 1;
			
			if (i < 4) {
				templete += "                                  <tr>\r\n"
					+ "                                            <td\r\n"
					+ "                                                style=\"width: 50%; text-align: left;  padding: 10px; border-right: 1px solid #fff;  border-bottom: 1px solid #e7e7e7; color: #333;\">\r\n"
					+ "                                                " + rehabilitateQuestions[i] + "</td>\r\n"
					+ "                                            <td\r\n"
					+ "                                                style=\"width: 50%;  padding: 10px; border: 1px solid #e7e7e7; color: #333; text-align: right;\">\r\n"
					+ "                                                <span\r\n"
					+ "                                                    style=\"background-color: #F1F3FC; padding: 5px 20px; border-radius: 30px;\">\r\n"
					+ "                                                    " + rehabilitateAnswers[index] + "</span>\r\n"
					+ "                                            </td>\r\n"
					+ "                                        </tr>";
			} else {
				templete += "                                  <tr>\r\n"
					+ "                                            <td\r\n"
					+ "                                                style=\"width: 50%; text-align: left;  padding: 10px; border-right: 1px solid #fff;  border-bottom: 1px solid #e7e7e7; color: #333;\">\r\n"
					+ "                                                " + rehabilitateQuestions[i] + "</td>\r\n"
					+ "                                            <td\r\n"
					+ "                                                style=\"width: 50%; padding: 10px; border: 1px solid #e7e7e7; color: #333; text-align: right;\">\r\n"
					+ "                                                <span\r\n"
					+ "                                                    style=\"background-color: #F1F3FC; padding: 5px 20px; border-radius: 30px;\">\r\n"
					+ "                                                    " + rehabilitateAnswers2[index] + "</span>\r\n"
					+ "                                            </td>\r\n"
					+ "                                        </tr>";
			}
		}
		return templete;
    }
    
    /*
     * 질병에 대한 템플릿
     */
    private String getDiseaseSelectTemplete(String selectStr) {
    	String[] diseaseQuestions = new String[] {
			"치매",
			"중풍(뇌졸증)",
			"고혈압",
			"당뇨병",
			"관절염(퇴행성,류마티스)",
			"요통,좌골통(디스크)",
			"심부전,폐질환,천식 등",
			"난청",
			"백내장,녹내장",
			"골절,탈골,사고 후유증",
			"암",
			"신부전",
			"욕창"
		};
    	
    	String[] split = selectStr.split(",");
    	List<Integer> selectedIndexList = new ArrayList<>();
    	for (int i = 0; i < split.length; i++) {
    		if ("1".equals(split[i])) {
    			selectedIndexList.add(i);
    		}
    	}
    	
    	String templete = "";
    	for (int i = 0; i < selectedIndexList.size(); i+=2) {
    		Integer index = selectedIndexList.get(i);
    		
    		templete += "                                      <tr>\r\n";
    		templete += "                                          <td style=\"text-align: left; padding: 10px; color: #333;\">\r\n"
    				+ "                                                <span\r\n"
    				+ "                                                    style=\"background-color: #F4F5ED; padding: 5px 20px; border-radius: 30px;\">" + diseaseQuestions[index] + "</span>\r\n"
    				+ "                                            </td>\r\n";
    		
    		if (i + 1 >= selectedIndexList.size()) {
    			templete += "";
    		} else {
    			index = selectedIndexList.get(i + 1);
    			templete += "                                          <td style=\"text-align: left; padding: 10px; color: #333;\">\r\n"
        				+ "                                                <span\r\n"
        				+ "                                                    style=\"background-color: #F4F5ED; padding: 5px 20px; border-radius: 30px;\">" + diseaseQuestions[index] + "</span>\r\n"
        				+ "                                            </td>\r\n";
    		}
    		templete += "                                      </tr>";
    	}
    	return templete;
    }
}
