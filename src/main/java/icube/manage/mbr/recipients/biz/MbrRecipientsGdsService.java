package icube.manage.mbr.recipients.biz;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.values.CodeMap;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.market.mbr.biz.MbrSession;

@Service("mbrRecipientsGdsService")
public class MbrRecipientsGdsService extends CommonAbstractServiceImpl {
	
	@Resource(name="mbrRecipientsGdsDAO")
	private MbrRecipientsGdsDAO mbrRecipientsGdsDAO;
	
	@Autowired
	private MbrSession mbrSession;
	
	
	public List<MbrRecipientsGdsVO> selectMbrRecipientsGds(Map<String, Object> paramMap) throws Exception {
		return mbrRecipientsGdsDAO.selectMbrRecipientsGds(paramMap);
	}
	
	public List<MbrRecipientsGdsVO> selectMbrRecipientsGdsByRecipientsNo(int recipientsNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchRecipientsNo", recipientsNo);
		return selectMbrRecipientsGds(paramMap);
	}
	
	public List<MbrRecipientsGdsVO> selectMbrRecipientsGdsByUniqueId(String uniqueId) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", uniqueId);
		return selectMbrRecipientsGds(paramMap);
	}
	
	public Integer insertMbrRecipientsGds(MbrRecipientsGdsVO mbrRecipientsGdsVO) throws Exception {
		return mbrRecipientsGdsDAO.insertMbrRecipientsGds(mbrRecipientsGdsVO);
	}
	
	public Integer deleteMbrRecipientsGds(int recipientsNo, String consltGdsTy) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("recipientsNo", recipientsNo);
		paramMap.put("consltGdsTy", consltGdsTy);
		return mbrRecipientsGdsDAO.deleteMbrRecipientsGds(paramMap);
	}
	
	public int insertMbrRecipientsGdCds(MbrVO mbrVO, int recipientsNo, String[] ctgryCds) throws Exception {
		
		MbrRecipientsGdsVO mbrRecipientsGds = new MbrRecipientsGdsVO();

		mbrRecipientsGds.setRecipientsNo(recipientsNo);
		mbrRecipientsGds.setConsltGdsTy("C"); //품목 상담(카테고리)
		
		mbrRecipientsGds.setMbrUniqueId(mbrVO.getUniqueId());
		mbrRecipientsGds.setMbrId(mbrVO.getMbrId());
		mbrRecipientsGds.setMbrNm(mbrVO.getMbrNm());
		
		int ifor, ilen = ctgryCds.length;
		String foundKey;

		deleteMbrRecipientsGds(recipientsNo, "C");

		for(ifor=0; ifor<ilen ; ifor++){
			final String sValue = ctgryCds[ifor];
			
			foundKey = CodeMap.CARE_10_CTGRY_CD.entrySet().stream().filter(item-> item.getValue().equals(sValue)).map(Map.Entry::getKey).findAny().orElse(null);
			if (foundKey == null){
				foundKey = CodeMap.CARE_20_CTGRY_CD.entrySet().stream().filter(item-> item.getValue().equals(sValue)).map(Map.Entry::getKey).findAny().orElse(null);
			}

			mbrRecipientsGds.setCtgryNm(foundKey);//CodeMap.CARE_10_CTGRY_CD
			mbrRecipientsGds.setCareCtgryCd(ctgryCds[ifor]);
			insertMbrRecipientsGds(mbrRecipientsGds);
		}
		
		return ctgryCds.length;
	}
	
	public void insertMbrRecipientsGds(int recipientsNo, String[] ctgry10Nms, String[] ctgry20Nms) throws Exception {
		List<MbrRecipientsGdsVO> recipientsGdsList = new ArrayList<MbrRecipientsGdsVO>();
		
		if (ctgry10Nms != null) {
			for (int i = 0; i < ctgry10Nms.length; i++) {
				MbrRecipientsGdsVO mbrRecipientsGds = new MbrRecipientsGdsVO();
				mbrRecipientsGds.setRecipientsNo(recipientsNo);
				mbrRecipientsGds.setConsltGdsTy("C"); //품목 상담(카테고리)
				mbrRecipientsGds.setCtgryNm(ctgry10Nms[i]);
				mbrRecipientsGds.setCareCtgryCd(CodeMap.CARE_10_CTGRY_CD.get(ctgry10Nms[i]));
				mbrRecipientsGds.setMbrUniqueId(mbrSession.getUniqueId());
				mbrRecipientsGds.setMbrId(mbrSession.getMbrId());
				mbrRecipientsGds.setMbrNm(mbrSession.getMbrNm());
				recipientsGdsList.add(mbrRecipientsGds);
			}
		}
		
		if (ctgry20Nms != null) {
			for (int i = 0; i < ctgry20Nms.length; i++) {
				MbrRecipientsGdsVO mbrRecipientsGds = new MbrRecipientsGdsVO();
				mbrRecipientsGds.setRecipientsNo(recipientsNo);
				mbrRecipientsGds.setConsltGdsTy("C"); //품목 상담(카테고리)
				mbrRecipientsGds.setCtgryNm(ctgry20Nms[i]);
				mbrRecipientsGds.setCareCtgryCd(CodeMap.CARE_20_CTGRY_CD.get(ctgry20Nms[i]));
				mbrRecipientsGds.setMbrUniqueId(mbrSession.getUniqueId());
				mbrRecipientsGds.setMbrId(mbrSession.getMbrId());
				mbrRecipientsGds.setMbrNm(mbrSession.getMbrNm());
				recipientsGdsList.add(mbrRecipientsGds);
			}
		}
		
		//기존 선택 정보 삭제 후 추가
		deleteMbrRecipientsGds(recipientsNo, "C");
		for(MbrRecipientsGdsVO recipientsGds : recipientsGdsList) {
			insertMbrRecipientsGds(recipientsGds);
		}
	}
}
