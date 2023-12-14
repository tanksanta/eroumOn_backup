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
import icube.manage.mbr.recipients.biz.MbrRecipientsGdsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsGdsVO;
import icube.market.mbr.biz.MbrSession;

@Service("mbrConsltGdsService")
public class MbrConsltGdsService extends CommonAbstractServiceImpl {
	
	@Resource(name="mbrConsltGdsDAO")
	private MbrConsltGdsDAO mbrConsltGdsDAO;
	
	@Resource(name= "mbrRecipientsGdsService")
	private MbrRecipientsGdsService mbrRecipientsGdsService;
	
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
	
	/**
	 * 수급자 복지용구 선택값으로 상담 복지용구 선택정보 저장
	 */
	public void insertMbrConsltGds(int recipientsNo, int consltNo) throws Exception {
		List<MbrConsltGdsVO> consltGdsList = new ArrayList<MbrConsltGdsVO>();
		List<MbrRecipientsGdsVO> recipientsGdsList = mbrRecipientsGdsService.selectMbrRecipientsGdsByRecipientsNo(recipientsNo);
		for(MbrRecipientsGdsVO recipientsGds : recipientsGdsList) {
            MbrConsltGdsVO mbrConsltGds = new MbrConsltGdsVO();
            mbrConsltGds.setConsltNo(consltNo);
            mbrConsltGds.setConsltGdsTy(recipientsGds.getConsltGdsTy()); //품목 상담(카테고리)
            mbrConsltGds.setCtgryNm(recipientsGds.getCtgryNm());
            mbrConsltGds.setCareCtgryCd(recipientsGds.getCareCtgryCd());
            mbrConsltGds.setMbrUniqueId(mbrSession.getUniqueId());
            mbrConsltGds.setMbrId(mbrSession.getMbrId());
            mbrConsltGds.setMbrNm(mbrSession.getMbrNm());
            consltGdsList.add(mbrConsltGds);
		}
		
		//기존 선택 정보 삭제 후 추가
		deleteMbrConsltGds(consltNo, "C");
		for(MbrConsltGdsVO consltGds : consltGdsList) {
			insertMbrConsltGds(consltGds);
		}
	}
}
