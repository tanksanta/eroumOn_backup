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

@Service("mbrConsltResultService")
public class MbrConsltResultService extends CommonAbstractServiceImpl {

	@Resource(name="mbrConsltDAO")
	private MbrConsltDAO mbrConsltDAO;

	@Resource(name="mbrConsltResultDAO")
	private MbrConsltResultDAO mbrConsltResultDAO;

	public CommonListVO selectMbrConsltResultListVO(CommonListVO listVO) throws Exception {

		listVO = mbrConsltResultDAO.selectMbrConsltResultListVO(listVO);

		List<MbrConsltResultVO> consltList = listVO.getListObject();
		for(MbrConsltResultVO mbrConsltResultVO : consltList) {
			int yyyy =  EgovStringUtil.string2integer(mbrConsltResultVO.getMbrConsltInfo().getBrdt().substring(0, 4));
			int mm =  EgovStringUtil.string2integer(mbrConsltResultVO.getMbrConsltInfo().getBrdt().substring(4, 6));
			int dd =  EgovStringUtil.string2integer(mbrConsltResultVO.getMbrConsltInfo().getBrdt().substring(6, 8));
			mbrConsltResultVO.getMbrConsltInfo().setAge(DateUtil.getRealAge(yyyy, mm, dd));
		}

		return listVO;
	}

	public int insertMbrConsltBplc(MbrConsltResultVO mbrConsltResultVO) throws Exception {
		return mbrConsltResultDAO.insertMbrConsltBplc(mbrConsltResultVO);
	}

	public int updateDtlsConslt(MbrConsltResultVO mbrConsltResultVO) throws Exception {

		Map<String, Object> paramMap = new HashMap<String,Object>();
		paramMap.put("consltNo", mbrConsltResultVO.getConsltNo());
		paramMap.put("consltSttus", "CS06"); // 상담완료
		mbrConsltDAO.updateSttus(paramMap);

		return mbrConsltResultDAO.updateDtlsConslt(mbrConsltResultVO);
	}

	public MbrConsltResultVO selectMbrConsltBplc(Map<String, Object> paramMap) throws Exception {
		return mbrConsltResultDAO.selectMbrConsltBplc(paramMap);
	}

	// 사업소에서 취소(같은 상태로 업데이트)
	public int updateCanclConslt(Map<String, Object> paramMap) throws Exception {
		mbrConsltDAO.updateCanclConslt(paramMap); // 상담취소
		return mbrConsltResultDAO.updateCanclConslt(paramMap); // 사업소 상담취소
	}

	// 사업소에서 상태 변경 (같은 상태로 업데이트)
	public int updateSttus(Map<String, Object> paramMap) throws Exception {
		mbrConsltDAO.updateSttus(paramMap);
		return mbrConsltResultDAO.updateSttus(paramMap);
	}
	
	// 사업소 제외하고 상담만 상태 변경
	public int updateSttusWithOutResult(Map<String, Object> paramMap) throws Exception {
		return mbrConsltDAO.updateSttus(paramMap);
	}

	public void deleteMbrConsltBplc(MbrConsltResultVO mbrConsltResultVO) throws Exception {
		mbrConsltResultDAO.deleteMbrConsltBplc(mbrConsltResultVO);
	}

	// 상담 재신청
	public int updateReConslt(MbrConsltResultVO mbrConsltResultVO) throws Exception {

		//상태값 변경
		Map<String, Object> paramMap = new HashMap<String,Object>();
		paramMap.put("consltNo", mbrConsltResultVO.getConsltNo());
		paramMap.put("consltSttus", "CS07"); // 재접수
		mbrConsltDAO.updateSttus(paramMap);

		//재신청 사유만 업데이트
		return mbrConsltResultDAO.updateReConslt(mbrConsltResultVO);

	}

	public List<MbrConsltResultVO> selectListForExcel(Map<String, Object> paramMap) throws Exception {
		return mbrConsltResultDAO.selectListForExcel(paramMap);
	}


}