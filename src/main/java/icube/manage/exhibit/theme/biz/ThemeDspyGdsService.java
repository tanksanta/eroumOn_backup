package icube.manage.exhibit.theme.biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;

@Service("themeDspyGdsService")
public class ThemeDspyGdsService extends CommonAbstractServiceImpl{

	@Resource(name = "themeDspyGdsDAO")
	private ThemeDspyGdsDAO themeDspyGdsDAO;

	public void insertGds(String[] itemList, Map<String, Object> reqMap, ThemeDspyVO themeDspyVO) throws Exception {
		int themeDspyGdsNo = themeDspyVO.getThemeDspyNo();
		themeDspyGdsDAO.deleteGds(themeDspyGdsNo);

		for(int i=0; i<itemList.length; i++) {
			ThemeDspyGdsVO gdsVO  = new ThemeDspyGdsVO();
			gdsVO.setGdsNo(EgovStringUtil.string2integer(itemList[i]));
			gdsVO.setThemeDspyNo(themeDspyGdsNo);
			gdsVO.setSortNo(i+1);
			themeDspyGdsDAO.insertGds(gdsVO);
		}

	}

	public List<ThemeDspyGdsVO> selectGdsList(int themeDspyNo) throws Exception {
		return themeDspyGdsDAO.selectGdsList(themeDspyNo);
	}

	public void deleteGds(int themeDspyNo) throws Exception {
		themeDspyGdsDAO.deleteGds(themeDspyNo);
	}

}
