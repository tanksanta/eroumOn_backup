package icube.manage.exhibit.main.biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;

@Service("mainGdsMngService")
public class MainGdsMngService extends CommonAbstractServiceImpl {

	@Resource(name="mainGdsMngDAO")
	private MainGdsMngDAO mainGdsMngDAO;

	public List<MainMngVO> selectMainGdsMngList(Map<String, Object> paramMap) throws Exception {
		return mainGdsMngDAO.selectMainGdsMngList(paramMap);
	}

	public void updateMainGdsMng(Map<String, Object> paramMap) throws Exception {
		int mainNo = (Integer)paramMap.get("mainNo");

		deleteMainGdsMng(mainNo);

		String gdsNos = (String)paramMap.get("gdsNos");
		String[] gdsNoList = gdsNos.replace(" ", "").split(",");
		int idx = 1;
		for(String gdsNo : gdsNoList) {
			MainGdsMngVO mainGdsMngVO = new MainGdsMngVO();
			mainGdsMngVO.setMainNo(mainNo);
			mainGdsMngVO.setGdsNo(EgovStringUtil.string2integer(gdsNo));
			mainGdsMngVO.setSortNo(idx);

			mainGdsMngDAO.insertMainGdsMng(mainGdsMngVO);
			idx += 1;
		}

	}

	public void deleteMainGdsMng(int mainNo) throws Exception {
		mainGdsMngDAO.deleteMainGdsMng(mainNo);
	}





}