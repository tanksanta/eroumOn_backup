package icube.manage.sysmng.test.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractMapper;

@Service("mMngTestDAO")
public class MMngTestDAO extends CommonAbstractMapper {
	
	public List<Map<String, String>> selectAllTestMng() {
		return selectList("test.selectAllTest");
	}
	
	public void insertTestMng(Map map) {
		insert("test.insertMngTest", map);
	}
	
	public void updateTestMng(Map map) {
		update("test.updateMngTest", map);
	}
}
