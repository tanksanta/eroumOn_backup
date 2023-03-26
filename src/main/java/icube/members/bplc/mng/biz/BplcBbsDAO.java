package icube.members.bplc.mng.biz;

import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("bplcBbsDAO")
public class BplcBbsDAO extends CommonAbstractMapper {

	public CommonListVO bplcBbsListVO(CommonListVO listVO) throws Exception {
		return selectListVO("bplc.bbs.selectBplcBbsCount", "bplc.bbs.selectBplcBbsListVO", listVO);
	}

	public BplcBbsVO selectBplcBbs(Map<String, Object> paramMap) throws Exception {
		return (BplcBbsVO)selectOne("bplc.bbs.selectBplcBbs", paramMap);
	}

	public void insertBplcBbs(BplcBbsVO bplcBbsVO) throws Exception {
		insert("bplc.bbs.insertBplcBbs", bplcBbsVO);
	}

	public void updateBplcBbs(BplcBbsVO bplcBbsVO) throws Exception {
		update("bplc.bbs.updateBplcBbs", bplcBbsVO);
	}

	public void updateInqcnt(BplcBbsVO bplcBbsVO) throws Exception {
		update("bplc.bbs.updateInqcnt", bplcBbsVO);
	}

	public void deleteBbs(Map<String, Object> paramMap) throws Exception {
		update("bplc.bbs.deleteBbs",paramMap);
	}
}