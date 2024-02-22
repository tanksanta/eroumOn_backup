package icube.app.matching.simpletest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovDateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import icube.app.matching.membership.mbr.biz.MatMbrSession;
import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.util.DateUtil;
import icube.manage.mbr.recipients.biz.MbrRecipientsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;

@Service("simpleTestService")
public class SimpleTestService extends CommonAbstractServiceImpl {
    
    @Autowired
	private MatMbrSession matMbrSession;

    @Resource(name="simpleTestDAO")
    private SimpleTestDAO simpleTestDAO;

    
    @Resource(name= "mbrRecipientsService")
	private MbrRecipientsService mbrRecipientsService;
    
    public List<SimpleTestVO> selectMbrTestList(Map paramMap) {
        return simpleTestDAO.selectMbrTestList(paramMap);
    }
    public List<SimpleTestVO> selectMbrTestListByUniqueId(String uniqueId) {
    	Map<String, Object> paramMap = new HashMap<>();
    	paramMap.put("srchUniqueId", uniqueId);
        return simpleTestDAO.selectMbrTestList(paramMap);
    }
    public SimpleTestVO selectMbrTest(Map paramMap) {
        return simpleTestDAO.selectMbrTest(paramMap);
    }
    public SimpleTestVO selectMbrTestByRecipientsNo(int recipientsNo) {
    	Map<String, Object> paramMap = new HashMap<>();
    	paramMap.put("srchRecipientsNo", recipientsNo);
    	return selectMbrTest(paramMap);
    }
    public Integer insertMbrTest(Map<String,Object> reqMap) throws Exception {
        MbrRecipientsVO  mbrRecipientsVO = mbrRecipientsService.selectMbrRecipientsByRecipientsNo(0);
        
        SimpleTestVO mbrTestVO = this.calcSimpleTest(reqMap, mbrRecipientsVO.getBrdt());

        return simpleTestDAO.insertMbrTest(mbrTestVO);
    }

    protected int calcTestScoreYn(Map<String,Object> reqMap) throws Exception{
        //&step100=1&step200=1&step300=1&step400=1&step500=1&step600=1

        String sKey;
        int score = 0;

        sKey = "step100"; if (reqMap.get(sKey) != null && reqMap.get(sKey).toString()=="1") score += 30;//혼자서 식사를 하실 수 있나요?
        sKey = "step200"; if (reqMap.get(sKey) != null && reqMap.get(sKey).toString()=="1") score += 30;//혼자서 양치나 세수가 가능하신가요?
        sKey = "step300"; if (reqMap.get(sKey) != null && reqMap.get(sKey).toString()=="1") score += 15;//팔 또는 다리를 움직이기 힘드세요?
        sKey = "step400"; if (reqMap.get(sKey) != null && reqMap.get(sKey).toString()=="1") score += 15;//혼자서 앉거나 방 밖으로 나가실 수 있나요?
        sKey = "step500"; if (reqMap.get(sKey) != null && reqMap.get(sKey).toString()=="1") score += 15;//스스로 대소변 조절이 가능한가요?
        sKey = "step600"; if (reqMap.get(sKey) != null && reqMap.get(sKey).toString()=="1") score += 15;//치매로 진단을 받으셨거나 의심되세요?


        return score;
    }
    protected SimpleTestVO calcSimpleTest(Map<String,Object> reqMap, String brdt) throws Exception{
        int age = 0;

        if (brdt.length() == 8) age = DateUtil.getRealAge(brdt);

        int score = this.calcTestScoreYn(reqMap);



        ObjectMapper objectMapper = new ObjectMapper();
        String jsonStr = objectMapper.writeValueAsString(reqMap);


        SimpleTestVO mbrTestVO = new SimpleTestVO();


        mbrTestVO.setUniqueId(matMbrSession.getUniqueId());
        mbrTestVO.setRecipientsNo(Integer.parseInt(reqMap.get("recipientsNo").toString()));
        mbrTestVO.setTestTy(reqMap.get("testTy").toString());
        mbrTestVO.setSelectedValue(jsonStr);

        mbrTestVO.setScore(score);
        mbrTestVO.setAge(age);



        return mbrTestVO;
    }

    public void updateMbrTest(SimpleTestVO mbrTestVO) {
    	simpleTestDAO.updateMbrTest(mbrTestVO);
    }
}