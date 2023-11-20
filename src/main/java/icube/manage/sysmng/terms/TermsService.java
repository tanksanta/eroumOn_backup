package icube.manage.sysmng.terms;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("termsService")
public class TermsService {
    @Resource(name = "termsDAO")
	private TermsDAO termsDAO;

    /*관리자 화면에서 리스트 조회*/
    public List<TermsVO> selectListMngVO(Map<String, Object> paramMap) throws Exception {
        return termsDAO.selectListVO(paramMap);
    }

    /*일반 사용자 화면에서 조회*/
    public List<TermsVO> selectListMemberVO(String termsKind) throws Exception {
        Map<String, Object> paramMap = new HashMap<String, Object>();

			paramMap.put("srchTermsKind", termsKind.toUpperCase());
			paramMap.put("srchPublicYn", "Y");
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

	/*사용 여부(최종)*/
	public int updateTermsUseYnOtherN(TermsVO vo) throws Exception {
		return termsDAO.updateTermsUseYnOtherN(vo);
	}
}
