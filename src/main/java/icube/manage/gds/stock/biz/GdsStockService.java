package icube.manage.gds.stock.biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;
import icube.manage.gds.gds.biz.GdsDAO;
import icube.manage.gds.gds.biz.GdsVO;
import icube.manage.gds.optn.biz.GdsOptnService;

@Service("gdsStockService")
public class GdsStockService extends CommonAbstractServiceImpl {

	@Resource(name="gdsStockDAO")
	private GdsStockDAO gdsStockDAO;

	@Resource(name = "gdsOptnService")
	private GdsOptnService gdsOptnService;

	@Resource(name = "gdsDAO")
	private GdsDAO gdsDAO;

	/**
	 * 상품재고 관리 목록
	 * @param listVO
	 */
	public CommonListVO gdsStockListVO(CommonListVO listVO) throws Exception {
		return gdsStockDAO.gdsStockListVO(listVO);
	}

	/**
	 * 상품 재고관리 수정
	 * @param paramMap
	 */
	public void updateGdsStock(Map<String, Object> paramMap) throws Exception {

		// 품절
		int optnStockQy = (Integer)paramMap.get("optnStockQy");
		if(optnStockQy == 0) {
			paramMap.put("soldoutYn", "Y");
		}else {
			paramMap.put("soldoutYn", "N");
		}

		// 상품
		if(((String)paramMap.get("optnTy")).equals("none")) {
			gdsDAO.updateGdsUseNStock(paramMap);
		// 옵션
		}else {
			gdsOptnService.updateOptnUseNStock(paramMap);
		}
	}

	/**
	 * 상품 재고 리스트
	 * @param reqMap
	 * @return
	 * @throws Exception
	 */
	public List<GdsVO> gdsStockListAll(Map<String, Object> reqMap) throws Exception {
		return gdsStockDAO.gdsStockListAll(reqMap);
	}

}