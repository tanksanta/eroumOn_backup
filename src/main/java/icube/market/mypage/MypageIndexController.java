package icube.market.mypage;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovDateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import icube.common.file.biz.FileService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.DateUtil;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.consult.biz.GdsQaService;
import icube.manage.consult.biz.GdsReviewService;
import icube.manage.consult.biz.GdsReviewVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.mbr.recipter.biz.RecipterInfoService;
import icube.manage.mbr.recipter.biz.RecipterInfoVO;
import icube.manage.ordr.ordr.biz.OrdrService;
import icube.manage.promotion.coupon.biz.CouponLstService;
import icube.manage.promotion.event.biz.EventApplcnService;
import icube.manage.promotion.mlg.biz.MbrMlgService;
import icube.manage.promotion.mlg.biz.MbrMlgVO;
import icube.manage.promotion.point.biz.MbrPointService;
import icube.manage.promotion.point.biz.MbrPointVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 마이페이지 > INDEX
 */

@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/mypage")
public class MypageIndexController extends CommonAbstractController {

	@Resource(name="mbrService")
	private MbrService mbrService;

	@Resource(name = "recipterInfoService")
	private RecipterInfoService recipterInfoService;

	@Resource(name="eventApplcnService")
	private EventApplcnService eventApplcnService;

	@Resource(name="couponLstService")
	private CouponLstService couponLstService;

	@Resource(name="mbrMlgService")
	private MbrMlgService mbrMlgService;

	@Resource(name = "mbrPointService")
	private MbrPointService mbrPointService;

	@Resource(name="gdsQaService")
	private GdsQaService gdsQaService;

	@Resource(name="gdsReviewService")
	private GdsReviewService gdsReviewService;

	@Resource(name = "fileService")
	private FileService fileService;

	@Resource(name = "ordrService")
	private OrdrService ordrService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	@Value("#{props['Globals.Server.Dir']}")
	private String serverDir;

	@Value("#{props['Globals.File.Upload.Dir']}")
	private String fileUploadDir;

	@RequestMapping(value = {"", "index"})
	@SuppressWarnings({"rawtypes","unchecked"})
	public String MypageIndex(
			@RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {

		int point = 0;
		int mlg = 0;

		// 회원 프로필 이미지
		MbrVO mbrVO = mbrService.selectMbrByUniqueId(mbrSession.getUniqueId());

		// 쿠폰 보유 개수
		Map couponMap = new HashMap();
		couponMap.put("uniqueId", mbrSession.getUniqueId());
		couponMap.put("srchUseYn", "N");
		couponMap.put("srchUseCoupon", 1); // 1 의미 x
		int OwnCouponCnt = couponLstService.selectCouponTrgtCnt(couponMap);

		// 마일리지, 포인트 누계
		Map mlgPointMap = new HashMap();
		mlgPointMap.put("srchUniqueId", mbrSession.getUniqueId());
		MbrMlgVO mbrMlgVO = mbrMlgService.selectMbrMlg(mlgPointMap);
		MbrPointVO mbrPointVO = mbrPointService.selectMbrPoint(mlgPointMap);

		if(mbrMlgVO != null) {
			mlg = mbrMlgVO.getMlgAcmtl();
		}
		if(mbrPointVO != null) {
			point = mbrPointVO.getPointAcmtl();
		}

		mlgPointMap.put("point", point);
		mlgPointMap.put("mlg", mlg);

		// 나의 상품 후기
		CommonListVO reviewListVO = new CommonListVO(request, 1, 2);
		reviewListVO.setParam("srchRegUniqueId", mbrSession.getUniqueId());
		reviewListVO.setParam("srchUseYn", "Y");
		reviewListVO = gdsReviewService.gdsReviewListVO(reviewListVO);


		// 나의 상품 QnA
		CommonListVO gdsQaListVO = new CommonListVO(request, 1, 2);
		gdsQaListVO.setParam("srchUniqueId", mbrSession.getUniqueId());
		gdsQaListVO.setParam("srchAnsYn", "N");
		gdsQaListVO.setParam("srchUseYn", "Y");
		gdsQaListVO = gdsQaService.gdsQaListVO(gdsQaListVO);


		// 이벤트 응모 현황
		CommonListVO eventList = new CommonListVO(request, 1, 2);
		eventList.setParam("uniqueId", mbrSession.getUniqueId());
		eventList = eventApplcnService.eventApplcnListVO(eventList);


		// 장바구니, 위시리스트 S
		Map<String, Object> mbrEtcInfoMap = mbrService.selectMbrEtcInfo(mbrSession.getUniqueId());
		model.addAttribute("mbrEtcInfoMap", mbrEtcInfoMap);
		// 장바구니, 위시리스트 E


		// 주문 상태별 건수
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchRegUniqueId", mbrSession.getUniqueId());
		Map<String, Integer> ordrSttsTyCntMap = ordrService.selectSttsTyCnt(paramMap);
		model.addAttribute("ordrSttsTyCntMap", ordrSttsTyCntMap);


		// 주문 S
		// 내 주문건 1건 + 최근6개월
		String srchBgnDt = DateUtil.formatDate(EgovDateUtil.getCalcDateAsString(EgovDateUtil.getCurrentYearAsString(), EgovDateUtil.getCurrentMonthAsString(), EgovDateUtil.getCurrentDayAsString(), -6, "month"),
				"yyyy-MM-dd");

		CommonListVO ordrListVO = new CommonListVO(request, 1, 1);
		ordrListVO.setParam("srchBgngDt", srchBgnDt);
		ordrListVO.setParam("srchUniqueId", mbrSession.getUniqueId());
		ordrListVO.setParam("ordrSttsTy", "ALL");
		ordrListVO = ordrService.ordrListVO(ordrListVO);
		model.addAttribute("ordrListVO", ordrListVO);

		// 주문 E
		model.addAttribute("mbrVO", mbrVO);
		model.addAttribute("ownCouponCnt", OwnCouponCnt);
		model.addAttribute("mlgPointMap", mlgPointMap);

		model.addAttribute("eventList", eventList);
		model.addAttribute("qaList", gdsQaListVO);
		model.addAttribute("reviewList", reviewListVO);

		model.addAttribute("ansYnCode", CodeMap.ANS_YN);
		model.addAttribute("recipterYnCode", CodeMap.RECIPTER_YN);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("bassStlmTyCode", CodeMap.BASS_STLM_TY);
		model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);
		model.addAttribute("ordrCancelTyCode", CodeMap.ORDR_CANCEL_TY);

		ObjectMapper mapper  = new ObjectMapper();
		String ordredListJson =  mapper.writeValueAsString(ordrListVO.getListObject());
		model.addAttribute("ordredListJson", ordredListJson);

		Map<String, Object> codeMap = new HashMap<String, Object>();
		codeMap.put("gdsTyCode", CodeMap.GDS_TY);
		codeMap.put("bassStlmTyCode", CodeMap.BASS_STLM_TY);
		codeMap.put("ordrSttsCode", CodeMap.ORDR_STTS);
		codeMap.put("ordrCancelTyCode", CodeMap.ORDR_CANCEL_TY);

		String codeMapJson =  mapper.writeValueAsString(codeMap);
		model.addAttribute("codeMapJson", codeMapJson);


		return "/market/mypage/index";
	}

	/**
	 * 포토 상품 후기
	 */
	@RequestMapping(value="photoReviewModal")
	public String photoReviewModal(
			HttpServletRequest request
			, Model model
			, @RequestParam(value="gdsReivewNo", required=true) int gdsReivewNo
			) throws Exception {

		GdsReviewVO gdsReviewVO = gdsReviewService.selectGdsReview(gdsReivewNo);

		model.addAttribute("reviewVO", gdsReviewVO);

		return "/market/mypage/photo-review-modal";
	}

	/**
	 * 프로필 이미지 편집
	 */
	@RequestMapping(value="proflImgChange.json")
	@ResponseBody
	@SuppressWarnings({"rawtypes","unchecked"})
	 public Map<String, Object> proflImgChange(
			 HttpServletRequest request
			 , Model model
			 , @RequestParam Map<String,MultipartFile> fileMap
			 )throws Exception {

		Map<String, Object> resultMap = new HashMap();
		boolean result = false;

		try {
			MbrVO mbrVO = mbrService.selectMbrByUniqueId(mbrSession.getUniqueId());
			String profileImg = fileService.uploadFile(fileMap.get("proflImg"), serverDir.concat(fileUploadDir), "PROFL");
			mbrVO.setProflImg(profileImg);
			mbrService.updateMbr(mbrVO);
			mbrSession.setProflImg(profileImg);

			result = true;

		}catch(Exception e) {
			e.printStackTrace();
			log.debug("MYPAGE UPDATE PROFLIMG ERROR");
		}

		resultMap.put("result", result);
		return resultMap;
	}

	/**
	 * 요양정보 최신 업데이트
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="updateRecipter.json")
	@ResponseBody
	public Map<String, Object> updateRecipter(
			HttpServletRequest request
			, Model model
			, HttpSession session
			)throws Exception {

		Map<String, Object> resultMap =new HashMap<String, Object>();
		boolean result = false;

		try {
			recipterInfoService.updateRecipterInfo(mbrSession.getUniqueId());

			MbrVO mbrVO = mbrService.selectMbrByUniqueId(mbrSession.getUniqueId());

			mbrSession.setParms(mbrVO, true);
			mbrSession.setMbrInfo(session, mbrSession);

			result = true;
		}catch(Exception e) {
			e.printStackTrace();
			log.debug("MYPAGE INDEX UPDATE RECIPTER INFO ERROR");
		}

		resultMap.put("result", result);
		return resultMap;
	}


}
