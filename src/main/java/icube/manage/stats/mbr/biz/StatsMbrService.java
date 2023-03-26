package icube.manage.stats.mbr.biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;

@Service("statsMbrService")

public class StatsMbrService extends CommonAbstractServiceImpl {

	@Resource(name = "statsMbrDAO")
	private StatsMbrDAO statsMbrDAO;

	// 전체 회원 누계
	public Map<String, Object> selectJoinMap(Map<String, Object> reqMap) throws Exception {
		return statsMbrDAO.selectJoinMap(reqMap);
	}

	// 가입/탈퇴 현황
	public List<StatsMbrVO> selectJoinList(Map<String, Object> reqMap) throws Exception{
		return statsMbrDAO.selectJoinList(reqMap);
	}

	// 휴면회원 누계
	public Map<String, Object> selectDrmcMap(Map<String, Object> reqMap) throws Exception {
		return statsMbrDAO.selectDrmcMap(reqMap);
	}

	// 휴면회원 현황
	public List<StatsMbrVO> selectDrmcList(Map<String, Object> reqMap) throws Exception {
		return statsMbrDAO.selectDrmcList(reqMap);
	}

	// 성별/연령별 현황
	public List<StatsMbrVO> selectGenderList(Map<String, Object> reqMap) throws Exception {
		return statsMbrDAO.selectGenderList(reqMap);
	}

	// 성별/연령별 누계
	public Map<String, Object> selectGenderMap(Map<String, Object> reqMap) throws Exception {
		return statsMbrDAO.selectGenderMap(reqMap);
	}

	// 가입경로 현황
	public List<StatsMbrVO> selectCoursList(Map<String, Object> reqMap) throws Exception {
		return statsMbrDAO.selectCoursList(reqMap);
	}

	// 등급별 현황
	public List<StatsMbrVO> selectGradeList(Map<String, Object> reqMap) throws Exception {
		return statsMbrDAO.selectGradeList(reqMap);
	}


}
