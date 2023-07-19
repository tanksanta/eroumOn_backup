package icube.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.values.CodeMap;
import icube.main.biz.MainService;
import icube.manage.consult.biz.MbrConsltService;
import icube.manage.consult.biz.MbrConsltVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.members.bplc.biz.BplcService;
import icube.manage.members.bplc.biz.BplcVO;

@Controller
@RequestMapping(value="#{props['Globals.Main.path']}/conslt")
public class MainConsltController extends CommonAbstractController{

	@Resource(name = "mainService")
	private MainService mainService;

	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "bplcService")
	private BplcService bplcService;

	/*@Autowired
	private MbrSession mbrSession;*/

	@Value("#{props['Globals.Main.path']}")
	private String mainPath;

	@RequestMapping(value = "form")
	public String form(
			HttpServletRequest request
			, Model model
			, HttpSession session
			, MbrConsltVO mbrConsltVO
			)throws Exception {

		/*if(!mbrSession.isLoginCheck()) {
			session.setAttribute("returnUrl", "/"+mainPath+"/conslt/form");
			return "redirect:" + "/"+mainPath+"/login?returnUrl=/"+mainPath+"/conslt/form";
		}*/

		model.addAttribute("mbrConsltVO", mbrConsltVO);
		model.addAttribute("genderCode", CodeMap.GENDER);

		return "/main/conslt/form";
	}

	@RequestMapping(value = "action")
	public View action(
			HttpServletRequest request
			, Model model
			, MbrConsltVO mbrConsltVO
			)throws Exception {

		JavaScript javaScript = new JavaScript();

		/*mbrConsltVO.setRegId(mbrSession.getMbrId());
		mbrConsltVO.setRegUniqueId(mbrSession.getUniqueId());
		mbrConsltVO.setRgtr(mbrConsltVO.getMbrNm());*/

		if(EgovStringUtil.isNotEmpty(mbrConsltVO.getBrdt())) {
			mbrConsltVO.setBrdt(mbrConsltVO.getBrdt().replace("/", ""));
		}

		int insertCnt = mbrConsltService.insertMbrConslt(mbrConsltVO);

		/*if(insertCnt > 0) {
			Map<String, Object> paramMap = new HashMap<String, Object>();

			paramMap.put("mbrNm", mbrConsltVO.getMbrNm());
			paramMap.put("mblTelno",mbrConsltVO.getMbrTelno());
			paramMap.put("zip", mbrConsltVO.getZip());
			paramMap.put("addr", mbrConsltVO.getAddr());
			paramMap.put("daddr", mbrConsltVO.getDaddr());
			paramMap.put("uniqueId", mbrSession.getUniqueId());

			int updateCnt = mbrService.updateMbrAddr(paramMap);

			if(updateCnt > 0) {
				javaScript.setMessage(getMsg("action.complete.insert"));
				javaScript.setLocation("/"+mainPath+"/conslt/view");
			}else {
				javaScript.setMessage(getMsg("fail.common.network"));
				javaScript.setMethod("window.history.back()");
			}
		}else {
			javaScript.setMessage(getMsg("fail.common.network"));
			javaScript.setMethod("window.history.back()");
		}*/

		javaScript.setMessage(getMsg("action.complete.insert"));
		javaScript.setLocation("/"+mainPath+"/conslt/view");
		return new JavaScriptView(javaScript);
	}

	@RequestMapping(value = "view")
	public String view(
			HttpServletRequest request
			, Model model
			)throws Exception {

		return "/main/conslt/view";
	}

	// 추천 멤버스 리스트
	@RequestMapping(value="include/popup")
	public String popup(
			Model model
			)throws Exception  {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchAprvTy", "C");
		paramMap.put("srchUseYn", "Y");
		paramMap.put("srchDspyYn", "Y");
		List<BplcVO> bplcList = bplcService.selectBplcList(paramMap);

		model.addAttribute("bplcList", bplcList);

		return "/main/conslt/include/popup";
	}
}