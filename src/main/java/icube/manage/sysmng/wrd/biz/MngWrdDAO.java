package icube.manage.sysmng.wrd.biz;


import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("mngWrdDAO")
public class MngWrdDAO extends CommonAbstractMapper {

	public CommonListVO selectMngWrdListVO(CommonListVO listVO) throws Exception {
		return selectListVO("wrd.selectMngWrdListCount", "wrd.selectMngWrdListVO", listVO);
	}


	public MngWrdVO selectMngWrd(int wrdNo) throws Exception {
		return selectOne("wrd.selectMngWrd",wrdNo);
	}

	public MngWrdVO selectMngWrdNm(String wrdNm) throws Exception {
		return selectOne("wrd.selectMngWrdNm",wrdNm);
	}

	public void insertMngWrd(MngWrdVO mngWrdVO) throws Exception {
		insert("wrd.insertMngWrd",mngWrdVO);
	}

	public void updateMngWrd(MngWrdVO mngWrdVO) throws Exception{
		update("wrd.updateMngWrd", mngWrdVO);
	}
}