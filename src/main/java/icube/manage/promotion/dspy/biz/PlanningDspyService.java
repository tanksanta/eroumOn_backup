package icube.manage.promotion.dspy.biz;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("planningDspyService")
public class PlanningDspyService extends CommonAbstractServiceImpl {

	@Resource(name="planningDspyDAO")
	private PlanningDspyDAO pdDao;

	public CommonListVO pDspyListVO(CommonListVO listVO) throws Exception {
		return pdDao.pDspyListVO(listVO);
	}

	public PlanningDspyVO selectPdspy(int planngDspyNo) throws Exception {
		return pdDao.selectPdspy(planngDspyNo);
	}

	public void insertPdspy(PlanningDspyVO planningDspyVO) throws Exception {
		pdDao.insertPdspy(planningDspyVO);
	}

	public void updatePdspy(PlanningDspyVO planningDspyVO) throws Exception {
		pdDao.updatePdspy(planningDspyVO);
	}

	/**
	 * DATA TABLE
	 * @param listVO
	 * @return
	 * @throws Exception
	 */
	public CommonListVO selectDspyListVO(CommonListVO listVO) throws Exception {
		return pdDao.selectListDspyVO(listVO);
	}


}
