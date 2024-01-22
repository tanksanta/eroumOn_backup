package icube.membership.info;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.values.CodeMap;
import icube.manage.consult.biz.MbrConsltService;
import icube.manage.consult.biz.MbrConsltVO;
import icube.manage.mbr.mbr.biz.MbrAuthService;
import icube.manage.mbr.mbr.biz.MbrAuthVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.ordr.dtl.biz.OrdrDtlService;
import icube.manage.promotion.coupon.biz.CouponLstService;
import icube.manage.promotion.mlg.biz.MbrMlgService;
import icube.manage.promotion.mlg.biz.MbrMlgVO;
import icube.manage.promotion.point.biz.MbrPointService;
import icube.manage.promotion.point.biz.MbrPointVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 마이페이지 > 회원정보 > 회원 탈퇴
 */
@Controller
@RequestMapping(value = "#{props['Globals.Membership.path']}/info/whdwl")
public class MbrsWhdwlController extends CommonAbstractController{

	@Resource(name="mbrService")
	private MbrService mbrService;
	
	@Resource(name = "mbrAuthService")
	private MbrAuthService mbrAuthService;

	@Resource(name="ordrDtlService")
	private OrdrDtlService ordrDtlService;

	@Resource(name = "mbrPointService")
	private MbrPointService mbrPointService;

	@Resource(name = "mbrMlgService")
	private MbrMlgService mbrMlgService;

	@Resource(name = "couponLstService")
	private CouponLstService couponLstService;
	
	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;

	@Value("#{props['Globals.Main.path']}")
	private String mainPath;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	@Autowired
	private MbrSession mbrSession;

	/**
	 * 회원 탈퇴
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="form")
	public String list(
			HttpServletRequest request
			, Model model
			) throws Exception{


		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchRegUniqueId", mbrSession.getUniqueId());
		paramMap.put("srchExSttsTy", "OR08");

		paramMap.put("srchOrdrOptnTy", "BASE");

		//특정 단계 제외 카운트
		int dlvyCount = ordrDtlService.selectExSttsTyCnt(paramMap);

		MbrConsltVO mbrConslt = mbrConsltService.selectConsltInProcess(mbrSession.getUniqueId());

		Map<String, Integer> resultMap = new HashMap<String, Integer>();
		paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());

		int point = 0;
		int mlg = 0;
		int coupon = 0;

		int pointCount = mbrPointService.selectMbrPointCount(paramMap);
		int mlgCount = mbrMlgService.selectMbrMlgCount(paramMap);

		// 포인트
		if(pointCount > 0) {
			MbrPointVO mbrPointVO = mbrPointService.selectMbrPoint(paramMap);
			point = mbrPointVO.getPointAcmtl();
		}

		// 마일리지
		if(mlgCount > 0) {
			MbrMlgVO mbrMlgVO = mbrMlgService.selectMbrMlg(paramMap);
			mlg = mbrMlgVO.getMlgAcmtl();
		}


		// 쿠폰
		paramMap.put("srchUseYn", "N");
		paramMap.put("srchUseCoupon", 1); // 1 의미 x
		paramMap.put("uniqueId", mbrSession.getUniqueId());
		coupon = couponLstService.selectCouponCnt(paramMap);

		resultMap.put("point", point);
		resultMap.put("mlg", mlg);
		resultMap.put("coupon", coupon);

		model.addAttribute("mbrConsltExists", (mbrConslt == null)?0:1);
		model.addAttribute("dlvyCount", dlvyCount);
		model.addAttribute("resultMap", resultMap);
		model.addAttribute("norResnCdCode", CodeMap.NOR_RESN_CD);
		model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);

		return "/membership/info/whdwl/form";
	}

	/**
	 * 회원 탈퇴 처리
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="action")
	public View action(
			HttpServletRequest request
			, HttpSession session
			, Model model
			, @RequestParam(value="resnCn", required=true) String resnCn
			, @RequestParam(value="whdwlEtc", required=false) String whdwlEtc
			, @RequestParam(value="pswd", required=false) String pswd
			)throws Exception {

		JavaScript javaScript = new JavaScript();
		
		//인증방식이 이로움 계정인 경우 패스워드 검사
		if ("E".equals(mbrSession.getLgnTy())) {
			List<MbrAuthVO> authList = mbrAuthService.selectMbrAuthByMbrUniqueId(mbrSession.getUniqueId());
			MbrAuthVO eroumAuthInfo = authList.stream().filter(f -> "E".equals(f.getJoinTy())).findAny().orElse(null);
			
			//비밀번호가 틀린 경우
			if (!BCrypt.checkpw(pswd, eroumAuthInfo.getPswd())) {
				javaScript.setMessage("비밀번호가 일치하지 않습니다.");
				javaScript.setMethod("window.history.back()");
				return new JavaScriptView(javaScript);
			}
		}
		

		//탈퇴전에 1:1 상담중인지 검사
		MbrConsltVO mbrConslt = mbrConsltService.selectConsltInProcess(mbrSession.getUniqueId());
		if (mbrConslt != null) {
			javaScript.setMessage("진행 중인 상담이 있습니다. 상담 완료 후 탈퇴해주세요.");
			javaScript.setMethod("window.history.back()");
			return new JavaScriptView(javaScript);
		}
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());
		paramMap.put("whdwlResn", resnCn);
		paramMap.put("whdwlEtc", whdwlEtc);
		paramMap.put("whdwlTy", "NORMAL");

		mbrService.updateExitMbr(paramMap);

		session.invalidate();

		javaScript.setMessage("탈퇴처리 되었습니다.");
		javaScript.setLocation("/"+mainPath);

		return new JavaScriptView(javaScript);

	}

	/**
	 * 특정 단계 제외 카운트 체크
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="exDlvySttsCnt.json")
	public Map<String, Object> dlvyCount(
			HttpServletRequest request
			, Model model
			) throws Exception{

		boolean result = false;


		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchRegUniqueId", mbrSession.getUniqueId());
		paramMap.put("srchExSttsTy", "OR08");

		paramMap.put("srchOrdrOptnTy", "BASE");

		//특정 단계 제외 카운트
		int dlvyCount = ordrDtlService.selectExSttsTyCnt(paramMap);

		if(dlvyCount < 1) {
			result = true;
		}

		//return map
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("sttsTy", paramMap.get("srchExSttsTy"));
		resultMap.put("result", result);


		return resultMap;
	}
}
