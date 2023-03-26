package icube.manage.consult.biz;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("gdsQaDAO")
public class GdsQaDAO extends CommonAbstractMapper {

	public CommonListVO gdsQaListVO(CommonListVO listVO) throws Exception {
		return selectListVO("gds.qa.selectGdsQaCount", "gds.qa.selectGdsQaListVO", listVO);
	}

	public GdsQaVO selectGdsQa(int gdsQaNo) throws Exception {
		return (GdsQaVO)selectOne("gds.qa.selectGdsQa", gdsQaNo);
	}

	public void insertGdsQa(GdsQaVO gdsQaVO) throws Exception {
		insert("gds.qa.insertGdsQa", gdsQaVO);
	}

	public void updateGdsQa(GdsQaVO gdsQaVO) throws Exception {
		update("gds.qa.updateGdsQa", gdsQaVO);
	}

	public void deleteGdsQa(int gdsQaNo) throws Exception {
		delete("gds.qa.deleteGdsQa", gdsQaNo);
	}

	public void updateGdsQaAns(GdsQaVO gdsQaVO) throws Exception {
		update("gds.qa.updateGdsQaAns",gdsQaVO);
	}

}