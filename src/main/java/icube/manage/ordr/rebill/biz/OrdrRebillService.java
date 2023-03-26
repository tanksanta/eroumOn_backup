package icube.manage.ordr.rebill.biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;
import icube.manage.ordr.ordr.biz.OrdrVO;

@Service("ordrRebillService")
public class OrdrRebillService extends CommonAbstractServiceImpl {

	@Resource(name="ordrRebillDAO")
	private OrdrRebillDAO ordrRebillDAO;

	public CommonListVO ordrRebillListVO(CommonListVO listVO) throws Exception {
		return ordrRebillDAO.ordrRebillListVO(listVO);
	}

	public List<OrdrRebillVO> selectOrdrRebillListAll(Map<String, Object> paramMap) throws Exception {
		return ordrRebillDAO.selectOrdrRebillListAll(paramMap);
	}

	public OrdrRebillVO selectOrdrRebill(Map<String, Object> paramMap) throws Exception {
		return ordrRebillDAO.selectOrdrRebill(paramMap);
	}

	public void insertOrdrRebill(OrdrRebillVO ordrRebillVO) throws Exception {
		ordrRebillDAO.insertOrdrRebill(ordrRebillVO);
	}

	public List<OrdrVO> selectRebillList(Map<String, Object> paramMap) throws Exception {
		return ordrRebillDAO.selectRebillList(paramMap);
	}

}
