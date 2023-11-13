package icube.members.bplc.mng;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.manage.consult.biz.MbrConsltResultService;

/**
 * 이로움케어 호출용 API 컨트롤러
 */
@Controller
@RequestMapping(value="/api/#{props['Globals.Members.path']}/conslt")
public class MBplcConsltApiController extends CommonAbstractController {

	@Resource(name = "mbrConsltResultService")
	private MbrConsltResultService mbrConsltResultService;

	@Value("#{props['Globals.EroumCare.PrivateKey']}")
	private String eroumCarePrivateKey;
	
	
	// 사업소 > 상담 거부 (이로움케어 호출용 API)
	@RequestMapping(value = "/rejectConslt.json", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> rejectConslt(
			@RequestParam(value = "bplcConsltNo", required=true) int bplcConsltNo
			, HttpServletRequest request
			) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", false);
		
		String eroumApikey = request.getHeader("eroumAPI_Key");
    	if (!eroumCarePrivateKey.equals(eroumApikey)) {
    		resultMap.put("msg", "인증되지 않은 접근입니다.");
    		resultMap.put("code", "err_99");
    		return resultMap;
    	}
		
		try {
			resultMap = mbrConsltResultService.changeSttusForBplc(bplcConsltNo, "CS04");
		} catch (Exception ex) {
			resultMap.put("msg", "서버 처리중 오류가 발생하였습니다.");
    		resultMap.put("code", "err_98");
    		return resultMap;
		}
		return resultMap;
	}
}
