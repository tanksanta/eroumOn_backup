package icube.manage.mbr.mbr.biz;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;
import icube.manage.mbr.recipter.biz.RecipterInfoDAO;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Service("mbrMngInfoService")
public class MbrMngInfoService extends CommonAbstractServiceImpl {

	@Resource(name="mbrMngInfoDAO")
	private MbrMngInfoDAO mbrMngInfoDAO;

	@Resource(name="mbrDAO")
	private MbrDAO mbrDAO;

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "recipterInfoDAO")
	private RecipterInfoDAO recipterInfoDAO;

	@Autowired
	private MngrSession mngrSession;

	public CommonListVO selectMbrMngInfoListVO(CommonListVO listVO) throws Exception {
		return mbrMngInfoDAO.selectMbrMngInfoListVO(listVO);
	}

	public MbrMngInfoVO selectMbrMngInfo(Map<String, Object> paramMap) throws Exception {
		return mbrMngInfoDAO.selectMbrMngInfo(paramMap);
	}

	public void insertMbrMngInfo(Map<String, String> reqMap) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();

		MbrVO mbrVO = mbrService.selectMbrByUniqueId((String)reqMap.get("uniqueId"));
		MbrMngInfoVO mbrMngInfoVO = new MbrMngInfoVO();

		mbrMngInfoVO.setUniqueId(reqMap.get("uniqueId"));
		mbrMngInfoVO.setMngTy(reqMap.get("mngTy"));
		mbrMngInfoVO.setMngSe(reqMap.get("mngSe"));
		mbrMngInfoVO.setResnCd(reqMap.get("resnCd"));
		mbrMngInfoVO.setMngrMemo(reqMap.get("mngrMemo"));
		mbrMngInfoVO.setRegUniqueId(mngrSession.getUniqueId());
		mbrMngInfoVO.setRegId(mngrSession.getMngrId());
		mbrMngInfoVO.setRgtr(mngrSession.getMngrNm());
		String uniqueId = reqMap.get("uniqueId");

		if(reqMap.get("bgng") != null) {
			if(!reqMap.get("bgng").isEmpty()) {
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				Date bgng = formatter.parse(reqMap.get("bgng"));
				Date end = formatter.parse(reqMap.get("end"));

				mbrMngInfoVO.setStopBgngYmd(bgng);
				mbrMngInfoVO.setStopEndYmd(end);
			}
		}

		mbrMngInfoDAO.insertMbrMngInfo(mbrMngInfoVO);

		// 블랙리스트 전환
		if(mbrMngInfoVO.getMngTy().equals("BLACK") && !mbrMngInfoVO.getMngSe().equals("NONE")) {
			paramMap.clear();
			paramMap.put("mberSttus", "BLACK");
			paramMap.put("uniqueId", mbrMngInfoVO.getUniqueId());
			mbrService.updateMberSttus(paramMap);

			// 포인트, 마일리지 reset
			paramMap.clear();
			paramMap.put("srchUniqueId", mbrMngInfoVO.getUniqueId());
			paramMap.put("mberStts", "BLACK");
			mbrService.resetMemberShip(paramMap);
		}

		// 블랙리스트 해제
		if(mbrMngInfoVO.getMngTy().equals("BLACK") && mbrMngInfoVO.getMngSe().equals("NONE")) {
			paramMap.clear();
			paramMap.put("mberSttus", "NORMAL");
			paramMap.put("uniqueId", mbrMngInfoVO.getUniqueId());
			mbrService.updateMberSttus(paramMap);

		}

		//직권탈퇴
		if(reqMap.get("mngTy").equals("AUTH")) {

			paramMap.clear();
			paramMap.put("srchUniqueId", uniqueId);
			paramMap.put("whdwlResn", (String)reqMap.get("resnCd"));
			paramMap.put("whdwlEtc", (String)reqMap.get("mngrMemo"));
			paramMap.put("whdwlTy", "AUTHEXIT");


			// 포인트, 마일리지 reset
			paramMap.clear();
			paramMap.put("srchUniqueId", uniqueId);
			paramMap.put("mberStts", "EXIT");
			mbrService.resetMemberShip(paramMap);

			// 회원 정보 삭제
			mbrDAO.updateExitMbr(paramMap);

			// 수급자 정보 삭제
			if(mbrVO != null) {
				if(mbrVO.getRecipterYn().equals("Y")) {
					recipterInfoDAO.deleteRecipter(paramMap);
				}
			}

			// 회원 관리 정보 삭제
			mbrMngInfoDAO.deleteExitMbr(paramMap);
		}

	}

	public void updateMbrMngInfo(MbrMngInfoVO mbrMngInfoVO) throws Exception {
		mbrMngInfoDAO.updateMbrMngInfo(mbrMngInfoVO);
	}

	public void deleteMbrMngInfo(int mbrMngInfoNo) throws Exception {
		mbrMngInfoDAO.deleteMbrMngInfo(mbrMngInfoNo);
	}

	public List<MbrMngInfoVO> selectMbrMngInfoListAll(Map<String, Object> paramMap) throws Exception{
		return mbrMngInfoDAO.selectMbrMngInfoListAll(paramMap);
	}

	public List<MbrMngInfoVO> selectMbrMngInfoListBySort(Map<String, Object> paramMap) throws Exception {
		return mbrMngInfoDAO.selectMbrMngInfoListBySort(paramMap);
	}

	public void insertMbrMngInfo(MbrMngInfoVO newInfoVO) throws Exception {
		mbrMngInfoDAO.insertMbrMngInfo(newInfoVO);
	}

}