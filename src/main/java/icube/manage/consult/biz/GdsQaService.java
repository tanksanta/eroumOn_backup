package icube.manage.consult.biz;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("gdsQaService")
public class GdsQaService extends CommonAbstractServiceImpl {

	@Resource(name = "gdsQaDAO")
	private GdsQaDAO gdsQaDAO;

	/**
	 * 상품문의 목록
	 *
	 * @param listVO
	 * @return
	 * @throws Exception
	 */
	public CommonListVO gdsQaListVO(CommonListVO listVO) throws Exception {
		return gdsQaDAO.gdsQaListVO(listVO);
	}

	/**
	 * 상품문의 상세
	 *
	 * @param gdsQaNo
	 * @return
	 * @throws Exception
	 */
	public GdsQaVO selectGdsQa(int gdsQaNo) throws Exception {
		return gdsQaDAO.selectGdsQa(gdsQaNo);
	}

	/**
	 * 상품문의 저장
	 *
	 * @param gdsQaVO
	 * @throws Exception
	 */
	public void insertGdsQa(GdsQaVO gdsQaVO) throws Exception {
		gdsQaDAO.insertGdsQa(gdsQaVO);
	}

	/**
	 * 상품문의 수정
	 *
	 * @param gdsQaVO
	 * @throws Exception
	 */
	public void updateGdsQa(GdsQaVO gdsQaVO) throws Exception {
		gdsQaDAO.updateGdsQa(gdsQaVO);
	}

	/**
	 * 상품문의 삭제
	 *
	 * @param gdsQaNo
	 * @throws Exception
	 */
	public void deleteGdsQa(int gdsQaNo) throws Exception {
		gdsQaDAO.deleteGdsQa(gdsQaNo);
	}

	/**
	 * 상품문의 답변
	 *
	 * @param gdsQaVO
	 * @throws Exception
	 */
	public void updateGdsQaAns(GdsQaVO gdsQaVO) throws Exception {
		gdsQaDAO.updateGdsQaAns(gdsQaVO);
	}
}