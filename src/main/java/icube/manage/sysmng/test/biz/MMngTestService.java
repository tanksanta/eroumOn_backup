package icube.manage.sysmng.test.biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;

@Service("mMngTestService")
public class MMngTestService extends CommonAbstractServiceImpl {
	
	@Resource(name="mMngTestDAO")
	private MMngTestDAO mMngTestDAO;
	
	public List<Map<String, String>> selectAllTestMng() {
		return mMngTestDAO.selectAllTestMng();
	}
	
	public void insertTestMng(Map map) {
		mMngTestDAO.insertTestMng(map);
	}
	
	public void updateTestMng(Map map) {
		mMngTestDAO.updateTestMng(map);
	}
}
