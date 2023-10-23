package icube.manage.mbr.recipients;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ibm.icu.text.SimpleDateFormat;

import icube.common.api.biz.TilkoApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CodeMap;
import icube.main.test.biz.MbrTestService;
import icube.main.test.biz.MbrTestVO;
import icube.manage.consult.biz.MbrConsltService;
import icube.manage.consult.biz.MbrConsltVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.recipients.biz.MbrRecipientsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;
import icube.manage.mbr.recipients.biz.RecipientsInfoVO;
import icube.manage.sysmng.mngr.biz.MngrService;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Controller
@RequestMapping(value="/_mng/mbr/recipients")
public class MMbrRecipientsController extends CommonAbstractController {
	
	@Resource(name = "mbrService")
    private MbrService mbrService;
	
	@Resource(name = "mbrRecipientsService")
    private MbrRecipientsService mbrRecipientsService;
	
	@Resource(name= "tilkoApiService")
	private TilkoApiService tilkoApiService;
	
	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;
	
	@Resource(name="mbrTestService")
    private MbrTestService mbrTestService;
	
	@Resource(name="mngrService")
	private MngrService mngrService;
	
	@Autowired
    private MngrSession mngrSession;
	
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm:ss");
	
	Pattern pattern = Pattern.compile("[0-9]+\\.?[0-9]?");
	
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "getInfo.json")
	public Map<String, Object> getInfo(@RequestParam int recipientsNo) {
		Map <String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			RecipientsInfoVO recipientInfoVO = new RecipientsInfoVO();
			
			//수급자 기본정보
			MbrRecipientsVO mbrRecipients = mbrRecipientsService.selectMbrRecipientsByRecipientsNo(recipientsNo);
			recipientInfoVO.setRecipientsNm(mbrRecipients.getRecipientsNm());
			recipientInfoVO.setRecipientsNo(mbrRecipients.getRecipientsNo());
			recipientInfoVO.setRelationText(CodeMap.MBR_RELATION_CD.get(mbrRecipients.getRelationCd()));
			if (EgovStringUtil.isNotEmpty(mbrRecipients.getRecipientsYn())) {
				recipientInfoVO.setRecipientsYn("Y".equals(mbrRecipients.getRecipientsYn()) ? "유" : "무");
			}
			recipientInfoVO.setTel(mbrRecipients.getTel());
			if (EgovStringUtil.isNotEmpty(mbrRecipients.getSido()) && 
					EgovStringUtil.isNotEmpty(mbrRecipients.getSigugun()) &&
					EgovStringUtil.isNotEmpty(mbrRecipients.getDong())) {
				recipientInfoVO.setAddress(mbrRecipients.getSido() + " " + mbrRecipients.getSigugun() + " " + mbrRecipients.getDong());
			}
			if (mbrRecipients.getBrdt() != null && mbrRecipients.getBrdt().length() == 8) {
				recipientInfoVO.setBrdt(mbrRecipients.getBrdt().substring(0, 4) + "-" + mbrRecipients.getBrdt().substring(4, 6)  + "-" + mbrRecipients.getBrdt().substring(6, 8));
			}
			if (mbrRecipients.getRegDt() != null) {
				recipientInfoVO.setRegDt(simpleDateFormat.format(mbrRecipients.getRegDt()));
			}
			if (EgovStringUtil.isNotEmpty(mbrRecipients.getGender())) {
				recipientInfoVO.setGender(CodeMap.GENDER.get(mbrRecipients.getGender()));
			}
			if (mbrRecipients.getMdfcnDt() != null) {
				recipientInfoVO.setMdfcnDt(simpleDateFormat.format(mbrRecipients.getMdfcnDt()));
			}
			if ("Y".equals(mbrRecipients.getMainYn())) {
				recipientInfoVO.setMainYn("대표");
			} else {
				recipientInfoVO.setMainYn("");
			}
			
			//수급자 요양정보 (내부DB에 요양정보저장 기능 구현 전까지 주석처리)
//			if ("Y".equals(mbrRecipients.getRecipientsYn())) {
//				Map<String, Object> returnMap = tilkoApiService.getRecipterInfo(mbrRecipients.getRecipientsNm(), mbrRecipients.getRcperRcognNo());
//				
//				recipientInfoVO.setRcperRcognNo(mbrRecipients.getRcperRcognNo());
//				returnMap = (Map<String, Object>)returnMap.get("infoMap");
//				
//				String penPayRate = "";
//				switch ((String)returnMap.get("REDUCE_NM")) {
//					case "일반" : penPayRate = "15"; break;
//					case "기초" : penPayRate = "0"; break;
//					case "의료급여" : penPayRate = "6"; break;
//					default: {
//						String sbaCd = (String)returnMap.get("SBA_CD");
//						
//						Matcher matcher = pattern.matcher(sbaCd);
//						if (matcher.find()) {
//							penPayRate = sbaCd.substring(matcher.start(), matcher.end());
//						}
//						break;
//					}
//				}
//				recipientInfoVO.setPenPayRate(penPayRate + "%");
//				recipientInfoVO.setLtcRcgtGradeCd((String)returnMap.get("LTC_RCGT_GRADE_CD"));
//				recipientInfoVO.setRcgtEdaDt((String)returnMap.get("RCGT_EDA_DT"));
//				
//				String apdtFrDt = (String)returnMap.get("APDT_FR_DT");
//				apdtFrDt = apdtFrDt.substring(0, 4) + "-" + apdtFrDt.substring(4, 6) + "-" + apdtFrDt.substring(6, 8);
//				String apdtToDt = (String)returnMap.get("APDT_TO_DT");
//				apdtToDt = apdtToDt.substring(0, 4) + "-" + apdtToDt.substring(4, 6) + "-" + apdtToDt.substring(6, 8);
//				recipientInfoVO.setBgngApdt(apdtFrDt + " ~ " + apdtToDt);
//				
//				Integer lmtAmt = Integer.valueOf((String)returnMap.get("LMT_AMT"));
//				Integer useAmt = Integer.valueOf((String)returnMap.get("USE_AMT"));
//				Integer remindAmt = lmtAmt - useAmt;
//				recipientInfoVO.setRemindAmt(remindAmt.toString());
//				recipientInfoVO.setUseAmt(useAmt.toString());
//				recipientInfoVO.setSearchDt(simpleDateFormat.format(new Date()));
//			}
			
			//수급자 상담정보
			MbrConsltVO mbrConsltVO = mbrConsltService.selectRecentConsltByRecipientsNo(recipientsNo);
			if (mbrConsltVO != null) {
				recipientInfoVO.setPrevPath(CodeMap.PREV_PATH.get(mbrConsltVO.getPrevPath()));
				recipientInfoVO.setRecentConsltSttus(CodeMap.CONSLT_STTUS.get(mbrConsltVO.getConsltSttus()));
				recipientInfoVO.setRecentConsltRegDt(simpleDateFormat.format(mbrConsltVO.getRegDt()));
			}
			
			//인정등급예상테스트 정보
			Map<String, Object> paramMap = new HashMap<>();
	    	paramMap.put("srchRecipientsNo", recipientsNo);
	    	MbrTestVO srchMbrTestVO = mbrTestService.selectMbrTest(paramMap);
	    	if (srchMbrTestVO != null) {
	    		recipientInfoVO.setTestResultYn("유");
	    		recipientInfoVO.setTestRegDt(simpleDateFormat.format(srchMbrTestVO.getRegDt()));
	    	} else {
	    		recipientInfoVO.setTestResultYn("무");
	    	}
			
	    	//관리정보 (최종변경일/처리자 항목 제거)
//	    	if ("Y".equals(mbrRecipients.getDelYn())) {
//	    		String delUserNm = "";
//	    		String delUserId = "";
//	    		String delDt = simpleDateFormat.format(mbrRecipients.getDelDt());
//	    		
//	    		if (EgovStringUtil.isNotEmpty(mbrRecipients.getDelMbrUniqueId())) {
//	    			MbrVO mbrVO = mbrService.selectMbrByUniqueId(mbrRecipients.getDelMbrUniqueId());
//	    			delUserNm = mbrVO.getMbrNm();
//	    			delUserId = mbrVO.getMbrId();
//	    		} else {
//	    			MngrVO mngrVO = mngrService.selectMngrByUniqueId(mbrRecipients.getDelMngrUniqueId());
//	    			delUserNm = mngrVO.getMngrNm();
//	    			delUserId = mngrVO.getMngrId();
//	    		}
//	    		
//	    		recipientInfoVO.setMngInfo(delDt + " / " + delUserNm + "(" + delUserId + ")");
//	    	}
	    	
			resultMap.put("recipientInfo", recipientInfoVO);
			resultMap.put("success", true);
		} catch (Exception ex) {
			resultMap.put("success", false);
			resultMap.put("msg", "수급자 정보 조회에 실패하였습니다.");
		}
		
		return resultMap;
	}
	
	/**
	 * 수급자 삭제
	 */
	@ResponseBody
	@RequestMapping(value = "/remove.json")
	public Map<String, Object> remove(@RequestParam int recipientsNo) {
		Map <String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			//수급자 기본정보
			MbrRecipientsVO mbrRecipients = mbrRecipientsService.selectMbrRecipientsByRecipientsNo(recipientsNo);
			mbrRecipients.setDelDt(new Date());
			mbrRecipients.setDelYn("Y");
			mbrRecipients.setDelMngrUniqueId(mngrSession.getUniqueId());
			
			mbrRecipientsService.updateMbrRecipients(mbrRecipients);
			resultMap.put("success", true);
		} catch (Exception ex) {
			resultMap.put("success", false);
			resultMap.put("msg", "수급자 정보 삭제에 실패하였습니다.");
		}
		
		return resultMap;
	}
}