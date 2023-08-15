package icube.membership;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.vo.CommonListVO;
import icube.manage.consult.biz.MbrConsltService;
import icube.market.mbr.biz.MbrSession;
import icube.membership.conslt.biz.ItrstService;
import icube.membership.conslt.biz.ItrstVO;

@Controller
@RequestMapping(value = "#{props['Globals.Membership.path']}")
public class MbrsIndexController extends CommonAbstractController {

	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;

	@Resource(name = "itrstService")
	private ItrstService itrstService;

	@Autowired
	private MbrSession mbrSession;

	@RequestMapping(value = "index")
	public String registStep(
			HttpServletRequest request
			, Model model) throws Exception {


		// 장기요양 상담신청
		CommonListVO listVO = new CommonListVO(request, 1, 3);
		listVO.setParam("srchUseYn", "Y");
		listVO.setParam("srchUniqueId", mbrSession.getUniqueId());
		listVO = mbrConsltService.selectMbrConsltListVO(listVO);
		model.addAttribute("consltList", listVO.getListObject());

		// 관심멤버스
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());
		paramMap.put("srchItrstTy", "B");
		List<ItrstVO> bplcList = itrstService.selectItrstListAll(paramMap);
		model.addAttribute("bplcList", bplcList);

		return "/membership/index";
	}
}
