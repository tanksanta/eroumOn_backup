package icube.manage.sysmng.mngr.biz;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.RandomUtils;
import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.Base64Utils;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.sysmng.menu.biz.MngMenuService;
import icube.manage.sysmng.menu.biz.MngMenuVO;

@Service("mngrService")
@SuppressWarnings({"rawtypes","unchecked"})
public class MngrService extends CommonAbstractServiceImpl {

	@Resource(name = "mngrDAO")
	private MngrDAO mngrDAO;

	@Resource(name="mngMenuService")
	private MngMenuService mngMenuService;

	@Value("#{props['Globals.Manager.cookie.hours']}")
	private int mngrCookieHours;

	@Autowired
	private MngrSession mngrSession;

	public CommonListVO selectMngrListVO(CommonListVO listVO) throws Exception {
		return mngrDAO.selectMngrListVO(listVO);
	}

	/*
	public List selectMngrList(Map paramMap) throws Exception {
		return mngrDAO.selectMngrList(paramMap);
	}
	*/

	public List menuMngrListJson(Map paramMap) throws Exception {

		List oldResultList = mngrDAO.selectMenuMngrList(paramMap);
		List resultList = new ArrayList();
		for (int i = 0; i < oldResultList.size(); i++) {
			Map mngrMap = (Map) oldResultList.get(i);
			mngrMap.put("authTyNm", CodeMap.MNGR_AUTH_TY.get(mngrMap.get("authTy"))); // 맘대로 설정
			resultList.add(mngrMap);
		}
		return resultList;
	}

	public void insertMngr(MngrVO mngrVO) throws Exception {
		mngrDAO.insertMngr(mngrVO);
	}

	public void updateMngr(MngrVO mngrVO) throws Exception {
		mngrDAO.updateMngr(mngrVO);

		if(mngrVO.getNewPswd() != null && !mngrVO.getNewPswd().equals("")) {
			mngrDAO.updateFailedLoginCountReset(mngrVO);
		}
	}

	public MngrVO selectMngrById(Map paramMap) throws Exception {
		return mngrDAO.selectMngr(paramMap);
	}

	public MngrVO selectMngrByUniqueId(String uniqueId) throws Exception {
		return mngrDAO.selectMngrByUniqueId(uniqueId);
	}

	public String selectMngrPwCheck(String mngrId, String mngrPassword) throws Exception {
		return mngrDAO.selectMngrPwCheck(mngrId, mngrPassword);
	}

	public Map mngrIdCheck(Map paramMap) throws Exception {
		return mngrDAO.mngrIdCheck(paramMap);
	}

	public int selectFailedLoginCount(MngrVO mngrVO) {
		return mngrDAO.selectFailedLoginCount(mngrVO);
	}

	public int updateFailedLoginCountUp(MngrVO mngrVO) {
		return mngrDAO.updateFailedLoginCountUp(mngrVO);
	}

	public int updateFailedLoginCountReset(MngrVO mngrVO) {
		return mngrDAO.updateFailedLoginCountReset(mngrVO);
	}

	public int updateMngrPswd(MngrVO mngrVO) throws Exception {
		return mngrDAO.updateMngrPswd(mngrVO);
	}

	public void updateRecentLgnDt(Map<String, Object> paramMap) throws Exception {
		mngrDAO.updateRecentLgnDt(paramMap);
	}

	public int getFailedLoginCountWithCountUp(MngrVO mngrVO) {
		updateFailedLoginCountUp(mngrVO);
		return selectFailedLoginCount(mngrVO);
	}

	private List<MngMenuVO> makeMngMenuList(Map<String, List<MngMenuVO>> mngMenuListMap, String key) {

		List<MngMenuVO> mngMenuList = new ArrayList<MngMenuVO>();
		List<MngMenuVO> mngMenuList1 = mngMenuListMap.get(key);

		if (mngMenuListMap != null) {
			for(MngMenuVO mngMenuVo : mngMenuList1) {
				mngMenuList.add(mngMenuVo);
				if(mngMenuListMap.containsKey(""+mngMenuVo.getMenuNo())) {
					List<MngMenuVO> mngMenuList2 = makeMngMenuList(mngMenuListMap, ""+mngMenuVo.getMenuNo());
					mngMenuList.addAll(mngMenuList2);
				}
			}
		}
		return mngMenuList;
	}

	public void setMngrSession(MngrVO mngrVO) throws Exception {

		mngrSession.setUniqueId(mngrVO.getUniqueId());
		mngrSession.setMngrId(mngrVO.getMngrId());
		mngrSession.setMngrNm(mngrVO.getMngrNm());
		mngrSession.setProflImg(mngrVO.getProflImg());
		mngrSession.setAuthrtTy(mngrVO.getAuthrtTy());
		mngrSession.setAuthrtTyNm(CodeMap.MNGR_AUTH_TY.get(mngrVO.getAuthrtTy()));
		mngrSession.setAuthrtNo(mngrVO.getAuthrtNo());
		mngrSession.setAuthrtNm(mngrVO.getAuthrtNm());
		mngrSession.setRecentLgnDt(mngrVO.getRecentLgnDt());

		Map<String, List<MngMenuVO>> mngMenuListMap = new HashMap<String, List<MngMenuVO>>();

		List<MngMenuVO> mngMenuList = null;

		if("1".equals(mngrVO.getAuthrtTy())) {
			mngMenuList = mngMenuService.selectMngMenuAuthListForSuperAdmin();
		} else {
			mngMenuList = mngMenuService.selectMngMenuAuthList(mngrVO.getAuthrtNo(), "Y");
		}

		for(int i=0; i<mngMenuList.size(); i++) {
			String upMenuNo = ""+mngMenuList.get(i).getUpMenuNo();
			List<MngMenuVO> tmpList = mngMenuListMap.containsKey(upMenuNo) ? mngMenuListMap.get(upMenuNo) : new ArrayList<MngMenuVO>();
			tmpList.add(mngMenuList.get(i));
			mngMenuListMap.put(upMenuNo, tmpList);
		}

		mngMenuList = makeMngMenuList(mngMenuListMap, "1");

		// 관리자 메뉴 설정 -- 상위메뉴일 경우 하위 메뉴 중 첫번째의 링크를 가지고 있는 메뉴로 연결
		for(int i=0; i<mngMenuList.size(); i++) {
			String dspyMenuUrl = mngMenuList.get(i).getMenuUrl();
			if("3".equals(mngMenuList.get(i).getMenuTy())) {
				int menuNo = mngMenuList.get(i).getMenuNo();
				for(int j=i+1; j<mngMenuList.size(); j++) {
					// 내 자식이 아니면 종료
					if(menuNo!=mngMenuList.get(j).getUpMenuNo()) {
						break;
					}
					String menuUrl = mngMenuList.get(j).getMenuUrl();
					if( EgovStringUtil.isNotEmpty(menuUrl) && menuUrl.startsWith("/") ) {
						dspyMenuUrl = menuUrl;
						break;
					}
				}
			}
			mngMenuList.get(i).setDspyMenuUrl(dspyMenuUrl);
		}

		mngrSession.setMngMenuList(mngMenuList);
		mngrSession.setLoginCheck(true);

	}

	public void clearMngrCookie(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 관리자 쿠키 설정시간이 0일 경우 쿠키로그인을 사용하지 않음
		if(mngrCookieHours > 0) {
			Cookie[] cookies = request.getCookies();
			for(Cookie cookie : cookies) {
				if(cookie.getName().startsWith("_eroum_manager_")) {
					cookie = new Cookie(cookie.getName(), null);
					cookie.setPath("/");
					cookie.setMaxAge(0);
					cookie.setSecure(true);
					response.addCookie(cookie);
				}
			}
		}
	}

	public void setMngrCookie(MngrVO mngrVO, HttpServletResponse response) throws Exception {
		// 관리자 쿠키 설정시간이 0일 경우 쿠키로그인을 사용하지 않음
		if(mngrCookieHours > 0) {
			String rand = Base64Utils.encodeToString(RandomUtils.nextBytes(3));
			rand = rand.replace("/", "!").replace(" ", "-"); // 쿠키 이름 오류 수정
			String value = RandomUtils.nextInt(111, 9876) + "!!" + mngrVO.getMngrId() + "!!" + rand;
			Cookie cookie = new Cookie("_eroum_manager_"+rand+"_", value);
			cookie.setPath("/");
			cookie.setMaxAge(60 * 60 * mngrCookieHours); // 관리자 쿠키 설정시간만큼 유지됨
			cookie.setSecure(true);
			response.addCookie(cookie);
		}
	}

	public boolean getLoginInfoFromCookies(HttpServletRequest request) {
		boolean result = false;
		// 관리자 쿠키 설정시간이 0일 경우 쿠키로그인을 사용하지 않음
		if(mngrCookieHours > 0) {
			Cookie[] cookies = request.getCookies();
			if(cookies!=null && cookies.length>0) {
				for(Cookie cookie : cookies) {
					if(cookie.getName().startsWith("_eroum_manager_")) {
						String dough = cookie.getValue();
						String sugar = cookie.getName();
						sugar = sugar.substring(16).replace("_", "");

						String decData = dough;

						log.debug("cookie value : " + decData);
						for(String t : decData.split("!!")) log.debug(t);

						if(EgovStringUtil.isNotEmpty(decData)) {
							String[] data = decData.split("!!");
							if(sugar.equals(data[2])) {

								Map<String, Object> map = new HashMap<String, Object>();
								map.put("mngrId", data[1]);
								try {
									MngrVO mngrVO = selectMngrById(map);
									if(mngrVO!=null) {
										setMngrSession(mngrVO);
										result = true;
									}
								} catch(Exception e) {
									log.debug(" ## cookie base auto login failed : " + e.getMessage());
								}
							}
						}
						break;
					}
				}
			}
		}
		return result;
	}

	public void updateMngrProflImg(MngrVO mngrVO) throws Exception {
		mngrDAO.updateMngrProflImg(mngrVO);
	}
}
