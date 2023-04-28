package icube.manage.mbr.mbr.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("mbrDAO")
public class MbrDAO extends CommonAbstractMapper {

	public CommonListVO mbrListVO(CommonListVO listVO) throws Exception {
		return selectListVO("mbr.selectMbrCount", "mbr.selectMbrListVO", listVO);
	}

	public List<MbrVO> selectMbrListAll(Map<String, Object> paramMap) throws Exception {
		return selectList("mbr.selectMbrListAll", paramMap);
	}

	public void insertMbr(MbrVO mbrVO) throws Exception {
		insert("mbr.insertMbr", mbrVO);
	}

	public void updateMbr(MbrVO mbrVO) throws Exception {
		update("mbr.updateMbr", mbrVO);
	}

	public void deleteMbr(String string) throws Exception {
		delete("mbr.deleteMbr", string);
	}

	public MbrVO selectMbr(Map<String, Object> paramMap) throws Exception{
		return selectOne("mbr.selectMbr", paramMap);
	}

	// 아이디 중복검색
	public Integer selectMbrIdChk(Map<String, Object> paramMap) throws Exception {
		return selectOne("mbr.selectMbrIdChk", paramMap);
	}

	// 로그인 실패 횟수
	public int selectFailedLoginCount(MbrVO mbrVO) throws Exception {
		return selectOne("mbr.selectFailedLoginCount", mbrVO);
	}

	public Map<String, Object> selectMbrEtcInfo(Map<String, Object> paramMap) throws Exception {
		return selectOne("mbr.selectMbrEtcInfo", paramMap);
	}

	public int selectMbrCount(Map<String, Object> paramMap) throws Exception {
		return selectOne("mbr.selectMbrCount",paramMap);
	}

	public int selectBrdtMbrCount() throws Exception {
		return selectOne("mbr.selectBrdtMbrCount");
	}

	public MbrVO selectMbrIdByOne(String rcmdtnId) throws Exception {
		return selectOne("mbr.selectMbrIdByOne",rcmdtnId);
	}

	public int selectMbrSumPc(Map<String, Object> paramMap) throws Exception {
		return selectOne("mbr.selectMbrSumPc",paramMap);
	}

	public Map<String, Object> selectOwnAccmt(Map<String, Object> paramMap) throws Exception {
		return selectOne("mbr.selectOwnAccmt",paramMap);
	}

	public void updateChoiceYn(Map<String, Object> paramMap) throws Exception {
		update("mbr.updateChoiceYn",paramMap);
	}

	public void updatePrvc(Map<String, Object> paramMap) throws Exception {
		update("mbr.updatePrvc",paramMap);
	}

	public void updateEvent(Map<String, Object> paramMap) throws Exception {
		update("mbr.updateEvent",paramMap);
	}

	// 로그인 실패 횟수 초기화
	public void updateFailedLoginCountReset(MbrVO mbrVO) throws Exception {
		update("mbr.updateFailedLoginCountReset", mbrVO);
	}

	// 로그인 실패횟수 증가
	public int updateFailedLoginCountUp(MbrVO mbrVO) throws Exception {
		return update("mbr.updateFailedLoginCountUp", mbrVO);
	}

	// 회원 비밀번호 업데이트
	public void updateMbrPswd(MbrVO mbrVO) throws Exception {
		update("mbr.updateMbrPswd",mbrVO);
	}

	// 회원 휴면계정 해제
	public void updateRlsDrmt(Map<String, Object> paramMap) throws Exception{
		update("mbr.updateRlsDrmt",paramMap);
	}

	//회원 탈퇴
	public void updateExitMbr(Map<String, Object> paramMap) throws Exception {
		update("mbr.updateExitMbr",paramMap);
	}

	// 마이페이지 회원 정보 수정
	public void updateMbrInfo(MbrVO mbrVO) throws Exception {
		update("mbr.updateMbrInfo",mbrVO);
	}

	// 최근 접속일시 업데이트
	public void updateRecentDt(String uniqueId) throws Exception {
		update("mbr.updateRecentDt",uniqueId);
	}

	public void updateMberSttus(Map<String, Object> paramMap) throws Exception {
		update("mbr.updateMberSttus",paramMap);
	}

	public void updateDiKey(Map<String, Object> paramMap) throws Exception {
		update("mbr.updateDiKey",paramMap);
	}

}