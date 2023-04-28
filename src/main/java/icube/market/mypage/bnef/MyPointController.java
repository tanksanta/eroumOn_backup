package icube.market.mypage.bnef;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.promotion.point.biz.MbrPointService;
import icube.market.mbr.biz.MbrSession;

/**
 * 마이페이지 > 쇼핑혜택 > 포인트
 */
@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/mypage/point")
public class MyPointController extends CommonAbstractController {

	@Resource(name="mbrPointService")
	private MbrPointService mbrPointService;

	@Autowired
	private MbrSession mbrSession;

	/**
	 * 회원 포인트 목록
	 * @param uniqueId
	 * @return 적립 && 차감 목록
	 * @throws Exception
	 */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model
			, @RequestParam(value="type", required=false) String type
			) throws Exception {

		// history
		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("srchUniqueId", mbrSession.getUniqueId());
		listVO.setParam("srchPointSe", type);
		listVO = mbrPointService.mbrPointListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("gradeCode", CodeMap.GRADE);
		model.addAttribute("pointCnCode", CodeMap.POINT_CN);

		return "/market/mypage/point/list";
	}

}
