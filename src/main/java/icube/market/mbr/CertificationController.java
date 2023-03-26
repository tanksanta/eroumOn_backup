package icube.market.mbr;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
 * 나이스 본인인증에서 변경 > 사용x
 */

//@Controller
@RequestMapping(value = "/common/certification")
public class CertificationController extends CommonAbstractController {

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name= "bootpayApiService")
	private BootpayApiService bootpayApiService;

	@Value("#{props['Globals.Nonmember.session.key']}")
	private String NONMEMBER_SESSION_KEY;

	@Autowired
	private MbrSession mbrSession;

	@RequestMapping("danal")
	public String niceIdStart(
			HttpSession session
			, @RequestParam(required = false) String rtnTy
			, @RequestParam(required = false) String findId
			, Model model
			, HttpServletRequest request) throws Exception {

		session.setAttribute("rtnTy", rtnTy);
		session.setAttribute("findId", findId);

		model.addAttribute("rtnTy", rtnTy);
		model.addAttribute("findId", findId);

		return "/market/mbr/certification/popup/start_mobile";
	}

	/* callback */
	@RequestMapping(value = "callback")
	public String niceIdCallback(
			@RequestParam(required = true) String receiptId // 필수
			, Model model
			, HttpServletRequest request
			, HttpSession session
			) throws Exception {


		String rtnTy  = (String) session.getAttribute("rtnTy");
		String findId  = (String) session.getAttribute("findId");

		MbrVO mbrVO = new MbrVO();
		HashMap<String, Object> res = bootpayApiService.certificate(receiptId);
		if(res.get("error_code") == null) { //success
            System.out.println("certificate success: " + res);

            HashMap<String, Object> authInfo = (HashMap<String, Object>) res.get("authenticate_data");
            String ciKey = (String) authInfo.get("unique");
            String sName = (String) authInfo.get("name");
            String sBirth = (String) authInfo.get("birth");
            String sGender = (String) authInfo.get("gender");
            String sPhone = (String) authInfo.get("phone");

            //생년월일
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date brdt = formatter.parse(DateUtil.convertDate(sBirth, "yyyy-MM-dd"));

            //휴대전화
            String mblTelno = sPhone.substring(0, 3) +"-"+ sPhone.substring(3, 7) +"-"+ sPhone.substring(7);

			mbrVO.setUniqueId(ciKey);
			mbrVO.setMbrNm(sName);
			mbrVO.setMblTelno(mblTelno);
			mbrVO.setGender(sGender.equals(0)?"W":"M");
			mbrVO.setBrdt(brdt);

			// 인증정보만 가지고 있음
			mbrSession.setParms(mbrVO, false);
	        session.setAttribute(NONMEMBER_SESSION_KEY, mbrSession);
			session.setMaxInactiveInterval(60*60);
        } else {
            System.out.println("certificate false: " + res);
        }

		System.out.println("CERT mbrVO.toString():::: " + mbrVO.toString());

		MbrVO findMbrVO = new MbrVO();

		if(EgovStringUtil.equals("findPwd", rtnTy)) { //비밀번호 찾기
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("srchMbrId", findId);
			paramMap.put("srchMbrNm", mbrVO.getMbrNm());
			paramMap.put("srchMblTelno", mbrVO.getMblTelno());
			findMbrVO = mbrService.selectMbr(paramMap);
		}

		model.addAttribute("mbrVO", mbrVO);
		model.addAttribute("findMbrVO", findMbrVO);
		model.addAttribute("rtnTy", rtnTy);

		return "/market/mbr/certification/popup/callback_mobile";
	}
}
