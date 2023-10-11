package icube.market.ordr.biz;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("dlvyCtAditRgnDAO")
public class DlvyCtAditRgnDAO extends CommonAbstractMapper {

	// (0/1) count return
	public int selectDlvyCtAditRgnCnt(String zip) throws Exception {
		return selectInt("dlvy.ct.selectDlvyCtAditRgnCnt", zip);
	}
}
