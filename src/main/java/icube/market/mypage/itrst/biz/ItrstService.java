package icube.market.mypage.itrst.biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.manage.gds.ctgry.biz.GdsCtgryVO;

@Service("itrstService")
public class ItrstService extends CommonAbstractServiceImpl {

	@Resource(name = "itrstDAO")
	private ItrstDAO itrstDAO;

	/**
	 * 관심 사업소, 카테고리 등록
	 * @param itrstVO
	 * @throws Exception
	 */
	public void insertItrst(ItrstVO itrstVO) throws Exception {
		itrstDAO.insertItrst(itrstVO);
	}

	/**
	 * 관심 사업소, 카테고리 리스트
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<ItrstVO> selectItrstListAll(Map<String, Object> paramMap) throws Exception {
		return itrstDAO.selectItrstListAll(paramMap);
	}

	/**
	 * 관심 사업소, 카테고리 삭제
	 * @param paramMap
	 * @throws Exception
	 */
	public void deleteItrst(Map<String, Object> paramMap) throws Exception {
		itrstDAO.deleteItrst(paramMap);
	}

	/**
	 * 카테고리 조회
	 * @return
	 * @throws Exception
	 */
	public List<GdsCtgryVO> selectGdsCtgryList() throws Exception {
		return itrstDAO.selectGdsCtgryList();
	}



}