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
import icube.common.values.CodeMap;
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
    	
	/**
	 * 어르신등록 인트로
	 */
	@RequestMapping(value = "regist/intro")
	public String registIntro(
		Model model) throws Exception {
		
		return "/app/matching/membership/recipients/regist/intro";
	}
    
    /**
	 * 어르신등록 관계
	 */
	@RequestMapping(value = "regist/relation")
	public String registRelation(
			// @RequestParam String type //본인인증 후 해야할 작업타입
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
		
		return "/app/matching/membership/recipients/regist/birth";
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

        mbrRecipientVO.setMbrUniqueId(matMbrSession.getUniqueId());

        try {
            mbrRecipientsService.insertMbrRecipients(mbrRecipientVO);
        } catch (Exception e) {
            log.debug("매칭앱 수급자 등록 실패" + e.toString());
        }

		return resultMap;
	}
}
