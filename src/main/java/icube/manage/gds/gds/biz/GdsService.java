package icube.manage.gds.gds.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringJoiner;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.util.HtmlUtil;
import icube.common.vo.CommonListVO;
import icube.manage.gds.rel.biz.GdsRelService;

@Service("gdsService")
public class GdsService extends CommonAbstractServiceImpl {

	@Resource(name="gdsDAO")
	private GdsDAO gdsDAO;

	@Resource(name="gdsRelService")
	private GdsRelService gdsRelService;

	/**
	 * 상품정보 목록
	 * @param listVO
	 */
	public CommonListVO gdsListVO(CommonListVO listVO) throws Exception {
		return gdsDAO.gdsListVO(listVO);
	}

	/**
	 * 상품 카운트
	 * @param paramMap
	 */
	public int selectGdsCnt(Map<String, Object> paramMap) throws Exception{
		return gdsDAO.selectGdsCnt(paramMap);
	}

	/**
	 * 상품정보 by PK
	 * @param gdsNo
	 */
	public GdsVO selectGds(int gdsNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("gdsNo", gdsNo);

		return this.selectGdsByFilter(paramMap);
	}

	/**
	 * 상품정보(다중 조건)
	 * @param paramMap
	 */
	public GdsVO selectGdsByFilter(Map<String, Object> paramMap) throws Exception {
		return gdsDAO.selectGdsByFilter(paramMap);
	}

	/**
	 * 상품정보 저장
	 * @param gdsVO
	 */
	public void insertGds(GdsVO gdsVO) throws Exception {

		// 고시정보 merge
		StringJoiner joiner = new StringJoiner(",", "{","}");
		for(int i=0;i<gdsVO.getArticle_ttl().length;i++) {
			joiner.add("\""+gdsVO.getArticle_ttl()[i]+"\":\""+HtmlUtil.escapeXmlStr(gdsVO.getArticle_val()[i].trim())+"\"");
		}
		gdsVO.setAncmntInfo(joiner.toString());

		//기본정보 저장
		gdsDAO.insertGds(gdsVO);

		//관련상품
		gdsRelService.registerGdsRel(gdsVO);
	}

	/**
	 * 상품정보 수정
	 * @param gdsVO
	 */
	public void updateGds(GdsVO gdsVO) throws Exception {

		// 고시정보 merge
		StringJoiner joiner = new StringJoiner(",", "{","}");
		for(int i=0;i<gdsVO.getArticle_ttl().length;i++) {
			joiner.add("\""+gdsVO.getArticle_ttl()[i]+"\":\""+HtmlUtil.escapeXmlStr(gdsVO.getArticle_val()[i].trim())+"\"");
		}
		gdsVO.setAncmntInfo(joiner.toString());

		//기본정보
		gdsDAO.updateGds(gdsVO);

		//관련상품
		gdsRelService.registerGdsRel(gdsVO);
	}

	/**
	 * 상품 정보 선택 수정
	 * @param paramMap
	 */
	public void updateEroumGds(Map<String, Object>paramMap) throws Exception {
		//기본정보
		gdsDAO.updateEroumGds(paramMap);
	}

	/**
	 * 상품정보 삭제
	 * @param gdsNo
	 */
	public void deleteGds(int gdsNo) throws Exception {
		gdsDAO.deleteGds(gdsNo);
	}

	/**
	 * 상품정보 사용 여부 변경
	 * @param paramMap {useYn}
	 */
	public Integer updateGdsUseYn(Map<String, Object> paramMap) throws Exception {
		return gdsDAO.updateGdsUseYn(paramMap);
	}

	/**
	 * 상품정보(목록) 사용 여부 변경
	 * @param paramMap {arrGdsNo[], useYn}
	 */
	public Integer updateGdsListUseYn(GdsVO gdsVO) throws Exception {
		return gdsDAO.updateGdsListUseYn(gdsVO);
	}

	/**
	 * 상품정보 목록
	 * @param reqMap {}
	 */
	public List<GdsVO> selectGdsListAll(Map<String, Object> paramMap) throws Exception {
		return gdsDAO.selectGdsListAll(paramMap);
	}

	/**
	 * 상품 재고수량 변경
	 * @param stockQyPlus
	 */
	public void updateGdsStockQy(Map<String, Object> stockQyPlus) throws Exception {
		gdsDAO.updateGdsStockQy(stockQyPlus);
	}

	/**
	 * 상품 조회수 증가
	 * @param gdsVO
	 */
	public void updateInqcnt(GdsVO gdsVO) throws Exception {
		gdsDAO.updateInqcnt(gdsVO);
	}

	/**
	 * 상품 태그 업데이트
	 * @param paramMap
	 * @throws Exception
	 */
	public void updateGdsTag(Map<String, Object> paramMap) throws Exception {
		gdsDAO.updateGdsTag(paramMap);
	}
}