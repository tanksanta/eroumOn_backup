package icube.membership.conslt;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.common.framework.abst.CommonAbstractController;
import icube.market.mbr.biz.MbrSession;

@Controller
@RequestMapping(value="#{props['Globals.Membership.path']}/conslt")
public class MbrsConsltController extends CommonAbstractController {


	@Autowired
	private MbrSession mbrSession;

	// 상담 신청목록
	@RequestMapping(value="/appl/list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());

		return "/membership/conslt/appl/list";
	}

	// 재상담 신청

	// 좋아요

	// 관심멤버스 추가
}
