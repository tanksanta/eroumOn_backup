package icube.app.matching.membership.info;

import java.util.HashMap;
import java.util.Map;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.app.matching.membership.mbr.biz.MatMbrSession;
import icube.common.framework.abst.CommonAbstractController;

/**
 * 어르신 등록
 */
@Controller
@RequestMapping(value="#{props['Globals.Matching.path']}/membership/recipients")
public class MatMbrRecipientsController extends CommonAbstractController {

    @Autowired
	private MatMbrSession matMbrSession;
    	
	/**
	 * 어르신등록 인트로
	 */
	@RequestMapping(value = "regist/intro")
	public String registIntro(
			// @RequestParam String type //본인인증 후 해야할 작업타입
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
			// @RequestParam String type //본인인증 후 해야할 작업타입
			Model model) throws Exception {
		
		return "/app/matching/membership/recipients/regist/name";
	}

    
    /**
	 * 어르신등록 생년월일
	 */
	@RequestMapping(value = "regist/birth")
	public String registBirth(
			// @RequestParam String type //본인인증 후 해야할 작업타입
			Model model) throws Exception {
		
		return "/app/matching/membership/recipients/regist/birth";
	}

    
}
