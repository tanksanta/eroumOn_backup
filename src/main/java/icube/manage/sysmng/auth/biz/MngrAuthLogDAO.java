package icube.manage.sysmng.auth.biz;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("mngrAuthLogDAO")
public class MngrAuthLogDAO extends CommonAbstractMapper {

	public CommonListVO selectMngrAuthLogListVO(CommonListVO listVO) throws Exception {
		return selectListVO("sysmng.auth.log.selectMngrAuthLogCount", "sysmng.auth.log.selectMngrAuthLogListVO", listVO);
	}

	public MngrAuthLogVO selectMngrAuthLog(int logNo) throws Exception {
		return (MngrAuthLogVO)selectOne("sysmng.auth.log.selectMngrAuthLog", logNo);
	}

	public int insertMngrAuthLog(MngrAuthLogVO mngrAuthLogVO) throws Exception {
		return insert("sysmng.auth.log.insertMngrAuthLog", mngrAuthLogVO);
	}

	public int updateMngrAuthLog(MngrAuthLogVO mngrAuthLogVO) throws Exception {
		return update("sysmng.auth.log.updateMngrAuthLog", mngrAuthLogVO);
	}

	public int deleteMngrAuthLog(int logNo) throws Exception {
		return delete("sysmng.auth.log.deleteMngrAuthLog", logNo);
	}

}