package icube.manage.sysmng.terms;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("termsService")
public class TermsService {
    @Resource(name = "termsDAO")
	private TermsDAO termsDAO;

    public List<TermsVO> selectListVO(Map<String, Object> paramMap) throws Exception {
        return termsDAO.selectListVO(paramMap);
    }

    public TermsVO selectTermsOne(int termsNo) throws Exception {
		return termsDAO.selectTermsOne(termsNo);
	}

    public int insertTermsOne(TermsVO vo) throws Exception {
		return termsDAO.insertTermsOne(vo);
	}

    public int updateTermsOne(TermsVO vo) throws Exception {
		return termsDAO.updateTermsOne(vo);
	}
}
