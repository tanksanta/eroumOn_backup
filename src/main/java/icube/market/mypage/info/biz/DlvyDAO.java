package icube.market.mypage.info.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("dlvyDAO")
public class DlvyDAO extends CommonAbstractMapper {

	public List<DlvyVO> selectDlvyListAll(Map<String, Object> paramMap) throws Exception {
		return selectList("mbr.dlvy.selectDlvyListAll", paramMap);
	}

	public void insertDlvyCoMng(DlvyVO dlvyVO) throws Exception {
		insert("mbr.dlvy.insertDlvy", dlvyVO);
	}

	public void updateDlvyCoMng(DlvyVO dlvyVO) throws Exception {
		update("mbr.dlvy.updateDlvy", dlvyVO);
	}

	public void deleteDlvyCoMng(Map<String, Object> paramMap) throws Exception {
		update("mbr.dlvy.deleteDlvy", paramMap);
	}

	public DlvyVO selectDlvy(Map<String, Object> paramMap) throws Exception {
		return selectOne("mbr.dlvy.selectDlvy",paramMap);
	}

	public int selectBassCount(Map<String, Object> paramMap) throws Exception{
		return selectOne("mbr.dlvy.selectBassCount",paramMap);
	}

	public void updateBassDlvy(Map<String, Object> paramMap) throws Exception {
		update("mbr.dlvy.updateBassDlvy",paramMap);
	}

	public DlvyVO selectBassDlvy(Map<String, Object> paramMap) throws Exception {
		return selectOne("mbr.dlvy.selectBassDlvy", paramMap);
	}

	public void insertBassDlvy(DlvyVO dlvyVO) throws Exception {
		insert("mbr.dlvy.insertBassDlvy",dlvyVO);
	}

	public void updateKakaoDlvy(DlvyVO dlvyVO) throws Exception {
		update("mbr.dlvy.updateKakaoDlvy",dlvyVO);
	}

}
