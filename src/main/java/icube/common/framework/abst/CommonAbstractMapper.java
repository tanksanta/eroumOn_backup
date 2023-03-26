package icube.common.framework.abst;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;

import icube.common.vo.CommonListVO;

public abstract class CommonAbstractMapper extends EgovAbstractMapper {

	protected Log log = LogFactory.getLog(this.getClass());

	public int insertIntResult(String queryId, Object parameterObject) throws Exception {
		Object obj = insert(queryId, parameterObject);
		return (Integer) obj;
	}

	public int selectInt(String query, Object object) {
		Object obj = selectOne(query, object);
		return Integer.parseInt(obj.toString());
	}

	public CommonListVO selectListVO(String countQuery, String listQuery, CommonListVO listVO) throws Exception {
		try {
			int totalCount = 0;
			int totalPage = 0;

			Object rtnObject =   selectInt(countQuery, listVO.getParamMap());
			try {
				totalCount = Integer.parseInt(rtnObject.toString());
			} catch(Exception e) {
				throw new Exception( "SELECT COUNT QUERY ERROR : " + countQuery, e);
			}

			listVO.setTotalCount(totalCount);
			List<Object> listObject = selectList(listQuery, listVO.getParamMap());
			listVO.setListObject(listObject);

			if(totalCount > 0){
				if ( totalCount % listVO.getCntPerPage() == 0) {
					totalPage = (int) ( totalCount / listVO.getCntPerPage());
				} else {
					totalPage = (int) ( totalCount / listVO.getCntPerPage()) + 1;
				}
			}
			listVO.setTotalPage(totalPage);
		} catch(Exception e) {
			throw new Exception( "LIST QUERY ERROR : " + listQuery, e);
		}
		return listVO;
	}


}
