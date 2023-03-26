package icube.manage.sysmng.dlvy.biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("dlvyCoMngService")
public class DlvyCoMngService extends CommonAbstractServiceImpl {

	@Resource(name="dlvyCoMngDAO")
	private DlvyCoMngDAO dlvyCoMngDAO;

	public CommonListVO dlvyCoMngListVO(CommonListVO listVO) throws Exception {
		return dlvyCoMngDAO.dlvyCoMngListVO(listVO);
	}

	public DlvyCoMngVO selectDlvyCoMng(int dlvyCoMngNo) throws Exception {
		return dlvyCoMngDAO.selectDlvyCoMng(dlvyCoMngNo);
	}

	public DlvyCoMngVO selectDlvyCoMng(String nm) throws Exception {
		return dlvyCoMngDAO.selectDlvyCoMng(nm);
	}

	public void insertDlvyCoMng(DlvyCoMngVO dlvyCoMngVO) throws Exception {
		dlvyCoMngDAO.insertDlvyCoMng(dlvyCoMngVO);
	}

	public void updateDlvyCoMng(DlvyCoMngVO dlvyCoMngVO) throws Exception {
		dlvyCoMngDAO.updateDlvyCoMng(dlvyCoMngVO);
	}

	/**
	 * 배송업체 리스트(전체)
	 * @param useYn
	 * @return List<DlvyCoMngVO>
	 */
	public List<DlvyCoMngVO> selectDlvyCoListAll(Map<String, Object> paramMap) throws Exception {
		return dlvyCoMngDAO.selectDlvyCoListAll(paramMap);
	}

}