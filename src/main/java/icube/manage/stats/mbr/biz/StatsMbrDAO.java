package icube.manage.stats.mbr.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("statsMbrDAO")
public class StatsMbrDAO extends CommonAbstractMapper {

	public Map<String, Object> selectJoinMap(Map<String, Object> reqMap) throws Exception {
		return selectOne("stats.mbr.selectJoinMap",reqMap);
	}

	// 가입/탈퇴현황
	public List<StatsMbrVO> selectJoinList(Map<String, Object> reqMap) throws Exception {
		return selectList("stats.mbr.selectJoinList",reqMap);
	}

	// 휴면회원 누계
	public Map<String, Object> selectDrmcMap(Map<String, Object> reqMap) throws Exception {
		return selectOne("stats.mbr.selectDrmcMap",reqMap);
	}

	// 휴면회원 현황
	public List<StatsMbrVO> selectDrmcList(Map<String, Object> reqMap) throws Exception {
		return selectList("stats.mbr.selectDrmcList",reqMap);
	}

	// 성별/연령별 현황
	public List<StatsMbrVO> selectGenderList(Map<String, Object> reqMap) throws Exception {
		return selectList("stats.mbr.selectGenderList",reqMap);
	}

	// 성별/연령별 누계
	public Map<String, Object> selectGenderMap(Map<String, Object> reqMap) throws Exception {
		return selectOne("stats.mbr.selectGenderMap",reqMap);
	}

	// 가입경로 현황
	public List<StatsMbrVO> selectCoursList(Map<String, Object> reqMap) throws Exception {
		return selectList("stats.mbr.selectCoursList",reqMap);
	}

	// 등급별 현황
	public List<StatsMbrVO> selectGradeList(Map<String, Object> reqMap) throws Exception {
		return selectList("stats.mbr.selectGradeList",reqMap);
	}



}
