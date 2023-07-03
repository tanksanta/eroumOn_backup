package icube.manage.exhibit.main.biz;

import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("mainMngDAO")
public class MainMngDAO extends CommonAbstractMapper {

	public CommonListVO mainMngListVO(CommonListVO listVO) throws Exception {
		return selectListVO("main.selectMainMngCount", "main.selectMainMngListVO", listVO);
	}

	public Integer updateMainUseYn(Map<String, Object>paramMap) throws Exception {
		return update("main.updateMainUseYn",paramMap);
	}

	public Integer updateMainSortNo(Map<String, Object> paramMap) throws Exception {
		return update("main.updateMainSortNo",paramMap);
	}

}