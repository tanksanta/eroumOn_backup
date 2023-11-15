package icube.manage.sysmng.mngr.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@SuppressWarnings("rawtypes")
@Repository("mngrExcelLogDAO")
public class MngrExcelLogDAO extends CommonAbstractMapper {

	public CommonListVO selectMngrListVO(CommonListVO listVO) throws Exception {
		return selectListVO("sysmng.excel.log.selectMngrExcelLogCount", "sysmng.excel.log.selectMngrExcelLogListVO", listVO);
	}

	public List selectMenuMngrList(Map paramMap) throws Exception{
		return selectList("sysmng.excel.log.selectMngrExcelLogListVO", paramMap);
	}

	public void insertMngr(MngrExcelLogVO mngrExcelLogVO) throws Exception {
		insert("sysmng.excel.log.insertMngrExcelLog", mngrExcelLogVO);
	}

}
