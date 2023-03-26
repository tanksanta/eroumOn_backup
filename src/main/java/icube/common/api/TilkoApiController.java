package icube.common.api;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.api.biz.TilkoApiService;

@Controller
@RequestMapping(value = "/common/recipter")
public class TilkoApiController {

	@Resource(name= "tilkoApiService")
	private TilkoApiService tilkoApiService;

	@ResponseBody
	@RequestMapping(value="getRecipterInfo.json", method=RequestMethod.POST)
	public Map<String, Object> getRecipterInfo(
			@RequestParam(value="mbrNm", required=true) String mbrNm
			, @RequestParam(value="rcperRcognNo", required=true) String rcperRcognNo
			) throws Exception {

		boolean result = false;

		Map<String, Object> returnMap = tilkoApiService.getRecipterInfo(mbrNm, rcperRcognNo);

		System.out.println("returnMap: " + returnMap.toString());

        return returnMap;
	}

}
