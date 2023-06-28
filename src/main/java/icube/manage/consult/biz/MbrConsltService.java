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

	

}