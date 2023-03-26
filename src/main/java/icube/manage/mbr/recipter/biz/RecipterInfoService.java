package icube.manage.mbr.recipter.biz;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import icube.common.api.biz.TilkoApiService;
import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.util.DateUtil;
import icube.market.mbr.biz.MbrSession;

@Service("recipterInfoService")
public class RecipterInfoService extends CommonAbstractServiceImpl {

	@Resource(name="recipterInfoDAO")
	private RecipterInfoDAO recipterInfoDAO;

	@Resource(name="tilkoApiService")
	private TilkoApiService tilkoApiService;

	@Autowired
	private MbrSession mbrSession;

	/*public CommonListVO recipterInfoListVO(CommonListVO listVO) throws Exception {
		return recipterInfoDAO.recipterInfoListVO(listVO);
	}*/

	/**
	 * 장기요양정보 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public RecipterInfoVO selectRecipterInfo(Map<String, Object> paramMap) throws Exception {
		return recipterInfoDAO.selectRecipterInfo(paramMap);
	}

	/**
	 * 장기요양정보 등록
	 * @param recipterInfoVO
	 * @throws Exception
	 */
	public void mergeRecipter(RecipterInfoVO recipterInfoVO) throws Exception {
		recipterInfoDAO.mergeRecipter(recipterInfoVO);
	}

	/**
	 * 수급자 정보 삭제
	 * @param uniqueId
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked","rawtypes"})
	public void deleteRecipter(String uniqueId) throws Exception {
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("srchUniqueId", uniqueId);
		recipterInfoDAO.deleteRecipter(paramMap);
	}

	/**
	 * 요양정보 업데이트
	 * @param uniqueId
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes","unchecked"})
	public void updateRecipterInfo(String uniqueId) throws Exception {
		Map paramMap = new HashMap();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());

		String rcperRcognNo = mbrSession.getRecipterInfo().getRcperRcognNo();
		//String mbrNm = mbrSession.getMbrNm();
		//TODO 회원 이름으로 수정
		RecipterInfoVO nmVO = this.selectRecipterInfo(paramMap);
		String mbrNm = nmVO.getTestName();

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

		// new info
		Map<String, Object> returnMap = tilkoApiService.getRecipterInfo(mbrNm, rcperRcognNo);

		if(returnMap != null) {
			Map<String, Object> infoMap = (Map) returnMap.get("infoMap");

			// old info
			RecipterInfoVO recipterInfoVO = this.selectRecipterInfo(paramMap);

			// 유효기간
			String vldDate = (String)infoMap.get("RCGT_EDA_DT");
			String[] arrDate = vldDate.split("~");
			String vldBgngYmd = arrDate[0].replace(" ", "");
			String vldEndYmd = arrDate[1].replace(" ", "");

			// recipterInfoVO
			recipterInfoVO.setRcognGrad((String)infoMap.get("LTC_RCGT_GRADE_CD"));
			recipterInfoVO.setSelfBndRt((Integer)infoMap.get("SELF_BND_RT"));
			recipterInfoVO.setVldBgngYmd(formatter.parse(vldBgngYmd));
			recipterInfoVO.setVldEndYmd(formatter.parse(vldEndYmd));
			recipterInfoVO.setAplcnBgngYmd(formatter.parse(DateUtil.formatDate((String)infoMap.get("APDT_FR_DT"),"yyyy-MM-dd")));
			recipterInfoVO.setAplcnEndYmd(formatter.parse(DateUtil.formatDate((String)infoMap.get("APDT_TO_DT") , "yyyy-MM-dd")));
			recipterInfoVO.setSprtAmt(EgovStringUtil.string2integer((String)infoMap.get("LMT_AMT")));
			recipterInfoVO.setBnefBlce(recipterInfoVO.getSprtAmt() - EgovStringUtil.string2integer((String)infoMap.get("USE_AMT")));

			this.mergeRecipter(recipterInfoVO);
		}
	}


}