package icube.members.stdg.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("stdgCdDAO")
public class StdgCdDAO extends CommonAbstractMapper {

	public List<StdgCdVO> selectStdgCdListAll(Map<String, Object> paramMap) {
		return selectList("partners.stdgCd.selectStdgCdListAll", paramMap);
	}

	public StdgCdVO selectStdgCd(Map<String, Object> paramMap) throws Exception {
		return selectOne("partners.stdgCd.selectStdgCd",paramMap);
	}

}
