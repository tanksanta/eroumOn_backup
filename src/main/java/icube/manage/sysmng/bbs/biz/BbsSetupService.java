package icube.manage.sysmng.bbs.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("bbsSetupService")
public class BbsSetupService extends CommonAbstractServiceImpl {

	@Resource(name = "bbsSetupDAO")
	private BbsSetupDAO bbsSetupDAO;

	public CommonListVO selectBbsSetupListVO(CommonListVO listVO) throws Exception {
		return bbsSetupDAO.selectBbsSetupListVO(listVO);
	}

	public BbsSetupVO selectBbsSetup(int bbsNo) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bbsNo", bbsNo);
		
		return this.selectBbsSetup(paramMap);
	}

	public BbsSetupVO selectBbsSetup(String srvcCd, String bbsCd) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srvcCd", srvcCd);
		paramMap.put("bbsCd", bbsCd);

		return this.selectBbsSetup(paramMap);
	}

	protected BbsSetupVO selectBbsSetup(Map<String, Object> paramMap) throws Exception {
		BbsSetupVO bbsSetupVO = bbsSetupDAO.selectBbsSetup(paramMap);

		// Category
		if (bbsSetupVO != null && "Y".equals(bbsSetupVO.getCtgryUseYn())) {
			List<BbsCtgryVO> ctgryList = bbsSetupDAO.listCtgry(bbsSetupVO.getBbsNo(), "L", "NTT");
			bbsSetupVO.setCtgryList(ctgryList);
		}

		return bbsSetupVO;
	}

	public void insertBbsSetup(BbsSetupVO bbsSetupVO) throws Exception {
		bbsSetupDAO.insertBbsSetup(bbsSetupVO);
	}

	public void updateBbsSetup(BbsSetupVO bbsSetupVO) throws Exception {
		bbsSetupDAO.updateBbsSetup(bbsSetupVO);
	}

	public void deleteBbsSetup(int bbsNo) throws Exception {
		bbsSetupDAO.deleteBbsSetup(bbsNo);
	}

	public Integer updateBbsSetupUseYn(Map<String, Object> paramMap) throws Exception {
		return bbsSetupDAO.updateBbsSetupUseYn(paramMap);
	}

	// 등록
	public void registerBbsSetup(BbsSetupVO bbsSetupVO) throws Exception {

		insertBbsSetup(bbsSetupVO);

		List<BbsCtgryVO> ctgryList = new BbsCtgryVO(bbsSetupVO, "NTT").getList();
		if (ctgryList != null) {
			bbsSetupDAO.executeBbsCtgry(ctgryList);
		}
	}

	// 수정
	public void modifyBbsSetup(BbsSetupVO bbsSetupVO) throws Exception {

		bbsSetupDAO.updateBbsSetup(bbsSetupVO);

		List<BbsCtgryVO> ctgryList = new BbsCtgryVO(bbsSetupVO, "NTT").getList();
		if (ctgryList != null) {
			bbsSetupDAO.executeBbsCtgry(ctgryList);
		}
	}

	/* Category */
	public List<BbsCtgryVO> listCtgry(int bbsNo, String prefix, String useTy) throws Exception {
		return bbsSetupDAO.listCtgry(bbsNo, prefix, useTy);
	}

	/* 게시판 전체 리스트 */
	/*
	public List<BbsSetupVO> selectAllBbsSetupList() throws Exception {
		return bbsSetupDAO.selectAllBbsSetupList();
	}
	*/

}
