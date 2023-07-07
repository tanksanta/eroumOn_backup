package icube.manage.exhibit.main.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("mainMngDAO")
public class MainMngDAO extends CommonAbstractMapper {

	public CommonListVO mainMngListVO(CommonListVO listVO) throws Exception {
		return selectListVO("main.selectMainMngCount", "main.selectMainMngListVO", listVO);
	}

	public List<MainMngVO> selectMainMngList(Map<String, Object> paramMap) throws Exception {
		return selectList("main.selectMainMngList",paramMap);
	}

	public MainMngVO selectMainMng(Map<String, Object> paramMap) throws Exception {
		return selectOne("main.selectMainMng",paramMap);
	}

	public Integer updateMainUseYn(Map<String, Object>paramMap) throws Exception {
		return update("main.updateMainUseYn",paramMap);
	}

	public Integer updateMainSortNo(Map<String, Object> paramMap) throws Exception {
		return update("main.updateMainSortNo",paramMap);
	}

	public Integer updateMainMng(MainMngVO mainMngVO) throws Exception {
		return update("main.updateMainMng",mainMngVO);
	}

	public Integer updateMainRdcnt(Map<String, Object> paramMap) throws Exception {
		return update("main.updateMainRdcnt", paramMap);
	}

	public void insertMainMng(MainMngVO mainMngVO) throws Exception {
		insert("main.insertMainMng",mainMngVO);
	}

}