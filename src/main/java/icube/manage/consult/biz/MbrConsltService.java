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

	/*
	@SuppressWarnings("unchecked")
	public CommonListVO formatMbrConsltVO(CommonListVO listVO) throws Exception{

		List<MbrConsltVO> consltList = listVO.getListObject();

		for(MbrConsltVO mbrConsltVO : consltList) {
			int yyyy =  EgovStringUtil.string2integer(mbrConsltVO.getBrdt().substring(0, 4));
			int mm =  EgovStringUtil.string2integer(mbrConsltVO.getBrdt().substring(4, 6));
			int dd =  EgovStringUtil.string2integer(mbrConsltVO.getBrdt().substring(6, 8));
			mbrConsltVO.setAge(DateUtil.getRealAge(yyyy, mm, dd));
		}

		return listVO;
	}
	*/

	public Integer updateMbrConslt(MbrConsltVO mbrConsltVO) throws Exception {
		return mbrConsltDAO.updateMbrConslt(mbrConsltVO);
	}


	public int updateCanclConslt(Map<String, Object> paramMap) throws Exception {
		return mbrConsltDAO.updateCanclConslt(paramMap); // 상담취소;
	}




}