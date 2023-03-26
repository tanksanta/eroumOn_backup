package icube.members.bplc.mng.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;
import icube.manage.gds.gds.biz.GdsVO;

/**
 * 사업소 상품관리
 */
@Service("bplcGdsService")
public class BplcGdsService extends CommonAbstractServiceImpl {

	@Resource(name="bplcGdsDAO")
	private BplcGdsDAO bplcGdsDAO;

	/**
	 * 사업소 등록 상품 목록
	 * @param listVO
	 * @return
	 * @throws Exception
	 */
	public CommonListVO bplcGdsListVO(CommonListVO listVO) throws Exception {
		return bplcGdsDAO.bplcGdsListVO(listVO);
	}

	/**
	 * 사업소 등록 상품 전체
	 * @param uniqueId
	 * @return
	 */
	public List<GdsVO> selectBplcGdsListAll(String uniqueId) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bplcUniqueId", uniqueId);

		return bplcGdsDAO.selectBplcGdsListAll(paramMap);
	}


	/**
	 * 사업소 상품 등록
	 * @param bplcGdsVO
	 * @return
	 */
	public Integer insertBplcGds(BplcGdsVO bplcGdsVO) throws Exception {
		return bplcGdsDAO.insertBplcGds(bplcGdsVO);
	}


	/**
	 * 사업소 상품 삭제
	 * @param bplcGds
	 */
	public void deleteBplcGds(BplcGdsVO bplcGdsVO) throws Exception{
		bplcGdsDAO.deleteBplcGds(bplcGdsVO);
	}

	public void deleteBplcGdsByUniqueId(String uniqueId) throws Exception {

		BplcGdsVO bplcGdsVO = new BplcGdsVO();
		bplcGdsVO.setUniqueId(uniqueId);

		this.deleteBplcGds(bplcGdsVO);
	}

	/**
	 * 급여 상품 사업소 전체 등록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public Integer selectInsertBplcGds(Map<String, Object> paramMap) throws Exception{
		return bplcGdsDAO.selectInsertBplcGds(paramMap);
	}

	/**
	 * 사업소 승인 시 전체 상품 등록
	 * @param paramMap
	 * @throws Exception
	 */
	public Integer selectInsertGds(Map<String, Object> paramMap) throws Exception{
		 return bplcGdsDAO.selectInsertGds(paramMap);

	}

}
