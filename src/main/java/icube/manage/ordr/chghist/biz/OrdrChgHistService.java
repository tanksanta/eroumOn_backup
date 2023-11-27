package icube.manage.ordr.chghist.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.manage.ordr.dtl.biz.OrdrDtlVO;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Service("ordrChgHistService")
public class OrdrChgHistService extends CommonAbstractServiceImpl {

	@Resource(name="ordrChgHistDAO")
	private OrdrChgHistDAO ordrChgHistDAO;

	@Autowired
	private MngrSession mngrSession;

	public List<OrdrChgHistVO> selectOrdrChgHistList(String ordrDtlNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ordrDtlNo", ordrDtlNo);

		return this.selectOrdrChgHistList(paramMap);
	}

	public List<OrdrChgHistVO> selectOrdrChgHistList(Map<String, Object> paramMap) throws Exception {
		return ordrChgHistDAO.selectOrdrChgHistList(paramMap);
	}

	public OrdrChgHistVO selectOrdrChgHist(Map<String, Object> paramMap) throws Exception {
		return ordrChgHistDAO.selectOrdrChgHist(paramMap);
	}

	public void insertOrdrChgHist(OrdrChgHistVO ordrChgHistVO) throws Exception {
		ordrChgHistDAO.insertOrdrChgHist(ordrChgHistVO);
	}

	// public void deleteOrdrChgHist(int chgNo) throws Exception {
	// 	ordrChgHistDAO.deleteOrdrChgHist(chgNo);
	// }


	/**
	 * 변경내역 기록
	 * @param ordrNo : 주문번호
	 * @param ordrDtlNos : 주문상세번호
	 * @param resnTy : 사유타입
	 * @param resn : 사유
	 * @param sttsTy : 상태타입
	 * @throws Exception : pass
	 */
	public void insertOrdrSttsChgHist(int ordrNo, int ordrDtlNo, String resnTy, String resn, String sttsTy) throws Exception {
		OrdrChgHistVO chgHistVO = new OrdrChgHistVO();
		chgHistVO.setOrdrNo(ordrNo);
		chgHistVO.setOrdrDtlNo(ordrDtlNo);
		chgHistVO.setChgStts(sttsTy);
		chgHistVO.setResnTy(resnTy);
		chgHistVO.setResn(resn);
		chgHistVO.setRegUniqueId(mngrSession.getUniqueId());
		chgHistVO.setRegId(mngrSession.getMngrId());
		chgHistVO.setRgtr(mngrSession.getMngrNm());
		this.insertOrdrChgHist(chgHistVO);
	}

	/**
	 * 변경내역 기록
	 */
	public void insertOrdrSttsChgHist(OrdrChgHistVO chgHistVO) throws Exception {
		this.insertOrdrChgHist(chgHistVO);
	}

}
