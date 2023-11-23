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

	// 회원 마일리지 소멸 처리
	public void extinctMbrMlg(MbrMlgVO mbrMlgVO) throws Exception {
		insert("mbr.mlg.extinctMbrMlg",mbrMlgVO);
	}

	// 마일리지 종합
	public Map<String, Object> selectAlltypeMlg(Map<String, Object> paramMap) throws Exception {
		return selectOne("mbr.mlg.selectAlltypeMlg", paramMap);
	}

	//마일리지 소멸 안내 이메일 발송 처리
	public void updateExtinctMlgMail(Map<String, Object> paramMap) throws Exception {
		update("mbr.mlg.updateExtinctMlgMail",paramMap);
	}
	
	//마일리지 소멸 여부 처리
	public void updateExtinctMlgAction(Map<String, Object> paramMap) throws Exception {
		update("mbr.mlg.updateExtinctMlgAction",paramMap);
	}
}