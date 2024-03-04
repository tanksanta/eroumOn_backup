package icube.manage.sysmng.bbs.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("bbsService")
public class BbsService extends CommonAbstractServiceImpl {

	@Resource(name = "bbsDAO")
	private BbsDAO bbsDAO;

	public CommonListVO selectNttListVO(CommonListVO listVO) throws Exception {
		return bbsDAO.selectNttListVO(listVO);
	}

	public BbsVO selectNtt(int bbsNo, int nttNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bbsNo", bbsNo);
		paramMap.put("nttNo", nttNo);

		return bbsDAO.selectNtt(paramMap);
	}
	public BbsVO selectNttByBbsCd(String srvcCd, String bbsCd, int nttNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srvcCd", srvcCd);
		paramMap.put("bbsCd", bbsCd);
		paramMap.put("nttNo", nttNo);

		return bbsDAO.selectNttByBbsCd(paramMap);
	}
	public BbsVO selectNttByUniqueText(String srvcCd, String bbsCd, String uniqueText) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srvcCd", srvcCd);
		paramMap.put("bbsCd", bbsCd);
		paramMap.put("addUniqueText01", uniqueText);

		return bbsDAO.selectNttByUniqueText(paramMap);
	}

	public void insertNtt(BbsVO nttVO) throws Exception {
		bbsDAO.insertNtt(nttVO);

		bbsDAO.insertNttAddColumn(nttVO);
	}

	public void updateNtt(BbsVO nttVO) throws Exception {
		bbsDAO.updateNtt(nttVO);

		bbsDAO.updateNttAddColumn(nttVO);
	}

	public void deleteNtt(int bbsNo, int nttNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bbsNo", bbsNo);
		paramMap.put("nttNo", nttNo);

		bbsDAO.deleteNtt(paramMap);
	}

	public void insertReplyNtt(BbsVO nttVO) throws Exception {
		BbsVO updateVO = (BbsVO) nttVO;
		bbsDAO.updateReplyOrdr(updateVO);

		nttVO.setNttOrdr(nttVO.getNttOrdr() + 1);
		nttVO.setNttLevel(nttVO.getNttLevel() + 1);

		bbsDAO.insertNtt(nttVO);
	}

	public Integer updateDelNtt(int bbsNo, int nttNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bbsNo", bbsNo);
		paramMap.put("nttNo", nttNo);

		return bbsDAO.updateDelNtt(paramMap);
	}

	public void updateInqcnt(int nttNo) throws Exception {
		bbsDAO.updateInqcnt(nttNo);
	}

	public Integer updateNttSttsTy(Map<String, Object> paramMap) throws Exception {
		return bbsDAO.updateNttSttsTy(paramMap);
	}

	public List<Map<String, Object>> selectNttPrevNext(int nttNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("nttNo", nttNo);

		return bbsDAO.selectNttPrevNext(paramMap);
	}

	public List<Map<String, Object>> selectNttPrevNext(int bbsNo, int nttNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bbsNo", bbsNo);
		paramMap.put("nttNo", nttNo);

		return bbsDAO.selectNttPrevNext(paramMap);
	}

	public void updateAnswer(BbsVO nttVO) throws Exception {
		bbsDAO.updateAnswer(nttVO);
	}

	public Integer updateDelAnswer(int bbsNo, int nttNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bbsNo", bbsNo);
		paramMap.put("nttNo", nttNo);

		return bbsDAO.updateDelAnswer(paramMap);
	}

	public int selectAnswerNCnt(int bbsNo, String mberId) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bbsNo", bbsNo);
		paramMap.put("wrterId", mberId);

		return bbsDAO.selectAnswerNCnt(paramMap);
	}

}
