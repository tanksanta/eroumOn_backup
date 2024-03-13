package icube.app.matching.simpletest;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("simpleTestDAO")
public class SimpleTestDAO extends CommonAbstractMapper {
    
	public List<SimpleTestVO> selectSimpleTestList(Map<String,Object> paramMap) {
        return selectList("mbr.simpletest.selectSimpleTest", paramMap);
    }

	public SimpleTestVO selectSimpleTestOne(Map<String,Object> paramMap) {
        return selectOne("mbr.simpletest.selectSimpleTestOne", paramMap);
    }

    public Integer insertSimpleTest(SimpleTestVO mbrTestVO) {
        insert("mbr.simpletest.insertSimpleTest", mbrTestVO);
        return mbrTestVO.getMbrSimpletestNo();
    }

    // public void updateSimpleTest(SimpleTestVO mbrTestVO) {
    // 	update("mbr.simpletest.updateSimpleTest", mbrTestVO);
    // }
}