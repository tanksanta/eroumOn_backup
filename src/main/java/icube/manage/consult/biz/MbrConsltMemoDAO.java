package icube.manage.consult.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("mbrConsltMemoDAO")
public class MbrConsltMemoDAO extends CommonAbstractMapper {
	public List<MbrConsltMemoVO> selectMbrConsltMemo(Map<String, Object> paramMap) throws Exception {
		return selectList("conslt.memo.selectMbrConsltMemo", paramMap);
	}
	
	public Integer insertMbrConsltMemo(MbrConsltMemoVO mbrConsltMemoVO) throws Exception {
		return insert("conslt.memo.insertMbrConsltMemo",mbrConsltMemoVO);
	}
}
