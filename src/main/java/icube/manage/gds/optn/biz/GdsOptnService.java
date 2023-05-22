package icube.manage.gds.optn.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;

@Service("gdsOptnService")
public class GdsOptnService extends CommonAbstractServiceImpl {

	@Resource(name="gdsOptnDAO")
	private GdsOptnDAO gdsOptnDAO;


	public List<GdsOptnVO> selectGdsOptnList(Map<String, Object> paramMap) throws Exception {
		return gdsOptnDAO.selectGdsOptnList(paramMap);
	}

	public void registerGdsOptn(List<GdsOptnVO> itemList) throws Exception {
		for (GdsOptnVO gdsOptnVO : itemList) {
			if(gdsOptnVO.getGdsOptnNo() > 0) {
				gdsOptnDAO.updateGdsOptn(gdsOptnVO);
			}else {
				gdsOptnDAO.insertGdsOptn(gdsOptnVO);
			}
		}
	}

	public void deleteGdsOptn(int gdsNo, String[] gdsOptnNos) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("gdsNo", gdsNo);
		paramMap.put("gdsOptnNos", gdsOptnNos);

		gdsOptnDAO.deleteGdsOptn(paramMap);

	}

	public void updateGdsOptnStockQy(Map<String, Object> paramMap) throws Exception {
		gdsOptnDAO.updateGdsOptnStockQy(paramMap);
	}

	public void updateOptnUseNStock(Map<String, Object> paramMap) throws Exception {
		gdsOptnDAO.updateOptnUseNStock(paramMap);
	}

	/**
	 * 상품 정보 업데이트 (API) 용
	 * @param optnMap
	 * @return gdsOptnVO
	 * @throws Exception
	 */
	public GdsOptnVO selectGdsOptn(Map<String, Object> optnMap) throws Exception {
		return gdsOptnDAO.selectGdsOptn(optnMap);
	}

	public void updateGdsOptn(GdsOptnVO ownOptnVO) throws Exception {
		gdsOptnDAO.updateGdsOptn(ownOptnVO);
	}

	/**
	 * 이로움1.0 데이터로 이로움 1.5 상품 정보 업데이트
	 * @param infoMap
	 */
	public void updateOptnStockQy(Map<String, Object> paramMap) throws Exception {
		gdsOptnDAO.updateOptnStockQy(paramMap);

	}

}
