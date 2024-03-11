package icube.app.matching.simpletest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.util.DateUtil;
import icube.manage.mbr.recipients.biz.MbrRecipientsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;

@Service("simpleTestService")
public class SimpleTestService extends CommonAbstractServiceImpl {

    @Resource(name="simpleTestDAO")
    private SimpleTestDAO simpleTestDAO;

    
    @Resource(name= "mbrRecipientsService")
	private MbrRecipientsService mbrRecipientsService;
    
    public List<SimpleTestVO> selectSimpleTestList(Map<String,Object> paramMap) {
        return simpleTestDAO.selectSimpleTestList(paramMap);
    }

    public List<SimpleTestVO> selectSimpleTestListByUniqueId(String uniqueId) {
    	Map<String, Object> paramMap = new HashMap<>();
    	paramMap.put("uniqueId", uniqueId);
        return simpleTestDAO.selectSimpleTestList(paramMap);
    }

    public SimpleTestVO selectSimpleTestOne(Map<String,Object> paramMap) {
        return simpleTestDAO.selectSimpleTestOne(paramMap);
    }

    public SimpleTestVO selectSimpleTestByRecipientsNo(String uniqueId, int recipientsNo, String testTy) {
    	Map<String, Object> paramMap = new HashMap<>();

    	paramMap.put("uniqueId", uniqueId);
        paramMap.put("recipientsNo", recipientsNo);
        paramMap.put("testTy", testTy);
        
    	return selectSimpleTestOne(paramMap);
    }

    public SimpleTestVO selectSimpleTestByNo(String uniqueId, int recipientsNo, int mbrSimpletestNo) {
    	Map<String, Object> paramMap = new HashMap<>();

    	paramMap.put("uniqueId", uniqueId);
        paramMap.put("recipientsNo", recipientsNo);
        paramMap.put("mbrSimpletestNo", mbrSimpletestNo);

    	return simpleTestDAO.selectSimpleTestNo(paramMap);
    }

    public Integer insertSimpleTest(int recipientsNo, Map<String,Object> reqMap) throws Exception {
        MbrRecipientsVO  mbrRecipientsVO = mbrRecipientsService.selectMbrRecipientsByRecipientsNo(recipientsNo);
        
        SimpleTestVO mbrTestVO = this.calcSimpleTest(mbrRecipientsVO.getMbrUniqueId(), reqMap, mbrRecipientsVO.getBrdt());

        return simpleTestDAO.insertSimpleTest(mbrTestVO);
    }

    protected int calcTestScoreYn(Map<String,Object> reqMap) throws Exception{
        //&step100=1&step200=1&step300=1&step400=1&step500=1&step600=1

        String sKey;
        int score = 0;

        sKey = "step100"; if (reqMap.get(sKey) != null && EgovStringUtil.equals(reqMap.get(sKey).toString(), "1")) score += 30;//혼자서 식사를 하실 수 있나요?
        sKey = "step200"; if (reqMap.get(sKey) != null && EgovStringUtil.equals(reqMap.get(sKey).toString(), "1")) score += 30;//혼자서 양치나 세수가 가능하신가요?
        sKey = "step300"; if (reqMap.get(sKey) != null && EgovStringUtil.equals(reqMap.get(sKey).toString(), "1")) score += 15;//팔 또는 다리를 움직이기 힘드세요?
        sKey = "step400"; if (reqMap.get(sKey) != null && EgovStringUtil.equals(reqMap.get(sKey).toString(), "1")) score += 15;//혼자서 앉거나 방 밖으로 나가실 수 있나요?
        sKey = "step500"; if (reqMap.get(sKey) != null && EgovStringUtil.equals(reqMap.get(sKey).toString(), "1")) score += 15;//스스로 대소변 조절이 가능한가요?
        sKey = "step600"; if (reqMap.get(sKey) != null && EgovStringUtil.equals(reqMap.get(sKey).toString(), "1")) score += 15;//치매로 진단을 받으셨거나 의심되세요?

        return score;
    }

    protected SimpleTestVO calcSimpleTest(String mbrUniqueId, Map<String,Object> reqMap, String brdt) throws Exception{
        int age = 0;

        if (brdt.length() == 8) age = DateUtil.getRealAge(brdt);

        int score = this.calcTestScoreYn(reqMap);
        String step600Val = "0";
        String sKey = "step600"; 
        if (reqMap.get(sKey) != null && EgovStringUtil.equals(reqMap.get(sKey).toString(), "1")) {
            step600Val = reqMap.get(sKey).toString();
        }
        

        int grade = 0;
        /*인정번호가 있으면 상담을 받을 수 있다*/
        if (reqMap.get("rcperRcognYn") != null && EgovStringUtil.equals(reqMap.get("rcperRcognYn").toString(), "Y")){
            grade = 1;
        } else if ((score >= 30 && age >= 65) || (step600Val == "1" && age < 65)){
            grade = 1;
        }

        ObjectMapper objectMapper = new ObjectMapper();
        String jsonStr = objectMapper.writeValueAsString(reqMap);

        SimpleTestVO mbrTestVO = new SimpleTestVO();

        mbrTestVO.setUniqueId(mbrUniqueId);
        // mbrTestVO.setUniqueId(reqMap.get("unique_id").toString());

        mbrTestVO.setRecipientsNo(Integer.parseInt(reqMap.get("recipientsNo").toString()));
        mbrTestVO.setTestTy(reqMap.get("testTy").toString());
        mbrTestVO.setSelectedValue(jsonStr);

        mbrTestVO.setScore(score);
        mbrTestVO.setAge(age);
        mbrTestVO.setGrade(grade);

        sKey = "careTime"; 
        if (reqMap.get(sKey) != null && EgovStringUtil.isNotEmpty(reqMap.get(sKey).toString())) {
            mbrTestVO.setCareTime(Integer.parseInt(reqMap.get(sKey).toString()));
        }else{
            mbrTestVO.setCareTime(0);
        }

        return mbrTestVO;
    }

    // public void updateSimpleTest(SimpleTestVO mbrTestVO) {
    // 	simpleTestDAO.updateSimpleTest(mbrTestVO);
    // }
}