package icube.manage.sysmng.code.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("codeDAO")
public class CodeDAO extends CommonAbstractMapper {

	public List<CodeVO> selectCodeList() throws Exception {
		return selectList("code.selectCodeList");
	}

	public List<CodeVO> selectCodeListByFilter(Map<String, Object> paramMap) throws Exception {
		return selectList("code.selectCodeListByFilter",  paramMap);
	}

	public CodeVO selectCode(Map<String, Object> reqMap) throws Exception {
		return selectOne("code.selectCode", reqMap);
	}
	
	public void insertCode(CodeVO codeVO) throws Exception {
		insert("code.insertCode", codeVO);
	}

	public void updateCode(CodeVO codeVO) throws Exception {
		update("code.updateCode", codeVO);
	}
	
	public void deleteCode(CodeVO codeVO) throws Exception {
		delete("code.deleteCode", codeVO);
	}

	public int updateCodeNm(Map<String, Object> reqMap) throws Exception {
		return update("code.updateCodeNm", reqMap);
	}

	public int updateCodePosition(CodeVO codeVO) throws Exception {
		return update("code.updateCodePosition", codeVO);
	}
}
