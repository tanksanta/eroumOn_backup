package icube.manage.consult.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("gdsReviewDAO")
public class GdsReviewDAO extends CommonAbstractMapper {

	/**
	 * DEFINE ListVO
	 * @param listVO
	 * @return
	 * @throws Exception
	 */
	public CommonListVO gdsReviewListVO(CommonListVO listVO) throws Exception {
		return selectListVO("gds.review.selectGdsReviewCount", "gds.review.selectGdsReviewListVO", listVO);
	}

	/**
	 * 사용자 마이페이지 상품 후기
	 * @param listVO
	 * @return
	 * @throws Exception
	 */
	public CommonListVO selectAvailListVO(CommonListVO listVO) throws Exception {
		return selectListVO("gds.review.selectAvailCount","gds.review.selectAvailListVO",listVO);
	}

	// 조회
	public GdsReviewVO selectGdsReview(int gdsReviewNo) throws Exception {
		return (GdsReviewVO)selectOne("gds.review.selectGdsReview", gdsReviewNo);
	}

	// 등록
	public void insertGdsReview(GdsReviewVO gdsReviewVO) throws Exception {
		insert("gds.review.insertGdsReview", gdsReviewVO);
	}

	// 업데이트
	public void updateGdsReview(GdsReviewVO gdsReviewVO) throws Exception {
		update("gds.review.updateGdsReview", gdsReviewVO);
	}

	// 사용 상태 업데이트
	public void updateUseYn(GdsReviewVO gdsReviewVO) throws Exception{
		update("gds.review.updateUseYn",gdsReviewVO);
	}

	//  작성 가능한 상품 후기, 작성한 상품 후기 카운트
	public Map<String, Object> selectPsbleCount(Map<String, Object> paramMap) throws Exception{
		return selectOne("gds.review.selectPsbleCount", paramMap);
	}

	// 작성 가능한 상품 후기 리스트
	public List<GdsReviewVO> selectPosbleListAll(Map<String, Object> paramMap) throws Exception {
		return selectList("gds.review.selectPosbleListAll", paramMap);
	}

	// 작성한 상품 후기 리스트
	public List<GdsReviewVO> selectGdsReviewListAll(Map<String, Object> paramMap) throws Exception{
		return selectList("gds.review.selectGdsReviewListAll", paramMap);
	}


}