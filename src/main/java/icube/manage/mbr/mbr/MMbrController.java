package icube.manage.mbr.mbr;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.util.HtmlUtils;

import icube.common.file.biz.FileService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.mail.MailService;
import icube.common.util.CommonUtil;
import icube.common.util.DateUtil;
import icube.common.util.ExcelExporter;
import icube.common.util.FileUtil;
import icube.common.util.HtmlUtil;
import icube.common.util.RandomUtil;
import icube.common.util.StringUtil;
import icube.common.util.ValidatorUtil;
import icube.common.util.WebUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.consult.biz.GdsQaService;
import icube.manage.consult.biz.GdsQaVO;
import icube.manage.consult.biz.GdsReviewService;
import icube.manage.consult.biz.GdsReviewVO;
import icube.manage.consult.biz.MbrInqryService;
import icube.manage.consult.biz.MbrInqryVO;
import icube.manage.mbr.itrst.biz.CartService;
import icube.manage.mbr.itrst.biz.CartVO;
import icube.manage.mbr.itrst.biz.WishService;
import icube.manage.mbr.itrst.biz.WishVO;
import icube.manage.mbr.mbr.biz.MbrAgreementVO;
import icube.manage.mbr.mbr.biz.MbrAuthService;
import icube.manage.mbr.mbr.biz.MbrAuthVO;
import icube.manage.mbr.mbr.biz.MbrMngInfoService;
import icube.manage.mbr.mbr.biz.MbrMngInfoVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;
import icube.manage.ordr.ordr.biz.OrdrService;
import icube.manage.promotion.coupon.biz.CouponLstService;
import icube.manage.promotion.event.biz.EventApplcnService;
import icube.manage.promotion.mlg.biz.MbrMlgService;
import icube.manage.promotion.point.biz.MbrPointService;
import icube.manage.sysmng.mngr.biz.MngrLogService;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Controller
@RequestMapping(value="/_mng/mbr")
@SuppressWarnings({"rawtypes","unchecked"})
public class MMbrController extends CommonAbstractController {

    @Resource(name = "mbrService")
    private MbrService mbrService;
    
    @Resource(name = "mbrAuthService")
	private MbrAuthService mbrAuthService;

    @Resource(name = "ordrService")
    private OrdrService ordrService;

    @Resource(name = "mbrInqryService")
    private MbrInqryService inqryService;

    @Resource(name = "fileService")
    private FileService fileService;

    @Resource(name = "mbrMngInfoService")
    private MbrMngInfoService mbrMngInfoService;

    @Resource(name = "couponLstService")
    private CouponLstService couponService;

    @Resource(name = "mbrMlgService")
    private MbrMlgService mbrMlgService;

    @Resource(name = "mbrPointService")
    private MbrPointService mbrPointService;

    @Resource(name = "eventApplcnService")
    private EventApplcnService eventService;

    @Resource(name = "gdsReviewService")
    private GdsReviewService gdsReviewService;

    @Resource(name = "gdsQaService")
    private GdsQaService gdsQaService;

    @Resource(name = "cartService")
    private CartService cartService;

    @Resource(name = "wishService")
    private WishService wishService;

	@Resource(name="mailService")
	private MailService mailService;
	
	@Resource(name="mngrLogService")
	private MngrLogService mngrLogService;

    @Value("#{props['Globals.Server.Dir']}")
    private String serverDir;

    @Value("#{props['Globals.File.Upload.Dir']}")
    private String fileUploadDir;

	@Value("#{props['Mail.Form.FilePath']}")
	private String mailFormFilePath;

	@Value("#{props['Mail.Username']}")
	private String sendMail;

    @Value("#{props['Mail.Testuser']}")
	private String mailTestuser;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;

    @Autowired
    private MngrSession mngrSession;

    private static String[] targetParams = {"curPage", "cntPerPage", "srchText", "sortBy", "srchJoinBgng", "srchJoinEnd", "srchMbrId", "srchMbrNm", "srchLastTelnoOfMbl","srchBrdt","srchRecipter"};

    /**
     * 일반 회원 관리
     */
    @RequestMapping(value="list")
    public String list(
            HttpServletRequest request
            , @RequestParam Map<String, Object> reqMap
            , Model model) throws Exception {

        CommonListVO listVO = new CommonListVO(request);

        String[] grade = new String[5];
        boolean result = false;

        for(int i=0; i < 5; i++) {
        	if(EgovStringUtil.isNotEmpty((String)reqMap.get("srchGrade"+i))) {
        		grade[i] = ((String)reqMap.get("srchGrade"+i));
        	}
        }

        for(int h=0; h < 5; h++) {
        	if(EgovStringUtil.isNotEmpty(grade[h])) {
        		result = true;
        	}
        }

        if(result) {
        	listVO.setParam("srchGrade", grade);
        }

        //검색어 초기화 이후 추가
        listVO.setParam("srchTarget", "");
        listVO.setParam("srchText", "");
        if (reqMap.containsKey("srchTarget") && reqMap.containsKey("srchText") && EgovStringUtil.isNotEmpty((String)reqMap.get("srchText"))) {
        	String value = (String)reqMap.get("srchText");
        	if ("srchLastTelnoOfMbl".equals((String)reqMap.get("srchTarget"))) {
        		listVO.setParam("srchLastTelnoOfMbl", value);
        	}
        	if ("srchMbrId".equals((String)reqMap.get("srchTarget"))) {
        		listVO.setParam("srchMbrId", value);
        	}
        	if ("srchMbrNm".equals((String)reqMap.get("srchTarget"))) {
        		listVO.setParam("srchMbrNm", value);
        	}
        	if ("srchRecipientsNm".equals((String)reqMap.get("srchTarget"))) {
        		listVO.setParam("srchRecipientsNm", value);
        	}
        	if ("srchRcperRcognNo".equals((String)reqMap.get("srchTarget"))) {
        		listVO.setParam("srchRcperRcognNo", value);
        	}
        	if ("srchUniqueId".equals((String)reqMap.get("srchTarget"))) {
        		listVO.setParam("srchUniqueId", value);
        	}
        }
        listVO.setParam("srchWithoutNotSnsExist", "1");
        listVO = mbrService.mbrListVO(listVO);
        
        if (listVO.getListObject() != null && !listVO.getListObject().isEmpty()) {
        	List<MbrVO> srchMbrList = (List<MbrVO>)listVO.getListObject();
        	List<String> srchUniqueIdList = srchMbrList.stream().map(f -> f.getUniqueId()).collect(Collectors.toList());
        	List<MbrAuthVO> mbrAuthList = mbrAuthService.selectMbrAuthByUniqueIdList(srchUniqueIdList);
        	
        	for(MbrVO vo : srchMbrList) {
        		//가입유형
        		List<String> joinTyList = mbrAuthList.stream().filter(f -> vo.getUniqueId().equals(f.getMbrUniqueId())).map(m -> m.getJoinTy()).collect(Collectors.toList());
        		// O, K, N 순으로 재정렬하기 위해 필요
        		List<String> sortedJoinTyList = new ArrayList();
        		if (joinTyList.contains("E")) {
        			sortedJoinTyList.add("O");
        		} 
        		if (joinTyList.contains("K")) {
        			sortedJoinTyList.add("K");
        		}
        		if (joinTyList.contains("N")) {
        			sortedJoinTyList.add("N");
        		}
        		
        		String joinTyStr = String.join(",", sortedJoinTyList);
        		vo.setJoinTyList(joinTyStr);
        		
        		//마스킹 처리
                vo.setMbrNm(StringUtil.nameMasking(vo.getMbrNm()));
                vo.setMblTelno(StringUtil.phoneMasking(vo.getMblTelno()));
                vo.getMbrRecipientsList().forEach(recipientInfo -> {
                	try {
                		recipientInfo.setRecipientsNm(StringUtil.nameMasking(recipientInfo.getRecipientsNm()));
                	} catch (Exception ex) {
                		recipientInfo.setRecipientsNm("");
                	}
                });
        	}
        }

        model.addAttribute("listVO", listVO);
        model.addAttribute("recipterYn", CodeMap.RECIPTER_YN);
        model.addAttribute("mberSttus", CodeMap.MBER_STTUS);
        model.addAttribute("grade", CodeMap.GRADE);
        model.addAttribute("gender", CodeMap.GENDER);
        model.addAttribute("mbrJoinTy", CodeMap.MBR_JOIN_TY2);
        model.addAttribute("mbrRelationCd", CodeMap.MBR_RELATION_CD);
        model.addAttribute("mbrJoinTy3", CodeMap.MBR_JOIN_TY3);

        return "/manage/mbr/manage/list";
    }
    /**
     * 일반 회원 관리 > 등록
     */
    @RequestMapping(value="form")
    public String form(
            MbrVO mbrVO
            , @RequestParam (value="uniqueId", required=false) String uniqueId
            , @RequestParam Map<String, Object> reqMap
            , HttpServletRequest request
            , HttpSession session
            , Model model)throws Exception {

        if(uniqueId == null) {
            mbrVO.setCrud(CRUD.CREATE);
        }else {

            mbrVO = mbrService.selectMbrByUniqueId(uniqueId);
            mbrVO.setCrud(CRUD.UPDATE);
        }

        model.addAttribute("mbrVO", mbrVO);
        model.addAttribute("param", reqMap);
        model.addAttribute("recipterYn", CodeMap.RECIPTER_YN);
        model.addAttribute("yn", CodeMap.YN);
        model.addAttribute("gender", CodeMap.GENDER);
        model.addAttribute("bassStlmTy", CodeMap.BASS_STLM_TY);
        model.addAttribute("mberSttus", CodeMap.MBER_STTUS);
        model.addAttribute("useYn", CodeMap.YN);
        model.addAttribute("joinCours", CodeMap.JOIN_COURS);


        return "/manage/mbr/manage/form";
    }
    /**
     * 일반 회원 관리 > 처리
     */
    @SuppressWarnings("unused")
	@RequestMapping(value="action")
    public View action(
            MbrVO mbrVO
            , @RequestParam Map<String,Object> reqMap
            , MultipartHttpServletRequest multiReq
            , HttpServletRequest request) throws Exception {

        JavaScript javaScript = new JavaScript();
        String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));
        //Map<String, MultipartFile> fileMap = multiReq.getFileMap();

        boolean changedPswd = false;

        String profileImg = "";

        // 비밀번호 암호화
        if (EgovStringUtil.isNotEmpty(mbrVO.getPswd())) {
            if (!ValidatorUtil.isValidPassword(mbrVO.getPswd())) {
                javaScript.setMessage("회원 계정 신청에 실패하였습니다. 다시 시도하시기 바랍니다.[비밀번호는 6~15자리, 알파벳, 숫자, 특수문자로 구성된 문자열만 가능]");
                javaScript.setMethod("window.history.back()");
                return new JavaScriptView(javaScript);
            }
            String encPswd = BCrypt.hashpw(mbrVO.getPswd(), BCrypt.gensalt());

            mbrVO.setPswd(encPswd);
            changedPswd = true;
        }

        // 관리자정보
        mbrVO.setRegUniqueId(mngrSession.getUniqueId());
        mbrVO.setRegId(mngrSession.getMngrId());
        mbrVO.setRgtr(mngrSession.getMngrNm());
        mbrVO.setMdfcnUniqueId(mngrSession.getUniqueId());
        mbrVO.setMdfcnId(mngrSession.getMngrId());
        mbrVO.setMdfr(mngrSession.getMngrNm());

        Map<String, MultipartFile> fileMap = multiReq.getFileMap();

        switch (mbrVO.getCrud()) {
            case CREATE:

                // 프로필 이미지 업로드
                if (!fileMap.get("profileImg").isEmpty()) {
                    profileImg = fileService.uploadFileNFixFileName(fileMap.get("profileImg"), serverDir.concat(fileUploadDir),
                            "PROFL", DateUtil.getCurrentDateTime("yyyyMMddHHmmss"));
                    mbrVO.setProflImg(profileImg);
                }
                // 프로필 이미지 END

                //정보 등록
                mbrService.insertMbr(mbrVO);


                javaScript.setMessage(getMsg("action.complete.insert"));
                javaScript.setLocation("./list?" + pageParam);
                break;

            case UPDATE:

                // 첨부파일 수정
                String delAttachFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delAttachFileNo"));
                String[] arrDelAttachFile = delAttachFileNo.split(",");
                if (!EgovStringUtil.isEmpty(arrDelAttachFile[0])) {
                    fileService.deleteFilebyNo(arrDelAttachFile, 1, "MBR", "ATTACH");
                }

                // file upload & data insert
                //fileService.creatFileInfo(fileMap, 1, "POPUP", reqMap);

                // 정보 수정
                mbrService.updateMbr(mbrVO);

                javaScript.setMessage(getMsg("action.complete.update"));
                javaScript.setLocation(
                        "./form?mbrId=" + mbrVO.getMbrId() + ("".equals(pageParam) ? "" : "&" + pageParam));
                break;

                default:
                    break;

            }
            return new JavaScriptView(javaScript);
        }

    /**
     * 회원 상세
     */
    @RequestMapping(value="{uniqueId}/view")
    public String view(
            @PathVariable String uniqueId
            , @RequestParam Map<String, Object> reqMap
            , HttpServletRequest request
            , Model model
            ) throws Exception{
    	Map<String, MbrMngInfoVO> mngMap = new HashMap();
        MbrVO mbrVO = mbrService.selectMbrByUniqueId(uniqueId);

        if (mbrVO == null) {
            model.addAttribute("alertMsg", getMsg("alert.author.common"));
            return "/common/msg";
        }

        Map<String, Object> infoMap = new HashMap();
        infoMap.put("srchUniqueId", uniqueId);
        infoMap.put("srchMngTy", "WARNING");

        MbrMngInfoVO warningInfoVO = mbrMngInfoService.selectMbrMngInfo(infoMap);
        mngMap.put("warning", warningInfoVO);

        infoMap.put("srchMngTy", "BLACK");
        MbrMngInfoVO blackInfoVO = mbrMngInfoService.selectMbrMngInfo(infoMap);
        mngMap.put("black", blackInfoVO);

        infoMap.put("srchMngTy", "AUTH");
        MbrMngInfoVO authInfoVO = mbrMngInfoService.selectMbrMngInfo(infoMap);
        mngMap.put("auth", authInfoVO);
        
        //인증정보
        List<MbrAuthVO> authList = mbrAuthService.selectMbrAuthByMbrUniqueId(mbrVO.getUniqueId());
		MbrAuthVO eroumAuthInfo = authList.stream().filter(f -> "E".equals(f.getJoinTy())).findAny().orElse(null);
		MbrAuthVO kakaoAuthInfo = authList.stream().filter(f -> "K".equals(f.getJoinTy())).findAny().orElse(null);
		MbrAuthVO naverAuthInfo = authList.stream().filter(f -> "N".equals(f.getJoinTy())).findAny().orElse(null);
        
        //약관동의 정보 조회
        MbrAgreementVO mbrAgreementVO = mbrService.selectMbrAgreementByMbrUniqueId(uniqueId);

        model.addAttribute("mbrVO", mbrVO);
        model.addAttribute("eroumAuthInfo", eroumAuthInfo);
		model.addAttribute("kakaoAuthInfo", kakaoAuthInfo);
		model.addAttribute("naverAuthInfo", naverAuthInfo);
        model.addAttribute("mbrAgreementVO", mbrAgreementVO);
        model.addAttribute("mngMap", mngMap);
        model.addAttribute("param", reqMap);
        model.addAttribute("gender", CodeMap.GENDER);
        model.addAttribute("joinCours", CodeMap.JOIN_COURS);
        model.addAttribute("yn", CodeMap.YN);
        model.addAttribute("expiration", CodeMap.EXPIRATION);
        model.addAttribute("mngSeWarning", CodeMap.MNG_SE_WARNING);
        model.addAttribute("mngSeBlack", CodeMap.MNG_SE_BLACK);
        model.addAttribute("resnCd", CodeMap.RESN_CD);
        model.addAttribute("mberGrade", CodeMap.GRADE);
        model.addAttribute("blackResnCd", CodeMap.BLACK_RESN_CD);
        model.addAttribute("authResnCd", CodeMap.AUTH_RESN_CD);
        model.addAttribute("norResnCd", CodeMap.NOR_RESN_CD);
        model.addAttribute("recipter", CodeMap.RECIPTER_YN);
        model.addAttribute("mbrJoinTy", CodeMap.MBR_JOIN_TY2);
        model.addAttribute("mbrJoinTy3", CodeMap.MBR_JOIN_TY3);

        
        //상세조회 로그 수집
        mngrLogService.insertMngrDetailLog(request);
        
        return "/manage/mbr/manage/view";
    }

    /**
     * 회원 상세 > 수급자정보
     */
    @RequestMapping(value="{uniqueId}/recipient")
    public String recipient(
            @PathVariable String uniqueId
            , @RequestParam Map<String, Object> reqMap
            , @RequestParam(required = false) Integer recipientsNo
            , HttpServletRequest request
            , Model model
            ) throws Exception{
        MbrVO mbrVO = mbrService.selectMbrByUniqueId(uniqueId);

        if (mbrVO == null) {
            model.addAttribute("alertMsg", getMsg("alert.author.common"));
            return "/common/msg";
        }

        model.addAttribute("recipientsNo", recipientsNo);
        model.addAttribute("mbrVO", mbrVO);;
        model.addAttribute("param", reqMap);
        model.addAttribute("gender", CodeMap.GENDER);
        model.addAttribute("mbrRelationCd", CodeMap.MBR_RELATION_CD);
        model.addAttribute("mbrJoinTy", CodeMap.MBR_JOIN_TY2);
        
        return "/manage/mbr/manage/recipient";
    }
    
    /**
     * 임시 비밀번호 발송
     * @return resultMap
     * @throws Exception
     */
    @RequestMapping(value = "{uniqueId}/sendPw.json")
    @ResponseBody
    public Map<String, Object> sendPw(
    		HttpServletRequest request
    		, Model model
    		, @PathVariable String uniqueId
    		) throws Exception {
    	Map<String, Object> resultMap = new HashMap();
    	resultMap.put("success", false);

    	try {
    		MbrVO mbrVO = mbrService.selectMbrByUniqueId(uniqueId);
        	if(mbrVO == null){
        		resultMap.put("msg", "존재하지 않는 회원입니다.");
        		return resultMap;
        	}
        	if (ValidatorUtil.isEmail(mbrVO.getEml()) == false) {
        		resultMap.put("msg", "이메일이 미동록된 회원입니다.");
        		return resultMap;
        	}
        	
        	List<MbrAuthVO> authList = mbrAuthService.selectMbrAuthByMbrUniqueId(mbrVO.getUniqueId());
			MbrAuthVO eroumAuthInfo = authList.stream().filter(f -> "E".equals(f.getJoinTy())).findAny().orElse(null);
			if(eroumAuthInfo == null) {
				resultMap.put("msg", "이로움 아이디가 등록되지 않은 회원입니다.");
				return resultMap;
			}
        	
        	String rndPswd = RandomUtil.getRandomPassword(10);
    		String encPswd = BCrypt.hashpw(rndPswd, BCrypt.gensalt());

    		//비밀번호 변경
    		mbrAuthService.updatePswd(eroumAuthInfo.getAuthNo(), encPswd);

    		
    		// 비밀번호 이메일 발송	
			String MAIL_FORM_PATH = mailFormFilePath;
			String mailForm = FileUtil.readFile(MAIL_FORM_PATH+"mail/mbr/mail_temp_password.html");

			mailForm = mailForm.replace("{rndPswd}", rndPswd);

			// 메일 발송
			String mailSj = "[이로움ON] 임시 비밀번호 안내";
			if(!EgovStringUtil.equals("local", activeMode)) {
				mailService.sendMail(sendMail, mbrVO.getEml(), mailSj, mailForm);
			} else {
				mailService.sendMail(sendMail, this.mailTestuser, mailSj, mailForm); //테스트
			}
			
        	resultMap.put("success", true);
    	} catch (Exception ex) {
    		log.error("관리자 임시 비밀번호 알림 EMAIL 전송 실패 :: ", ex);
    		resultMap.put("msg", "이메일 발송 중 오류가 발생하였습니다.");
    	}

    	return resultMap;
    }

    /**
     * 회원 상세 > 관리정보
     */
    @RequestMapping(value="{uniqueId}/manageInfo.json")
    @ResponseBody
    public boolean blackList(
    		@PathVariable String uniqueId
            , @RequestParam Map<String,String> reqMap
            , HttpServletRequest request
    		) throws Exception {

        boolean result = false;

        try {

        	reqMap.put("uniqueId", uniqueId);
            mbrMngInfoService.insertMbrMngInfo(reqMap);

            result = true;

        }catch(Exception e) {
        	e.printStackTrace();
        	log.debug("INSERT WARNING MBR_MNG_INFO ERROR");
        }

        return result;
    }

    /**
     * 선택정보 정보 수신
     */
    @RequestMapping(value="{uniqueId}/choice.json")
    @ResponseBody
    public boolean choice(
            @RequestParam Map<String, String> reqMap
            )throws Exception{

    	boolean result = false;

        try {
        	mbrService.updateChoiceYn(reqMap);
        	result = true;

        }catch(Exception e) {
        	e.printStackTrace();
        	log.debug("MBR UPDATE CHOICE YN ERROR");
        	}


        return result;
    }

    /**
     * 개인정보 유효기간
     */
    @RequestMapping(value="{uniqueId}/prvc.json")
    @ResponseBody
    public boolean prvc(
            @RequestParam Map<String, String> reqMap
            , @PathVariable String uniqueId
            )throws Exception{

    	boolean result = false;

    	try {
            reqMap.put("uniqueId", uniqueId);
            mbrService.updatePrvc(reqMap);
            result = true;

    	}catch(Exception e) {
    		e.printStackTrace();
    		log.debug("MBR UPDATE PRVC ERROR");
    	}

        return result;
    }


    /**
     * 주문 내역
     */
    @RequestMapping(value="{uniqueId}/ordr")
    public String ordr(
		   HttpServletRequest request
           , Model model
           , @PathVariable String uniqueId
    		)throws Exception {

    	// 회원정보
    	MbrVO mbrVO = mbrService.selectMbrByUniqueId(uniqueId);

    	// 주문 내역
    	CommonListVO listVO = new CommonListVO(request);
    	listVO.setParam("srchUniqueId", uniqueId);
    	listVO.setParam("ordrSttsTy", "ALL");
    	listVO = ordrService.ordrListVO(listVO);

    	model.addAttribute("listVO", listVO);
    	model.addAttribute("mbrVO", mbrVO);
    	model.addAttribute("sttsTyCode", CodeMap.ORDR_STTS);
    	model.addAttribute("ordrCoursCode", CodeMap.JOIN_COURS);
    	model.addAttribute("stlmTyCode", CodeMap.BASS_STLM_TY);
    	model.addAttribute("mberGradeCode", CodeMap.GRADE);
    	model.addAttribute("mbrJoinTy", CodeMap.MBR_JOIN_TY2);

    	return "/manage/mbr/manage/ordr";
    }


    /**
     * 마일리지
     */
    @RequestMapping(value="{uniqueId}/mlg")
    public String mlg(
            HttpServletRequest request
            , Model model
            , @PathVariable String uniqueId
            ) throws Exception{

        // 회원 정보
        MbrVO mbrVO = mbrService.selectMbrByUniqueId(uniqueId);

        // 마일리지 종류별 합계
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("srchUniqueId", uniqueId);
        Map<String, Object> mlgMap = mbrMlgService.selectAlltypeMlg(paramMap);

        // 마일리지 내역
        CommonListVO listVO = new CommonListVO(request);
        listVO.setParam("srchRegDt", 1);
        listVO.setParam("srchUniqueId", uniqueId);
        listVO = mbrMlgService.mbrMlgListVO(listVO);


        model.addAttribute("listVO", listVO);
        model.addAttribute("mbrVO", mbrVO);
        model.addAttribute("mlgMap", mlgMap);
        model.addAttribute("mlgSeCode", CodeMap.POINT_SE);
        model.addAttribute("mlgCnCode", CodeMap.POINT_CN);
        model.addAttribute("mberGradeCode", CodeMap.GRADE);
        model.addAttribute("mbrJoinTy", CodeMap.MBR_JOIN_TY2);

        return "/manage/mbr/manage/mlg";
    }

    /**
     * 쿠폰
     */
    @RequestMapping(value="{uniqueId}/coupon")
    public String coupon(
            HttpServletRequest request
            , Model model
            , @PathVariable String uniqueId
            ) throws Exception{

        // 회원 정보
        MbrVO mbrVO = mbrService.selectMbrByUniqueId(uniqueId);

        // 쿠폰 종류별 정보
        Map<String, Integer> resultMap = couponService.selectAllTypeCoupon(uniqueId);

        // 쿠폰 내역
        CommonListVO listVO = new CommonListVO(request);
        listVO.setParam("uniqueId", uniqueId);
        listVO = couponService.couponLstListVO(listVO);

        model.addAttribute("mbrVO", mbrVO);
        model.addAttribute("listVO", listVO);
        model.addAttribute("resultMap", resultMap);
        model.addAttribute("couponTyCode", CodeMap.COUPON_TY);
        model.addAttribute("mberGradeCode", CodeMap.GRADE);
        model.addAttribute("mbrJoinTy", CodeMap.MBR_JOIN_TY2);

        return "/manage/mbr/manage/coupon";
    }

    /**
     * 포인트
     */
    @RequestMapping(value="{uniqueId}/point")
    public String point(
            HttpServletRequest request
            , Model model
            , @PathVariable String uniqueId
            ) throws Exception{

        // 회원정보
        MbrVO mbrVO = mbrService.selectMbrByUniqueId(uniqueId);

        // 포인트별 종류별 합계
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("srchUniqueId", uniqueId);
        Map<String, Object> pointMap = mbrPointService.selectAlltypePoint(paramMap);

        // 포인트 내역
        CommonListVO listVO = new CommonListVO(request);
        listVO.setParam("srchRegDt", 1);
        listVO.setParam("srchUniqueId", uniqueId);
        listVO = mbrPointService.mbrPointListVO(listVO);


        model.addAttribute("mbrVO", mbrVO);
        model.addAttribute("listVO", listVO);
        model.addAttribute("pointMap", pointMap);
        model.addAttribute("pointCnCode", CodeMap.POINT_CN);
        model.addAttribute("pointSeCode", CodeMap.POINT_SE);
        model.addAttribute("mberGradeCode", CodeMap.GRADE);
        model.addAttribute("mbrJoinTy", CodeMap.MBR_JOIN_TY2);

        return "/manage/mbr/manage/point";
    }

    /**
     * 이벤트
     */
    @RequestMapping(value="{uniqueId}/event")
    public String event(
            HttpServletRequest request
            , Model model
            , @PathVariable String uniqueId
            ) throws Exception{

        // 회원정보
        MbrVO mbrVO = mbrService.selectMbrByUniqueId(uniqueId);

        // 이벤트 정보
        CommonListVO listVO = new CommonListVO(request);
        listVO.setParam("uniqueId", uniqueId);
        listVO =  eventService.eventApplcnListVO(listVO);

        model.addAttribute("mbrVO", mbrVO);
        model.addAttribute("listVO", listVO);
        model.addAttribute("playSttusCode", CodeMap.PLAY_STTUS);
        model.addAttribute("mberGradeCode", CodeMap.GRADE);
        model.addAttribute("mbrJoinTy", CodeMap.MBR_JOIN_TY2);

        return "/manage/mbr/manage/event";
    }

    /**
     * 상품 후기
     */
    @RequestMapping(value="{uniqueId}/review")
    public String review(
            HttpServletRequest request
            , Model model
            , @PathVariable String uniqueId
            ) throws Exception{

        // 회원정보
        MbrVO mbrVO = mbrService.selectMbrByUniqueId(uniqueId);

        // 상품 후기 목록
        CommonListVO listVO = new CommonListVO(request);
        listVO.setParam("srchRegUniqueId", uniqueId);
        listVO = gdsReviewService.gdsReviewListVO(listVO);

        // 문의 내용 태그 처리
        List<GdsReviewVO> reviewList = listVO.getListObject();
    	for(GdsReviewVO gdsReviewVO : reviewList) {
    		gdsReviewVO.setCn(HtmlUtil.clean(gdsReviewVO.getCn()));
		}


        model.addAttribute("mbrVO", mbrVO);
        model.addAttribute("listVO", listVO);
        model.addAttribute("mberGradeCode", CodeMap.GRADE);
        model.addAttribute("useYnCode", CodeMap.USE_YN);
        model.addAttribute("dspyYnCode", CodeMap.DSPY_YN);
        model.addAttribute("mbrJoinTy", CodeMap.MBR_JOIN_TY2);

        return "/manage/mbr/manage/review";
    }

    /**
     * 상품 Q&A
     */
    @RequestMapping(value="{uniqueId}/qna")
    public String qna(
            HttpServletRequest request
            , Model model
            , @PathVariable String uniqueId
            ) throws Exception{

        // 회원정보
        MbrVO mbrVO = mbrService.selectMbrByUniqueId(uniqueId);

        // QnA 내역
        CommonListVO listVO = new CommonListVO(request);
        listVO.setParam("srchUniqueId", uniqueId);
        listVO = gdsQaService.gdsQaListVO(listVO);

        // QnA 내용 태그 처리
        List<GdsQaVO> qaList = listVO.getListObject();
    	for(GdsQaVO gdsQaVO : qaList) {
    		gdsQaVO.setQestnCn(HtmlUtil.clean(gdsQaVO.getQestnCn()));
		}


        model.addAttribute("mbrVO", mbrVO);
        model.addAttribute("listVO", listVO);
        model.addAttribute("mberGradeCode", CodeMap.GRADE);
        model.addAttribute("ansYnCode", CodeMap.ANS_YN);
        model.addAttribute("mbrJoinTy", CodeMap.MBR_JOIN_TY2);

        return "/manage/mbr/manage/qna";
    }

    /**
     * 상품 Q&A 상세
     */
    @RequestMapping(value="{uniqueId}/qnaView")
    public String qnaView(
    		  HttpServletRequest request
              , Model model
              , @PathVariable String uniqueId
              , @RequestParam(value="qaNo", required=true) int qaNo
            ) throws Exception{

    	// 회원정보
        MbrVO mbrVO = mbrService.selectMbrByUniqueId(uniqueId);

        // 상세 정보
        GdsQaVO gdsQaVO = gdsQaService.selectGdsQa(qaNo);

        model.addAttribute("mbrVO", mbrVO);
        model.addAttribute("gdsQaVO", gdsQaVO);
        model.addAttribute("ansYnCode", CodeMap.ANS_YN);
        model.addAttribute("useYnCode", CodeMap.USE_YN);
        model.addAttribute("mberGradeCode", CodeMap.GRADE);
        model.addAttribute("mbrJoinTy", CodeMap.MBR_JOIN_TY2);

        return "/manage/mbr/manage/qnaView";
    }

    /**
     * 1:1문의 리스트
     */
    @RequestMapping(value="{uniqueId}/question")
    public String question(
  		  HttpServletRequest request
          , Model model
          , @PathVariable String uniqueId
          ) throws Exception{

        // 회원 정보
    	MbrVO mbrVO = mbrService.selectMbrByUniqueId(uniqueId);

        // 리스트
    	CommonListVO listVO = new CommonListVO(request);
        listVO.setParam("uniqueId", uniqueId);
        listVO = inqryService.mbrInqryListVO(listVO);

        model.addAttribute("mbrVO", mbrVO);
        model.addAttribute("listVO", listVO);
        model.addAttribute("ansYn", CodeMap.ANS_YN);
        model.addAttribute("inqryTyCode1", CodeMap.INQRY_TY_NO1);
        model.addAttribute("inqryTyCode2", CodeMap.INQRY_TY_NO2);
        model.addAttribute("mberGradeCode", CodeMap.GRADE);
        model.addAttribute("mbrJoinTy", CodeMap.MBR_JOIN_TY2);

        return "/manage/mbr/manage/question";
    }

    /**
     * 1:1문의 상세
     */
    @RequestMapping(value="{uniqueId}/questionView")
    public String questionView(
    		  HttpServletRequest request
              , Model model
              , @PathVariable String uniqueId
              , @RequestParam(value="inqryNo", required=true) int inqryNo
            ) throws Exception{

    	// 회원 정보
    	MbrVO mbrVO = mbrService.selectMbrByUniqueId(uniqueId);

    	// 문의 정보
    	MbrInqryVO mbrInqryVO = inqryService.selectMbrInqry(inqryNo);

    	model.addAttribute("mbrVO", mbrVO);
    	model.addAttribute("mbrInqryVO", mbrInqryVO);
        model.addAttribute("inqryTyCode1", CodeMap.INQRY_TY_NO1);
        model.addAttribute("inqryTyCode2", CodeMap.INQRY_TY_NO2);
        model.addAttribute("ansYnCode", CodeMap.ANS_YN);
        model.addAttribute("mberGradeCode", CodeMap.GRADE);
        model.addAttribute("mbrJoinTy", CodeMap.MBR_JOIN_TY2);


        return "/manage/mbr/manage/questionView";
    }

    /**
     * 관심상품 리스트
     */
    @RequestMapping(value="{uniqueId}/favorite")
    public String favorite(
    		HttpServletRequest request
            , Model model
            , @PathVariable String uniqueId
            ) throws Exception{

    	// 회원 정보
    	MbrVO mbrVO = mbrService.selectMbrByUniqueId(uniqueId);

    	// 장바구니
    	Map<String, Object> paramMap = new HashMap<String, Object>();
    	paramMap.put("srchUniqueId",uniqueId);
    	List<CartVO> cartList = cartService.selectCartListAll(paramMap);

    	// 위시리스트
    	paramMap.clear();
    	paramMap.put("srchUniqueId", uniqueId);
    	List <WishVO> wishList = wishService.selectWishListAll(paramMap);

    	model.addAttribute("mbrVO", mbrVO);
    	model.addAttribute("cartList", cartList);
    	model.addAttribute("wishList", wishList);
    	model.addAttribute("mberGradeCode", CodeMap.GRADE);
    	model.addAttribute("mbrJoinTy", CodeMap.MBR_JOIN_TY2);

        return "/manage/mbr/manage/favorite";
    }

    @RequestMapping("excel")
	public void excelDownload(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception{

		String[] grade = new String[5];
		boolean result = false;

		for(int i=0; i < 5; i++) {
			if(EgovStringUtil.isNotEmpty((String)reqMap.get("srchGrade"+i))) {
				grade[i] = ((String)reqMap.get("srchGrade"+i));
		 	}
		 }

		 for(int h=0; h < 5; h++) {
		 	if(EgovStringUtil.isNotEmpty(grade[h])) {
		 		result = true;
		 	}
		 }

        if(result) {
        	reqMap.put("srchGrade", grade);
        }

        List<MbrVO> mbrList = mbrService.selectMbrListAll(reqMap);

	    model.addAttribute("mbrList", mbrList);
	    model.addAttribute("recipterYn", CodeMap.RECIPTER_YN);
	    model.addAttribute("mberSttus", CodeMap.MBER_STTUS);
	    model.addAttribute("grade", CodeMap.GRADE);
	    model.addAttribute("gender", CodeMap.GENDER);

        // excel data
        Map<String, Function<Object, Object>> mapping = new LinkedHashMap<>();
        mapping.put("번호", obj -> "rowNum");
        mapping.put("회원코드", obj -> ((MbrVO)obj).getUniqueId());
        mapping.put("회원이름", obj -> ((MbrVO)obj).getMbrNm());
        mapping.put("휴대폰번호", obj -> ((MbrVO)obj).getMblTelno());
        mapping.put("등록수급자수", obj -> ((MbrVO)obj).getMbrRecipientsList().size());
        mapping.put("관계1", obj -> getRelationText(((MbrVO)obj).getMbrRecipientsList(), 0));
        mapping.put("관계2", obj -> getRelationText(((MbrVO)obj).getMbrRecipientsList(), 1));
        mapping.put("관계3", obj -> getRelationText(((MbrVO)obj).getMbrRecipientsList(), 2));
        mapping.put("관계4", obj -> getRelationText(((MbrVO)obj).getMbrRecipientsList(), 3));
        mapping.put("회원등급", obj -> CodeMap.GRADE.get(((MbrVO)obj).getMberGrade()));
        mapping.put("가입유형", obj -> {
        	String joinTy = ((MbrVO)obj).getJoinTy();
        	return CodeMap.MBR_JOIN_TY3.get(joinTy);
        });
        mapping.put("가입일", obj -> new SimpleDateFormat("yyyy-MM-dd").format(((MbrVO)obj).getJoinDt()));
        mapping.put("수급자본인여부", obj -> {
        	return ((MbrVO)obj).getMbrRecipientsList().stream().filter(f -> "007".equals(f.getRelationCd())).count() > 0 ? "본인" : "-";
        });
        mapping.put("L번호등록수급자", obj -> {
        	return ((MbrVO)obj).getMbrRecipientsList().stream().filter(f -> "Y".equals(f.getRecipientsYn())).count();
        });


        List<LinkedHashMap<String, Object>> dataList = new ArrayList<>();


        for (MbrVO mbrVO : mbrList) {
 		    LinkedHashMap<String, Object> tempMap = new LinkedHashMap<>();
 		    for (String header : mapping.keySet()) {
 		        Function<Object, Object> extractor = mapping.get(header);
 		        if (extractor != null) {
 		            tempMap.put(header, extractor.apply(mbrVO));
 		        }
 		    }
		    dataList.add(tempMap);
		}

		ExcelExporter exporter = new ExcelExporter();
		try {
			exporter.export(response, "회원목록", dataList, mapping);
		} catch (IOException e) {
		    e.printStackTrace();
 		}

	}

    @RequestMapping(value = "{uniqueId}/chgGrade.json")
    public Map<String, Object> chgGrade(
    		@PathVariable String uniqueId
    		, @RequestParam(value = "mberGrade", required=true) String mberGrade
    		, HttpServletRequest request
    		, Model model
    		)throws Exception{
    	Map<String, Object> paramMap = new HashMap<String, Object>();

    	boolean result = false;

    	try {
    		paramMap.put("srchUniqueId", uniqueId);
    		paramMap.put("mberGrade", mberGrade);
    		int resultCnt = mbrService.updateMberGrade(paramMap);

    		if(resultCnt > 0) {
    			result = true;
    		}else {
    			log.debug("chgGrade.json Not Update");
    		}

    	}catch(Exception e) {
    		e.printStackTrace();
    		log.debug("chgGrade.json Error : " + e.getMessage());
    	}

    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	resultMap.put("result", result);
    	return resultMap;
    }

    
    // 엑셀다운로드 관계1~4에 문구 표출시 사용
    private String getRelationText(List<MbrRecipientsVO> mbrRecipientList, int index) {
    	if (mbrRecipientList == null) {
    		return "";
    	}
    	
    	if (mbrRecipientList.size() >= index + 1) {
    		return CodeMap.MBR_RELATION_CD.get(mbrRecipientList.get(index).getRelationCd()) +
    				"(" +
    				mbrRecipientList.get(index).getRecipientsNm() +
    				")";
    	} else {
    		return "";
    	}
    }
    
    /**
     * 휴면계정 정책 변경 안내 메일 발송(수동 url로 직접 실행)
     */
    @RequestMapping(value="send/drmcChangeGuideEmail")
    public String sendDrmcChangeGuideEmail(
    		Model model
            ) throws Exception{

    	try {
    		Map<String, Object> paramMap = new HashMap<String, Object>();
    		paramMap.put("srchMbrStts", "NORMAL");
    		List<MbrVO> mbrList = mbrService.selectMbrListAll(paramMap);

    		String MAIL_FORM_PATH = mailFormFilePath;
    		String mailForm = FileUtil.readFile(MAIL_FORM_PATH+"mail/mbr/mail_drmc_change_guide.html");
    		
    		// 메일 발송
    		String mailSj = "[이로움ON] 휴면계정 정책 변경 안내";
    		if(EgovStringUtil.equals("real", activeMode)) {
    			for (MbrVO mbrVO : mbrList) {
    				if (EgovStringUtil.isNotEmpty(mbrVO.getEml())) {
    					mailService.sendMail(sendMail, mbrVO.getEml(), mailSj, mailForm);
    				}
    			}
    		} else {
    			mailService.sendMail(sendMail, this.mailTestuser, mailSj, mailForm); //테스트
    		}
    		
    		model.addAttribute("alertMsg", "전송이 완료되었습니다.");
    	} catch (Exception ex) {
    		log.error("--------휴면계정 정책 변경 안내 메일 발송 오류 : ", ex);
    		model.addAttribute("alertMsg", "전송중 오류가 발생하였습니다.");
    	}
    	return "/common/msg";
    }
}
