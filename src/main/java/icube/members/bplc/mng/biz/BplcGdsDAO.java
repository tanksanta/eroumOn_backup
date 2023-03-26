package icube.members.bplc.mng.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;
import icube.manage.gds.gds.biz.GdsVO;

@Repository("bplcGdsDAO")
public class BplcGdsDAO extends CommonAbstractMapper {

	public CommonListVO bplcGdsListVO(CommonListVO listVO) throws Exception {
		return selectListVO("partners.bplc.gds.selectBplcGdsCount", "partners.bplc.gds.selectBplcGdsListVO", listVO);
	}

	public List<GdsVO> selectBplcGdsListAll(Map<String, Object> paramMap) throws Exception {
		return selectList("partners.bplc.gds.selectBplcGdsListAll", paramMap);
	}

	public int insertBplcGds(BplcGdsVO bplcGdsVO) throws Exception {
		return insert("partners.bplc.gds.insertBplcGds", bplcGdsVO);
	}

	public void deleteBplcGds(BplcGdsVO bplcGdsVO) throws Exception {
		delete("partners.bplc.gds.deleteBplcGds", bplcGdsVO);
	}

	public Integer selectInsertBplcGds(Map<String, Object> paramMap) throws Exception {
		return insert("partners.bplc.gds.selectInsertBplcGds", paramMap);
	}

	public Integer selectInsertGds(Map<String, Object> paramMap) throws Exception {
		return insert("partners.bplc.gds.selectInsertGds", paramMap);
	}

}
