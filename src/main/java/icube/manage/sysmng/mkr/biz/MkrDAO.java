package icube.manage.sysmng.mkr.biz;

import java.util.List;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("mkrDAO")
public class MkrDAO extends CommonAbstractMapper {

	public CommonListVO mkrListVO(CommonListVO listVO) throws Exception {
		return selectListVO("mkr.selectMkrCount", "mkr.selectMkrListVO", listVO);
	}

	public MkrVO selectMkr(int mkrNo) throws Exception {
		return (MkrVO)selectOne("mkr.selectMkr", mkrNo);
	}

	public MkrVO selectMkr(String mkrNm) throws Exception {
		return selectOne("mkr.selectMkrNm",mkrNm);
	}

	public List<MkrVO> selectMkrListAll() throws Exception {
		return selectList("mkr.selectMkrListAll");
	}

	public void insertMkr(MkrVO mkrVO) throws Exception {
		insert("mkr.insertMkr", mkrVO);
	}

	public void updateMkr(MkrVO mkrVO) throws Exception {
		update("mkr.updateMkr", mkrVO);
	}


}