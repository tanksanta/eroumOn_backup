package icube.members.bplc.rcmd.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("bplcRcmdDAO")
public class BplcRcmdDAO extends CommonAbstractMapper {

	public int insertRecomend(BplcRcmdVO bplcRcmdVO) throws Exception {
		return insert("bplc.rcmd.insertRcmd", bplcRcmdVO);
	}

	public int deleteRecomend(BplcRcmdVO bplcRcmdVO) throws Exception {
		return delete("bplc.rcmd.deleteRcmd", bplcRcmdVO);
	}

	public int selectRcmdCntByUniqueId(BplcRcmdVO rcmdVO) throws Exception {
		return selectInt("bplc.rcmd.selectRcmdCntByUniqueId", rcmdVO);
	}

	public List<BplcRcmdVO> selectBplcRcmdByUniqueId(Map<String, Object> param) throws Exception {
		return selectList("bplc.rcmd.selectBplcRcmdByUniqueId", param);
	}
}
