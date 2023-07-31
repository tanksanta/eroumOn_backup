package icube.manage.sysmng.code.biz;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.cache.EhcacheService;
import icube.common.framework.abst.CommonAbstractServiceImpl;
import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;

@SuppressWarnings("unchecked")
@Service("codeService")
public class CodeService extends CommonAbstractServiceImpl {

	@Resource(name = "codeDAO")
	private CodeDAO codeDAO;
	
	@Resource(name = "icube.ehcache.icubeCodeCache")
	Ehcache icubeCodeCache;
	
	@Resource(name = "ehcacheService")
	EhcacheService ehcacheService;
	
	public List<CodeVO> selectCodeList() throws Exception {
		return codeDAO.selectCodeList();
	}

	public List<CodeVO> selectCodeList(String upperCodeId) throws Exception {
		
		String cacheNm = "codeCache_" + upperCodeId;
		
		Element el = icubeCodeCache.get(cacheNm);
		if (el == null) {
			log.debug("#### cache is not defined");
			
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("upperCodeId", upperCodeId);
			
			List<CodeVO> codeList = codeDAO.selectCodeListByFilter(paramMap);
			icubeCodeCache.put(new Element(cacheNm, codeList));

			el = icubeCodeCache.get(cacheNm);
		} else {
			log.debug("#### already cached: " + cacheNm);
		}
		
		//return codeDAO.selectCodeListByFilter(paramMap);
		return (List<CodeVO>) el.getObjectValue();
	}
	
	public Map<String, Object> selectCodeListToMap(String upperCodeId) throws Exception {

		List<CodeVO> codeList = this.selectCodeList(upperCodeId);
		
		Map<String, Object> returnMap = new LinkedHashMap<String, Object>();
		for(CodeVO codeVO : codeList) {
			returnMap.put(codeVO.getCdId(), codeVO.getCdNm());
		}

		return returnMap;
	}
	
	public CodeVO selectCode(String upperCodeId, String codeId) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("upperCodeId", upperCodeId);
		paramMap.put("codeId", codeId);
		
		return codeDAO.selectCode(paramMap);
	}
	
	public void insertCode(CodeVO codeVO) throws Exception {

		codeDAO.insertCode(codeVO);
		ehcacheService.removeAllCaches("code");
	}

	public void updateCode(CodeVO codeVO) throws Exception {
		
		codeDAO.updateCode(codeVO);
		ehcacheService.removeAllCaches("code");
	}

	public void deleteCode(CodeVO codeVO) throws Exception {

		codeDAO.deleteCode(codeVO);
		ehcacheService.removeAllCaches("code");
	}

	public int updateCodeNm(Map<String, Object> reqMap) throws Exception {
		int result = codeDAO.updateCodeNm(reqMap);
		ehcacheService.removeAllCaches("code");
		return result;
	}

	public void moveCode(CodeVO codeVO, String sortSeq) throws Exception {
		String[] sortedCodeIds = sortSeq.split(",");

		for(int i=0; i<sortedCodeIds.length; i++) {
			log.debug(" ## menu sort  " + sortedCodeIds[i] + " index " + i);
			codeVO.setSortNo(i+1);
			codeVO.setCdId(sortedCodeIds[i]);
			codeDAO.updateCodePosition(codeVO);
		}		
	}

	
	
}
