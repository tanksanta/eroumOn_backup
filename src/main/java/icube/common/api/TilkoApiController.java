package icube.common.api;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.api.biz.TilkoApiService;
import icube.main.biz.MainService;
import icube.market.mbr.biz.MbrSession;

@Controller
@RequestMapping(value = "/common/recipter")
public class TilkoApiController {

	@Resource(name= "tilkoApiService")
	private TilkoApiService tilkoApiService;
	
	@Resource(name = "mainService")
	private MainService mainService;
	
	@Autowired
	private MbrSession mbrSession;

	@ResponseBody
	@RequestMapping(value="getRecipterInfo.json", method=RequestMethod.POST)
	public Map<String, Object> getRecipterInfo(
			@RequestParam(value="mbrNm", required=true) String mbrNm
			, @RequestParam(value="rcperRcognNo", required=true) String rcperRcognNo
			) throws Exception {

		Map<String, Object> returnMap = new HashMap<>();
		returnMap.put("isSearch", false);
		
		if (mbrSession.isLoginCheck()) {
			if (!mbrNm.equals(mbrSession.getMbrNm())) {
				returnMap.put("msg", "본인 명의만 조회가 가능합니다.");
			} else {
				//수급자 본인인 경우만 조회가능
				returnMap = tilkoApiService.getRecipterInfo(mbrSession.getMbrNm(), rcperRcognNo);
				returnMap.put("isSearch", true);
			}
		} else {
			returnMap.put("msg", "로그인 이후 이용가능합니다.");
		}

		System.out.println("returnMap: " + returnMap.toString());
		
        return returnMap;
	}


}
