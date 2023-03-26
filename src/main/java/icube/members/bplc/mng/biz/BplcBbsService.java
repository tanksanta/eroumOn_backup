package icube.members.bplc.mng.biz;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("bplcBbsService")
public class BplcBbsService extends CommonAbstractServiceImpl {

	@Resource(name="bplcBbsDAO")
	private BplcBbsDAO bplcBbsDAO;

	public CommonListVO bplcBbsListVO(CommonListVO listVO) throws Exception {
		return bplcBbsDAO.bplcBbsListVO(listVO);
	}

	public BplcBbsVO selectBplcBbs(String bplcUniqueId, int nttNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bplcUniqueId", bplcUniqueId);
		paramMap.put("nttNo", nttNo);
		return bplcBbsDAO.selectBplcBbs(paramMap);
	}

	public void insertBplcBbs(BplcBbsVO bplcBbsVO) throws Exception {
		bplcBbsDAO.insertBplcBbs(bplcBbsVO);
	}

	public void updateBplcBbs(BplcBbsVO bplcBbsVO) throws Exception {
		bplcBbsDAO.updateBplcBbs(bplcBbsVO);
	}

	public void updateInqcnt(BplcBbsVO bplcBbsVO) throws Exception {
		bplcBbsDAO.updateInqcnt(bplcBbsVO);
	}

	public void deleteBbs(String bplcUniqueId, int nttNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bplcUniqueId", bplcUniqueId);
		paramMap.put("nttNo", nttNo);

		bplcBbsDAO.deleteBbs(paramMap);
	}

}