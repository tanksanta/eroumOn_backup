package icube.manage.mbr.recipter.biz;

import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("recipterInfoDAO")
public class RecipterInfoDAO extends CommonAbstractMapper{

	// 장기요양정보 업데이트
	public void mergeRecipter(RecipterInfoVO recipterInfoVO) throws Exception {
		insert("recipter.mergeRecipter",recipterInfoVO);
	}

	// 수급자 정보 삭제
	public void deleteRecipter(Map<String, Object> paramMap) throws Exception{
		delete("recipter.deleteRecipter",paramMap);
	}

	// 수급자 정보 조회
	public RecipterInfoVO selectRecipterInfo(Map<String, Object> paramMap) throws Exception {
		return selectOne("recipter.selectRecipter",paramMap);
	}


}
