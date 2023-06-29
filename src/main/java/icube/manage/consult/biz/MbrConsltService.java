package icube.manage.consult.biz;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("mbrConsltService")
public class MbrConsltService extends CommonAbstractServiceImpl {

	@Resource(name="mbrConsltDAO")
	private MbrConsltDAO mbrConsltDAO;

	public CommonListVO selectMbrConsltListVO(CommonListVO listVO) throws Exception {
		return mbrConsltDAO.selectMbrConsltListVO(listVO);
	}

	public Integer updateUseYn(int consltNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("consltNo", consltNo);
		paramMap.put("useYn", "N");
		return mbrConsltDAO.updateUseYn(paramMap);
	}

	public MbrConsltVO selectMbrConslt(String uniqueId) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchRegUniqueId", uniqueId);
		return selectMbrConslt(paramMap);
	}

	public MbrConsltVO selectMbrConslt(Map<String, Object> paramMap) throws Exception {
		return mbrConsltDAO.selectMbrConslt(paramMap);
	}

	public Integer insertMbrConslt(MbrConsltVO mbrConsltVO) throws Exception {
		return mbrConsltDAO.insertMbrConslt(mbrConsltVO);
	}

	

}