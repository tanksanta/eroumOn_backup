package icube.market.mbr;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CodeMap;
import icube.manage.mbr.mbr.biz.MbrPrtcrService;
import icube.manage.mbr.mbr.biz.MbrPrtcrVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.mbr.recipter.biz.RecipterInfoVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 가족회원
 * @author ogy
 *
 */
@Controller
@RequestMapping(value = "#{props['Globals.Market.path']}/fml")
public class PrtcrController extends CommonAbstractController{

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "mbrPrtcrService")
	private MbrPrtcrService mbrPrtcrService;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	@Autowired
	private MbrSession mbrSession;

	/**
	 * 가족회원 검색
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="app")
	@SuppressWarnings({"rawtypes","unchecked"})
	public String fml(
			HttpServletRequest request
			, Model model
			, @RequestParam(value="mbrId", required=false) String mbrId
			, @RequestParam(value="mblTelno", required=false) String mblTelno
			, @RequestParam(value="mbrNm", required=false) String mblNm
			, @RequestParam(value="brdt", required=false) String brdt
			, @RequestParam(value="sortBy", required=false) String sortBy
			, @RequestParam(value="returnUrl", required=false) String returnUrl
			)throws Exception {

		if(!mbrSession.isLoginCheck()) {
			return 	"redirect:/" + marketPath +"/login?returnUrl="+returnUrl;
		}

		Map paramMap = new HashMap();

		//디폴트
		if(sortBy.equals("none")) {
			paramMap.put("srchUniqueId", "NON_0000000");
		}else {
			paramMap.put("srchOwnUniqueId", mbrSession.getUniqueId());
		}

		//param
		paramMap.put("srchMbrId", mbrId);
		paramMap.put("srchMblTelno", mblTelno);
		paramMap.put("srchMbrNm", mblNm);
		paramMap.put("srchBrdt", brdt);
		paramMap.put("srchMbrSttus", "NORMAL");

		//검색 회원
		List<MbrPrtcrVO> srchList = mbrPrtcrService.selectPrtcrMbrList(paramMap);

		model.addAttribute("srchList", srchList);
		model.addAttribute("reqTyCode", CodeMap.REQ_TY);

		return "/market/mbr/fml/app";
	}

	/**
	 * 가족회원 신청 처리
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="registFml.json")
	@ResponseBody
	@SuppressWarnings({"rawtypes","unchecked"})
	public boolean registFml(
			HttpServletRequest request
			, Model model
			, @RequestParam(value="uniqueId", required=true) String uniqueId
			) throws Exception{

		boolean result = false;

		MbrPrtcrVO mbrPrtcrVO = new MbrPrtcrVO();
		mbrPrtcrVO.setUniqueId(mbrSession.getUniqueId());
		mbrPrtcrVO.setPrtcrUniqueId(uniqueId);
		mbrPrtcrVO.setReqTy("P");

		Map paramMap = new HashMap();
		paramMap.put("srchMyUniqueId", mbrSession.getUniqueId());
		paramMap.put("srchReqTy", "C");

		int fmlCount = mbrPrtcrService.selectPrtcrCount(paramMap);

		if(fmlCount < 4) {
			mbrPrtcrService.insertPrtcr(mbrPrtcrVO);
			result = true;
		}

		return result;
	}


	/**
	 * 가족회원 신청 완료
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="appCnfm")
	public String fmlCnfm(
			HttpServletRequest request
			, Model model
			, @RequestParam (value="mbrId", required=true) String mbrId
			)throws Exception {

		MbrVO mbrVO = mbrService.selectMbrById(mbrId);

		model.addAttribute("mbrVO", mbrVO);

		return "/market/mbr/fml/app_cnfm";
	}



	// 가족회원(수급자) 변경
	@ResponseBody
	@RequestMapping(value="setPrtcr.json")
	public Map<String, Object> setPrtcr(
			@RequestParam(value="uniqueId", required=true) String uniqueId
			, @RequestParam(value="index", required=true) int index
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session) throws Exception {
		boolean result = false;

		MbrVO prtcrMbrVO = mbrService.selectMbrByUniqueId(uniqueId);
		if(prtcrMbrVO != null) {
			if("Y".equals(prtcrMbrVO.getRecipterYn())){
				mbrSession.setPrtcrRecipter(prtcrMbrVO.getRecipterInfo(), prtcrMbrVO.getRecipterYn(), index);
			}else {
				RecipterInfoVO recipterInfoVO = new RecipterInfoVO();
				recipterInfoVO.setUniqueId(prtcrMbrVO.getUniqueId());
				recipterInfoVO.setMbrId(prtcrMbrVO.getMbrId());
				recipterInfoVO.setMbrNm(prtcrMbrVO.getMbrNm());
				recipterInfoVO.setProflImg(prtcrMbrVO.getProflImg());
				recipterInfoVO.setMberSttus(prtcrMbrVO.getMberSttus());
				recipterInfoVO.setMberGrade(prtcrMbrVO.getMberGrade());
				mbrSession.setPrtcrRecipter(recipterInfoVO, prtcrMbrVO.getRecipterYn(), index);
			}
			mbrSession.setMbrInfo(session, mbrSession);

			result = true;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}
}
