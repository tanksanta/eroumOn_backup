package icube.manage.promotion.dspy.biz;

import java.util.List;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("planngDspyGrpDAO")
public class PlanngDspyGrpDAO extends CommonAbstractMapper{

	public void insertPlanngDspyGrp(PlanngDspyGrpVO planngDspGrpVO) throws Exception{
		insert("dspy.grp.insertPlanngDspyGrp",planngDspGrpVO);
	}

	public PlanngDspyGrpVO selectPlanngDspyGrp(int planngDspyNo) throws Exception {
		return selectOne("dspy.grp.selectPlanngDspyGrp",planngDspyNo);
	}

	public List<PlanngDspyGrpVO> selectGrpList(int planningDspyNo) throws Exception {
		return selectList("dspy.grp.selectGrpList",planningDspyNo);
	}

	/**
	 * 업데이트용 delete
	 * @param planngDspyNo
	 * @throws Exception
	 */
	public void deletePlanngDspyGrp(int planngDspyNo) throws Exception {
		delete("dspy.grp.deletePlanngDspyGrp",planngDspyNo);
	}


}
