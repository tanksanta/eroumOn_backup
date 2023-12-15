package icube.manage.consult.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("mbrConsltGdsDAO")
public class MbrConsltGdsDAO extends CommonAbstractMapper {
	public List<MbrConsltGdsVO> selectMbrConsltGds(Map<String, Object> paramMap) throws Exception {
		return selectList("conslt.gds.selectMbrConsltGds", paramMap);
	}
	
	public Integer insertMbrConsltGds(MbrConsltGdsVO mbrConsltGdsVO) throws Exception {
		return insert("conslt.gds.insertMbrConsltGds", mbrConsltGdsVO);
	}
	
	public Integer deleteMbrConsltGds(Map<String, Object> paramMap) throws Exception {
		return delete("conslt.gds.deleteMbrConsltGds", paramMap);
	}
}
