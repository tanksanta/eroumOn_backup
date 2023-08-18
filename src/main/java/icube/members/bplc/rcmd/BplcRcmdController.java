package icube.members.bplc.rcmd;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.market.mbr.biz.MbrSession;
import icube.members.bplc.rcmd.biz.BplcRcmdService;
import icube.members.bplc.rcmd.biz.BplcRcmdVO;

/**
 * 사업소 추천
 */
@Controller
@RequestMapping(value="#{props['Globals.Members.path']}/bplc/rcmd")
public class BplcRcmdController extends CommonAbstractController {

	@Resource(name="bplcRcmdService")
	private BplcRcmdService bplcRcmdService;

	@Autowired
	private MbrSession mbrSession;

	@ResponseBody
	@RequestMapping("incrsAction.json")
	public Map<String, Object> incrsAction(
			@RequestParam(value="bplcUniqueId", required=true) String bplcUniqueId
			, HttpSession session) throws Exception {

		String result = "fail";

		BplcRcmdVO rcmdVO = new BplcRcmdVO();
		rcmdVO.setBplcUniqueId(bplcUniqueId);
		rcmdVO.setRegUniqueId(mbrSession.getUniqueId());
		rcmdVO.setRegId(mbrSession.getMbrId());
		rcmdVO.setRgtr(mbrSession.getMbrNm());

		if (!mbrSession.isLoginCheck()) {
			result = "login";
		} else {

			int chkCnt = bplcRcmdService.selectRcmdCntByUniqueId(rcmdVO);
			if(chkCnt > 0) {
				bplcRcmdService.updateIncrsCnt(rcmdVO, "dislike");
				result = "dislike";
			} else {
				int resultCnt = bplcRcmdService.updateIncrsCnt(rcmdVO, "like");
				if (resultCnt > 0) {
					result = "success";
				}
			}
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);

		return resultMap;
	}

}
