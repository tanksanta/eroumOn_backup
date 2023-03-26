package icube.market.mbr;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 휴면 계정
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/drmt")
@SuppressWarnings({"rawtypes","unchecked"})
public class DrmtController extends CommonAbstractController {

	@Resource(name="mbrService")
	private MbrService mbrService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	/**
	 * 휴면계정 확인
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="view")
	public String view(
			HttpServletRequest request
			, Model model
			)throws Exception {

		Map paramMap = new HashMap();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());
		MbrVO mbrVO = mbrService.selectMbr(paramMap);

		model.addAttribute("mbrVO", mbrVO);

		return "/market/mbr/drmt/view";
	}

	//임시 해제
	@RequestMapping(value="action")
	public View action(
			HttpServletRequest request
			, Model model
			) throws Exception{

		JavaScript javaScript = new JavaScript();

		//TO-DO 본인인증 절차

		Map paramMap = new HashMap();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());
		paramMap.put("mdfcnId", mbrSession.getMbrId());
		paramMap.put("mdfr", mbrSession.getMbrNm());
		paramMap.put("mberSttus", "NORMAL");
		mbrService.updateRlsDrmt(paramMap);

		javaScript.setMessage(getMsg("action.complete.newPswd"));
		javaScript.setLocation("/"+ marketPath + "/drmt/clear");

		return new JavaScriptView(javaScript);
	}


	/**
	 * 휴면 계정 해제 확인
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="clear")
	public String clear(
			HttpServletRequest request
			, Model model
			)throws Exception {

		Map paramMap = new HashMap();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());
		MbrVO mbrVO = mbrService.selectMbr(paramMap);

		model.addAttribute("mbrVO", mbrVO);


		return "/market/mbr/drmt/clear";
	}
}
