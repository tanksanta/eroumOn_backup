package icube.manage.clcln.biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.manage.ordr.dtl.biz.OrdrDtlVO;

@Service("clclnService")
public class ClclnService extends CommonAbstractServiceImpl {

	@Resource(name="clclnDAO")
	private ClclnDAO clclnDAO;

	public List<OrdrDtlVO> selectOrdrList(Map<String, Object> paramMap) throws Exception {
		return clclnDAO.selectOrdrList(paramMap);
	}

	public List<Map<String, Object>> selectPartnerList(Map<String, Object> paramMap) throws Exception {
		return clclnDAO.selectPartnerList(paramMap);
	}
}
