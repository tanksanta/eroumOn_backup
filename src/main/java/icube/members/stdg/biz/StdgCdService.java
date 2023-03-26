package icube.members.stdg.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;

@Service("stdgCdService")
public class StdgCdService extends CommonAbstractServiceImpl {

	@Resource(name="stdgCdDAO")
	private StdgCdDAO stdgCdDAO;

	public List<StdgCdVO> selectStdgCdListAll(int levelNo, String stdgCd) throws Exception {

		Map<String, Object> paramMap =  new HashMap<String, Object>();
		paramMap.put("stdgCd", stdgCd);
		paramMap.put("levelNo", levelNo);

		return stdgCdDAO.selectStdgCdListAll(paramMap);
	}


	public List<StdgCdVO> selectStdgCdListAll(int levelNo) throws Exception {
		return this.selectStdgCdListAll(levelNo, "");
	}


	public StdgCdVO selectStdgCd(Map<String, Object> paramMap) throws Exception {
		return stdgCdDAO.selectStdgCd(paramMap);
	}

}
