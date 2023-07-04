package icube.manage.exhibit.main.biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;

@Service("mainGdsMngService")
public class MainGdsMngService extends CommonAbstractServiceImpl {

	@Resource(name="mainGdsMngDAO")
	private MainGdsMngDAO mainGdsMngDAO;

	public List<MainMngVO> selectMainGdsMngList(Map<String, Object> paramMap) throws Exception {
		return mainGdsMngDAO.selectMainGdsMngList(paramMap);
	}





}