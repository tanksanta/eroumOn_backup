package icube.manage.promotion.point.biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;
import icube.manage.mbr.mbr.biz.MbrDAO;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Service("pointMngService")
public class PointMngService extends CommonAbstractServiceImpl {

	@Resource(name="pointMngDAO")
	private PointMngDAO pointMngDAO;

	@Resource(name="mbrPointDAO")
	private MbrPointDAO mbrPointDAO;

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
	public CommonListVO pointMngListVO(CommonListVO listVO) throws Exception {
		return pointMngDAO.pointMngListVO(listVO);
	}

	/**
	 * 포인트 조회
	 * @param pointMngNo
	 * @return
	 * @throws Exception
	 */
	public PointMngVO selectPointMng(int pointMngNo) throws Exception {
		return pointMngDAO.selectPointMng(pointMngNo);
	}

	/**
	 * 포인트 등록
	 * @param pointMngVO
	 * @throws Exception
	 */
	public void insertPointMng(PointMngVO pointMngVO) throws Exception {
		pointMngDAO.insertPointMng(pointMngVO);
	}

	/**
	 * 포인트 적립 차감
	 * 프로세스 :
	 * 1. 포인트 관리 TB INSERT
	 * 2. 회원 포인트(포인트 대상) TB INSERT  , 회원 포인트 -> 회원 포인트 누계 +- 적립&&차감 포인트
	 * 3. 회원 포인트 누계 업데이트
	 */
	public void insertPoint(PointMngVO pointMngVO, String[] arrUniqueId) throws Exception {

		// 1. 포인트 관리
		this.insertPointMng(pointMngVO);

		// 2. 회원 포인트
		MbrPointVO mbrPointVO = new MbrPointVO();
		mbrPointVO.setPointMngNo(pointMngVO.getPointMngNo());

		mbrPointVO.setPointSe(pointMngVO.getPointSe());
		mbrPointVO.setPointCn(pointMngVO.getPointCn());
		mbrPointVO.setPoint(pointMngVO.getPoint());

		// 3. 관리자 정보
		mbrPointVO.setRegId(mngrSession.getMngrId());
		mbrPointVO.setRegUniqueId(mngrSession.getUniqueId());
		mbrPointVO.setRgtr(mngrSession.getMngrNm());

		// 4. 선택 회원
		for(int i=0; i < arrUniqueId.length; i++) {
			mbrPointVO.setUniqueId(arrUniqueId[i]);
			mbrPointDAO.insertMbrPoint(mbrPointVO);
		}

	}

	public List<PointMngVO> selectPointMngListAll(Map<String, Object> paramMap) throws Exception {
		return pointMngDAO.selectPointMngListAll(paramMap);
	}
}