package icube.manage.sysmng.dlvy.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("dlvyCoMngDAO")
public class DlvyCoMngDAO extends CommonAbstractMapper {

	public CommonListVO dlvyCoMngListVO(CommonListVO listVO) throws Exception {
		return selectListVO("dlvy.selectDlvyCoMngCount", "dlvy.selectDlvyCoMngListVO", listVO);
	}

	public DlvyCoMngVO selectDlvyCoMng(int dlvyCoMngNo) throws Exception {
		return (DlvyCoMngVO)selectOne("dlvy.selectDlvyCoMng", dlvyCoMngNo);
	}

	public DlvyCoMngVO selectDlvyCoMng(String nm) throws Exception {
		return selectOne("dlvy.selectDlvyCoMngNm",nm);
	}

	public void insertDlvyCoMng(DlvyCoMngVO dlvyCoMngVO) throws Exception {
		insert("dlvy.insertDlvyCoMng", dlvyCoMngVO);
	}

	public void updateDlvyCoMng(DlvyCoMngVO dlvyCoMngVO) throws Exception {
		update("dlvy.updateDlvyCoMng", dlvyCoMngVO);
	}

	public List<DlvyCoMngVO> selectDlvyCoListAll(Map<String, Object> paramMap) throws Exception {
		return selectList("dlvy.selectDlvyCoListAll", paramMap);
	}

}