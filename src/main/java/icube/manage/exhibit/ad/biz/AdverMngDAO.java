package icube.manage.exhibit.ad.biz;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("adverMngDAO")
public class AdverMngDAO extends CommonAbstractMapper {

	public CommonListVO adverMngListVO(CommonListVO listVO) throws Exception {
		return selectListVO("adver.mng.selectAdverMngCount", "adver.mng.selectAdverMngListVO", listVO);
	}

	public AdverMngVO selectAdverMng(int adverMngNo) throws Exception {
		return (AdverMngVO)selectOne("adver.mng.selectAdverMng", adverMngNo);
	}

	public void insertAdverMng(AdverMngVO adverMngVO) throws Exception {
		insert("adver.mng.insertAdverMng", adverMngVO);
	}

	public void updateAdverMng(AdverMngVO adverMngVO) throws Exception {
		update("adver.mng.updateAdverMng", adverMngVO);
	}
}