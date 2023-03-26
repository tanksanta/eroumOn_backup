package icube.manage.consult.biz;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("mbrInqryDAO")
public class MbrInqryDAO extends CommonAbstractMapper {

	public CommonListVO mbrInqryListVO(CommonListVO listVO) throws Exception {
		return selectListVO("inqry.selectMbrInqryCount", "inqry.selectMbrInqryListVO", listVO);
	}

	public MbrInqryVO selectMbrInqry(int mbrInqryNo) throws Exception {
		return (MbrInqryVO)selectOne("inqry.selectMbrInqry", mbrInqryNo);
	}

	public void insertMbrInqry(MbrInqryVO mbrInqryVO) throws Exception {
		insert("inqry.insertMbrInqry", mbrInqryVO);
	}

	public void updateMbrInqry(MbrInqryVO mbrInqryVO) throws Exception {
		update("inqry.updateMbrInqry", mbrInqryVO);
	}

	public void updateAnsInqry(MbrInqryVO mbrInqryVO) throws Exception{
		insert("inqry.updateAnsInqry",mbrInqryVO);
	}

	public void deleteInqry(int inqryNo) throws Exception {
		update("inqry.deleteInqry",inqryNo);
	}
}