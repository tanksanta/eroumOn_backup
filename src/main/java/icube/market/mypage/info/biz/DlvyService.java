package icube.market.mypage.info.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.stringtemplate.v4.compiler.CodeGenerator.subtemplate_return;

import icube.common.framework.abst.CommonAbstractServiceImpl;

@Service("dlvyService")
public class DlvyService extends CommonAbstractServiceImpl {

	@Resource(name="dlvyDAO")
	private DlvyDAO dlvyDAO;


	public List<DlvyVO> selectDlvyListAll(Map<String, Object> paramMap) throws Exception {
		return dlvyDAO.selectDlvyListAll(paramMap);
	}


	public DlvyVO selectDlvy(Map<String, Object> paramMap) throws Exception {
		return dlvyDAO.selectDlvy(paramMap);
	}


	public void insertDlvyCoMng(DlvyVO dlvyVO) throws Exception {
		dlvyDAO.insertDlvyCoMng(dlvyVO);
	}


	public void updateDlvyCoMng(DlvyVO dlvyVO) throws Exception {
		dlvyDAO.updateDlvyCoMng(dlvyVO);
	}


	public void deleteDlvyCoMng(Map<String, Object> paramMap) throws Exception {
		dlvyDAO.deleteDlvyCoMng(paramMap);
	}


	public int selectBassCount(Map<String, Object> paramMap) throws Exception {
		return dlvyDAO.selectBassCount(paramMap);
	}


	/**
	 * 기본 배송지 업데이트
	 * @param paramMap2
	 * @throws Exception
	 */
	public void updateBassDlvy(Map<String, Object> paramMap) throws Exception {
		dlvyDAO.updateBassDlvy(paramMap);
	}


	public DlvyVO selectBassDlvy(String uniqueId) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", uniqueId);

		return dlvyDAO.selectBassDlvy(paramMap);
	}


	public void insertBassDlvy(DlvyVO dlvyVO) throws Exception {
		dlvyDAO.insertBassDlvy(dlvyVO);
	}

}
