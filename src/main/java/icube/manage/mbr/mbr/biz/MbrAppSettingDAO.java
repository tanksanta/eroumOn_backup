package icube.manage.mbr.mbr.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("mbrAppSettingDAO")
public class MbrAppSettingDAO extends CommonAbstractMapper {
	
	public List<MbrAppSettingVO> selectMbrAppSettingListAll(Map<String, Object> paramMap) throws Exception {
		return selectList("mbr.app.setting.selectMbrAppSetting", paramMap);
	}
	
	public MbrAppSettingVO selectMbrAppSettingByMbrUniqueId(String uniqueId) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("srchMbrUniqueId", uniqueId);
		return selectOne("mbr.app.setting.selectMbrAppSetting", paramMap);
	}
	
	public MbrAppSettingVO selectMbrAppSettingByPushToken(String pushToken) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("srchPushToken", pushToken);
		return selectOne("mbr.app.setting.selectMbrAppSetting", paramMap);
	}
	
	public void insertMbrAppSetting(MbrAppSettingVO mbrAppSettingVO) throws Exception {
		insert("mbr.app.setting.insertMbrAppSetting", mbrAppSettingVO);
	}
	
	public void updateMbrAppSetting(MbrAppSettingVO mbrAppSettingVO) throws Exception {
		update("mbr.app.setting.updateMbrAppSetting", mbrAppSettingVO);
	}
}
