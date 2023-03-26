package icube.manage.promotion.dspy.biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;

@Service("planngDspyGrpService")
public class PlanngDspyGrpService extends CommonAbstractServiceImpl{

	@Resource(name="planngDspyGrpDAO")
	private PlanngDspyGrpDAO pdgsDAO;

	@Resource(name = "planngDspyGrpGdsDAO")
	private PlanngDspyGrpGdsDAO pdgsGdsDAO;

	/**
	 * 상품 등록
	 * @param reqMap
	 * @param planningDspyVO
	 * @throws Exception
	 */
	public void insertPlanngDspyGrp(Map<String, Object> reqMap, PlanningDspyVO planningDspyVO) throws Exception {

		int total = EgovStringUtil.string2integer((String)reqMap.get("grpGdsTotal"));

		// 상품 그룹
		PlanngDspyGrpVO planngDspGrpVO = new PlanngDspyGrpVO();

		for(int i=0; i<(total-1); i++) {
			//상품 넘버
			String[] gdsNoList = (((String)reqMap.get("gdsNo"+(i+1))).replace(" ", "")).split(",");
			String[] gdsCdList = (((String)reqMap.get("gdsCd"+(i+1))).replace(" ", "")).split(",");

			planngDspGrpVO.setGrpNm((String)reqMap.get("grpNm"+(i+1)));
			planngDspGrpVO.setExhibiCo(EgovStringUtil.string2integer((String)reqMap.get("exhbiCo"+(i+1))));
			planngDspGrpVO.setSortNo(EgovStringUtil.string2integer((String)reqMap.get("sortNo"+(i+1))));
			planngDspGrpVO.setPlanngDspyNo(planningDspyVO.getPlanngDspyNo());
			pdgsDAO.insertPlanngDspyGrp(planngDspGrpVO);

			 //상품
			PlanngDspyGrpVO grpNoVO = this.selectPlanngDspyGrp(planningDspyVO.getPlanngDspyNo());
				for(int h=0; h<gdsNoList.length; h++) {
					PlanngDspyGrpGdsVO gdsVO = new PlanngDspyGrpGdsVO();
					gdsVO.setPlanngDspyNo(planningDspyVO.getPlanngDspyNo());
					gdsVO.setGrpNo(grpNoVO.getGrpNo());
					gdsVO.setGdsNo(EgovStringUtil.string2integer(gdsNoList[h]));
					gdsVO.setSortNo(h+1);
					gdsVO.setGdsCd(gdsCdList[h]);
					pdgsGdsDAO.insertGds(gdsVO);
					}
		}
	}

	public PlanngDspyGrpVO selectPlanngDspyGrp(int planngDspyNo) throws Exception {
		return pdgsDAO.selectPlanngDspyGrp(planngDspyNo);
	}

	public List<PlanngDspyGrpVO> selectGrpList(int planningDspyNo) throws Exception {
		return pdgsDAO.selectGrpList(planningDspyNo);
	}

	/**
	 * 업데이트 delete > insert
	 * @param reqMap
	 * @param planningDspyVO
	 * @throws Exception
	 */
	public void updatePlanngDspyGrp(Map<String, Object> reqMap, PlanningDspyVO planningDspyVO) throws Exception {
		// 상품
		int planngDspyNo = planningDspyVO.getPlanngDspyNo();

		log.debug("@@@@@@@@@@ : " + reqMap);
		pdgsGdsDAO.deletePlanngDspyGrpGds(planngDspyNo);
		pdgsDAO.deletePlanngDspyGrp(planngDspyNo);
		this.insertPlanngDspyGrp(reqMap, planningDspyVO);


		/*for(int i=1; i<EgovStringUtil.string2integer((String)reqMap.get("grpGdsTotal")); i++) {
			if((String)reqMap.get("gdsNo"+i) != null) {

			}
		}*/
	}
}
