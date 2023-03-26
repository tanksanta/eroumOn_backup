package icube.market.mypage.act;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.vo.CommonListVO;
import icube.manage.ordr.ordr.biz.OrdrService;
import icube.market.mbr.biz.MbrSession;

/**
 * 마이페이지 > 쇼핑활동 > 내가 구매한 상품
 */

@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/mypage/buy")
public class MyBuyGdsController extends CommonAbstractController {

	@Resource(name = "ordrService")
	private OrdrService ordrService;

	@Autowired
	private MbrSession mbrSession;

	@RequestMapping(value = "list")
	public String list(
			HttpServletRequest request
			, Model model
			) throws Exception {

		CommonListVO listVO = new CommonListVO(request);

		listVO.setParam("ordrSttsTy", "OR09");
		listVO.setParam("srchUniqueId", mbrSession.getUniqueId());
		listVO.setParam("srchOptnTy", "BASE");
		listVO.setParam("srchBuyDay", 6);
		listVO = ordrService.ordrMyListVO(listVO);

		model.addAttribute("listVO", listVO);

		return "/market/mypage/buy/list";
	}

}
