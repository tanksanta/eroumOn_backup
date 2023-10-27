package icube.main.test.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;

@Service("mbrTestService")
public class MbrTestService extends CommonAbstractServiceImpl {
    
    @Resource(name="mbrTestDAO")
    private MbrTestDAO mbrTestDAO;
    
    public List<MbrTestVO> selectMbrTestList(Map paramMap) {
        return mbrTestDAO.selectMbrTestList(paramMap);
    }
    
    public List<MbrTestVO> selectMbrTestListByUniqueId(String uniqueId) {
    	Map<String, Object> paramMap = new HashMap<>();
    	paramMap.put("srchUniqueId", uniqueId);
        return mbrTestDAO.selectMbrTestList(paramMap);
    }
    
    public MbrTestVO selectMbrTest(Map paramMap) {
        return mbrTestDAO.selectMbrTest(paramMap);
    }
    
    public Integer insertMbrTest(MbrTestVO mbrTestVO) {
        return mbrTestDAO.insertMbrTest(mbrTestVO);
    }
    
    public void updateMbrTest(MbrTestVO mbrTestVO) {
    	mbrTestDAO.updateMbrTest(mbrTestVO);
    }
}