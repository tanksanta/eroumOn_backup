package icube.manage.consult.biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("gdsReviewService")
public class GdsReviewService extends CommonAbstractServiceImpl {

	@Resource(name="gdsReviewDAO")
	private GdsReviewDAO gdsReviewDAO;

	/**
	 * 상품후기 목록 (포토,일반)
	 * @param listVO
	 * @return
	 * @throws Exception
	 */
	public CommonListVO gdsReviewListVO(CommonListVO listVO) throws Exception {
		return gdsReviewDAO.gdsReviewListVO(listVO);
	}

	/**
	 * 사용자 상품 후기
	 * @param listVO
	 * @return
	 * @throws Exception
	 */
	public CommonListVO selectAvailListVO(CommonListVO listVO) throws Exception {
		return gdsReviewDAO.selectAvailListVO(listVO);
	}

	/**
	 * 상품후기 상세
	 * @param gdsReviewNo
	 * @return
	 * @throws Exception
	 */
	public GdsReviewVO selectGdsReview(int gdsReviewNo) throws Exception {
		return gdsReviewDAO.selectGdsReview(gdsReviewNo);
	}

	/**
	 * 상품후기 저장
	 * @param gdsReviewVO
	 * @throws Exception
	 */
	public void insertGdsReview(GdsReviewVO gdsReviewVO) throws Exception {
		gdsReviewDAO.insertGdsReview(gdsReviewVO);
	}

	/**
	 * 상품후기 수정
	 * @param gdsReviewVO
	 * @throws Exception
	 */
	public void updateGdsReview(GdsReviewVO gdsReviewVO) throws Exception {
		gdsReviewDAO.updateGdsReview(gdsReviewVO);
	}

	/**
	 * 상품후기 관리자 수정
	 * @param gdsReviewVO
	 * @throws Exception
	 */
	public void updateUseYn(GdsReviewVO gdsReviewVO) throws Exception {
		gdsReviewDAO.updateUseYn(gdsReviewVO);
	}

	/**
	 * 작성 가능 상품 후기 카운트
	 * @param paramMap
	 * @return resultMap
	 * @throws Exception
	 */
	public Map<String, Object> selectPsbleCount(Map<String, Object> paramMap) throws Exception{
		return gdsReviewDAO.selectPsbleCount(paramMap);

	}

	/**
	 * 작성 가능한 상품 후기 리스트
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<GdsReviewVO> selectPosbleListAll(Map<String, Object> paramMap) throws Exception {
		return gdsReviewDAO.selectPosbleListAll(paramMap);
	}

	/**
	 * 등록한 상품 후기
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<GdsReviewVO> selectGdsReviewListAll(Map<String, Object> paramMap) throws Exception {
		return gdsReviewDAO.selectGdsReviewListAll(paramMap);
	}

}