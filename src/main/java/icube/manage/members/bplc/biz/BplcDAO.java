package icube.manage.members.bplc.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

/**
 * 파트너스 > 사업소 DAO
 */
@Repository("bplcDAO")
public class BplcDAO extends CommonAbstractMapper {

	// 사업소 목록/갯수
	public CommonListVO bplcListVO(CommonListVO listVO) throws Exception {
		return selectListVO("partners.bplc.selectBplcCount", "partners.bplc.selectBplcListVO", listVO);
	}

	// 사업소 갯수
	public int selectBplcCnt(Map<String, Object> paramMap) throws Exception {
		return selectOne("partners.bplc.selectBplcCount");
	}

	// 최근 구매 사업소
	public CommonListVO recentBplcListVO(CommonListVO listVO) throws Exception {
		return selectListVO("partners.bplc.recentBplcCount","partners.bplc.recentBplcListVO",listVO);
	}

	// 사업소 상세정보
	public BplcVO selectBplc(Map<String, Object> paramMap) throws Exception {
		return (BplcVO)selectOne("partners.bplc.selectBplc", paramMap);
	}

	// 사업소 아이디 체크
	public int selectBplcIdChk(String bplcId) throws Exception{
		return selectOne("partners.bplc.selectBplcIdChk",bplcId);
	}

	// 사업소 상세정보 by URL : TO-DO CHECK
	public BplcVO selectBplcUrl(String bplcUrl) throws Exception {
		return selectOne("partners.bplc.selectBplcUrl",bplcUrl);
	}

	// 사업소 정보 저장
	public void insertBplc(BplcVO bplcVO) throws Exception {
		insert("partners.bplc.insertBplc", bplcVO);
	}

	// 사업소 신청 관리
	public void updateBplcApp(BplcVO bplcVO) throws Exception {
		update("partners.bplc.updateBplcApp", bplcVO);
	}

	// 사업소 정보 수정
	public void updateBplc(BplcVO bplcVO) throws Exception {
		update("partners.bplc.updateBplc", bplcVO);
	}

	// 사업소 기존회원 > 계정활성화
	public void updatePartnersBplc(BplcVO bplcVO) throws Exception {
		update("partners.bplc.updatePartnersBplc", bplcVO);
	}

	// 사업소 상세정보 by URL : selectBplcUrl와 체크
	public BplcVO selectBplcByUrl(String bplcUrl) throws Exception {
		return selectOne("partners.bplc.selectBplcByUrl", bplcUrl);
	}

	// 사업소 사업자 번호 조회
	public BplcVO selectBrno(BplcVO bplcVO) throws Exception {
		return selectOne("partners.bplc.selectBrno", bplcVO);
	}

	// 사업소 파일 이름 업데이트
	public void updateFilesName(BplcVO bplcVO) throws Exception {
		update("partners.bplc.updateFilesName", bplcVO);
	}

	// 사업소 비밀번호 업데이트
	public void updateBplcPswd(Map<String, Object> paramMap) throws Exception {
		update("partners.bplc.updateBplcPswd", paramMap);
	}

	// 사업소 전체 목록
	public List<BplcVO> selectBplcListAll(Map<String, Object> paramMap) throws Exception {
		return selectList("partners.bplc.selectBplcListAll", paramMap);
	}

	// 사업소 공간좌표 수정
	public void updateBplcGeocode(Map<String, Object> paramMap) throws Exception {
		update("partners.bplc.updateBplcGeocode", paramMap);

	}

	// 사업소 로그인 실패횟수 증가
	public int updateFailedLoginCountUp(BplcVO bplcVO) throws Exception {
		return update("partners.bplc.updateFailedLoginCountUp", bplcVO);
	}

	// 사업소 로그인 실패 횟수
	public int selectFailedLoginCount(BplcVO bplcVO) throws Exception {
		return selectOne("partners.bplc.selectFailedLoginCount", bplcVO);
	}

	// 사업소 로그인 실패 횟수 초기화
	public void updateFailedLoginCountReset(BplcVO bplcVO) throws Exception {
		update("partners.bplc.updateFailedLoginCountReset", bplcVO);
	}

	public List<BplcVO> selectBplcList(Map<String, Object> paramMap) throws Exception {
		return selectList("partners.bplc.selectBplcList",paramMap);
	}

}