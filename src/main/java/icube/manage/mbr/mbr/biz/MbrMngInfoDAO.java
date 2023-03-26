package icube.manage.mbr.mbr.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("mbrMngInfoDAO")
public class MbrMngInfoDAO extends CommonAbstractMapper {

	public CommonListVO selectMbrMngInfoListVO(CommonListVO listVO) throws Exception {
		return selectListVO("mbr_mng_info.selectMbrMngInfoCount", "mbr_mng_info.selectMbrMngInfoListVO", listVO);
	}

	public MbrMngInfoVO selectMbrMngInfo(Map<String, Object> paramMap) throws Exception {
		return (MbrMngInfoVO)selectOne("mbr_mng_info.selectMbrMngInfo", paramMap);
	}

	public void insertMbrMngInfo(MbrMngInfoVO mbrMngInfoVO) throws Exception {
		insert("mbr_mng_info.insertMbrMngInfo", mbrMngInfoVO);
	}

	public void updateMbrMngInfo(MbrMngInfoVO mbrMngInfoVO) throws Exception {
		update("mbr_mng_info.updateMbrMngInfo", mbrMngInfoVO);
	}

	public void deleteMbrMngInfo(int mbrMngInfoNo) throws Exception {
		delete("mbr_mng_info.deleteMbrMngInfo", mbrMngInfoNo);
	}

	public List<MbrMngInfoVO> selectMbrMngInfoListAll(Map<String, Object> paramMap) throws Exception {
		return selectList("mbr_mng_info.selectMbrMngInfoListAll",paramMap);
	}

	public void deleteExitMbr(Map<String, Object> paramMap) throws Exception {
		update("mbr_mng_info.deleteExitMbr",paramMap);
	}

	public MbrMngInfoVO selectMbrMngInfoNm(String uniqueId) throws Exception{
		return selectOne("mbr_mng_info.selectMbrMngInfoNm",uniqueId);
	}

	public void updateWarn(MbrMngInfoVO mbrMngInfoVO) throws Exception{
		update("mbr_mng_info.updateWarn",mbrMngInfoVO);
	}

	public List<MbrMngInfoVO> selectMbrMngInfoListBySort(Map<String, Object> paramMap) throws Exception {
		return selectList("mbr_mng_info.selectMbrMngInfoListBySort",paramMap);
	}


}