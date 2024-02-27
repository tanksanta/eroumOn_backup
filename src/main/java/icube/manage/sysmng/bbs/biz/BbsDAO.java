package icube.manage.sysmng.bbs.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("bbsDAO")
public class BbsDAO extends CommonAbstractMapper {

	public CommonListVO selectNttListVO(CommonListVO listVO) throws Exception {
		return selectListVO("bbs.ntt.selectNttCount", "bbs.ntt.selectNttListVO", listVO);
	}

	public BbsVO selectNtt(Map<String, Object> paramMap) throws Exception {
		return selectOne("bbs.ntt.selectNtt", paramMap);
	}

	public void insertNtt(BbsVO nttVO) throws Exception {
		insert("bbs.ntt.insertNtt", nttVO);
	}
	public void insertNttAddColumn(BbsVO nttVO) throws Exception {
		insert("bbs.ntt.insertNttAddColumn", nttVO);
	}

	public void updateNtt(BbsVO nttVO) throws Exception {
		update("bbs.ntt.updateNtt", nttVO);
	}
	public void updateNttAddColumn(BbsVO nttVO) throws Exception {
		update("bbs.ntt.updateNttAddColumn", nttVO);
	}

	public void deleteNtt(Map<String, Object> paramMap) throws Exception {
		delete("bbs.ntt.deleteNtt", paramMap);
	}

	public void updateReplyOrdr(BbsVO nttVO) throws Exception {
		update("bbs.ntt.updateNttOrdr", nttVO);
	}

	public Integer updateDelNtt(Map<String, Object> paramMap) throws Exception {
		return update("bbs.ntt.updateDelNtt", paramMap);
	}

	public int nttPasswordChk(Map<String, Object> paramMap) throws Exception {
		return selectInt("bbs.ntt.passwordChk", paramMap);
	}

	public void updateInqcnt(int nttNo) throws Exception {
		update("bbs.ntt.updateInqcnt", nttNo);
	}

	public Integer updateNttSttsTy(Map<String, Object> paramMap) throws Exception {
		return update("bbs.ntt.updateNttSttsTy", paramMap);
	}

	public List<Map<String, Object>> selectNttPrevNext(Map<String, Object> paramMap) throws Exception {
		return selectList("bbs.ntt.selectNttPrevNext", paramMap);
	}

	public void updateAnswer(BbsVO nttVO) throws Exception {
		update("bbs.ntt.updateAnswer", nttVO);
	}

	public Integer updateDelAnswer(Map<String, Object> paramMap) throws Exception {
		return update("bbs.ntt.updateDelAnswer", paramMap);
	}

	public int selectAnswerNCnt(Map<String, Object> paramMap) throws Exception {
		return selectInt("bbs.ntt.selectAnswerNCnt", paramMap);
	}

}
