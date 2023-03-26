package icube.manage.sysmng.auth.biz;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.util.NumberUtil;
import icube.common.util.StringUtil;
import icube.common.vo.CommonListVO;

@Service("mngAuthrtService")
public class MngAuthrtService extends CommonAbstractServiceImpl {

	@Resource(name = "mngAuthrtDAO")
	private MngAuthrtDAO mngAuthrtDAO;


	public CommonListVO mngAuthrtListVO(CommonListVO listVO) throws Exception {
		return mngAuthrtDAO.selectMngAuthrtListVO(listVO);
	}


	public MngAuthrtVO selectMngAuthrt(int authrtNo) throws Exception {
		return mngAuthrtDAO.selectMngAuthrt(authrtNo);
	}


	public void insertMngAuthrt(MngAuthrtVO mngAuthrtVO) throws Exception {
		mngAuthrtDAO.insertMngAuthrt(mngAuthrtVO);
	}


	public void updateMngAuthrt(MngAuthrtVO mngAuthrtVO) throws Exception {
		mngAuthrtDAO.updateMngAuthrt(mngAuthrtVO);
	}


	public void deleteMngAuthrt(int authrtNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("authrtNo", authrtNo);
		// 권한 삭제
		mngAuthrtDAO.deleteMngAuthrt(paramMap);
		// 메뉴 삭제
		mngAuthrtDAO.deleteMngAuthrtMenu(paramMap);
	}


	public void executeMngAuthrtMenu(int authrtNo, String[] arrMenuNo)
			throws Exception {
		if (arrMenuNo != null) {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("authrtNo", authrtNo);
			mngAuthrtDAO.deleteMngAuthrtMenu(paramMap);

			for (int i = 0; i < arrMenuNo.length; i++) {
				MngAuthrtMenuVO mngAuthrtMenuVO = new MngAuthrtMenuVO();
				mngAuthrtMenuVO.setAuthrtNo(authrtNo);

				String[] splitArrMenuNo = arrMenuNo[i].split("[|]");
				mngAuthrtMenuVO.setMenuNo(EgovStringUtil
						.string2integer(splitArrMenuNo[0]));

				if (EgovStringUtil
						.countOf(arrMenuNo[i].toLowerCase(), "inqire") > 0) {
					mngAuthrtMenuVO.setInqYn("Y");
				}
				if (EgovStringUtil
						.countOf(arrMenuNo[i].toLowerCase(), "writng") > 0) {
					mngAuthrtMenuVO.setWrtYn("Y");
				}
				if (EgovStringUtil.equals(mngAuthrtMenuVO.getInqYn(), "Y")
						|| EgovStringUtil.equals(mngAuthrtMenuVO.getWrtYn(),
								"Y")) {
					mngAuthrtDAO.insertMngAuthrtMenu(mngAuthrtMenuVO);
				}
			}
		}
	}

	public boolean diffMngAuthrtMenu(int authrtNo, String authMngMenus) throws Exception {

		if (authMngMenus != null) {

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("authrtNo", authrtNo);

			String authrtMenuGroup = mngAuthrtDAO.selectMngAuthrtMenuGroup(paramMap);


			if(authrtMenuGroup == null) {
				if(authMngMenus.isEmpty()) {
					return false;
				} else {
					return true;
				}
			}

			List<String> authrtMenuList = new ArrayList<String>(Arrays.asList(authrtMenuGroup.split(",")));

			String[] arrAuthMngMenus = authMngMenus.split(",");

			for(String menuNo : arrAuthMngMenus) {
				if(authrtMenuList.contains(menuNo)) {
					authrtMenuList.remove(menuNo);
				} else {
					return true;
				}
			}
			if(authrtMenuList.size()>0) {
				return true;
			}
		}
		return false;
	}

	public void executeMngAuthrtMenu(int authrtNo, String authMngMenus)
			throws Exception {
		if (authMngMenus != null) {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("authrtNo", authrtNo);
			mngAuthrtDAO.deleteMngAuthrtMenu(paramMap);

			String[] arrAuthMngMenus = authMngMenus.split(",");

			for(String authMenuNo : arrAuthMngMenus) {
				if(StringUtil.isNotEmpty(authMenuNo)) {
					int menuNo = NumberUtil.nullToInt(authMenuNo, 0);
					if(menuNo>0) {
						MngAuthrtMenuVO mngAuthrtMenuVO = new MngAuthrtMenuVO();
						mngAuthrtMenuVO.setAuthrtNo(authrtNo);
						mngAuthrtMenuVO.setMenuNo(menuNo);
						mngAuthrtMenuVO.setAuthrtYn("Y");
						mngAuthrtDAO.insertMngAuthrtMenu(mngAuthrtMenuVO);
					}
				}
			}
		}
	}


	public List<MngAuthrtVO> mngAuthrtListAll() throws Exception {
		return mngAuthrtDAO.selectMngAuthrtListAll();
	}
}
