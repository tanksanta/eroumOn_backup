package icube.manage.members.bplc.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("bplcService")
public class BplcService extends CommonAbstractServiceImpl {

	@Resource(name="bplcDAO")
	private BplcDAO bplcDAO;

	/**
	 * 사업소 리스트
	 * @param listVO
	 * @return
	 * @throws Exception
	 */
	public CommonListVO bplcListVO(CommonListVO listVO) throws Exception {
		return bplcDAO.bplcListVO(listVO);
	}

	/**
	 * 사업소 카운트
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectBplcCnt(Map<String, Object> paramMap) throws Exception {
		return bplcDAO.selectBplcCnt(paramMap);
	}

	/**
	 * 최근 구매 사업소
	 * @param listVO
	 * @return
	 * @throws Exception
	 */
	public CommonListVO recentBplcListVO(CommonListVO listVO) throws Exception {
		return bplcDAO.recentBplcListVO(listVO);
	}

	/**
	 * 사업소 상세정보
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public BplcVO selectBplc(Map<String, Object> paramMap) throws Exception {
		return bplcDAO.selectBplc(paramMap);
	}

	/**
	 * 사업소 상세정보 by uniqueId
	 * @param uniqueId
	 * @return
	 * @throws Exception
	 */
	public BplcVO selectBplcByUniqueId(String uniqueId) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", uniqueId);
		return this.selectBplc(paramMap);
	}

	/**
	 * 사업소 상세정보 by bplcId
	 * @param loginId
	 * @return
	 * @throws Exception
	 */
	public BplcVO selectBplcById(String bplcId) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchBplcId", bplcId);
		return this.selectBplc(paramMap);
	}

	/**
	 * 사업소 아이디체크
	 * @param bplcId
	 * @return count
	 * @throws Exception
	 */
	public int selectBplcIdChk(String bplcId) throws Exception {
		return bplcDAO.selectBplcIdChk(bplcId);
	}

	public BplcVO selectBplcUrl(String bplcUrl) throws Exception {
		return bplcDAO.selectBplcUrl(bplcUrl);
	}

	public void insertBplc(BplcVO bplcVO) throws Exception {
		bplcDAO.insertBplc(bplcVO);
	}

	//파트너 신청 관리
	public void updateBplcApp(BplcVO bplcVO) throws Exception {
		bplcDAO.updateBplcApp(bplcVO);
	}

	//파트너 관리
	public void updateBplc(BplcVO bplcVO) throws Exception {
		bplcDAO.updateBplc(bplcVO);
	}

	//사용자 > 기존회원 > 계정활성화
	public void updatePartnersBplc(BplcVO bplcVO) throws Exception {
		bplcDAO.updatePartnersBplc(bplcVO);
	}

	public BplcVO selectBplcByUrl(String bplcUrl) throws Exception {
		return bplcDAO.selectBplcByUrl(bplcUrl);
	}

	public BplcVO selectBrno(BplcVO bplcVO) throws Exception {
		return bplcDAO.selectBrno(bplcVO);
	}

	//파일 이름 업데이트
	public void updateFilesName(BplcVO bplcVO) throws Exception {
		bplcDAO.updateFilesName(bplcVO);
	}


	//비밀번호 업데이트
	public void updateBplcPswd(String uniqueId, String newPswd) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("uniqueId", uniqueId);
		paramMap.put("newPswd", newPswd);

		bplcDAO.updateBplcPswd(paramMap);
	}

	//사업소 전체 목록
	public List<BplcVO> selectBplcListAll(Map<String, Object> paramMap) throws Exception {


		return bplcDAO.selectBplcListAll(paramMap);
	}

	public void updateBplcGeocode(String uniqueId, String lat, String lot) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("uniqueId", uniqueId);
		paramMap.put("lat", lat);
		paramMap.put("lot", lot);

		bplcDAO.updateBplcGeocode(paramMap);

	}


	/**
	 * 로그인 실패횟수 증가 및 최종 횟수
	 * @param bplcVO
	 * @return fail count
	 * @throws Exception
	 */
	public int getFailedLoginCountWithCountUp(BplcVO bplcVO) throws Exception {
		this.updateFailedLoginCountUp(bplcVO);
		return selectFailedLoginCount(bplcVO);
	}

	/**
	 * 로그인 실패횟수 증가
	 * @param bplcVO
	 * @return count
	 * @throws Exception
	 */
	public int updateFailedLoginCountUp(BplcVO bplcVO) throws Exception {
		return bplcDAO.updateFailedLoginCountUp(bplcVO);
	}

	/**
	 * 로그인 실패횟수
	 * @param mngrVO
	 * @return count
	 * @throws Exception
	 */
	public int selectFailedLoginCount(BplcVO bplcVO) throws Exception {
		return bplcDAO.selectFailedLoginCount(bplcVO);
	}

	/**
	 * 로그인 실패횟수 초기화
	 * @param bplcVO
	 * @throws Exception
	 */
	public void updateFailedLoginCountReset(BplcVO bplcVO) throws Exception {
		bplcDAO.updateFailedLoginCountReset(bplcVO);
	}

}