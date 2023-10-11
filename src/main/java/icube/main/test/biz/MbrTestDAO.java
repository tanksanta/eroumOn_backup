package icube.main.test.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("mbrTestDAO")
public class MbrTestDAO extends CommonAbstractMapper {
    
    public MbrTestVO selectMbrTest(Map paramMap) {
        return selectOne("mbr.test.selectMbrTest", paramMap);
    }
    
    public Integer insertMbrTest(MbrTestVO mbrTestVO) {
        insert("mbr.test.insertMbrTest", mbrTestVO);
        return mbrTestVO.getMbrTestNo();
    }
    
    public void updateMbrTest(MbrTestVO mbrTestVO) {
    	update("mbr.test.updateMbrTest", mbrTestVO);
    }
}