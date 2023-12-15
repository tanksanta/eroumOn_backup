package icube.manage.mbr.recipients.biz;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.values.CodeMap;
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
	
	public Integer insertMbrRecipientsGds(MbrRecipientsGdsVO mbrRecipientsGdsVO) throws Exception {
		return mbrRecipientsGdsDAO.insertMbrRecipientsGds(mbrRecipientsGdsVO);
	}
	
	public Integer deleteMbrRecipientsGds(int recipientsNo, String consltGdsTy) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("recipientsNo", recipientsNo);
		paramMap.put("consltGdsTy", consltGdsTy);
		return mbrRecipientsGdsDAO.deleteMbrRecipientsGds(paramMap);
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
