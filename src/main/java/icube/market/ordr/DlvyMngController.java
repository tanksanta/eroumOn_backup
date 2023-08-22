package icube.market.ordr;

import java.util.HashMap;
import java.util.List;
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
import icube.manage.ordr.ordr.biz.OrdrService;
import icube.manage.ordr.ordr.biz.OrdrVO;
import icube.market.mbr.biz.MbrSession;
import icube.membership.info.biz.DlvyService;
import icube.membership.info.biz.DlvyVO;

@Controller
@RequestMapping(value="/comm/dlvy")
public class DlvyMngController extends CommonAbstractController{


	@Resource(name="ordrService")
	private OrdrService ordrService;

	@Resource(name="dlvyService")
	private DlvyService dlvyService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	/**
	 * 주문 결제용 배송지 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="dlvyUseByOrder")
	@SuppressWarnings({"rawtypes","unchecked"})
	public String dlvyUseByOrder(
			HttpServletRequest request
			, Model model
			, DlvyVO dlvyVO
			, @RequestParam(value="path", required=true) String path //현재 주소 param
			, @RequestParam(value="ordrCd", required=false) String ordrCd // 주문번호
			) throws Exception {


		//최근 배송지
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());

		List<OrdrVO> recentList = ordrService.selectOrdrList(paramMap);

		//나의 주소록
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());
		paramMap.put("srchUseYn", "Y");
		List<DlvyVO> dlvyList = dlvyService.selectDlvyListAll(paramMap);

		model.addAttribute("recentList", recentList);
		model.addAttribute("dlvyList", dlvyList);
		model.addAttribute("path", path);
		model.addAttribute("ordrCd", ordrCd);

		return "/market/ordr/include/modal_dlvy";
	}

	/**
	 * 배송지 신규 수정
	 * @param request
	 * @param model
	 * @param dlvyVO
	 * @param ordrCd
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="action")
	public View action(
			HttpServletRequest request
			, Model model
			, DlvyVO dlvyVO
			, @RequestParam(value="ordrDlvyCd", required=true) String ordrCd
			) throws Exception {

		JavaScript javaScript = new JavaScript();

		Map<String, Object> paramMap = new HashMap();

		paramMap.put("ordrCd", ordrCd);
		paramMap.put("recptrNm", dlvyVO.getNm());
		paramMap.put("recptrTelno", dlvyVO.getTelno());
		paramMap.put("recptrMblTelno", dlvyVO.getMblTelno());
		paramMap.put("recptrZip", dlvyVO.getZip());
		paramMap.put("recptrAddr", dlvyVO.getAddr());
		paramMap.put("recptrDaddr", dlvyVO.getDaddr());
		paramMap.put("ordrrMemo", dlvyVO.getMemo());

		try {
			ordrService.updateDlvyInfo(paramMap);

		}catch(Exception e) {
			e.printStackTrace();
			log.debug("ORDR DLVY UPDATE ERROR");
		}

		javaScript.setMessage("수정되었습니다.");
		javaScript.setLocation("/" + marketPath + "/mypage/ordr/view/"+ordrCd);

		return new JavaScriptView(javaScript);

	}

	/**
	 * 배송지 선택 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="updDlvyBySelect.json")
	@ResponseBody
	@SuppressWarnings({"unchecked","rawtypes"})
	public Map<String, Object> updDlvyBySelect(
			HttpServletRequest request
			, Model model
			, @RequestParam Map<String, Object> reqMap
			)throws Exception {

		Map<String, Object> resultMap = new HashMap();
		Map<String, Object> paramMap = new HashMap();

		boolean result = false;

		paramMap.put("ordrCd", reqMap.get("ordrDlvyCd"));
		paramMap.put("recptrNm", reqMap.get("nm"));
		paramMap.put("recptrTelno", reqMap.get("telno"));
		paramMap.put("recptrMblTelno", reqMap.get("mbltelno"));
		paramMap.put("recptrZip", reqMap.get("zip"));
		paramMap.put("recptrAddr", reqMap.get("addr"));
		paramMap.put("recptrDaddr", reqMap.get("daddr"));
		paramMap.put("ordrrMemo", reqMap.get("memo"));

		try {
			ordrService.updateDlvyInfo(paramMap);
			result = true;

		}catch(Exception e) {
			e.printStackTrace();
			log.debug("ORDR DLVY UPDATE ERROR");
		}

		resultMap.put("result", result);

		return resultMap;
	}
}
