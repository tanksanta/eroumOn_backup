package icube.manage.gds.ctgry.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("gdsCtgryDAO")
public class GdsCtgryDAO extends CommonAbstractMapper {

	public List<GdsCtgryVO> selectGdsCtgryList() throws Exception {
		return selectList("gds.ctgry.selectGdsCtgryList");
	}

	public List<GdsCtgryVO> selectGdsCtgryListByFilter(Map<String, Object> paramMap) throws Exception {
		return selectList("gds.ctgry.selectGdsCtgryListByFilter",  paramMap);
	}

	public GdsCtgryVO selectGdsCtgry(Map<String, Object> reqMap) throws Exception {
		return selectOne("gds.ctgry.selectGdsCtgry", reqMap);
	}

	public void insertGdsCtgry(GdsCtgryVO gdsCtgryVO) throws Exception {
		insert("gds.ctgry.insertGdsCtgry", gdsCtgryVO);
	}

	public void updateGdsCtgry(GdsCtgryVO gdsCtgryVO) throws Exception {
		update("gds.ctgry.updateGdsCtgry", gdsCtgryVO);
	}

	public void deleteGdsCtgry(GdsCtgryVO gdsCtgryVO) throws Exception {
		delete("gds.ctgry.deleteGdsCtgry", gdsCtgryVO);
	}

	public int updateGdsCtgryNm(Map<String, Object> reqMap) throws Exception {
		return update("gds.ctgry.updateGdsCtgryNm", reqMap);
	}

	public int updateGdsCtgryPosition(GdsCtgryVO gdsCtgryVO) throws Exception {
		return update("gds.ctgry.updateGdsCtgryPosition", gdsCtgryVO);
	}

	public void updateGdsCtgryImg(GdsCtgryVO ctgryVO) throws Exception {
		update("gds.ctgry.updateGdsCtgryImg",ctgryVO);
	}

}
