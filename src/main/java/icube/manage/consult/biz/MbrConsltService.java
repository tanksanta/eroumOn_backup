package icube.manage.consult.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.util.DateUtil;
import icube.common.vo.CommonListVO;

@Service("mbrConsltService")
public class MbrConsltService extends CommonAbstractServiceImpl {

	@Resource(name="mbrConsltDAO")
	private MbrConsltDAO mbrConsltDAO;

	@Resource(name="mbrConsltResultDAO")
	private MbrConsltResultDAO mbrConsltResultDAO;
	
	@Resource(name="mbrConsltMemoDAO")
	private MbrConsltMemoDAO mbrConsltMemoDAO;
	
	@Resource(name="mbrConsltChgHistDAO")
	private MbrConsltChgHistDAO mbrConsltChgHistDAO;
	
	public CommonListVO selectMbrConsltListVO(CommonListVO listVO) throws Exception {

		listVO = mbrConsltDAO.selectMbrConsltListVO(listVO);

		List<MbrConsltVO> consltList = listVO.getListObject();
		for(MbrConsltVO mbrConsltVO : consltList) {
			int yyyy =  EgovStringUtil.string2integer(mbrConsltVO.getBrdt().substring(0, 4));
			int mm =  EgovStringUtil.string2integer(mbrConsltVO.getBrdt().substring(4, 6));
			int dd =  EgovStringUtil.string2integer(mbrConsltVO.getBrdt().substring(6, 8));
			mbrConsltVO.setAge(DateUtil.getRealAge(yyyy, mm, dd));
		}

		return listVO;
	}

	public Integer updateUseYn(int consltNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("consltNo", consltNo);
		paramMap.put("useYn", "N");
		return mbrConsltDAO.updateUseYn(paramMap);
	}

	public MbrConsltVO selectMbrConslt(String uniqueId) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchRegUniqueId", uniqueId);
		return selectMbrConslt(paramMap);
	}

	public MbrConsltVO selectMbrConslt(Map<String, Object> paramMap) throws Exception {
		return mbrConsltDAO.selectMbrConslt(paramMap);
	}

	public Integer insertMbrConslt(MbrConsltVO mbrConsltVO) throws Exception {
		return mbrConsltDAO.insertMbrConslt(mbrConsltVO);
	}

	public Integer updateMbrConslt(MbrConsltVO mbrConsltVO) throws Exception {
		return mbrConsltDAO.updateMbrConslt(mbrConsltVO);
	}


	public int updateCanclConslt(Map<String, Object> paramMap) throws Exception {
		// 관리자에서 취소시 사업소 지정된 데이터도 취소 처리
		// updateCanclConslt
		mbrConsltResultDAO.updateCanclConslt(paramMap);
		return mbrConsltDAO.updateCanclConslt(paramMap); // 상담취소;
	}
	
	public int updateMngMemo(Map<String, Object> paramMap) throws Exception {
		return mbrConsltDAO.updateMngMemo(paramMap);
	}

	public List<MbrConsltVO> selectListForExcel(Map<String, Object> paramMap) throws Exception {
		return mbrConsltDAO.selectListForExcel(paramMap);
	}

	public Integer insertMbrConsltMemo(MbrConsltMemoVO mbrConsltMemoVO) throws Exception {
		return mbrConsltMemoDAO.insertMbrConsltMemo(mbrConsltMemoVO);
	}

	public MbrConsltVO selectLastMbrConsltForCreate(Map<String, Object> paramMap) throws Exception {
		return mbrConsltDAO.selectLastMbrConsltForCreate(paramMap);
	}
	
	public MbrConsltVO selectConsltInProcess(String uniqueId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("srchUniqueId", uniqueId);
		return mbrConsltDAO.selectConsltInProcess(param);
	}
	
	public Integer insertMbrConsltChgHist(MbrConsltChgHistVO mbrConsltChgHistVO) throws Exception {
		return mbrConsltChgHistDAO.insertMbrConsltChgHist(mbrConsltChgHistVO);
	}
	
	public List<MbrConsltMemoVO> selectMbrConsltMemo(Map<String, Object> paramMap) throws Exception {
		return mbrConsltMemoDAO.selectMbrConsltMemo(paramMap);
	}
	
	public List<MbrConsltChgHistVO> selectMbrConsltChgHist(Map<String, Object> paramMap) throws Exception {
		return mbrConsltChgHistDAO.selectMbrConsltChgHist(paramMap);
	}
	
	public MbrConsltChgHistVO selectMbrConsltChgHistByChgNo(int chgNo) throws Exception {
		Map<String, Object> srchParam = new HashMap<String, Object>();
		srchParam.put("srchChgNo", chgNo);
		
		List<MbrConsltChgHistVO> chgHistList = mbrConsltChgHistDAO.selectMbrConsltChgHist(srchParam);
		if (chgHistList.size() > 0) {
			return chgHistList.get(0);
		} else {
			return null;
		}
	}
	
	public MbrConsltVO selectRecentConsltByRecipientsNo(int RecipientsNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchRecipientsNo", RecipientsNo);
		return mbrConsltDAO.selectRecentConsltByRecipientsNo(paramMap);
	}
}