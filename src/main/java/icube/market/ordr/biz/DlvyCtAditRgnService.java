package icube.market.ordr.biz;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;

@Service("dlvyCtAditRgnService")
public class DlvyCtAditRgnService extends CommonAbstractServiceImpl {

	@Resource(name = "dlvyCtAditRgnDAO")
	private DlvyCtAditRgnDAO dlvyCtAditRgnDAO;

	public int selectDlvyCtAditRgnCnt(String zip) throws Exception {
		return dlvyCtAditRgnDAO.selectDlvyCtAditRgnCnt(zip);
	}

}
