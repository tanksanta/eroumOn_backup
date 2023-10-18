package icube.common.api;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ibm.icu.text.SimpleDateFormat;

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
	
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm:ss"); 

	@ResponseBody
	@RequestMapping(value="getRecipterInfo.json", method=RequestMethod.POST)
	public Map<String, Object> getRecipterInfo(
			@RequestParam(value="mbrNm", required=true) String mbrNm
			, @RequestParam(value="rcperRcognNo", required=true) String rcperRcognNo
			) throws Exception {

		Map<String, Object> returnMap = new HashMap<>();
		returnMap.put("isSearch", false);
		
		if (mbrSession.isLoginCheck()) {
			returnMap = tilkoApiService.getRecipterInfo(mbrNm, rcperRcognNo);
			
			returnMap.put("refleshDate", simpleDateFormat.format(new Date()));
			returnMap.put("isSearch", true);
		} else {
			returnMap.put("msg", "로그인 이후 이용가능합니다.");
		}

		System.out.println("returnMap: " + returnMap.toString());
		
        return returnMap;
	}

	@ResponseBody
	@RequestMapping(value="getRecipterInfoInRegist.json", method=RequestMethod.POST)
	public Map<String, Object> getRecipterInfoInRegist(
			@RequestParam(value="mbrNm", required=true) String mbrNm
			, @RequestParam(value="rcperRcognNo", required=true) String rcperRcognNo
			) throws Exception {

		Map<String, Object> returnMap = new HashMap<>();
		returnMap = tilkoApiService.getRecipterInfo(mbrNm, rcperRcognNo);
		returnMap.put("isSearch", true);

		System.out.println("returnMap: " + returnMap.toString());
		
        return returnMap;
	}
}
