package icube.members.bplc.mng;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.vo.CommonListVO;
import icube.manage.members.notice.biz.BplcNoticeService;
import icube.manage.ordr.ordr.biz.OrdrService;
import icube.members.biz.PartnersSession;

/**
 * 사업소 관리자 > INDEX(dashboard)
 */
@Controller
@RequestMapping(value="#{props['Globals.Members.path']}/{bplcUrl}/mng")
public class MBplcIndexController extends CommonAbstractController {

	@Resource(name = "bplcNoticeService")
	private BplcNoticeService noticeService;

	@Resource(name = "ordrService")
	private OrdrService ordrService;

	@Autowired
	private PartnersSession partnersSession;

	@Value("#{props['Globals.Members.path']}")
	private String membersPath;


	@RequestMapping(value = {"","index", "dashboard"})
	public String bplcMngIndex(
			@PathVariable String bplcUrl
			, HttpSession session
			, HttpServletRequest request
			, Model model) throws Exception {


		return "redirect:/"+ membersPath +"/"+partnersSession.getPartnersId()+"/mng/conslt/list";

		/* 20230817 kkm : 대시보드가 확정되기 전까지 1:1상담으로 리턴

		//마켓 공지사항
		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("srchUseYn", "Y");
		listVO = noticeService.bplcNoticeListVO(listVO);

		model.addAttribute("listVO", listVO);


		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchBplcUniqueId", partnersSession.getUniqueId());
		Map<String, Integer> ordrSttsTyCntMap = ordrService.selectSttsTyCnt(paramMap);
		model.addAttribute("ordrSttsTyCntMap", ordrSttsTyCntMap);

		return "/members/bplc/mng/dashboard";
		 */
	}



}
