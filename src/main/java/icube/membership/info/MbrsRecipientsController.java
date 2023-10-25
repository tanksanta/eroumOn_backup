package icube.membership.info;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.api.biz.TilkoApiVO;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CodeMap;
import icube.main.biz.ItemMap;
import icube.main.test.biz.MbrTestService;
import icube.main.test.biz.MbrTestVO;
import icube.manage.consult.biz.MbrConsltChgHistVO;
import icube.manage.consult.biz.MbrConsltResultVO;
import icube.manage.consult.biz.MbrConsltService;
import icube.manage.consult.biz.MbrConsltVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.mbr.recipients.biz.MbrRecipientsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;
import icube.market.mbr.biz.MbrSession;
import icube.membership.conslt.biz.ItrstService;
import icube.membership.conslt.biz.ItrstVO;

/**
 * 마이페이지 > 수급자 관리
 */
@Controller
@RequestMapping(value = "#{props['Globals.Membership.path']}/info/recipients")
public class MbrsRecipientsController extends CommonAbstractController {
	
	@Resource(name="mbrService")
	private MbrService mbrService;
	
	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;
	
	@Resource(name= "mbrRecipientsService")
	private MbrRecipientsService mbrRecipientsService;
	
	@Resource(name = "itrstService")
	private ItrstService itrstService;
	
	@Resource(name="mbrTestService")
    private MbrTestService mbrTestService;
	
	@Autowired
	private MbrSession mbrSession;
	
	/**
	 * 수급자 관리 목록
	 */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model
			) throws Exception {

		MbrVO mbrVO = mbrService.selectMbrByUniqueId(mbrSession.getUniqueId());
		
		Map<Integer, MbrConsltVO> mbrConsltMap = new HashMap<>();
		List<MbrRecipientsVO> mbrRecipientsList = mbrVO.getMbrRecipientsList();
		if (mbrRecipientsList != null && mbrRecipientsList.size() > 0) {
			for(int i = 0; i < mbrRecipientsList.size(); i++) {
				MbrConsltVO mbrConslt = mbrConsltService.selectRecentConsltByRecipientsNo(mbrRecipientsList.get(i).getRecipientsNo());
				mbrConsltMap.put(mbrRecipientsList.get(i).getRecipientsNo(), mbrConslt);
			}
		}
		model.addAttribute("mbrVO", mbrVO);
		model.addAttribute("mbrConsltMap", mbrConsltMap);
		
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());
		paramMap.put("srchItrstTy", "B");
		
		List <ItrstVO> itrstList = itrstService.selectItrstListAll(paramMap);
		model.addAttribute("itrstList", itrstList);
		
		
		model.addAttribute("prevPath", CodeMap.PREV_PATH);
		model.addAttribute("consltSttus", CodeMap.CONSLT_STTUS);
		model.addAttribute("relationCd", CodeMap.MBR_RELATION_CD);
		
		return "/membership/info/recipients/list";
	}
	
	/**
	 * 수급자 관리 상세
	 */
	@RequestMapping(value="view")
	public String view(
			@RequestParam Integer recipientsNo
			, Model model
			) throws Exception {
		
		MbrRecipientsVO recipient = mbrRecipientsService.selectMbrRecipientsByRecipientsNo(recipientsNo);
		String recipientsNm = recipient.getRecipientsNm();
		String rcperRcognNo = recipient.getRcperRcognNo();
		
		//수급자 정보
		MbrVO mbrVO = mbrService.selectMbrByUniqueId(mbrSession.getUniqueId());
		List<MbrRecipientsVO> mbrRecipientList = mbrVO.getMbrRecipientsList();
		MbrRecipientsVO srchRecipient = mbrRecipientList.stream().filter(f -> f.getRecipientsNo() == recipientsNo).findAny().orElse(null);
		
		//상담정보
		MbrConsltVO mbrConslt = mbrConsltService.selectRecentConsltByRecipientsNo(recipientsNo);
		if (mbrConslt != null) {
			List<MbrConsltResultVO> consltResultList = mbrConslt.getConsltResultList();
			if (consltResultList.size() > 0) {
				MbrConsltResultVO mbrConsltResult = consltResultList.get(0);
				model.addAttribute("consltResultVO", mbrConsltResult);
				
				//상담 완료 히스토리 찾기
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("srchConsltNo", mbrConslt.getConsltNo());
				List<MbrConsltChgHistVO> chgHistList =  mbrConsltService.selectMbrConsltChgHist(paramMap);
				for(MbrConsltChgHistVO chgHist : chgHistList) {
					if (chgHist.getBplcConsltNo() != null && chgHist.getBplcConsltNo() == mbrConsltResult.getBplcConsltNo()
							&& "CS06".equals(chgHist.getBplcConsltSttusChg())) {
						model.addAttribute("completeChgHistVO", mbrConsltResult);
					}
				}
			}
		}
		
		//인정등급예상테스트 정보
		Map<String, Object> paramMap = new HashMap<>();
    	paramMap.put("srchRecipientsNo", recipientsNo);
    	MbrTestVO srchMbrTestVO = mbrTestService.selectMbrTest(paramMap);
    	
		
		TilkoApiVO apiVO = new TilkoApiVO();
		model.addAttribute("apiVO",apiVO);
		model.addAttribute("apiCode", ItemMap.RECIPTER_ITEM);
		model.addAttribute("recipientVO", srchRecipient);
		model.addAttribute("consltVO", mbrConslt);
		model.addAttribute("testVO", srchMbrTestVO);
		model.addAttribute("recipientsNo", recipientsNo);
		model.addAttribute("recipientsNm", recipientsNm);
		model.addAttribute("rcperRcognNo", rcperRcognNo);
		model.addAttribute("refleshDate", new Date());
		
		model.addAttribute("relationCd", CodeMap.MBR_RELATION_CD);
		model.addAttribute("genderCode", CodeMap.GENDER);
		model.addAttribute("prevPathCode", CodeMap.PREV_PATH);
		model.addAttribute("consltSttusCode", CodeMap.CONSLT_STTUS);
		
		return "/membership/info/recipients/view";
	}
	
	/**
	 * 대표 수급자 처리 API
	 */
	@ResponseBody
	@RequestMapping(value = "update/main.json")
	public Map<String, Object> addMbrRecipient(
		@RequestParam Integer recipientsNo,
		HttpServletRequest request) throws Exception {
		
		Map <String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<MbrRecipientsVO> mbrRecipientList = mbrRecipientsService.selectMbrRecipientsByMbrUniqueId(mbrSession.getUniqueId());
			MbrRecipientsVO srchRecipient = mbrRecipientList.stream().filter(f -> f.getRecipientsNo() == recipientsNo).findAny().orElse(null);
			if (srchRecipient == null) {
				resultMap.put("success", false);
				resultMap.put("msg", "회원에 등록되지 않은 수급자입니다");
				return resultMap;
			}
			
			for (MbrRecipientsVO mbrRecipient : mbrRecipientList) {
				if (mbrRecipient.getRecipientsNo() == recipientsNo) {
					mbrRecipient.setMainYn("Y");
				} else {
					mbrRecipient.setMainYn("N");
				}
				mbrRecipientsService.updateMbrRecipients(mbrRecipient);
			}
			resultMap.put("success", true);
		} catch (Exception ex) {
			resultMap.put("success", false);
			resultMap.put("msg", "수급자 등록중 오류가 발생하였습니다");
		}
		
		return resultMap;
	}
}
