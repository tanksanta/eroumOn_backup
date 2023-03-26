package icube.manage.sysmng.menu.biz;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("mngMenuDAO")
public class MngMenuDAO extends CommonAbstractMapper {

	public List selectMngMenuList() throws Exception {
		return selectList("sysmng.menu.selectMngMenuList");
	}

	public List selectMngMenuList(Map<String, Object> paramMap) throws Exception {
		return selectList("sysmng.menu.selectMngMenuList", paramMap);
	}

	public List<MngMenuVO> selectChildMngMenuList(Map<String, Object> paramMap) throws Exception {
		return selectList("sysmng.menu.selectChildMngMenuList", paramMap);
	}

	public MngMenuVO selectMngMenu(int menuNo) throws Exception {
		return (MngMenuVO)selectOne("sysmng.menu.selectMngMenu", menuNo);
	}

	public void insertMngMenu(MngMenuVO mngMenuVO) throws Exception {
		insert("sysmng.menu.insertMngMenu", mngMenuVO);
	}

	public void updateMngMenu(MngMenuVO mngMenuVO) throws Exception {
		update("sysmng.menu.updateMngMenu", mngMenuVO);
	}

	public void deleteMngMenu(int menuNo) throws Exception {
		delete("sysmng.menu.deleteMngMenu", menuNo);
	}

	public List<MngMenuVO> selectMngMenuExceptList(Map paramMap) throws Exception {
		return selectList("sysmng.menu.selectMngMenuExceptList", paramMap);
	}

	public Integer selectLowerMenuCheck(Map paramMap) throws Exception {
		return (Integer)selectOne("sysmng.menu.selectLowerMenuCheck", paramMap);
	}

	public void updateLowerMenuUseYn(MngMenuVO mngMenuVO) {
		update("sysmng.menu.updateLowerMenuUseYn", mngMenuVO);
	}

	public int updateMenuUseYn(MngMenuVO mngMenuVO) throws Exception {
		return update("sysmng.menu.updateMenuUseYn", mngMenuVO);
	}

	public int updateMngMenuPosition(MngMenuVO mngMenuVO) throws Exception {
		return update("sysmng.menu.updateMngMenuPosition", mngMenuVO);
	}

	public List<MngMenuVO> selectMngMenuAuthList(Map paramMap) throws Exception {
		return selectList("sysmng.menu.selectMngMenuAuthList", paramMap);
	}

	// 전체관리자 메뉴
	public List<MngMenuVO> selectMngMenuAuthListForSuperAdmin() throws Exception {
		return selectList("sysmng.menu.selectMngMenuAuthListForSuperAdmin");
	}

	public String selectMenuNmFromUrl(String menuUrl) throws Exception {
		String result="";
		Map<String,String> map = selectOne("sysmng.menu.selectMenuNmFromUrl", menuUrl);
		if( map!=null ){
			String menuNm = EgovStringUtil.null2void(map.get("menuNm"));
			result+= map.get("upperMenuNm");
			if( !"".equals(result) && !"".equals(menuNm) ){ result += ">"; }
			result += menuNm;
		}
		return result;
	}

	public MngMenuVO selectMenuInfoFromUrl(String menuUrl) throws Exception {
		return (MngMenuVO)selectOne("sysmng.menu.selectMenuInfoFromUrl", menuUrl);
	}

	public int updateMngMenuNm(Map<String, Object> paramMap) {
		return update("sysmng.menu.updateMngMenuNm", paramMap);
	}
}
