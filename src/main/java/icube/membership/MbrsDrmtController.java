package icube.membership;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.api.biz.BootpayApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.DateUtil;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 휴면 계정
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="#{props['Globals.Membership.path']}/drmt")
@SuppressWarnings({"rawtypes","unchecked"})
public class MbrsDrmtController extends CommonAbstractController {

	@Resource(name="mbrService")
	private MbrService mbrService;

	@Resource(name = "bootpayApiService")
	private BootpayApiService bootpayApiService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Membership.path']}")
	private String membershipPath;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	@Value("#{props['Globals.Planner.path']}")
	private String plannerPath;


	/**
	 * 휴면계정 확인
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="view")
	public String view(
			@RequestParam(value="mbrId", required=true) String mbrId
			, HttpServletRequest request
			, Model model
			)throws Exception {

		/*if(mbrSession.isLoginCheck()) {
			return "redirect:" + "/"+plannerPath;
		}*/

		MbrVO mbrVO = mbrService.selectMbrIdByOne(mbrId);

		if(!mbrVO.getMberSttus().equals("HUMAN")) {
			return "redirect:" + "/"+plannerPath;
		}

		model.addAttribute("mbrVO", mbrVO);

		return "/membership/drmt/view";
	}

	/**
	 * 휴면 계정 해제 확인
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="clear")
	public String clear(
			@RequestParam(value="mbrNm", required=false) String mbrNm
			, @RequestParam(value="mblTelno", required=false) String mblTelno
			, @RequestParam(value="gender", required=false) String gender
			, @RequestParam(value="brdt", required=false) String brdt
			, @RequestParam(value="receiptId", required=false) String receiptId
			, @RequestParam(value="mbrId", required=false) String mbrId
			, HttpServletRequest request
			, Model model
			)throws Exception {

		if(mbrSession.isLoginCheck()) {
			return "redirect:" + "/"+plannerPath;
		}

		MbrVO mbrVO = mbrService.selectMbrIdByOne(mbrId);
		
		if(!mbrVO.getJoinTy().equals("E")) {
	    	Map newMap = new HashMap();
	    	newMap.put("srchUniqueId", mbrVO.getUniqueId());
	    	newMap.put("mdfcnId", mbrVO.getMbrId());
	    	newMap.put("mdfr", mbrVO.getMbrNm());
	    	newMap.put("mberSttus", "NORMAL");
			mbrService.updateRlsDrmt(newMap);
		}else {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

			MbrVO noMbrVO = new MbrVO();
			if(EgovStringUtil.isNotEmpty(mbrNm) && EgovStringUtil.isNotEmpty(mblTelno)) {

		        Date sBrdt = formatter.parse(DateUtil.convertDate(brdt, "yyyy-MM-dd"));

				noMbrVO.setMbrNm(mbrNm);
				noMbrVO.setMblTelno(mblTelno);
				noMbrVO.setGender(gender);
				noMbrVO.setBrdt(sBrdt);

			}else if(EgovStringUtil.isNotEmpty(receiptId)) {
				// 본인인증정보 체크
				HashMap<String, Object> res = bootpayApiService.certificate(receiptId);

				String authData =String.valueOf(res.get("authenticate_data"));
				String[] spAuthData = authData.substring(1, authData.length()-1).split(",");

				HashMap<String, String> authMap = new HashMap<String, String>();
				for(String auth : spAuthData) {
					System.out.println("spAuthData: " + auth.trim());
					String[] spTmp = auth.trim().split("=", 2);
					authMap.put(spTmp[0], spTmp[1]); //key:value
				}
				/*
				 !참고:부트페이 제공문서와 결과 값이 다름
				      결과값에 json 문자열 처리가 정확하지 않아 타입변환이 안됨

				 */
		        Date sBrdt = formatter.parse(DateUtil.formatDate(authMap.get("birth"), "yyyy-MM-dd")); //생년월일
		        mblTelno = authMap.get("phone");
		        gender = authMap.get("gender"); //1.0 > 부트페이 제공문서와 다름
		        if(EgovStringUtil.equals("1.0", gender)) {
		        	gender = "M";
		        }else {
		        	gender = "W";
		        }

		        noMbrVO.setDiKey(authMap.get("di"));
		        noMbrVO.setMbrNm(authMap.get("name"));
		        noMbrVO.setMblTelno(mblTelno.substring(0, 3) + "-" + mblTelno.substring(3, 7) +"-"+ mblTelno.substring(7, 11));
		        noMbrVO.setGender(gender);
		        noMbrVO.setBrdt(sBrdt);

		        System.out.println("noMbrVO: " + noMbrVO.toString());

		    	Map newMap = new HashMap();
		    	newMap.put("srchUniqueId", mbrVO.getUniqueId());
		    	newMap.put("mdfcnId", mbrVO.getMbrId());
		    	newMap.put("mdfr", mbrVO.getMbrNm());
		    	newMap.put("mberSttus", "NORMAL");
				mbrService.updateRlsDrmt(newMap);

				mbrSession.setLoginCheck(false);
			}else {
				model.addAttribute("alertMsg", "잘못된 방법으로 접근하였습니다.");
				return "/common/msg";
			}
		}

		model.addAttribute("mbrVO", mbrVO);

		return "/membership/drmt/clear";
	}
}
