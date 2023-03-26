package icube.manage.promotion.dspy.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("planngDspyGrpGdsDAO")
@SuppressWarnings("rawtypes")
public class PlanngDspyGrpGdsDAO extends CommonAbstractMapper{

	public List<PlanngDspyGrpGdsVO> selectGdsList(Map paramMap) throws Exception {
		return selectList("dspy.grp.gds.selectGdsList",paramMap);
	}

	public void insertGds(PlanngDspyGrpGdsVO gdsVO) throws Exception {
		insert("dspy.grp.gds.insertGds",gdsVO);
	}

	public List<PlanngDspyGrpGdsVO> selectGrpGdsListAll(Map paramMap) throws Exception {
		return selectList("dspy.grp.gds.selectGrpGdsListAll",paramMap);
	}

	/**
	 * 업데이트용 delete
	 * @param planngDspyNo
	 * @throws Exception
	 */
	public void deletePlanngDspyGrpGds(int planngDspyNo) throws Exception {
		delete("dspy.grp.gds.deletePlanngDspyGrpGds",planngDspyNo);
	}
}
