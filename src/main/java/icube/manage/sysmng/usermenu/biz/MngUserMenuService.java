package icube.manage.sysmng.usermenu.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.manage.sysmng.menu.biz.MngMenuVO;

@SuppressWarnings("rawtypes")
@Service("mngUserMenuService")
public class MngUserMenuService extends CommonAbstractServiceImpl {

	@Resource(name="mngUserMenuDAO")
	private MngUserMenuDAO mngUserMenuDAO;


	public List selectMngMenuList() throws Exception {
		return mngUserMenuDAO.selectMngMenuList();
	}

	public List selectMngMenuList(Map<String, Object> paramMap) throws Exception {
		return mngUserMenuDAO.selectMngMenuList(paramMap);
	}

	public List<MngMenuVO> selectChildMngMenuList(Map<String, Object> paramMap) throws Exception {
		return mngUserMenuDAO.selectChildMngMenuList(paramMap);
	}


	public MngMenuVO selectMngMenu(int menuNo) throws Exception {
		return mngUserMenuDAO.selectMngMenu(menuNo);
	}


	public void insertMngMenu(MngMenuVO mngMenuVO) throws Exception {
		mngUserMenuDAO.insertMngMenu(mngMenuVO);
	}


	public void updateMngMenu(MngMenuVO mngMenuVO) throws Exception {
		mngUserMenuDAO.updateMngMenu(mngMenuVO);
	}


	public void deleteMngMenu(int menuNo) throws Exception {
		mngUserMenuDAO.deleteMngMenu(menuNo);
	}


	public List<MngMenuVO> selectMngMenuExceptList(Map<String, Object> paramMap) throws Exception {
		return mngUserMenuDAO.selectMngMenuExceptList(paramMap);
	}


	public int selectLowerMenuCheck(Map<String, Object> paramMap) throws Exception {
		return mngUserMenuDAO.selectLowerMenuCheck(paramMap);
	}


	public void updateLowerMenuUseYn(MngMenuVO mngMenuVO) {
		mngUserMenuDAO.updateLowerMenuUseYn(mngMenuVO);
	}


	public int updateMenuUseYn(MngMenuVO mngMenuVO) throws Exception {
		return mngUserMenuDAO.updateMenuUseYn(mngMenuVO);
	}

	@SuppressWarnings("unchecked")
	public List<MngMenuVO> selectMngMenuAuthList(int authrtNo, String authrtYn) throws Exception {
		Map paramMap = new HashMap();
		paramMap.put("authrtNo", authrtNo);
		paramMap.put("authrtYn", authrtYn);
		return mngUserMenuDAO.selectMngMenuAuthList(paramMap);
	}

	//전체관리자 메뉴
	public List<MngMenuVO> selectMngMenuAuthListForSuperAdmin() throws Exception {
		return mngUserMenuDAO.selectMngMenuAuthListForSuperAdmin();
	}


	public String selectMenuNmFromUrl(String menuUrl) throws Exception {
		return mngUserMenuDAO.selectMenuNmFromUrl(menuUrl);
	}


	public MngMenuVO selectMenuInfoFromUrl(String menuUrl) throws Exception {
		return mngUserMenuDAO.selectMenuInfoFromUrl(menuUrl);
	}


	public int updateMngMenuNm(Map<String, Object> paramMap) {
		return mngUserMenuDAO.updateMngMenuNm(paramMap);
	}


	public void moveMngMenu(MngMenuVO mngMenuVO, String sortSeq) throws Exception {

		String[] sortedMenuNos = sortSeq.split(",");

		for(int i=0; i<sortedMenuNos.length; i++) {
			log.debug(" ## menu sort  " + sortedMenuNos[i] + " index " + i);
			mngMenuVO.setSortNo(i+1);
			mngMenuVO.setMenuNo(NumberUtils.toInt(sortedMenuNos[i]));
			mngUserMenuDAO.updateMngMenuPosition(mngMenuVO);
		}

	}

}
