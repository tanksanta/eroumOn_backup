package icube.manage.exhibit.main.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("mainGdsMngDAO")
public class MainGdsMngDAO extends CommonAbstractMapper {

	public void insertMainGdsMng(MainGdsMngVO mainGdsMngVO) throws Exception {
		insert("main.gds.insertMainGdsMng",mainGdsMngVO);
	}

	public List<MainMngVO> selectMainGdsMngList(Map<String, Object> paramMap) throws Exception {
		return selectList("main.gds.selectMainGdsMngList",paramMap);
	}




}