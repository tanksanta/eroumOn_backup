package icube.manage.sysmng.terms;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;



@Repository("termsDAO")
public class TermsDAO extends CommonAbstractMapper {
   
    public List<TermsVO> selectListVO(Map<String, Object> paramMap) throws Exception {
		return selectList("terms.selectListVO", paramMap);
	}

    public TermsVO selectTermsOne(int no) throws Exception {
		return selectOne("terms.selectTermsOne", no);
	}

	public int insertTermsOne(TermsVO vo) throws Exception {
		return insert("terms.insertTerms", vo);
	}

	public int updateTermsOne(TermsVO vo) throws Exception {
		return update("terms.updateTermsOne", vo);
	}

	/*사용 여부(최종)*/
	public int updateTermsUseYnOtherN(TermsVO vo) throws Exception {
		return update("terms.updateTermsUseYnOtherN", vo);
	}
}
