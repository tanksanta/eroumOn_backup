package icube.manage.gds.ctgry.biz;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Service;

import icube.common.cache.EhcacheService;
import icube.common.framework.abst.CommonAbstractServiceImpl;
import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;

@Service("gdsCtgryService")
public class GdsCtgryService extends CommonAbstractServiceImpl {

	@Resource(name = "gdsCtgryDAO")
	private GdsCtgryDAO gdsCtgryDAO;

	@Resource(name = "icube.ehcache.gdsCtgryCache")
	Ehcache gdsCtgryCache;

	@Resource(name = "ehcacheService")
	EhcacheService ehcacheService;

	public List<GdsCtgryVO> selectGdsCtgryList() throws Exception {
		return gdsCtgryDAO.selectGdsCtgryList();
	}


	public List<GdsCtgryVO> selectGdsCtgryList(int upCtgryNo) throws Exception {
		return selectGdsCtgryList(upCtgryNo, null);
	}

	@SuppressWarnings("unchecked")
	public List<GdsCtgryVO> selectGdsCtgryList(int upCtgryNo, String useYn) throws Exception {

		String cacheNm = "gdsCtgryCache_" + upCtgryNo;

		Element el = gdsCtgryCache.get(cacheNm);
		if (el == null) {
			log.debug("#### cache is not defined");


			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("upCtgryNo", upCtgryNo);
			paramMap.put("useYn", useYn);

			System.out.println("paramMap: " + paramMap.toString());

			List<GdsCtgryVO> gdsCtgryList = gdsCtgryDAO.selectGdsCtgryListByFilter(paramMap);
			gdsCtgryCache.put(new Element(cacheNm, gdsCtgryList));

			el = gdsCtgryCache.get(cacheNm);
		} else {
			log.debug("#### already cached: " + cacheNm);
		}

		return (List<GdsCtgryVO>) el.getObjectValue();
	}

	public Map<Integer, String> selectGdsCtgryListToMap(int upCtgryNo) throws Exception {

		List<GdsCtgryVO> gdsCtgryList = this.selectGdsCtgryList(upCtgryNo);

		Map<Integer, String> returnMap = new LinkedHashMap<Integer, String>();
		for(GdsCtgryVO gdsCtgryVO : gdsCtgryList) {
			returnMap.put(gdsCtgryVO.getCtgryNo(), gdsCtgryVO.getCtgryNm());
		}

		return returnMap;
	}

	public GdsCtgryVO selectGdsCtgry(int upCtgryNo, int ctgryNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("upCtgryNo", upCtgryNo);
		paramMap.put("ctgryNo", ctgryNo);

		return gdsCtgryDAO.selectGdsCtgry(paramMap);
	}

	public GdsCtgryVO selectGdsCtgryNo(Map<String, Object> paramMap) throws Exception{
		return gdsCtgryDAO.selectGdsCtgryNo(paramMap);
	}
	
	public List<GdsCtgryVO> selectGdsCtgryNoList(Map<String, Object> paramMap) throws Exception {
		return gdsCtgryDAO.selectGdsCtgryNoList(paramMap);
	}

	public void insertGdsCtgry(GdsCtgryVO gdsCtgryVO) throws Exception {

		gdsCtgryDAO.insertGdsCtgry(gdsCtgryVO);
		ehcacheService.removeAllCaches("gdsCtgry");
	}

	public void updateGdsCtgry(GdsCtgryVO gdsCtgryVO) throws Exception {

		gdsCtgryDAO.updateGdsCtgry(gdsCtgryVO);
		ehcacheService.removeAllCaches("gdsCtgry");
	}

	public void deleteGdsCtgry(GdsCtgryVO gdsCtgryVO) throws Exception {

		gdsCtgryDAO.deleteGdsCtgry(gdsCtgryVO);
		ehcacheService.removeAllCaches("gdsCtgry");
	}

	public int updateGdsCtgryNm(Map<String, Object> reqMap) throws Exception {
		int result = gdsCtgryDAO.updateGdsCtgryNm(reqMap);
		ehcacheService.removeAllCaches("gdsCtgry");
		return result;
	}

	public void moveGdsCtgry(GdsCtgryVO gdsCtgryVO, String sortSeq) throws Exception {
		String[] sortedCtgryNos = sortSeq.split(",");

		for(int i=0; i<sortedCtgryNos.length; i++) {
			log.debug(" ## menu sort  " + sortedCtgryNos[i] + " index " + i);
			gdsCtgryVO.setSortNo(i+1);
			gdsCtgryVO.setCtgryNo(EgovStringUtil.string2integer(sortedCtgryNos[i]));
			gdsCtgryDAO.updateGdsCtgryPosition(gdsCtgryVO);
		}

		ehcacheService.removeAllCaches("gdsCtgry");
	}


	public void updateGdsCtgryImg(GdsCtgryVO ctgryVO) throws Exception {
		gdsCtgryDAO.updateGdsCtgryImg(ctgryVO);
		ehcacheService.removeAllCaches("gdsCtgry");
	}


	public GdsCtgryVO findRootCategory(List<GdsCtgryVO> dataList) {
        for (GdsCtgryVO category : dataList) {
            if (category.getUpCtgryNo() == 0) {
                return category;
            }
        }
        return null;
    }

	public GdsCtgryVO findChildCategory(List<GdsCtgryVO> dataList, int ctgryNo) {
        for (GdsCtgryVO category : dataList) {
            if (category.getCtgryNo() == ctgryNo) {
                return category;
            }
        }
        return null;
    }

	public void printCategoryTree(GdsCtgryVO category, String prefix) {
        System.out.println(prefix + "|_" + category.getCtgryNm());
        List<GdsCtgryVO> children = category.getChildList();
        for (GdsCtgryVO child : children) {
            printCategoryTree(child, prefix + "   ");
        }
    }


	public String selectGdsCtgryNoPath(Map<String, Object> paramMap) throws Exception {
		return gdsCtgryDAO.selectGdsCtgryNoPath(paramMap);
	}

}
