package icube.manage.exhibit.banner.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("bnnrMngDAO")
public class BnnrMngDAO extends CommonAbstractMapper {

	public CommonListVO bnnrMngListVO(CommonListVO listVO) throws Exception {
		return selectListVO("banner.mng.selectBnnrMngCount", "banner.mng.selectBnnrMngListVO", listVO);
	}

	public List<BnnrMngVO> selectBnnrMngList(Map<String, Object> paramMap) throws Exception {
		return selectList("banner.mng.selectBnnrMngList",paramMap);
	}

	public BnnrMngVO selectBnnrMng(int bnnrMngNo) throws Exception {
		return (BnnrMngVO)selectOne("banner.mng.selectBnnrMng", bnnrMngNo);
	}

	public Integer updateBnnrMng(BnnrMngVO bnnrMngVO) throws Exception {
		return update("banner.mng.updateBnnrMng", bnnrMngVO);
	}

	public Integer updateBnnrUseYn(Map<String, Object> paramMap) throws Exception {
		return update("banner.mng.updateBnnrUseYn",paramMap);
	}

	public Integer updateSortNo(Map<String, Object> paramMap) throws Exception {
		return update("banner.mng.updateSortNo",paramMap);
	}

	public Integer updateBnnrRdcnt(Map<String, Object> paramMap) throws Exception {
		return update("banner.mng.updateBnnrRdcnt",paramMap);
	}

	public void insertBnnrMng(BnnrMngVO bnnrMngVO) throws Exception {
		insert("banner.mng.insertBnnrMng", bnnrMngVO);
	}

}