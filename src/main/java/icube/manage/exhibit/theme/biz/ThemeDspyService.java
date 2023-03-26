package icube.manage.exhibit.theme.biz;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("themeDspyService")
public class ThemeDspyService extends CommonAbstractServiceImpl {

	@Resource(name="themeDspyDAO")
	private ThemeDspyDAO themeDspyDAO;

	public CommonListVO themeDspyListVO(CommonListVO listVO) throws Exception {
		return themeDspyDAO.themeDspyListVO(listVO);
	}

	public ThemeDspyVO selectThemeDspy(int themeDspyNo) throws Exception {
		return themeDspyDAO.selectThemeDspy(themeDspyNo);
	}

	public void insertThemeDspy(ThemeDspyVO themeDspyVO) throws Exception {
		themeDspyDAO.insertThemeDspy(themeDspyVO);
	}

	public void updateThemeDspy(ThemeDspyVO themeDspyVO) throws Exception {
		themeDspyDAO.updateThemeDspy(themeDspyVO);
	}

}