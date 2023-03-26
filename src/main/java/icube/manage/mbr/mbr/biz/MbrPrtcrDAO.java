package icube.manage.mbr.mbr.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("mbrPrtcrDAO")
public class MbrPrtcrDAO extends CommonAbstractMapper{

	public void selectPrtcrMbrList(Map<String, Object> paramMap) throws Exception {
		selectList("mbr.prtcr.selectPrtcrMbrList",paramMap);
	}

	public MbrPrtcrVO selectPrtcrByMap(Map<String, Object> paramMap) throws Exception{
		return selectOne("mbr.prtcr.selectPrtcrByMap",paramMap);
	}

	/**
	 * 가족회원 초대
	 * @param mbrPrtcrVO
	 * @throws Exception
	 */
	public void insertPrtcr(MbrPrtcrVO mbrPrtcrVO) throws Exception {
		insert("mbr.prtcr.insertPrtcr",mbrPrtcrVO);
	}

	/**
	 * 가족회원 카운트
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectPrtcrCount(Map<String, Object> paramMap) throws Exception{
		return selectOne("mbr.prtcr.selectPrtcrCount",paramMap);
	}

	public List<MbrPrtcrVO> selectPrtcrListByMap(Map<String, Object> paramMap) throws Exception{
		return selectList("mbr.prtcr.selectPrtcrListByMap",paramMap);
	}

	/**
	 * 가족회원 승인&거부
	 * @param paramMap
	 * @throws Exception
	 */
	public void updateReqTy(MbrPrtcrVO mbrPrtcrVO) throws Exception{
		update("mbr.prtcr.updateReqTy",mbrPrtcrVO);
	}

	public MbrPrtcrVO selectMbrPrtcr(Map<String, Object> paramMap) throws Exception {
		return selectOne("mbr.prtcr.selectMbrPrtcr",paramMap);
	}

	/**
	 * 가족 회원 삭제
	 * @param paramMap
	 * @throws Exception
	 */
	public void deleteFml(Map<String, Object> paramMap) throws Exception {
		delete("mbr.prtcr.deleteFml",paramMap);
	}

	public List<MbrPrtcrVO> selectPrtcrListByUniqueId(Map<String, Object> paramMap) throws Exception {
		return selectList("mbr.prtcr.selectPrtcrListByUniqueId", paramMap);
	}

}
