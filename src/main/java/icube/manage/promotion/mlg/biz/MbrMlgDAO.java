package icube.manage.promotion.mlg.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("mbrMlgDAO")
public class MbrMlgDAO extends CommonAbstractMapper {

	public CommonListVO mbrMlgListVO(CommonListVO listVO) throws Exception {
		return selectListVO("mbr.mlg.selectMbrMlgCount", "mbr.mlg.selectMbrMlgListVO", listVO);
	}

	public MbrMlgVO selectMbrMlg(Map<String, Object> paramMap) throws Exception {
		return (MbrMlgVO)selectOne("mbr.mlg.selectMbrMlg", paramMap);
	}

	public void insertMbrMlg(MbrMlgVO mbrMlgVO) throws Exception {
		insert("mbr.mlg.insertMbrMlg", mbrMlgVO);
	}

	public List<MbrMlgVO> selectMbrMlgList(Map<String, Object> paramMap) throws Exception {
		return selectList("mbr.mlg.selectMbrMlgList",paramMap);
	}

	public int selectMbrMlgCount(Map<String, Object> paramMap) throws Exception {
		return selectOne("mbr.mlg.selectMbrMlgCount",paramMap);
	}

	// 마일리지 sum
	public int selectSumMlgByMlgSe(Map<String, Object> paramMap) throws Exception {
		return selectOne("mbr.mlg.selectSumMlgByMlgSe",paramMap);
	}

	// 회원 소멸 마일리지
	public List<MbrMlgVO> selectMbrDedMlgList() throws Exception {
		return selectList("mbr.mlg.selectMbrDedMlgList");
	}

}