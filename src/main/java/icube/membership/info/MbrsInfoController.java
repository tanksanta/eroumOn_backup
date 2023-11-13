
package icube.membership.info;

import java.security.PrivateKey;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import icube.common.api.biz.BiztalkApiService;
import icube.common.api.biz.BootpayApiService;
import icube.common.api.biz.TilkoApiService;
import icube.common.file.biz.FileService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.RSA;
import icube.common.util.WebUtil;
import icube.common.values.CodeMap;
import icube.manage.consult.biz.MbrConsltChgHistVO;
import icube.manage.consult.biz.MbrConsltService;
import icube.manage.consult.biz.MbrConsltVO;
import icube.manage.mbr.itrst.biz.CartService;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.mbr.recipients.biz.MbrRecipientsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 마이페이지 > 회원정보 > 회원정보 수정
 */
@Controller
@RequestMapping(value = "#{props['Globals.Membership.path']}/info/myinfo")
public class MbrsInfoController extends CommonAbstractController{

	@Resource(name="mbrService")
	private MbrService mbrService;

	@Resource(name="fileService")
	private FileService fileService;

	@Resource(name = "bootpayApiService")
	private BootpayApiService bootpayApiService;

	@Resource(name = "cartService")
	private CartService cartService;
	
	@Resource(name= "mbrRecipientsService")
	private MbrRecipientsService mbrRecipientsService;
	
	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;
	
	@Resource(name= "tilkoApiService")
	private TilkoApiService tilkoApiService;

	@Value("#{props['Globals.Membership.path']}")
	private String membershipPath;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	@Value("#{props['Globals.Main.path']}")
	private String mainPath;

	@Value("#{props['Globals.Nonmember.session.key']}")
	private String NONMEMBER_SESSION_KEY;

	@Value("#{props['Globals.Server.Dir']}")
	private String serverDir;

	@Value("#{props['Globals.File.Upload.Dir']}")
	private String fileUploadDir;

	@Resource(name = "biztalkApiService")
	private BiztalkApiService biztalkApiService;
	
	@Autowired
	private MbrSession mbrSession;

	private static final String RSA_MEMBERSHIP_KEY = "__rsaMembersKey__";



	/**
	 * 비밀번호 확인
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="confirm")
	public String list(
			HttpServletRequest request
			, HttpSession session
			, Model model
			, @RequestParam(value = "returnUrl", required=false) String returnUrl
			)throws Exception {

		if(!mbrSession.isLoginCheck()) {
			return "redirect:/"+ mainPath;
		}

		/*
		if(!mbrSession.getJoinTy().equals("E")) {
			session.setAttribute("infoStepChk", "EASYLOGIN");
			session.setMaxInactiveInterval(60*60);

			if(EgovStringUtil.isNotEmpty(returnUrl)) {
				return "redirect:/"+ membershipPath + "/info/myinfo/form?returnUrl=" + returnUrl;
			}else {
				return "redirect:/"+ membershipPath + "/info/myinfo/form";
			}

		}*/

		//암호화
		RSA rsa = RSA.getEncKey();
		request.setAttribute("publicKeyModulus", rsa.getPublicKeyModulus());
		request.setAttribute("publicKeyExponent", rsa.getPublicKeyExponent());
		session.setAttribute(RSA_MEMBERSHIP_KEY, rsa.getPrivateKey());

		return "/membership/info/myinfo/confirm";
	}

	/**
	 * 비밀번호 확인
	 * @param request
	 * @param session
	 * @param model
	 * @param pswd
	 * @return
	 */
	@RequestMapping(value="action")
	@SuppressWarnings({"rawtypes","unchecked"})
	public View action(
			HttpServletRequest request
			, HttpSession session
			, Model model
			, @RequestParam(value="encPw", required=true) String encPw
			, @RequestParam(value="returnUrl", required=false) String returnUrl
			) throws Exception {

		JavaScript javaScript = new JavaScript();
		String loginPswd="";

		Map paramMap = new HashMap();
		paramMap.put("srchUniqueId",mbrSession.getUniqueId());

		MbrVO mbrVO = mbrService.selectMbr(paramMap);

		if(EgovStringUtil.isNotEmpty(encPw)) {
			loginPswd = RSA.decryptRsa((PrivateKey) request.getSession().getAttribute(RSA_MEMBERSHIP_KEY), encPw); //암호화된 비밀번호를 복호화한다.
		}

		if(mbrVO != null) {
			if(BCrypt.checkpw(loginPswd, mbrVO.getPswd())) {
				session.setAttribute("infoStepChk", encPw);
				session.setMaxInactiveInterval(60*60);

				if(EgovStringUtil.isNotEmpty(returnUrl)) {
					javaScript.setLocation("/"+ membershipPath + "/info/myinfo/form?returnUrl="+ returnUrl);
				}else {
					javaScript.setLocation("/"+ membershipPath + "/info/myinfo/form");
				}
			}else {
				javaScript.setMessage("비밀번호가 일치하지 않습니다.");
				javaScript.setMethod("window.history.back()");
			}
		}

		return new JavaScriptView(javaScript);
	}

	/**
	 * 정보 변경
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="form")
	public String form(
			HttpServletRequest request
			, HttpSession session
			, Model model
			, MbrVO mbrVO
			)throws Exception {

		if(session.getAttribute("infoStepChk") == null) {
			return "redirect:/"+ membershipPath +"/info/myinfo/confirm";
		}

		mbrVO = mbrService.selectMbrByUniqueId(mbrSession.getUniqueId());
		List<MbrRecipientsVO> mbrRecipientList = mbrRecipientsService.selectMbrRecipientsByMbrUniqueId(mbrSession.getUniqueId());

		model.addAttribute("genderCode", CodeMap.GENDER);
		model.addAttribute("expirationCode", CodeMap.EXPIRATION);
		model.addAttribute("recipterYnCode", CodeMap.RECIPTER_YN);
		model.addAttribute("itrstCode", CodeMap.ITRST_FIELD);
		model.addAttribute("mbrVO", mbrVO);
		model.addAttribute("mbrRecipientList", mbrRecipientList);

		return "/membership/info/myinfo/info";
	}

	/**
	 * 정보 변경 처리
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="infoAction")
	public View infoAction(
			HttpServletRequest request
			, Model model
			, MbrVO mbrVO
			, HttpSession session
			, @RequestParam (value="returnUrl", required=false) String returnUrl
			) throws Exception {

		JavaScript javaScript = new JavaScript();

		try {
			// 회원정보 수정
			MbrVO srchMbr = mbrService.selectMbrByUniqueId(mbrSession.getUniqueId());
			srchMbr.setMblTelno(mbrVO.getMblTelno());
			srchMbr.setEml(mbrVO.getEml());
			srchMbr.setZip(mbrVO.getZip());
			srchMbr.setAddr(mbrVO.getAddr());
			srchMbr.setDaddr(mbrVO.getDaddr());
			
			srchMbr.setSmsRcptnYn(mbrVO.getSmsRcptnYn());
			srchMbr.setSmsRcptnDt(mbrVO.getSmsRcptnDt());
			srchMbr.setEmlRcptnYn(mbrVO.getEmlRcptnYn());
			srchMbr.setEmlRcptnDt(mbrVO.getEmlRcptnDt());
			srchMbr.setTelRecptnYn(mbrVO.getTelRecptnYn());
			srchMbr.setTelRecptnDt(mbrVO.getTelRecptnDt());
			srchMbr.setPrvcVldPd(mbrVO.getPrvcVldPd());
			mbrService.updateMbrInfo(srchMbr);
			
			mbrSession.setParms(srchMbr, true);
			mbrSession.setMbrInfo(session, mbrSession);

			javaScript.setMessage(getMsg("action.complete.update"));
			if(EgovStringUtil.isNotEmpty(returnUrl)) {
				javaScript.setLocation(returnUrl);
			}else {
				javaScript.setLocation("/"+ mainPath + "/index");
			}
		}catch(Exception e) {
			log.debug("MYPAGE UPDATE INFO ERROR");
			e.printStackTrace();
		}

		return new JavaScriptView(javaScript);
	}

	/**
	 * 비밀번호 변경
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="pswd")
	public String pswd(
			HttpServletRequest request
			, HttpSession session
			, Model model
			, MbrVO mbrVO
			)throws Exception {

		// 간편 회원 체크
		if(!mbrSession.getJoinTy().equals("E")) {
			model.addAttribute("alertMsg", "간편가입 회원은 비밀번호 변경을 이용하실 수 없습니다.");
			return "/common/msg";
		}

		if(session.getAttribute("infoStepChk") == null) {
			return "redirect:/"+ membershipPath +"/info/myinfo/confirm";
		}

		return "/membership/info/myinfo/pw";
	}

	/**
	 * 비밀번호 변경 처리
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="pwdAction")
	public View pwdAction(
			HttpServletRequest request
			, @RequestParam(value="returnUrl", required=false) String returnUrl
			, Model model
			, MbrVO mbrVO
			) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pwd ="";

		String pswd = mbrVO.getPswd();

		try {
			if(EgovStringUtil.isNotEmpty(pswd)) {
				pwd = WebUtil.clearSqlInjection(pswd);
			}

			//비밀번호 암호화
			String encPswd = BCrypt.hashpw(pwd, BCrypt.gensalt());
			mbrVO.setPswd(encPswd);

			mbrService.updateMbrPswd(mbrVO);

			javaScript.setMessage(getMsg("action.complete.newPswd"));

			if(EgovStringUtil.isNotEmpty(returnUrl)) {
				javaScript.setLocation(returnUrl);
			}else {
				javaScript.setLocation("/" + mainPath + "/index");
			}
		}catch(Exception e) {
			e.printStackTrace();
			log.debug("MYPAGE PASSWORD CHANGE ERROR");
		}


		return new JavaScriptView(javaScript);
	}

	/**
	 * 본인인증 조회
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "getMbrTelno.json")
	public Map<String, Object> getMbrTelno (
		@RequestParam(value="receiptId", required=true) String receiptId
		, @RequestParam Map<String, Object> reqMap
		, HttpServletRequest request
		)throws Exception {

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

		Map <String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("mblTelno", authMap.get("phone"));
		resultMap.put("diKey", authMap.get("di"));
		return resultMap;
	}
	
	/**
	 * 로그인 여부 및 수급자 정보 조회 ajax
	 */
	@ResponseBody
	@RequestMapping(value = "getMbrInfo.json")
	public Map<String, Object> getMbrInfo(
		) throws Exception {
		
		Map <String, Object> resultMap = new HashMap<String, Object>();
		
		if(!mbrSession.isLoginCheck()) {
			resultMap.put("isLogin", false);
			return resultMap;
		}
	
		MbrVO mbrVO = mbrService.selectMbrByUniqueId(mbrSession.getUniqueId());
		resultMap.put("mbrVO", mbrVO);
		resultMap.put("mbrRecipients", mbrVO.getMbrRecipientsList());
		
		resultMap.put("isLogin", true);
		return resultMap;
	}
	
	/**
	 * 수급자의 진행중인 상담 체크 ajax
	 */
	@ResponseBody
	@RequestMapping(value = "getRecipientConsltSttus.json")
	public Map<String, Object> getRecipientConsltSttus(
	    Integer recipientsNo,
	    String prevPath        //상담 유형 검사
		) throws Exception {
		
		Map <String, Object> resultMap = new HashMap<String, Object>();
		
		if(!mbrSession.isLoginCheck()) {
			resultMap.put("isLogin", false);
			return resultMap;
		}
		
		//내 수급자 정보 체크가 아니면 그냥 리턴
		List<MbrRecipientsVO> mbrRecipients = mbrRecipientsService.selectMbrRecipientsByMbrUniqueId(mbrSession.getUniqueId());
		MbrRecipientsVO srchRecipient = mbrRecipients.stream().filter(f -> f.getMbrUniqueId().equals(mbrSession.getUniqueId())).findAny().orElse(null);
		if (srchRecipient == null) {
			return resultMap;
		}
		
		
		//수급자 최근 상담 조회(진행 중인 상담 체크)
		MbrConsltVO recipientConslt = mbrConsltService.selectRecentConsltByRecipientsNo(recipientsNo, prevPath);
		if (recipientConslt != null && (
				!"CS03".equals(recipientConslt.getConsltSttus()) &&
				!"CS04".equals(recipientConslt.getConsltSttus()) &&
				!"CS09".equals(recipientConslt.getConsltSttus()) &&
				!"CS06".equals(recipientConslt.getConsltSttus())
				)) {
			resultMap.put("isExistRecipientConslt", true);
		} else {
			resultMap.put("isExistRecipientConslt", false);
		}
		
		resultMap.put("isLogin", true);
		return resultMap;
	}
	
	/**
	 * 기존 진행하는 수급자의 상담 종료 ajax
	 */
	@ResponseBody
	@RequestMapping(value = "cancelRecipientConslt.json")
	public Map<String, Object> cancelRecipientConslt(
	    Integer recipientsNo,
	    String prevPath
		) throws Exception {
		
		Map <String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", false);
		
		
		//내 수급자 정보 체크가 아니면 그냥 리턴
		List<MbrRecipientsVO> mbrRecipients = mbrRecipientsService.selectMbrRecipientsByMbrUniqueId(mbrSession.getUniqueId());
		MbrRecipientsVO srchRecipient = mbrRecipients.stream().filter(f -> f.getMbrUniqueId().equals(mbrSession.getUniqueId())).findAny().orElse(null);
		if (srchRecipient == null) {
			resultMap.put("success", false);
			resultMap.put("msg", "존재하지 않는 수급자입니다.");
			return resultMap;
		}
		
		
		//수급자 최근 상담 조회(진행 중인 상담 체크)
		MbrConsltVO recipientConslt = mbrConsltService.selectRecentConsltByRecipientsNo(recipientsNo, prevPath);
		if (recipientConslt != null && (
				!"CS03".equals(recipientConslt.getConsltSttus()) &&
				!"CS04".equals(recipientConslt.getConsltSttus()) &&
				!"CS09".equals(recipientConslt.getConsltSttus()) &&
				!"CS06".equals(recipientConslt.getConsltSttus())
				)) {
		} else {
			resultMap.put("success", false);
			resultMap.put("msg", "진행중인 상담이 존재하지 않습니다.");
			return resultMap;
		}
		
		//상담 취소 처리
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("consltSttus", "CS03"); //상담자 취소
		paramMap.put("canclResn", "새롭게 진행하기로 인한 취소");
		paramMap.put("consltNo", recipientConslt.getConsltNo());

		int resultCnt = mbrConsltService.updateCanclConslt(paramMap);

		if(resultCnt > 0) {
			//1:1 상담 취소 이력 추가(접수, 재접수일 때만 취소가 되므로 사업소 상담 정보는 없음)
			MbrConsltChgHistVO mbrConsltChgHistVO = new MbrConsltChgHistVO();
			mbrConsltChgHistVO.setConsltNo(recipientConslt.getConsltNo());
			mbrConsltChgHistVO.setConsltSttusChg("CS03");
			mbrConsltChgHistVO.setResn(CodeMap.CONSLT_STTUS_CHG_RESN.get("상담자 취소"));
			mbrConsltChgHistVO.setMbrUniqueId(mbrSession.getUniqueId());
			mbrConsltChgHistVO.setMbrId(mbrSession.getMbrId());
			mbrConsltChgHistVO.setMbrNm(mbrSession.getMbrNm());
			mbrConsltService.insertMbrConsltChgHist(mbrConsltChgHistVO);
			
			MbrConsltVO mbrConslt = mbrConsltService.selectMbrConsltByConsltNo(recipientConslt.getConsltNo());

			MbrVO mbrVO = mbrService.selectMbrByUniqueId(mbrConslt.getRegUniqueId());
			MbrRecipientsVO mbrRecipientsVO = mbrRecipientsService.selectMbrRecipientsByRecipientsNo(mbrConslt.getRecipientsNo());
			//사용자 상담취소
			biztalkApiService.sendOnTalkCancel(mbrVO, mbrRecipientsVO);
		} else {
			resultMap.put("success", false);
			resultMap.put("msg", "진행중인 상담이 존재하지 않습니다.");
			return resultMap;
		}
		
		resultMap.put("success", true);
		return resultMap;
	}
	
	
	/**
	 * 장기요양테스트, 간편조회 이전 수급자 추가 ajax
	 */
	@ResponseBody
	@RequestMapping(value = "addMbrRecipient.json")
	public Map<String, Object> addMbrRecipient(
        @RequestParam String relationCd,
        @RequestParam String recipientsNm,
        @RequestParam(required = false) String rcperRcognNo,
        @RequestParam(required = false) String tel,
        @RequestParam(required = false) String sido,
        @RequestParam(required = false) String sigugun,
        @RequestParam(required = false) String dong,
        @RequestParam(required = false) String brdt,
        @RequestParam(required = false) String gender,
		HttpServletRequest request) throws Exception {
		
		Map <String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			//수급자 회원 등록 최대수 확인(최대 4명)
			List<MbrRecipientsVO> srchMbrRecipientList = mbrRecipientsService.selectMbrRecipientsByMbrUniqueId(mbrSession.getUniqueId());
			if (srchMbrRecipientList.size() > 3) {
				resultMap.put("success", false);
				resultMap.put("msg", "더 이상 수급자(어르신)를 등록할 수 없습니다");
				return resultMap;
			}
			
			//동일한 수급자 이름 등록 체크
			if (srchMbrRecipientList.stream().filter(f -> recipientsNm.equals(f.getRecipientsNm())).count() > 0) {
				resultMap.put("success", false);
				resultMap.put("msg", "이미 등록한 수급자입니다");
				return resultMap;
			}
			
			//요양인정번호를 입력한 경우 조회 가능한지 유효성 체크
			if (EgovStringUtil.isNotEmpty(rcperRcognNo)) {
				Map<String, Object> returnMap = tilkoApiService.getRecipterInfo(recipientsNm, rcperRcognNo);
				
				Boolean result = (Boolean) returnMap.get("result");
				if (result == false) {
					resultMap.put("success", false);
					resultMap.put("msg", "수급자 정보를 다시 확인해주세요");
					return resultMap;
				}
			}
			
			
			
			//회원의 수급자 정보 등록
			MbrRecipientsVO mbrRecipient = new MbrRecipientsVO();
			mbrRecipient.setMbrUniqueId(mbrSession.getUniqueId());
			mbrRecipient.setRelationCd(relationCd);
			mbrRecipient.setRecipientsNm(recipientsNm);
			if (EgovStringUtil.isNotEmpty(rcperRcognNo)) {
				mbrRecipient.setRcperRcognNo(rcperRcognNo);
				mbrRecipient.setRecipientsYn("Y");
			} else {
				mbrRecipient.setRecipientsYn("N");
			}
			mbrRecipient.setTel(tel);
			mbrRecipient.setSido(sido);
			mbrRecipient.setSigugun(sigugun);
			mbrRecipient.setDong(dong);
			if(EgovStringUtil.isNotEmpty(brdt)) {
				mbrRecipient.setBrdt(brdt.replace("/", ""));
			}
			mbrRecipient.setGender(gender);
			
			mbrRecipientsService.insertMbrRecipients(mbrRecipient);
			
			//등록된 수급전 번호 가져오기
			List<MbrRecipientsVO> mbrRecipientList = mbrRecipientsService.selectMbrRecipientsByMbrUniqueId(mbrSession.getUniqueId());
			int createdRecipientsNo = mbrRecipientList.get(0).getRecipientsNo();
			
			resultMap.put("success", true);
			resultMap.put("createdRecipientsNo", createdRecipientsNo);
		} catch (Exception ex) {
			resultMap.put("success", false);
			resultMap.put("msg", "수급자 등록 중 오류가 발생하였습니다");
		}
		
		return resultMap;
	}
	
	/**
	 * 수급자 수정 ajax
	 */
	@ResponseBody
	@RequestMapping(value = "updateMbrRecipient.json")
	public Map<String, Object> updateMbrRecipient(
		@RequestParam int recipientsNo,
        @RequestParam String relationCd,
        @RequestParam String recipientsNm,
        @RequestParam(required = false) String rcperRcognNo,
        @RequestParam(required = false) String tel,
        @RequestParam(required = false) String sido,
        @RequestParam(required = false) String sigugun,
        @RequestParam(required = false) String dong,
        @RequestParam(required = false) String brdt,
        @RequestParam(required = false) String gender,
		HttpServletRequest request) throws Exception {
		
		Map <String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<MbrRecipientsVO> mbrRecipientList = mbrRecipientsService.selectMbrRecipientsByMbrUniqueId(mbrSession.getUniqueId());
			MbrRecipientsVO mbrRecipient = mbrRecipientList.stream().filter(f -> f.getRecipientsNo() == recipientsNo).findAny().orElse(null);
			
			//동일한 수급자 이름 등록 체크
			if (mbrRecipientList.stream().filter(f -> recipientsNm.equals(f.getRecipientsNm()) && f.getRecipientsNo() != mbrRecipient.getRecipientsNo()).count() > 0) {
				resultMap.put("success", false);
				resultMap.put("msg", "이미 등록한 다른 수급자성명으로 변경할 수 없습니다");
				return resultMap;
			}
			
			//기존에 요양인정번호가 없었고 요양인정번호를 입력한 경우 조회 가능한지 유효성 체크
			if ("N".equals(mbrRecipient.getRecipientsYn()) && EgovStringUtil.isNotEmpty(rcperRcognNo)) {
				Map<String, Object> returnMap = tilkoApiService.getRecipterInfo(recipientsNm, rcperRcognNo);
				
				Boolean result = (Boolean) returnMap.get("result");
				if (result == false) {
					returnMap.put("success", false);
					resultMap.put("msg", "수급자 정보를 다시 확인해주세요");
					return resultMap;
				}
			}
			
			//회원의 수급자 정보 수정
			mbrRecipient.setRelationCd(relationCd);
			mbrRecipient.setRecipientsNm(recipientsNm);
			if (EgovStringUtil.isNotEmpty(rcperRcognNo)) {
				mbrRecipient.setRcperRcognNo(rcperRcognNo);
				mbrRecipient.setRecipientsYn("Y");
			} else {
				mbrRecipient.setRecipientsYn("N");
			}
			mbrRecipient.setTel(tel);
			mbrRecipient.setSido(sido);
			mbrRecipient.setSigugun(sigugun);
			mbrRecipient.setDong(dong);
			if(EgovStringUtil.isNotEmpty(brdt)) {
				mbrRecipient.setBrdt(brdt.replace("/", ""));
			}
			mbrRecipient.setGender(gender);
			
			mbrRecipientsService.updateMbrRecipients(mbrRecipient);
			
			resultMap.put("success", true);
		} catch (Exception ex) {
			resultMap.put("success", false);
			resultMap.put("msg", "수급자 수정 중 오류가 발생하였습니다");
		}
		
		return resultMap;
	}
	
	/**
	 * 수급자 삭제 ajax
	 */
	@ResponseBody
	@RequestMapping(value = "removeMbrRecipient.json")
	public Map<String, Object> removeMbrRecipient(
		@RequestParam int recipientsNo) throws Exception {
		
		Map <String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			//삭제전에 1:1 상담중인지 검사
			MbrConsltVO mbrConslt = mbrConsltService.selectRecentConsltByRecipientsNo(recipientsNo);
			if (mbrConslt != null && 
					("CS01".equals(mbrConslt.getConsltSttus()) ||
					"CS02".equals(mbrConslt.getConsltSttus()) ||
					"CS05".equals(mbrConslt.getConsltSttus()) ||
					"CS07".equals(mbrConslt.getConsltSttus()) ||
					"CS08".equals(mbrConslt.getConsltSttus()))) {
				resultMap.put("success", false);
				resultMap.put("msg", "진행중인 상담이 있습니다");
				return resultMap;
			}
			
			List<MbrRecipientsVO> mbrRecipientList = mbrRecipientsService.selectMbrRecipientsByMbrUniqueId(mbrSession.getUniqueId());
			MbrRecipientsVO mbrRecipient = mbrRecipientList.stream().filter(f -> f.getRecipientsNo() == recipientsNo).findAny().orElse(null);
			
			//삭제처리
			mbrRecipient.setDelDt(new Date());
			mbrRecipient.setDelYn("Y");
			mbrRecipient.setDelMbrUniqueId(mbrSession.getUniqueId());
			
			mbrRecipientsService.updateMbrRecipients(mbrRecipient);
			
			resultMap.put("success", true);
		} catch (Exception ex) {
			resultMap.put("success", false);
			resultMap.put("msg", "수급자 삭제 중 오류가 발생하였습니다");
		}
		
		return resultMap;
	}
}
