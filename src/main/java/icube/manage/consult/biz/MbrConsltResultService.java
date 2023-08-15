package icube.manage.consult.biz;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;

@Service("mbrConsltResultService")
public class MbrConsltResultService extends CommonAbstractServiceImpl {

	@Resource(name="mbrConsltResultDAO")
	private MbrConsltResultDAO mbrConsltResultDAO;


	public Integer insertMbrConsltBplc(MbrConsltResultVO mbrConsltResultVO) throws Exception {
		return mbrConsltResultDAO.insertMbrConsltBplc(mbrConsltResultVO);
	}



}