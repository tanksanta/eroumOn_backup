package icube.manage.promotion.dspy.biz;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("planningDspyDAO")
public class PlanningDspyDAO extends CommonAbstractMapper {

	public CommonListVO pDspyListVO(CommonListVO listVO) throws Exception{
		return selectListVO("dspy.selectPdspyCount", "dspy.selectPdspyListVO", listVO);
	}

	public PlanningDspyVO selectPdspy(int planngDspyNo) throws Exception{
		return (PlanningDspyVO)selectOne("dspy.selectPdspy", planngDspyNo);
	}

	public void insertPdspy(PlanningDspyVO planningDspyVO) throws Exception{
		insert("dspy.insertPdspy", planningDspyVO);
	}

	public void updatePdspy(PlanningDspyVO planningDspyVO) throws Exception{
		update("dspy.updatePdspy", planningDspyVO);
	}

	/**
	 * DATA TABLE
	 * @param listVO
	 * @return
	 * @throws Exception
	 */
	public CommonListVO selectListDspyVO(CommonListVO listVO) throws Exception {
		return selectListVO("dspy.selectDspyCount","dspy.selectDspyListVO",listVO);
	}
}
