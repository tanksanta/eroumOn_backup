package icube.manage.promotion.point.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("mbrPointDAO")
public class MbrPointDAO extends CommonAbstractMapper {

	public CommonListVO mbrPointListVO(CommonListVO listVO) throws Exception {
		return selectListVO("mbr.point.selectMbrPointCount", "mbr.point.selectMbrPointListVO", listVO);
	}

	public MbrPointVO selectMbrPoint(Map<String, Object> paramMap) throws Exception {
		return (MbrPointVO)selectOne("mbr.point.selectMbrPoint", paramMap);
	}

	public void insertMbrPoint(MbrPointVO mbrPointVO) throws Exception {
		insert("mbr.point.insertMbrPoint", mbrPointVO);
	}

	public List<MbrPointVO> selectMbrPointList(Map<String, Object> paramMap) throws Exception {
		return selectList("mbr.point.selectMbrPointList",paramMap);
	}

	public int selectMbrPointCount(Map<String, Object> paramMap) throws Exception{
		return selectOne("mbr.point.selectMbrPointCount",paramMap);
	}

	// 포인트 sum
	public int selectSumPointByPointSe(Map<String, Object> paramMap) throws Exception {
		return selectOne("mbr.point.selectSumPointByPointSe",paramMap);
	}

}