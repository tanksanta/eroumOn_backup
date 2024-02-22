package icube.app.matching.simpletest;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("simpleTestDAO")
public class SimpleTestDAO extends CommonAbstractMapper {
    
	public List<SimpleTestVO> selectMbrTestList(Map paramMap) {
        return selectList("mbr.test.selectMbrTest", paramMap);
    }
	    public SimpleTestVO selectMbrTest(Map paramMap) {
        return selectOne("mbr.test.selectMbrTest", paramMap);
    }
        public Integer insertMbrTest(SimpleTestVO mbrTestVO) {
        insert("mbr.test.insertMbrTest", mbrTestVO);
        return mbrTestVO.getMbrTestNo();
    }
        public void updateMbrTest(SimpleTestVO mbrTestVO) {
    	update("mbr.test.updateMbrTest", mbrTestVO);
    }
}