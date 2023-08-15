package icube.manage.consult.biz;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("mbrConsltResultDAO")
public class MbrConsltResultDAO extends CommonAbstractMapper {

	public Integer insertMbrConsltBplc(MbrConsltResultVO mbrConsltResultVO) throws Exception {
		return insert("conslt.result.insertMbrConsltBplc", mbrConsltResultVO);
	}

}