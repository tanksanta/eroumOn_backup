package icube.manage.consult.biz;

import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("mbrConsltResultDAO")
public class MbrConsltResultDAO extends CommonAbstractMapper {

	public CommonListVO selectMbrConsltResultListVO(CommonListVO listVO) throws Exception {
		return selectListVO("conslt.result.selectMbrConsltResultCount","conslt.result.selectMbrConsltResultListVO",listVO);
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



}