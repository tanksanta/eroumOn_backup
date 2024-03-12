package icube.app.matching.main.biz;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("appVersionDAO")
public class AppVersionDAO extends CommonAbstractMapper {
	public AppVersionVO selectLastAppVersion(String appNm) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("srchAppNm", appNm);
		return selectOne("app.version.selectLastAppVersion", paramMap);
	}
}
