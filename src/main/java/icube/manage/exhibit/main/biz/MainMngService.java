package icube.manage.exhibit.main.biz;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("mainMngService")
public class MainMngService extends CommonAbstractServiceImpl {

	@Resource(name="mainMngDAO")
	private MainMngDAO mainMngDAO;

	@Resource(name="mainGdsMngDAO")
	private MainGdsMngDAO mainGdsMngDAO;

	public CommonListVO mainMngListVO(CommonListVO listVO) throws Exception {
		return mainMngDAO.mainMngListVO(listVO);
	}

	public Integer updateMainUseYn(int mainNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("mainNo", mainNo);
		paramMap.put("useYn", "N");
		return mainMngDAO.updateMainUseYn(paramMap);
	}

	public Integer updateMainSortNo(Map<String, Object> paramMap) throws Exception {
		return mainMngDAO.updateMainSortNo(paramMap);
	}

	public MainMngVO selectMainMng(int mainNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchMainNo", mainNo);
		return selectMainMng(paramMap);
	}

	public MainMngVO selectMainMng(Map<String, Object> paramMap) throws Exception {
		return mainMngDAO.selectMainMng(paramMap);
	}

	public void insertMainMng(MainMngVO mainMngVO) throws Exception {
		mainMngDAO.insertMainMng(mainMngVO);
	}

	public void insertMainGds(MainMngVO mainMngVO, Map<String, Object> reqMap) throws Exception {

		String gdsNos = (String)reqMap.get("gdsNo");
		String[] gdsNoList = gdsNos.replace(" ", "").split(",");
		int idx = 1;
		for(String gdsNo : gdsNoList) {
			MainGdsMngVO mainGdsMngVO = new MainGdsMngVO();
			mainGdsMngVO.setMainNo(mainMngVO.getMainNo());
			mainGdsMngVO.setGdsNo(EgovStringUtil.string2integer(gdsNo));
			mainGdsMngVO.setSortNo(idx);

			mainGdsMngDAO.insertMainGdsMng(mainGdsMngVO);
			idx += 1;
		}

	}

}