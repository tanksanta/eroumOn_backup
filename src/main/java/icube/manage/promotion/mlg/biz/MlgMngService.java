package icube.manage.promotion.mlg.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;
import icube.manage.mbr.mbr.biz.MbrDAO;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Service("mlgMngService")
public class MlgMngService extends CommonAbstractServiceImpl {

	@Resource(name="mlgMngDAO")
	private MlgMngDAO mlgMngDAO;

	@Resource(name="mbrMlgDAO")
	private MbrMlgDAO mbrMlgDAO;

	@Resource(name="mbrDAO")
	private MbrDAO mbrDAO;

	@Autowired
	private MngrSession mngrSession;

	/**
	 * 목록
	 * @param listVO
	 * @return
	 * @throws Exception
	 */
	public CommonListVO mlgMngListVO(CommonListVO listVO) throws Exception {
		return mlgMngDAO.mlgMngListVO(listVO);
	}

	/**
	 * 마일리지 조회
	 * @param mlgMngNo
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked","rawtypes"})
	public MlgMngVO selectMlgMng(int mlgMngNo) throws Exception {
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("srchMlgMngNo", mlgMngNo);
		return mlgMngDAO.selectMlgMng(paramMap);
	}

	/**
	 * 마일리지 등록
	 * @param mlgMngVO
	 * @throws Exception
	 */
	public void insertMlgMng(MlgMngVO mlgMngVO) throws Exception {
		mlgMngDAO.insertMlgMng(mlgMngVO);
	}

	/**
	 * 마일리지 회원 적용
	 * @param mlgMngVO
	 * @param arrUniqueId (선택 회원)
	 * @throws Exception
	 */
	public void insertMng(MlgMngVO mlgMngVO, String[] arrUniqueId) throws Exception {
		// 1. 마일리지 정의
		this.insertMlgMng(mlgMngVO);

		// 2. 회원 마일리지
		MbrMlgVO mbrMlgVO = new MbrMlgVO();
		mbrMlgVO.setMlgMngNo(mlgMngVO.getMlgMngNo());

		mbrMlgVO.setMlgSe(mlgMngVO.getMlgSe());
		mbrMlgVO.setMlgCn(mlgMngVO.getMlgCn());
		mbrMlgVO.setMlg(mlgMngVO.getMlg());
		mbrMlgVO.setGiveMthd("MNG");

		// 3. 관리자 정보
		mbrMlgVO.setRegId(mngrSession.getMngrId());
		mbrMlgVO.setRegUniqueId(mngrSession.getUniqueId());
		mbrMlgVO.setRgtr(mngrSession.getMngrNm());

		// 4. 선택 회원
		for(int i=0; i < arrUniqueId.length; i++) {
			mbrMlgVO.setUniqueId(arrUniqueId[i]);
			mbrMlgDAO.insertMbrMlg(mbrMlgVO);
		}
	}

	public List<MlgMngVO> selectMlgMngListAll(Map<String, Object> paramMap) throws Exception {
		return mlgMngDAO.selectMlgMngListAll(paramMap);
	}

}