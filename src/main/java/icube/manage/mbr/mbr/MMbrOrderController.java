package icube.manage.mbr.mbr;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.vo.CommonListVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;

@Controller
@RequestMapping(value="/_mng/mbr/order")
public class MMbrOrderController extends CommonAbstractController {

	@Resource(name = "mbrService")
	private MbrService mbrService;



	/**
	 * 주문 내역
	 *
	 */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model
			, @RequestParam(value="uniqueId", required=true) String uniqueId
			) throws Exception{


		// 20221113 kkm, 무슨 기능인지 확인 못했으나 > 오류방지 수정

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("srchUniqueId", uniqueId);
		listVO = mbrService.mbrListVO(listVO);

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", uniqueId);
		MbrVO mbrVO = mbrService.selectMbr(paramMap);

		model.addAttribute("listVO", listVO);
		model.addAttribute("mbrVO", mbrVO);

		return "/manage/mbr/manage/order/list";
	}
}
