package icube.common.vo;

import java.net.URLEncoder;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.egovframe.rte.fdl.string.EgovStringUtil;


@SuppressWarnings({ "rawtypes", "unchecked" })
public class CommonListVO {

	protected Log log = LogFactory.getLog(this.getClass());

	public static String  PAGE_PARAM_NAME = "curPage";
	public static String[] EXCLUDE_PARAM_NAME = {"nttNo"};

	private String curUrl;
	private String urlParam;

	private int totalCount;
	private int curPage;
	private int totalPage		= 0;
	private int startNum 		= 0;
	private int endNum 			= 10;
	private int cntPerPage 		= 10;
	private int cntPerblock 	= 10;

	private int endNumMysql		= 10; //for mySql

	private List<Object> listObject;

	private Map<Object, Object> paramMap;

	public CommonListVO() {
		if(paramMap == null) {
			paramMap = new HashMap<Object, Object>();
		}
	}

	public CommonListVO(int curPage) {
		if(paramMap == null) {
			paramMap = new HashMap<Object, Object>();
		}
		setPage(curPage);
	}


	public CommonListVO(int curPage, int cntPerPage) {
		if(paramMap == null) {
			paramMap = new HashMap<Object, Object>();
		}
		this.cntPerPage = cntPerPage;
		setPage(curPage);
	}

	public CommonListVO(HttpServletRequest request) {
		curPage = EgovStringUtil.string2integer(request.getParameter(PAGE_PARAM_NAME), 1) ;

		if( EgovStringUtil.isNotEmpty(request.getParameter("cntPerPage")) ) {
			this.cntPerPage = Integer.parseInt(request.getParameter("cntPerPage") );
		}

		initListVO(request, curPage, cntPerPage);
	}

	public CommonListVO(HttpServletRequest request, int curPage) {
		if(paramMap == null) {
			paramMap = new HashMap<Object, Object>();
		}

		if( EgovStringUtil.isNotEmpty(request.getParameter("cntPerPage")) ) {
			this.cntPerPage = Integer.parseInt(request.getParameter("cntPerPage") );
		}

		initListVO(request, curPage, cntPerPage);
	}

	public CommonListVO(HttpServletRequest request, int curPage, int cntPerPage) {
		initListVO(request, curPage, cntPerPage);
	}


	private void initListVO(HttpServletRequest request, int curPage, int cntPerPage) {

		if(paramMap == null) {
			paramMap = new HashMap<Object, Object>();
		}

		this.curPage = curPage;
		setCntPerPage(cntPerPage);

		String url = request.getRequestURI();
		setCurUrl(url);

		StringBuffer paramBuf = new StringBuffer();
		Enumeration eParam = request.getParameterNames();
		while (eParam.hasMoreElements()) {
			String pName = (String)eParam.nextElement();
			String pValue = request.getParameter(pName);
			if(!PAGE_PARAM_NAME.equals(pName)
					&& !ArrayUtils.contains(EXCLUDE_PARAM_NAME, pName)) {
				if(paramBuf.length() > 0) {
					paramBuf.append("&amp;");
				}
				try{
					paramBuf.append(pName + "=" + URLEncoder.encode(pValue, "UTF-8"));
					//System.out.println("param=" + pName + "=" + URLEncoder.encode(pValue, "UTF-8"));
				}catch(Exception e){}

				paramMap.put(pName, pValue);
			}
		}

		setUrlParam(paramBuf.toString());
	}

	private void setPage(int curPage) {
		this.curPage = curPage;

		startNum = ((curPage-1) * this.cntPerPage );
		endNum = startNum + (cntPerPage);
		endNumMysql = cntPerPage;

		paramMap.put("startNum", startNum);
		paramMap.put("endNum", endNum);
		paramMap.put("endNumMysql", endNumMysql);
		paramMap.put("cntPerPage", cntPerPage);
		paramMap.put("curPage", curPage);
	}

	public int getCntPerPage() {
		return cntPerPage;
	}

	public void setCntPerPage(int cntPerPage) {
		this.cntPerPage = cntPerPage;
		setPage(this.curPage);
	}

	public int getTotalCount() {
		return totalCount;
	}


	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getCntPerblock() {
		return cntPerblock;
	}

	public void setCntPerblock(int cntPerblock) {
		this.cntPerblock = cntPerblock;
	}

	public String getCurUrl() {
		return curUrl;
	}

	public void setCurUrl(String curUrl) {
		this.curUrl = curUrl;
	}

	public List getListObject() {
		return listObject;
	}

	public void setListObject(List listObject) {
		this.listObject = listObject;
	}

	public String getUrlParam() {
		return urlParam;
	}

	public void setUrlParam(String urlParam) {
		this.urlParam = urlParam;
	}

	public void setParam(String key, String value ) {
		this.paramMap.put(key, value);
	}

	public void setParam(String key, String[] value ) {
		this.paramMap.put(key, value);
	}

	public void setParam(String key, int value) {
		this.paramMap.put(key, value);
	}

	public void setParam(String key, long value){
		this.paramMap.put(key, value);
	}

	public void setParam(String key, List value){//list type 추가
		this.paramMap.put(key, value);
	}

	public String getParam(String key) {
		return (String)this.paramMap.get(key);
	}

	public List getParamList(String key) {
		return (List)this.paramMap.get(key);
	}

	public Map getParamMap() {
		return paramMap;
	}

	public void setParamMap(Map paramMap) {
		this.paramMap = paramMap;
	}

	public int getTotalPage() {
		if( totalPage == 0 ) {
			if ( totalCount % cntPerPage == 0) {
				totalPage = (int) ( totalCount / cntPerPage);
			} else {
				totalPage = (int) ( totalCount / cntPerPage) + 1;
			}
		}
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getStartNo() {
		return this.totalCount - ( cntPerPage *  (curPage - 1) );
	}

	public String getPageParam(String[] targetParams) {
		Map paramMap = this.getParamMap();
		Iterator<String> keys = paramMap.keySet().iterator();
		StringBuffer sbParam = new StringBuffer();
		String parameter = "";

		while(keys.hasNext()){
			String key = keys.next();
			if (Arrays.asList(targetParams).contains(key)) {
				sbParam.append(key + "=" + paramMap.get(key) + "&");
			}
		}
		parameter = sbParam.toString();

		if (parameter.length() > 0) {
			parameter = parameter.substring(0, parameter.length() - 1);
		}

		return parameter;
	}

}
