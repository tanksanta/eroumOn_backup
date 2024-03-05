package icube.app.matching.membership.info;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.app.matching.membership.mbr.biz.MatMbrSession;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.DateUtil;
import icube.common.values.CodeMap;
import icube.common.vo.CommonCheckVO;
import icube.manage.mbr.recipients.biz.MbrRecipientsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;

/**
 * 어르신 등록
 */
@Controller
@RequestMapping(value="#{props['Globals.Matching.path']}/membership/recipients")
public class MatMbrRecipientsController extends CommonAbstractController {

    @Resource(name= "mbrRecipientsService")
	private MbrRecipientsService mbrRecipientsService;

    @Autowired
	private MatMbrSession matMbrSession;

	protected Map<String, Object> convertToMap(CommonCheckVO checkVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("success", checkVO.isSuccess());
		if (!checkVO.isSuccess()){
			if (EgovStringUtil.isNotEmpty(checkVO.getErrorMsg())){
				resultMap.put("msg", checkVO.getErrorMsg());
			} else if (EgovStringUtil.isNotEmpty(checkVO.getErrorCode())){
				resultMap.put("msg", getMsg(checkVO.getErrorCode()));
			}
		}

		return resultMap;
	}
    	
	/**
	 * 어르신등록 인트로
	 */
	@RequestMapping(value = "regist/intro")
	public String registIntro(
		Model model) throws Exception {

		boolean isLogin = true;
        if(!matMbrSession.isLoginCheck()) {
            isLogin = false;
        }
		model.addAttribute("isLogin", isLogin);

		if (isLogin){
			int count = mbrRecipientsService.selectCountMbrRecipientsByMbrUniqueId(matMbrSession.getUniqueId());

			model.addAttribute("recipientsCount", count);
		}
		
		
		return "/app/matching/membership/recipients/regist/intro";
	}
    
    /**
	 * 어르신등록 관계
	 */
	@RequestMapping(value = "regist/relation")
	public String registRelation(
			Model model) throws Exception {
		
		return "/app/matching/membership/recipients/regist/relation";
	}

    
    /**
	 * 어르신등록 이름
	 */
	@RequestMapping(value = "regist/name")
	public String registName(
		@RequestParam String relationCd
		, Model model) throws Exception {

		if (EgovStringUtil.equals(relationCd, "007") ){
			model.addAttribute("recipientsNm", matMbrSession.getMbrNm());
			model.addAttribute("disabled", "disabled");
		}
			
        model.addAttribute("relationNm", CodeMap.MBR_RELATION_CD.get(relationCd));
        
		
		return "/app/matching/membership/recipients/regist/name";
	}

    
    /**
	 * 어르신등록 생년월일
	 */
	@RequestMapping(value = "regist/birth")
	public String registBirth(
        @RequestParam String relationCd
		, @RequestParam String recipientsNm
		, Model model) throws Exception {

		model.addAttribute("relationNm", CodeMap.MBR_RELATION_CD.get(relationCd));
		model.addAttribute("recipientsNm", recipientsNm);

		if (EgovStringUtil.equals(relationCd, "007") ){
			model.addAttribute("birth", DateUtil.getDateTime(matMbrSession.getBrdt(), "yyyy/MM/dd"));
			model.addAttribute("disabled", "disabled");
		}
		
		return "/app/matching/membership/recipients/regist/birth";
	}

	/**
	 * 어르신등록 체크로직
	 */
	@ResponseBody
	@RequestMapping(value = "regist/check")
	public Map<String, Object> registCheck(
        @RequestParam Map<String,Object> reqMap
		, Model model) throws Exception {

		CommonCheckVO checkVO = mbrRecipientsService.insertCheckMbrRecipients(matMbrSession.getUniqueId(), reqMap);
		
		return this.convertToMap(checkVO);
	}

    /**
	 * 어르신등록 저장
	 */
    @ResponseBody
	@RequestMapping(value = "regist/regist.json")
	public Map<String, Object> registUpdate(
        @RequestParam Map<String,Object> reqMap
        , MbrRecipientsVO mbrRecipientVO
        , HttpServletRequest request
		, Model model) throws Exception {

        Map<String, Object> resultMap = new HashMap<String, Object>();

		int recipientsCnt = mbrRecipientsService.selectCountMbrRecipientsByMbrUniqueId(matMbrSession.getUniqueId());
		if (recipientsCnt == 0){
			mbrRecipientVO.setMainYn("Y");
		}else{
			mbrRecipientVO.setMainYn("N");
		}

        mbrRecipientVO.setMbrUniqueId(matMbrSession.getUniqueId());
        
        if (EgovStringUtil.isEmpty(mbrRecipientVO.getRcperRcognNo())){
			mbrRecipientVO.setRecipientsYn("N");
		}else{
			mbrRecipientVO.setRecipientsYn("Y");
		}

		int recipientsNo = 0;
        try {
            mbrRecipientsService.insertMbrRecipients(mbrRecipientVO);
        } catch (Exception e) {
            log.debug("매칭앱 수급자 등록 실패" + e.toString());
        }

		recipientsNo = mbrRecipientVO.getRecipientsNo();

		resultMap.put("success", true);
		resultMap.put("recipientsNo", recipientsNo);
		
		return resultMap;
	}
    
    /**
	 * 대표 수급자 처리 API
	 */
	@ResponseBody
	@RequestMapping(value = "update/main.json")
	public Map<String, Object> updateMainRecipient(
		@RequestParam Integer recipientsNo,
		HttpServletRequest request) throws Exception {
		return mbrRecipientsService.updateMainRecipient(matMbrSession.getUniqueId(), recipientsNo);
	}
}
