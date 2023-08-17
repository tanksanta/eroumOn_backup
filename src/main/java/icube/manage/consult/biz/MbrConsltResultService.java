package icube.manage.consult.biz;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("mbrConsltResultService")
public class MbrConsltResultService extends CommonAbstractServiceImpl {

	@Resource(name="mbrConsltResultDAO")
	private MbrConsltResultDAO mbrConsltResultDAO;

	public CommonListVO selectMbrConsltResultListVO(CommonListVO listVO) throws Exception {
		return mbrConsltResultDAO.selectMbrConsltResultListVO(listVO);
	}

	public Integer insertMbrConsltBplc(MbrConsltResultVO mbrConsltResultVO) throws Exception {
		return mbrConsltResultDAO.insertMbrConsltBplc(mbrConsltResultVO);
	}

	public Integer updateDtlsConslt(MbrConsltResultVO mbrConsltResultVO) throws Exception {
		return mbrConsltResultDAO.updateDtlsConslt(mbrConsltResultVO);
	}

	public MbrConsltResultVO selectMbrConsltBplc(Map<String, Object> paramMap) throws Exception {
		return mbrConsltResultDAO.selectMbrConsltBplc(paramMap);
	}



}