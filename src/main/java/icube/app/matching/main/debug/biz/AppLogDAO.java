package icube.app.matching.main.debug.biz;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("appLogDAO")
public class AppLogDAO extends CommonAbstractMapper {
	public void insertAppLog(AppLogVO appLogVO) throws Exception {
		insert("app.log.insertAppLog", appLogVO);
	}
}
