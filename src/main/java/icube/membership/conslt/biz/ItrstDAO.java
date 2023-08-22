package icube.membership.conslt.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.manage.gds.ctgry.biz.GdsCtgryVO;

@Repository("itrstDAO")
public class ItrstDAO extends CommonAbstractMapper {

	// 관심사업소, 카테고리 등록
	public void insertItrst(ItrstVO itrstVO) throws Exception {
		insert("mbr.itrst.insertItrst",itrstVO);
	}

	// 리스트 조회
	public List<ItrstVO> selectItrstListAll(Map<String, Object> paramMap) throws Exception {
		return selectList("mbr.itrst.selectItrstListAll",paramMap);
	}

	// 관심 사업소, 카테고리 삭제
	public void deleteItrst(Map<String, Object> paramMap) throws Exception {
		delete("mbr.itrst.deleteItrst",paramMap);
	}

	// 카테고리 조회
	public List<GdsCtgryVO> selectGdsCtgryList() throws Exception {
		return selectList("mbr.itrst.selectGdsCtgryList");
	}

}