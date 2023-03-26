package icube.manage.promotion.mlg.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("mlgMngDAO")
public class MlgMngDAO extends CommonAbstractMapper {

	public CommonListVO mlgMngListVO(CommonListVO listVO) throws Exception {
		return selectListVO("mlg.mng.selectMlgMngCount", "mlg.mng.selectMlgMngListVO", listVO);
	}

	public MlgMngVO selectMlgMng(Map<String, Object> paramMap) throws Exception {
		return (MlgMngVO)selectOne("mlg.mng.selectMlgMng", paramMap);
	}

	public void insertMlgMng(MlgMngVO mlgMngVO) throws Exception {
		insert("mlg.mng.insertMlgMng", mlgMngVO);
	}

	public List<MlgMngVO> selectMlgMngListAll(Map<String, Object> paramMap) throws Exception {
		return selectList("mlg.mng.selectMlgMngListAll",paramMap);
	}
}