package icube.manage.mbr.mbr.biz;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.manage.promotion.mlg.biz.MbrMlgService;
import icube.manage.promotion.mlg.biz.MbrMlgVO;
import icube.manage.promotion.point.biz.MbrPointService;
import icube.manage.promotion.point.biz.MbrPointVO;
import icube.market.mbr.biz.MbrSession;

@Service("mbrPrtcrService")
public class MbrPrtcrService  extends CommonAbstractServiceImpl {

	@Resource(name="mbrPrtcrDAO")
	private MbrPrtcrDAO mbrPrtcrDAO;

	@Resource(name="mbrService")
	private MbrService mbrService;

	@Resource(name = "mbrPointService")
	private MbrPointService mbrPointService;

	@Resource(name = "mbrMlgService")
	private MbrMlgService mbrMlgService;

	@Autowired
	private MbrSession mbrSession;

	/**
	 * 검색회원 > 검색회원 가족회원 상태값 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes","unchecked"})
	public List<MbrPrtcrVO> selectPrtcrMbrList(Map<String,Object> paramMap) throws Exception{

		List<MbrVO> mbrList = mbrService.selectMbrListAll(paramMap);

		List<MbrPrtcrVO> prtcrList = new ArrayList<>();

		for(int i=0; i < mbrList.size(); i++) {
			Map newParam = new HashMap();
			newParam.put("srchPrtcrUniqueId", mbrList.get(i).getUniqueId());
			newParam.put("srchOwnUniqueId", paramMap.get("srchOwnUniqueId"));

			MbrPrtcrVO MbrPrtcrVO = this.selectPrtcrByMap(newParam);

			prtcrList.add(MbrPrtcrVO);
		}

		return prtcrList;
	}

	public MbrPrtcrVO selectPrtcrByMap (Map<String, Object> paramMap) throws Exception {
		return mbrPrtcrDAO.selectPrtcrByMap(paramMap);
	}

	/**
	 * 가족회원 초대
	 * @param mbrPrtcrVO
	 * @throws Exception
	 */
	public void insertPrtcr(MbrPrtcrVO mbrPrtcrVO) throws Exception {
		mbrPrtcrDAO.insertPrtcr(mbrPrtcrVO);
	}

	/**
	 * 가족회원 카운트
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectPrtcrCount(Map<String, Object> paramMap) throws Exception {
		return mbrPrtcrDAO.selectPrtcrCount(paramMap);
	}

	public List<MbrPrtcrVO> selectPrtcrListByMap(Map<String, Object> paramMap) throws Exception{
		return mbrPrtcrDAO.selectPrtcrListByMap(paramMap);
	}

	/**
	 * 가족회원 승인& 거부 처리
	 * @param prtcrMbrNo
	 * @throws Exception
	 */
	public void updateReqTy(MbrPrtcrVO mbrPrtcrVO) throws Exception {
		mbrPrtcrDAO.updateReqTy(mbrPrtcrVO);
	}

	public MbrPrtcrVO selectMbrPrtcr(Map <String, Object>paramMap) throws Exception {
		return mbrPrtcrDAO.selectMbrPrtcr(paramMap);
	}

	/**
	 * 가족 회원 상대방 조회
	 * @param playList
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes","unchecked"})
	public List<MbrPrtcrVO> selectAppListByList(List<MbrPrtcrVO> playList) throws Exception {

		List<MbrPrtcrVO> mbrList = new ArrayList<>();
		Map paramMap = new HashMap();

		// 발신자, 수신자 판별 loop
		for(int i=0; i < playList.size(); i++) {
			String own = playList.get(i).getUniqueId();
			String prtcr = playList.get(i).getPrtcrUniqueId();

			//1. 발신자가 자신
			if(own.equals(mbrSession.getUniqueId())) {
				paramMap.put("srchUniqueId", prtcr);
				paramMap.put("appTy", "send");
			}else {
				//2. 수신자가 자신
				paramMap.put("srchUniqueId", own);
				paramMap.put("appTy", "rcve");
			}

			// 3. 조회 && 회원 값 setting
			MbrVO mbrVO = mbrService.selectMbr(paramMap);
			playList.get(i).setMblTelno(mbrVO.getMblTelno());
			playList.get(i).setMbrId(mbrVO.getMbrId());
			playList.get(i).setMbrNm(mbrVO.getMbrNm());

			//TODO 메소드 수정
			paramMap.put("srchUniqueId", mbrVO.getUniqueId());
			MbrPointVO mbrPointVO = mbrPointService.selectMbrPoint(paramMap);
			MbrMlgVO MbrMlgVO = mbrMlgService.selectMbrMlg(paramMap);
			if(mbrPointVO != null) {
				playList.get(i).setMbrPoint(mbrPointVO.getPointAcmtl());
			}else {
				playList.get(i).setMbrPoint(0);
			}
			if(MbrMlgVO != null) {
				playList.get(i).setMbrMlg(MbrMlgVO.getMlgAcmtl());
			}else {
				playList.get(i).setMbrMlg(0);
			}
			playList.get(i).setProflImg(mbrVO.getProflImg());

			// 4. 송, 수신 값 setting
			if(paramMap.get("appTy").equals("send")) {
				playList.get(i).setAppTy("send");
			}else {
				playList.get(i).setAppTy("rcve");
			}

			mbrList.add(playList.get(i));
		}

		return mbrList;
	}

	/**
	 * 가족회원 삭제
	 * @param paramMap
	 * @throws Exception
	 */
	public void deleteFml(Map<String, Object> paramMap) throws Exception {
		mbrPrtcrDAO.deleteFml(paramMap);
	}

	/**
	 * 가족회원 리스트
	 * @param paramMap
	 * @return
	 */
	public List<MbrPrtcrVO> selectPrtcrListByUniqueId(Map<String, Object> paramMap) throws Exception {
		return mbrPrtcrDAO.selectPrtcrListByUniqueId(paramMap);
	}

}
