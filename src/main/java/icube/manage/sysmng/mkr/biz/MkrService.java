package icube.manage.sysmng.mkr.biz;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("mkrService")
public class MkrService extends CommonAbstractServiceImpl {

	@Resource(name="mkrDAO")
	private MkrDAO mkrDAO;

	public CommonListVO mkrListVO(CommonListVO listVO) throws Exception {
		return mkrDAO.mkrListVO(listVO);
	}

	public MkrVO selectMkr(int mkrNo) throws Exception {
		return mkrDAO.selectMkr(mkrNo);
	}

	public MkrVO selectMkr(String mkrNm) throws Exception {
		return mkrDAO.selectMkr(mkrNm);
	}

	public List<MkrVO> selectMkrListAll() throws Exception {
		return mkrDAO.selectMkrListAll();
	}

	public void insertMkr(MkrVO mkrVO) throws Exception {
		mkrDAO.insertMkr(mkrVO);
	}

	public void updateMkr(MkrVO mkrVO) throws Exception {
		mkrDAO.updateMkr(mkrVO);
	}


}