package icube.manage.exhibit.theme.biz;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("themeDspyDAO")
public class ThemeDspyDAO extends CommonAbstractMapper {

	public CommonListVO themeDspyListVO(CommonListVO listVO) throws Exception {
		return selectListVO("theme.dspy.selectThemeDspyCount", "theme.dspy.selectThemeDspyListVO", listVO);
	}

	public ThemeDspyVO selectThemeDspy(int themeDspyNo) throws Exception {
		return (ThemeDspyVO)selectOne("theme.dspy.selectThemeDspy", themeDspyNo);
	}

	public void insertThemeDspy(ThemeDspyVO themeDspyVO) throws Exception {
		insert("theme.dspy.insertThemeDspy", themeDspyVO);
	}

	public void updateThemeDspy(ThemeDspyVO themeDspyVO) throws Exception {
		update("theme.dspy.updateThemeDspy", themeDspyVO);
	}

}