package icube.market.mypage.bnef;

import java.util.Map;

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
import icube.manage.promotion.mlg.biz.MbrMlgService;
import icube.market.mbr.biz.MbrSession;

/**
 * 마이페이지 > 쇼핑혜택 > 마일리지
 */
@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/mypage/mlg")
public class MyMlgController extends CommonAbstractController {

	@Resource(name="mbrMlgService")
	private MbrMlgService mbrMlgService;

	@Autowired
	private MbrSession mbrSession;

	/**
	 * 회원 마일리지 목록
	 * @param uniqueId
	 * @return 이용가능 마일리지, 이달 소멸 예정, 가족회원 마일리지 by Map
	 * @return 적립 && 차감 목록
	 * @throws Exception
	 */
	@RequestMapping(value="list")
	private String list(
			HttpServletRequest request
			, Model model
			, @RequestParam(value="type", required=false) String type
			) throws Exception{

		// 마일리지 정보
		Map<String, Object> synMap = mbrMlgService.selectTotalTypeMlg(mbrSession.getUniqueId());

		// history
		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("srchMlgSe", type);
		listVO.setParam("srchUniqueId", mbrSession.getUniqueId());
		listVO = mbrMlgService.mbrMlgListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("synMap", synMap);
		model.addAttribute("gradeCode", CodeMap.GRADE);
		model.addAttribute("mlgCnCode", CodeMap.POINT_CN);

		return "/market/mypage/mlg/list";
	}
}
