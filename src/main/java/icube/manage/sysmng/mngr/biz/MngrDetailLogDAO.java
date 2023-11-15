package icube.manage.sysmng.mngr.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@SuppressWarnings("rawtypes")
@Repository("mngrDetailLogDAO")
public class MngrDetailLogDAO extends CommonAbstractMapper {

	public CommonListVO selectMngrDetailLogListVO(CommonListVO listVO) throws Exception {
		return selectListVO("sysmng.detail.log.selectMngrDetailLogCount", "sysmng.detail.log.selectMngrDetailLogListVO", listVO);
	}

	public List selectMngrDetailLogList(Map paramMap) throws Exception{
		return selectList("sysmng.detail.log.selectMngrDetailLogListVO", paramMap);
	}

	public void insertMngrDetailLog(MngrDetailLogVO mngrDetailLogVO) throws Exception {
		insert("sysmng.detail.log.insertMngrDetailLog", mngrDetailLogVO);
	}

}
