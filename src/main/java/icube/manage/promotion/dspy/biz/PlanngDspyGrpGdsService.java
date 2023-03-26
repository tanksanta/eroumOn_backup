package icube.manage.promotion.dspy.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;

@Service("planngDspyGrpGdsService")
@SuppressWarnings({ "rawtypes", "unchecked" })
public class PlanngDspyGrpGdsService extends CommonAbstractServiceImpl{

	@Resource(name="planngDspyGrpService")
	private PlanngDspyGrpService planngDspyGrpService;

	@Resource(name="planngDspyGrpGdsDAO")
	private PlanngDspyGrpGdsDAO planngDspyGrpGdsDAO;

	public List<PlanngDspyGrpGdsVO> selectGdsList(int planningDspyNo, int grpNo) throws Exception {
		Map paramMap = new HashMap();
		paramMap.put("planningDspyNo", planningDspyNo);
		paramMap.put("grpNo", grpNo);
		return planngDspyGrpGdsDAO.selectGdsList(paramMap);
	}

	public List<PlanngDspyGrpGdsVO> selectGrpGdsListAll(int planningDspyNo, int grpNo) throws Exception {
		Map paramMap = new HashMap();
		paramMap.put("planningDspyNo", planningDspyNo);
		paramMap.put("grpNo", grpNo);
		return planngDspyGrpGdsDAO.selectGrpGdsListAll(paramMap);
	}

}
