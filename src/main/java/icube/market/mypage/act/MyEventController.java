package icube.market.mypage.act;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.vo.CommonListVO;
import icube.manage.promotion.event.biz.EventApplcnService;
import icube.market.mbr.biz.MbrSession;

/**
 * 마이페이지 > 쇼핑활동 > 참여한 이벤트
 */

@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/mypage/event")
public class MyEventController extends CommonAbstractController {

	@Resource(name="eventApplcnService")
	private EventApplcnService eventApplcnService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	/**
	 * 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model
			)throws Exception {

		//최근 내역 개월
		int monthParam = 6;

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("uniqueId", mbrSession.getUniqueId());
		listVO.setParam("srchLastMonth", monthParam);

		listVO = eventApplcnService.eventApplcnListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("srchLastMonthParam", monthParam);

		return "/market/mypage/event/list";
	}

}
