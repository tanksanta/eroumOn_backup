package icube.common.cache;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.math.NumberUtils;
import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;

/**
 * 공통으로 사용하는 cache에 대한 삭제 로직 구현
 * 다중서버일경우 core의 ehcache.xml에서 설정(RMI, Multicast 등)하여 사용
 */
@SuppressWarnings("rawtypes")
@Service("ehcacheService")
public class EhcacheService extends CommonAbstractServiceImpl {

    @Resource(name="icube.ehcache.icubeCommonCache")
    Ehcache icubeCommonCache;

	@Resource(name="icube.ehcache.icubeCodeCache")
	Ehcache icubeCodeCache;

	@Resource(name = "icube.ehcache.gdsCtgryCache")
	Ehcache gdsCtgryCache;

	private String deadlineKeyStr = "__dlks_";

	public void setCacheWithDeadline(String targetCache, String cacheCode, int deadlineSec, Object valueObj) throws Exception {

		if(deadlineSec < 1) {
			deadlineSec = 60;
		}

		String deadlineKey = cacheCode + deadlineKeyStr;
		Date date = new Date();
		String dateline = Long.toString(date.getTime() + (deadlineSec * 1000));

		if("common".equals(targetCache)) {
			icubeCommonCache.put(new Element(cacheCode, valueObj));
			icubeCommonCache.put(new Element(deadlineKey, dateline));
		}else if("code".equals(targetCache)) {
			icubeCodeCache.put(new Element(cacheCode, valueObj));
			icubeCodeCache.put(new Element(deadlineKey, dateline));
		}else if("gdsCtgry".equals(targetCache)) {
			gdsCtgryCache.put(new Element(cacheCode, valueObj));
			gdsCtgryCache.put(new Element(deadlineKey, dateline));
		}

	}

	public Object getCache(String targetCache, String cacheCode) throws Exception {

		Element el = null;

		if("common".equals(targetCache)) {
			el = icubeCommonCache.get(cacheCode);
		}
		else if("code".equals(targetCache)) {
			el = icubeCodeCache.get(cacheCode);
		}
		else if("gdsCtgry".equals(targetCache)) {
			el = gdsCtgryCache.get(cacheCode);
		}

		if(el != null) {
			return el.getObjectValue();
		}
		return null;
	}

	public boolean isExpiredCache(String targetCache, String cacheCode) throws Exception {

		String deadlineKey = cacheCode + deadlineKeyStr;

		Element el = null;

		if("common".equals(targetCache)) {
			el = icubeCommonCache.get(deadlineKey);
		}
		else if("code".equals(targetCache)) {
			el = icubeCodeCache.get(deadlineKey);
		}
		else if("gdsCtgry".equals(targetCache)) {
			el = gdsCtgryCache.get(deadlineKey);
		}

		if(el != null) {
			long deadline = NumberUtils.toLong(el.getObjectValue().toString(), 0L);
			if((new Date()).before(new Date(deadline))) {
				return false;
			}
		}

		return true;
	}

	public void removeCache(String targetCache, String cacheCode) throws Exception {

		// 로컬서버 IP 주소
		InetAddress inet = null;
		try {
			inet = InetAddress.getLocalHost();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
    	if (EgovStringUtil.isEmpty(cacheCode)) throw new IllegalArgumentException();


		/**
		 * 캐시 존재 여부 판단 구문 변경 : 만료된 캐시도 삭제
		 * - AS-IS::
		 *  Element el = icubeCodeCache.get(cacheCode);
		 *  if (!(el == null || "".equals(el))) {
		 * - TO-BE::
		 *  if (icubeCodeCache.get(cacheCode)) {
		 */
    	if(EgovStringUtil.equals("code", targetCache)){
    		if (icubeCodeCache.isKeyInCache(cacheCode)) {
    			icubeCodeCache.remove(cacheCode);
    		}
    	}else if(EgovStringUtil.equals("common", targetCache)){
    		if (icubeCommonCache.isKeyInCache(cacheCode)) {
        		icubeCommonCache.remove(cacheCode);
        	}
    	}else if(EgovStringUtil.equals("gdsCtgry", targetCache)){
    		if (gdsCtgryCache.isKeyInCache(cacheCode)) {
    			gdsCtgryCache.remove(cacheCode);
        	}
    	}

    	log.debug("#### " + inet.getHostAddress() + " removeCache End");

	}

	public void removeAllCaches(String targetCache) throws Exception {
		// 로컬서버 IP 주소
		InetAddress inet = null;
		try {
			inet = InetAddress.getLocalHost();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}

    	List cacheKeyList = null;

    	if(EgovStringUtil.equals("code", targetCache)){
    		cacheKeyList = icubeCodeCache.getKeys();
    	}else if(EgovStringUtil.equals("common", targetCache)){
    		cacheKeyList = icubeCommonCache.getKeys();
    	}else if(EgovStringUtil.equals("gdsCtgry", targetCache)){
    		cacheKeyList = gdsCtgryCache.getKeys();
    	}

    	if(cacheKeyList != null) {
	    	for (int i=0; i<cacheKeyList.size(); i++) {

	    		String cacheKey = (String) cacheKeyList.get(i);

	        	if(EgovStringUtil.equals("code", targetCache)){
	        		if (icubeCodeCache.isKeyInCache(cacheKey)) {
	        			icubeCodeCache.remove(cacheKey);
	        		}
	        	}else if(EgovStringUtil.equals("common", targetCache)){
	        		if (icubeCommonCache.isKeyInCache(cacheKey)) {
	            		icubeCommonCache.remove(cacheKey);
	            	}
	        	}else if(EgovStringUtil.equals("gdsCtgry", targetCache)){
	        		if (gdsCtgryCache.isKeyInCache(cacheKey)) {
	        			gdsCtgryCache.remove(cacheKey);
	            	}
	        	}

			}
    	}

	}

}
