package icube.manage.ordr.dtl.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("ordrDtlDAO")
public class OrdrDtlDAO extends CommonAbstractMapper {

	public List<OrdrDtlVO> selectOrdrDtlList(Map<String, Object> paramMap) {
		return selectList("ordr.dtl.selectOrdrDtlList", paramMap);
	}

	public OrdrDtlVO selectOrdrDtl(int ordrDtlNo) throws Exception {
		return (OrdrDtlVO)selectOne("ordr.dtl.selectOrdrDtl", ordrDtlNo);
	}

	public void insertOrdrDtl(OrdrDtlVO ordrDtlVO) throws Exception {
		insert("ordr.dtl.insertOrdrDtl", ordrDtlVO);
	}

	public void updateOrdrDtl(OrdrDtlVO ordrDtlVO) throws Exception {
		update("ordr.dtl.updateOrdrDtl", ordrDtlVO);
	}

	public void deleteOrdrDtl(int ordrDtlNo) throws Exception {
		delete("ordr.dtl.deleteOrdrDtl", ordrDtlNo);
	}

	public void deleteOrdrDtlByNos(Map<String, Object> paramMap) throws Exception {
		delete("ordr.dtl.deleteOrdrDtlByNos", paramMap);
	}

	public Integer updateoOptnChg(OrdrDtlVO ordrDtlVO) throws Exception {
		return update("ordr.dtl.updateoOptnChg", ordrDtlVO);
	}

	public Integer mergeOptnChg(OrdrDtlVO ordrDtlVO) throws Exception {
		return insert("ordr.dtl.mergeOptnChg", ordrDtlVO);
	}

	public Integer updateDlvyCoInfo(OrdrDtlVO ordrDtlVO) throws Exception {
		return update("ordr.dtl.updateDlvyCoInfo", ordrDtlVO);
	}

	public void updateOrdrConfrm(OrdrDtlVO ordrDtlVO) throws Exception {
		update("ordr.dtl.updateOrdrConfrm", ordrDtlVO);
	}
	
	public void updateDlvyPreparing(OrdrDtlVO ordrDtlVO) throws Exception {
		update("ordr.dtl.updateDlvyPreparing", ordrDtlVO);
	}

	// 주문상태변경
	public Integer updateOrdrStts(OrdrDtlVO ordrDtlVO) throws Exception {
		return update("ordr.dtl.updateOrdrStts", ordrDtlVO);
	}

	// 환불정보 업데이트(건별)
	public void updateOrdrDtlRfndInfo(Map<String, Object> rfndMap) throws Exception {
		update("ordr.dtl.updateOrdrDtlRfndInfo", rfndMap);
	}

	// 특정 단계 제외 카운트
	public int selectExSttsTyCnt(Map<String, Object> paramMap) throws Exception {
		return selectOne("ordr.dtl.selectExSttsTyCnt",paramMap);
	}

	// 결제완료 처리
	public void updateOrdrSttsByOrdrCd(Map<String, Object> paramMap) throws Exception {
		update("ordr.dtl.updateOrdrSttsByOrdrCd", paramMap);
	}

	// 이전 선택 사업소
	public OrdrDtlVO selectOrdrDtlHistory(Map<String, Object> dtlMap) throws Exception {
		return selectOne("ordr.dtl.selectOrdrDtlHistory",dtlMap);
	}

	// 스케줄러 상태 조회
	public List<OrdrDtlVO> selectOrdrSttsList(Map<String, Object> paramMap) throws Exception {
		return selectList("ordr.dtl.selectOrdrSttsList",paramMap);
	}

	// 반품, 주문취소 마지막 상품 판별
	public int selectLastReturn(Map<String, Object> paramMap) throws Exception {
		return selectOne("ordr.dtl.selectLastReturn",paramMap);
	}

	// 주문연계 API 용 사업소 승인 / 반려 업데이트
	public Integer updateBplcSttus(Map<String, Object> paramMap) throws Exception {
		return update("ordr.dtl.updateBplcSttus",paramMap);
	}
}
