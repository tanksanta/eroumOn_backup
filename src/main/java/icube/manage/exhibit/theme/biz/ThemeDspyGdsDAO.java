package icube.manage.exhibit.theme.biz;

import java.util.List;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("themeDspyGdsDAO")
public class ThemeDspyGdsDAO extends CommonAbstractMapper{

	public void deleteGds(int themeDspyGdsNo) throws Exception {
		delete("theme.dspy.gds.deleteGds",themeDspyGdsNo);
	}

	public void insertGds(ThemeDspyGdsVO themeDspyGdsVO) throws Exception{
		insert("theme.dspy.gds.insertGds",themeDspyGdsVO);
	}

	public List<ThemeDspyGdsVO> selectGdsList(int themeDspyNo) throws Exception {
		return selectList("theme.dspy.gds.selectGdsList",themeDspyNo);
	}

}
