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

import icube.common.api.biz.EroumcareApiResponseVO;
import icube.common.framework.abst.CommonAbstractController;
import icube.manage.consult.biz.MbrConsltResultService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 이로움케어 호출용 API 컨트롤러
 */
@Api(tags = "이로움케어 상담상태 변경 요청 API")
@Controller
@RequestMapping(value="/api/#{props['Globals.Members.path']}/conslt")
public class MBplcConsltApiController extends CommonAbstractController {

	@Resource(name = "mbrConsltResultService")
	private MbrConsltResultService mbrConsltResultService;

	@Value("#{props['Globals.EroumCare.PrivateKey']}")
	private String eroumCarePrivateKey;
	
	
	// 사업소 > 상담 거부 (이로움케어 호출용 API)
	@ApiOperation(value="상담 거부", notes="err_01: 해당 사업소의 상담을 찾을 수 없습니다. <br>err_02: 해당 사업소를 찾을 수 없습니다. <br>err_98: 서버 처리중 오류가 발생하였습니다. <br>err_99: 인증되지 않은 접근입니다.")
	@RequestMapping(value = "/rejectConslt.json", method = RequestMethod.POST)
	@ResponseBody
	public EroumcareApiResponseVO rejectConslt(
			@RequestParam(value = "bplcConsltNo", required=true) int bplcConsltNo
			, HttpServletRequest request
			) throws Exception {

		EroumcareApiResponseVO responseVO = new EroumcareApiResponseVO();
		responseVO.setSuccess(false);
		
		String eroumApikey = request.getHeader("eroumAPI_Key");
    	if (!eroumCarePrivateKey.equals(eroumApikey)) {
    		responseVO.setCode("err_99");
    		responseVO.setMsg("인증되지 않은 접근입니다.");
    		return responseVO;
    	}
    	
		try {
			Map<String, Object> resultMap = mbrConsltResultService.changeSttusForBplc(bplcConsltNo, "CS04");
			responseVO.setSuccess((boolean)resultMap.get("success"));
			responseVO.setCode((String)resultMap.get("code"));
    		responseVO.setMsg((String)resultMap.get("msg"));
		} catch (Exception ex) {
    		responseVO.setCode("err_98");
    		responseVO.setMsg("서버 처리중 오류가 발생하였습니다.");
    		return responseVO;
		}
		return responseVO;
	}
}
