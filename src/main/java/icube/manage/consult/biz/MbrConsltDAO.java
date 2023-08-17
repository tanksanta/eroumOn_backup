package icube.manage.consult.biz;

import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("mbrConsltDAO")
public class MbrConsltDAO extends CommonAbstractMapper {

	public CommonListVO selectMbrConsltListVO(CommonListVO listVO) throws Exception {
		return selectListVO("conslt.selectMbrConsltCount","conslt.selectMbrConsltListVO",listVO);
	}

	public Integer updateUseYn(Map<String, Object> paramMap) throws Exception {
		return update("conslt.updateUseYn", paramMap);
	}

	public MbrConsltVO selectMbrConslt(Map<String, Object> paramMap) throws Exception {
		return selectOne("conslt.selectMbrConslt",paramMap);
	}

	public Integer insertMbrConslt(MbrConsltVO mbrConsltVO) throws Exception {
		return insert("conslt.insertMbrConslt",mbrConsltVO);
	}

	public Integer updateMbrConslt(MbrConsltVO mbrConsltVO) throws Exception {
		return update("conslt.updateMbrConslt", mbrConsltVO);
	}

	public int updateCanclConslt(Map<String, Object> paramMap) throws Exception {
		return update("conslt.updateCanclConslt", paramMap);
	}

	public int updateSttus(Map<String, Object> paramMap) throws Exception {
		return update("conslt.updateSttus", paramMap);
	}

}