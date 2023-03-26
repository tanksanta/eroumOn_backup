package icube.market.mypage.act;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.vo.CommonListVO;
import icube.manage.consult.biz.GdsQaService;
import icube.manage.consult.biz.GdsQaVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 마이페이지 > 쇼핑활동 > 상품Q&A
 */

@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/mypage/gdsQna")
public class MyQaController extends CommonAbstractController {

	@Resource(name="gdsQaService")
	private GdsQaService gdsQaService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	/**
	 * Qna 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model
			) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("srchUniqueId", mbrSession.getUniqueId());
		listVO.setParam("srchUseYn", "Y");

		listVO = gdsQaService.gdsQaListVO(listVO);

		model.addAttribute("listVO", listVO);

		return "/market/mypage/gdsQna/list";
	}

	/**
	 * 상품 문의 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="action")
	public View action(
			HttpServletRequest request
			, Model model
			, GdsQaVO gdsQaVO
			, @RequestParam(value = "secret", required=true) String secretYn
			) throws Exception {

		JavaScript javaScript = new JavaScript();

		//수정자 정보
		gdsQaVO.setMdfcnId(mbrSession.getMbrId());
		gdsQaVO.setMdfcnUniqueId(mbrSession.getUniqueId());
		gdsQaVO.setMdfr(mbrSession.getMbrNm());

		gdsQaVO.setSecretYn(secretYn);


		try {
			gdsQaService.updateGdsQa(gdsQaVO);
			javaScript.setMessage(getMsg("action.complete.update"));
			javaScript.setLocation("/"+ marketPath + "/mypage/gdsQna/list");

		}catch(Exception e) {
			e.printStackTrace();
			log.debug("GDSQA UPDATE ERROR");
		}

		return new JavaScriptView(javaScript);
	}

	/**
	 * 정보 수정 모달
	 * @param request
	 * @param model
	 * @param gdsCd
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="modalGdsQnaForm")
	public String modalGdsQnaForm(
			HttpServletRequest request
			, Model model
			, GdsQaVO gdsQaVO
			, @RequestParam(value="qaNo" , required=true) int qaNo
			)throws Exception {


		gdsQaVO = gdsQaService.selectGdsQa(qaNo);

		model.addAttribute("gdsQaVO", gdsQaVO);

		return "/market/mypage/gdsQna/include/gdsQna-update-modal";
	}


	/**
	 * 게시글 삭제
	 * @param qaNo
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="deleteQna.json")
	@ResponseBody
	@SuppressWarnings({"unchecked","rawtypes"})
	public Map<String, Object> resultMap(
			@RequestParam(value="qaNo", required=true) int qaNo
			, HttpServletRequest request
			, Model model
			)throws Exception {
		Map<String, Object> resultMap = new HashMap();
		boolean result = false;

		try {
			GdsQaVO gdsQaVO = gdsQaService.selectGdsQa(qaNo);
			gdsQaVO.setUseYn("N");
			gdsQaService.updateGdsQa(gdsQaVO);
			result = true;
		}catch(Exception e) {
			e.printStackTrace();
			log.debug("MY QNA DELETE ERROR");
		}

		resultMap.put("result", result);
		return resultMap;
	}
}
