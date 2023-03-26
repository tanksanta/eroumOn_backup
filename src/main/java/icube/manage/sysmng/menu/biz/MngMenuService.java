package icube.manage.sysmng.menu.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;

@SuppressWarnings("rawtypes")
@Service("mngMenuService")
public class MngMenuService extends CommonAbstractServiceImpl {

	@Resource(name="mngMenuDAO")
	private MngMenuDAO mngMenuDAO;


	public List selectMngMenuList() throws Exception {
		return mngMenuDAO.selectMngMenuList();
	}

	public List selectMngMenuList(Map<String, Object> paramMap) throws Exception {
		return mngMenuDAO.selectMngMenuList(paramMap);
	}

	public List<MngMenuVO> selectChildMngMenuList(Map<String, Object> paramMap) throws Exception {
		return mngMenuDAO.selectChildMngMenuList(paramMap);
	}


	public MngMenuVO selectMngMenu(int menuNo) throws Exception {
		return mngMenuDAO.selectMngMenu(menuNo);
	}


	public void insertMngMenu(MngMenuVO mngMenuVO) throws Exception {
		mngMenuDAO.insertMngMenu(mngMenuVO);
	}


	public void updateMngMenu(MngMenuVO mngMenuVO) throws Exception {
		mngMenuDAO.updateMngMenu(mngMenuVO);
	}


	public void deleteMngMenu(int menuNo) throws Exception {
		mngMenuDAO.deleteMngMenu(menuNo);
	}


	public List<MngMenuVO> selectMngMenuExceptList(Map<String, Object> paramMap) throws Exception {
		return mngMenuDAO.selectMngMenuExceptList(paramMap);
	}


	public int selectLowerMenuCheck(Map<String, Object> paramMap) throws Exception {
		return mngMenuDAO.selectLowerMenuCheck(paramMap);
	}


	public void updateLowerMenuUseYn(MngMenuVO mngMenuVO) {
		mngMenuDAO.updateLowerMenuUseYn(mngMenuVO);
	}


	public int updateMenuUseYn(MngMenuVO mngMenuVO) throws Exception {
		return mngMenuDAO.updateMenuUseYn(mngMenuVO);
	}

	@SuppressWarnings("unchecked")
	public List<MngMenuVO> selectMngMenuAuthList(int authrtNo, String authrtYn) throws Exception {
		Map paramMap = new HashMap();
		paramMap.put("authrtNo", authrtNo);
		paramMap.put("authrtYn", authrtYn);
		return mngMenuDAO.selectMngMenuAuthList(paramMap);
	}

	//전체관리자 메뉴
	public List<MngMenuVO> selectMngMenuAuthListForSuperAdmin() throws Exception {
		return mngMenuDAO.selectMngMenuAuthListForSuperAdmin();
	}


	public String selectMenuNmFromUrl(String menuUrl) throws Exception {
		return mngMenuDAO.selectMenuNmFromUrl(menuUrl);
	}


	public MngMenuVO selectMenuInfoFromUrl(String menuUrl) throws Exception {
		return mngMenuDAO.selectMenuInfoFromUrl(menuUrl);
	}


	public int updateMngMenuNm(Map<String, Object> paramMap) {
		return mngMenuDAO.updateMngMenuNm(paramMap);
	}


	public void moveMngMenu(MngMenuVO mngMenuVO, String sortSeq) throws Exception {

		String[] sortedMenuNos = sortSeq.split(",");

		for(int i=0; i<sortedMenuNos.length; i++) {
			log.debug(" ## menu sort  " + sortedMenuNos[i] + " index " + i);
			mngMenuVO.setSortNo(i+1);
			mngMenuVO.setMenuNo(NumberUtils.toInt(sortedMenuNos[i]));
			mngMenuDAO.updateMngMenuPosition(mngMenuVO);
		}

	}

}
