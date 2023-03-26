package icube.manage.clcln.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.manage.ordr.dtl.biz.OrdrDtlVO;

@Repository("clclnDAO")
public class ClclnDAO extends CommonAbstractMapper {

	public List<OrdrDtlVO> selectOrdrList(Map<String, Object> paramMap) throws Exception {
		return selectList("clcln.selectOrdrList", paramMap);
	}

	public List<Map<String, Object>> selectPartnerList(Map<String, Object> paramMap) throws Exception {
		return selectList("clcln.selectPartnerList", paramMap);
	}
}
