package icube.market.srch.biz;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("srchLogDAO")
public class SrchLogDAO extends CommonAbstractMapper {

	public void insertSrchLog(SrchLogVO srchLogVO) throws Exception {
		insert("srch.log.insertSrchLog",srchLogVO);
	}


}
