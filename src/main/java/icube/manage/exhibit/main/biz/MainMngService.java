package icube.manage.exhibit.main.biz;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("mainMngService")
public class MainMngService extends CommonAbstractServiceImpl {

	@Resource(name="mainMngDAO")
	private MainMngDAO mainMngDAO;

	public CommonListVO mainMngListVO(CommonListVO listVO) throws Exception {
		return mainMngDAO.mainMngListVO(listVO);
	}

	public Integer updateMainUseYn(int mainNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("mainNo", mainNo);
		paramMap.put("useYn", "N");
		return mainMngDAO.updateMainUseYn(paramMap);
	}

	public Integer updateMainSortNo(Map<String, Object> paramMap) throws Exception {
		return mainMngDAO.updateMainSortNo(paramMap);
	}

}