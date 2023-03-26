package icube.manage.promotion.point.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("pointMngDAO")
public class PointMngDAO extends CommonAbstractMapper {

	public CommonListVO pointMngListVO(CommonListVO listVO) throws Exception {
		return selectListVO("point.mng.selectPointMngCount", "point.mng.selectPointMngListVO", listVO);
	}

	public PointMngVO selectPointMng(int pointMngNo) throws Exception {
		return (PointMngVO)selectOne("point.mng.selectPointMng", pointMngNo);
	}

	public void insertPointMng(PointMngVO pointMngVO) throws Exception {
		insert("point.mng.insertPointMng", pointMngVO);
	}

	public List<PointMngVO> selectPointMngListAll(Map<String, Object> paramMap) throws Exception {
		return selectList("point.mng.selectPointMngListAll",paramMap);
	}
}