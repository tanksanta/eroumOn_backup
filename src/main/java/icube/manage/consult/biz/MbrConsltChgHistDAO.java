package icube.manage.consult.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("mbrConsltChgHistDAO")
public class MbrConsltChgHistDAO extends CommonAbstractMapper {
	public List<MbrConsltChgHistVO> selectMbrConsltChgHist(Map<String, Object> paramMap) throws Exception {
		return selectList("conslt.chg.hist.selectMbrConsltChgHist", paramMap);
	}
	
	public Integer insertMbrConsltChgHist(MbrConsltChgHistVO mbrConsltMemoVO) throws Exception {
		return insert("conslt.chg.hist.insertMbrConsltChgHist",mbrConsltMemoVO);
	}
}
