package icube.manage.consult.biz;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.util.DateUtil;
import icube.common.vo.CommonListVO;

@Repository("mbrConsltResultDAO")
public class MbrConsltResultDAO extends CommonAbstractMapper {

	public CommonListVO selectMbrConsltResultListVO(CommonListVO listVO) throws Exception {
		return selectListVO("conslt.result.selectMbrConsltResultCount","conslt.result.selectMbrConsltResultListVO",listVO);
	}
	
	public int selectMbrConsltResultCount(Map<String, Object> paramMap) throws Exception {
		return selectInt("selectMbrConsltResultCount", paramMap);
	}

	public Integer insertMbrConsltBplc(MbrConsltResultVO mbrConsltResultVO) throws Exception {
		return insert("conslt.result.insertMbrConsltBplc", mbrConsltResultVO);
	}

	public Integer updateDtlsConslt(MbrConsltResultVO mbrConsltResultVO) throws Exception{
		return insert("conslt.result.updateDtlsConslt", mbrConsltResultVO);
	}

	public MbrConsltResultVO selectMbrConsltBplc(Map<String, Object> paramMap) throws Exception {
		return selectOne("conslt.result.selectMbrConsltBplc", paramMap);
	}

	public int updateCanclConslt(Map<String, Object> paramMap) throws Exception {
		return update("conslt.result.updateCanclConslt", paramMap);
	}

	public int updateSttus(Map<String, Object> paramMap) throws Exception {
		return update("conslt.result.updateSttus", paramMap);
	}

	public void deleteMbrConsltBplc(MbrConsltResultVO mbrConsltResultVO) throws Exception {
		delete("conslt.result.deleteMbrConsltBplc", mbrConsltResultVO);
	}

	public int updateReConslt(MbrConsltResultVO mbrConsltResultVO) throws Exception {
		return update("conslt.result.updateReConslt", mbrConsltResultVO);
	}

	public List<MbrConsltResultVO> selectListForExcel(Map<String, Object> paramMap) throws Exception {
		return selectList("conslt.result.selectListForExcel", paramMap);
	}

	public List<MbrConsltResultVO> selectListForCareTalkDelayed(Map<String, Object> paramMap) throws Exception {
		String sDate = DateUtil.getDateTime(DateUtil.getDateAdd(new Date(), "date", -1), "yyyy-MM-dd");
		paramMap.put("consltDt10forBiztalk", sDate);
		return selectList("conslt.result.selectListForCareTalkDelayed", paramMap);
	}
	public List<MbrConsltResultVO> selectListForCareTalkAttention(Map<String, Object> paramMap) throws Exception {
		
		String sDate = DateUtil.getDateTime(DateUtil.getDateAdd(new Date(), "date", -2), "yyyy-MM-dd");
		paramMap.put("consltDt10forBiztalk", sDate);

		return selectList("conslt.result.selectListForCareTalkAttention", paramMap);
	}

}