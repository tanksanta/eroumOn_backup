package icube.manage.ordr.ordr.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;
import icube.manage.ordr.dtl.biz.OrdrDtlService;

@Service("ordrService")
public class OrdrService extends CommonAbstractServiceImpl {

	@Resource(name="ordrDAO")
	private OrdrDAO ordrDAO;

	@Resource(name = "ordrDtlService")
	private OrdrDtlService ordrDtlService;

	/**
	 * 주문목록 > 주문상태 기준
	 * @param listVO
	 * @return
	 * @throws Exception
	 */
	public CommonListVO ordrListVO(CommonListVO listVO) throws Exception {
		return ordrDAO.ordrListVO(listVO);
	}

	// 내가 구매한 상품용
	public CommonListVO ordrMyListVO(CommonListVO listVO) throws Exception {
		return ordrDAO.ordrMyListVO(listVO);
	}

	public OrdrVO selectOrdrByCd(String ordrCd) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ordrCd", ordrCd);
		return ordrDAO.selectOrdr(paramMap);
	}

	public OrdrVO selectOrdrByNo(int ordrNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ordrNo", ordrNo);
		return ordrDAO.selectOrdr(paramMap);
	}

	public void insertOrdr(OrdrVO ordrVO) throws Exception {
		ordrDAO.insertOrdr(ordrVO);
	}

	public void updateOrdr(OrdrVO ordrVO) throws Exception {
		ordrDAO.updateOrdr(ordrVO);
	}

	public void deleteOrdr(int ordrNo) throws Exception {
		ordrDAO.deleteOrdr(ordrNo);
	}

	// 배송지정보 수정
	public Integer updateDlvyInfo(Map<String, Object> paramMap) throws Exception {
		return ordrDAO.updateDlvyInfo(paramMap);
	}

	// 총 결제금액 수정
	public void updateStlmAmt(OrdrVO ordrVO) throws Exception {
		ordrDAO.updateStlmAmt(ordrVO);
	}


	// 단계별 카운트
	public Map<String, Integer> selectSttsTyCnt(Map<String, Object> paramMap) throws Exception {
		return ordrDAO.selectSttsTyCnt(paramMap);
	}

	public List<OrdrVO> selectOrdrList(Map<String, Object> paramMap) throws Exception {
		return ordrDAO.selectOrdrList(paramMap);
	}

	// 결제완료 처리
	public void updateStlmYn(Map<String, Object> paramMap) throws Exception {
		ordrDAO.updateStlmYn(paramMap);
		if("Y".equals(paramMap.get("stlmYn"))) { // 승인변경시
			ordrDtlService.updateOrdrOR05( (String) paramMap.get("ordrCd") );
		}

	}

	public List<OrdrVO> selectOrdrSttsList(Map<String, Object> paramMap) throws Exception {
		return ordrDAO.selectOrdrSttsList(paramMap);
	}

	// 빌링키삭제
	public void updateBillingCancel(int ordrNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ordrNo", ordrNo);
		ordrDAO.updateBillingCancel(paramMap);
	}

	// 빌링키 업데이트
	public void updateBillingChg(Map<String, Object> paramMap) throws Exception {
		ordrDAO.updateBillingChg(paramMap);
	}

	// 이로움1.5 -> 이로움1.0 주문정보 송신 결과 값 업데이트
	public void updateOrdrByMap(Map<String, Object> paramMap) throws Exception {
		ordrDAO.updateOrdrByMap(paramMap);
	}

	// 주문 리스트 전체 조회
	public List<OrdrVO> selectOrdrListAll(Map<String, Object> paramMap) throws Exception {
		return ordrDAO.selectOrdrListAll(paramMap);
	}

}