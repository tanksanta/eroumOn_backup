package icube.manage.consult.biz;

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

@Service("mbrConsltGdsService")
public class MbrConsltGdsService extends CommonAbstractServiceImpl {
	
	@Resource(name="mbrConsltGdsDAO")
	private MbrConsltGdsDAO mbrConsltGdsDAO;
	
	@Autowired
	private MbrSession mbrSession;
	
	
	public List<MbrConsltGdsVO> selectMbrConsltGds(Map<String, Object> paramMap) throws Exception {
		return mbrConsltGdsDAO.selectMbrConsltGds(paramMap);
	}
	
	public List<MbrConsltGdsVO> selectMbrConsltGdsByConsltNo(int consltNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchConsltNo", consltNo);
		return selectMbrConsltGds(paramMap);
	}
	
	public Integer insertMbrConsltGds(MbrConsltGdsVO mbrConsltGdsVO) throws Exception {
		return mbrConsltGdsDAO.insertMbrConsltGds(mbrConsltGdsVO);
	}
	
	public Integer deleteMbrConsltGds(int consltNo, String consltGdsTy) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("consltNo", consltNo);
		paramMap.put("consltGdsTy", consltGdsTy);
		return mbrConsltGdsDAO.deleteMbrConsltGds(paramMap);
	}
	
	public void insertMbrConsltGds(int consltNo, String[] ctgry10Nms, String[] ctgry20Nms) throws Exception {
		List<MbrConsltGdsVO> consltGdsList = new ArrayList<MbrConsltGdsVO>();
		
		if (ctgry10Nms != null) {
			for (int i = 0; i < ctgry10Nms.length; i++) {
				MbrConsltGdsVO mbrConsltGds = new MbrConsltGdsVO();
				mbrConsltGds.setConsltNo(consltNo);
				mbrConsltGds.setConsltGdsTy("C"); //품목 상담(카테고리)
				mbrConsltGds.setCtgryNm(ctgry10Nms[i]);
				mbrConsltGds.setCareCtgryCd(CodeMap.CARE_10_CTGRY_CD.get(ctgry10Nms[i]));
				mbrConsltGds.setMbrUniqueId(mbrSession.getUniqueId());
				mbrConsltGds.setMbrId(mbrSession.getMbrId());
				mbrConsltGds.setMbrNm(mbrSession.getMbrNm());
				consltGdsList.add(mbrConsltGds);
			}
		}
		
		if (ctgry20Nms != null) {
			for (int i = 0; i < ctgry20Nms.length; i++) {
				MbrConsltGdsVO mbrConsltGds = new MbrConsltGdsVO();
				mbrConsltGds.setConsltNo(consltNo);
				mbrConsltGds.setConsltGdsTy("C"); //품목 상담(카테고리)
				mbrConsltGds.setCtgryNm(ctgry20Nms[i]);
				mbrConsltGds.setCareCtgryCd(CodeMap.CARE_20_CTGRY_CD.get(ctgry20Nms[i]));
				mbrConsltGds.setMbrUniqueId(mbrSession.getUniqueId());
				mbrConsltGds.setMbrId(mbrSession.getMbrId());
				mbrConsltGds.setMbrNm(mbrSession.getMbrNm());
				consltGdsList.add(mbrConsltGds);
			}
		}
		
		//기존 선택 정보 삭제 후 추가
		deleteMbrConsltGds(consltNo, "C");
		for(MbrConsltGdsVO consltGds : consltGdsList) {
			insertMbrConsltGds(consltGds);
		}
	}
}
