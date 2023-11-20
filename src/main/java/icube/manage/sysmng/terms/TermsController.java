package icube.manage.sysmng.terms;

import java.util.List;
import java.util.Map;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.DateUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Controller
@RequestMapping(value = "/_mng/sysmng/terms")
public class TermsController  extends CommonAbstractController {
    @Autowired
	private MngrSession mngrSession;

    @Resource(name = "termsService")
	private TermsService termsService;

    @RequestMapping(value = "privacy/list")
	public String listPrivacy(
			HttpServletRequest request
            , @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {
        
                String termsKind = "PRIVACY";
        return this.listTerms(request, reqMap, termsKind, model);
	}

    @RequestMapping(value = "terms/list")
	public String listTerms(
			HttpServletRequest request
            , @RequestParam Map<String,Object> reqMap
            
			, Model model) throws Exception {
        String termsKind = "TERMS";
        return this.listTerms(request, reqMap, termsKind, model);
	}

    protected String listTerms(HttpServletRequest request
            , @RequestParam Map<String,Object> reqMap
            , String termsKind
			, Model model) throws Exception {
        
        reqMap.put("srchTermsKind", termsKind);

        List<TermsVO> listVO = termsService.selectListMngVO(reqMap);
        
        model.addAttribute("listVO", listVO);

        model.addAttribute("termsKind", termsKind);
        
        model.addAttribute("useYnCode", CodeMap.USE_YN);
        model.addAttribute("publicYnCode", CodeMap.PUBLIC_YN);
        model.addAttribute("termsKindCode", CodeMap.TERMS_KIND);

		return "/manage/sysmng/terms/list";
    }

    @RequestMapping(value = "privacy/form")
	public String formPrivacy(
			HttpServletRequest request
            , @RequestParam Map<String,Object> reqMap
            , @RequestParam(value="termsNo", required=true) int termsNo
            , TermsVO termsVO
			, Model model) throws Exception {

        String termsKind = "PRIVACY";
            
        return this.formTerms(request, reqMap, termsNo, termsKind, termsVO, model);
    }

    @RequestMapping(value = "terms/form")
	public String formTerms(
			HttpServletRequest request
            , @RequestParam Map<String,Object> reqMap
            , @RequestParam(value="termsNo", required=true) int termsNo
            , TermsVO termsVO
			, Model model) throws Exception {

        String termsKind = "TERMS";
            
        return this.formTerms(request, reqMap, termsNo, termsKind, termsVO, model);
    }

    public String formTerms(
			HttpServletRequest request
            , Map<String,Object> reqMap
            , int termsNo
            , String termsKind
            , TermsVO termsVO
			, Model model) throws Exception {

        if (termsNo == 0){
            termsVO.setCrud(CRUD.CREATE);
            termsVO.setTermsDt(DateUtil.getCurrentDateTime("yyyy-MM-dd"));
            termsVO.setUseYn("Y");
            termsVO.setPublicYn("Y");
            
        }else{
            termsVO = termsService.selectTermsOne(termsNo);
            termsVO.setCrud(CRUD.UPDATE);
        }
        
        model.addAttribute("termsVO", termsVO);

        model.addAttribute("param", reqMap);
        
        model.addAttribute("termsKind", termsKind);
        model.addAttribute("useYnCode", CodeMap.USE_YN);
        model.addAttribute("publicYnCode", CodeMap.PUBLIC_YN);
        model.addAttribute("termsKindCode", CodeMap.TERMS_KIND);

		return "/manage/sysmng/terms/form";
	}

    @RequestMapping(value = "{pathTermsKind}/action")
	public View action(
		@PathVariable String pathTermsKind
        , @RequestParam(value = "returnUrl", required=true) String returnUrl
		, TermsVO termsVO
        , @RequestParam Map<String,Object> reqMap
		, HttpSession session
    ) throws Exception {
        JavaScript javaScript = new JavaScript();

        termsVO.setRegUniqueId(mngrSession.getUniqueId());
		termsVO.setRegId(mngrSession.getMngrId());
		termsVO.setRgtr(mngrSession.getMngrNm());
		termsVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		termsVO.setMdfcnId(mngrSession.getMngrId());
		termsVO.setMdfr(mngrSession.getMngrNm());

        switch (termsVO.getCrud()) {
			case CREATE:
                termsService.insertTermsOne(termsVO);
                javaScript.setMessage(getMsg("action.complete.insert"));
                javaScript.setLocation(returnUrl);
            break;
			case UPDATE:
                termsService.updateTermsOne(termsVO);
                javaScript.setMessage(getMsg("action.complete.update"));
                javaScript.setLocation(returnUrl);
            break;
            default:
				break;

		}

        String useYn = reqMap.get("useYn").toString();

        if (EgovStringUtil.equals("Y", useYn) && !EgovStringUtil.equals(reqMap.get("oldUseYn").toString(), useYn)){
            termsService.updateTermsUseYnOtherN(termsVO);
        }

        return new JavaScriptView(javaScript);
    }
}
