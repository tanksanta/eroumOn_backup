package icube.members.bplc.rcmd.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;

@Service("bplcRcmdService")
public class BplcRcmdService extends CommonAbstractServiceImpl {

	@Resource(name="bplcRcmdDAO")
	private BplcRcmdDAO bplcRcmdDAO;

	public int updateIncrsCnt(BplcRcmdVO rcmdVO, String likeStatus) throws Exception {

		int resultCnt = 0;

		if(EgovStringUtil.equals(likeStatus, "like")) {
			rcmdVO.setRcmdYn("Y");
			resultCnt = bplcRcmdDAO.insertRecomend(rcmdVO);
		} else {
			resultCnt = bplcRcmdDAO.deleteRecomend(rcmdVO);
		}

		return resultCnt;
	}

	public int selectRcmdCntByUniqueId(BplcRcmdVO rcmdVO) throws Exception {
		return bplcRcmdDAO.selectRcmdCntByUniqueId(rcmdVO);
	}

	public List<BplcRcmdVO> selectBplcRcmdByUniqueId(String mbrUniqueId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("regUniqueId", mbrUniqueId);
		return bplcRcmdDAO.selectBplcRcmdByUniqueId(param);
	}
}
