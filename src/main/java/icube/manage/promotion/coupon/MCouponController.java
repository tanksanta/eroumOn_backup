package icube.manage.promotion.coupon;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;
import org.springframework.web.util.HtmlUtils;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.CommonUtil;
import icube.common.util.MapUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.common.vo.DataTablesVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.promotion.coupon.biz.CouponAplcnTrgtService;
import icube.manage.promotion.coupon.biz.CouponLstService;
import icube.manage.promotion.coupon.biz.CouponLstVO;
import icube.manage.promotion.coupon.biz.CouponService;
import icube.manage.promotion.coupon.biz.CouponVO;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Controller
@RequestMapping(value="/_mng/promotion/coupon")
public class MCouponController extends CommonAbstractController {

	@Resource(name = "couponService")
	private CouponService couponService;

	@Resource(name = "couponLstService")
	private CouponLstService couponLstService;

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "couponAplcnTrgtService")
	private CouponAplcnTrgtService couponAplcnTrgtService;

	@Autowired
	private MngrSession mngrSession;

	private static String[] targetParams = {"curPage", "cntPerPage", "srchCouponTy", "srchCouponNm", "sortBy","srchCouponCd","srchIssuTy","srchSttusTy","srchDt","srchBgngDt","srchEndDt"};

	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = couponService.couponListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("couponTy", CodeMap.COUPON_TY);
		model.addAttribute("issuTy", CodeMap.ISSU_TY);
		model.addAttribute("sttusTy", CodeMap.STTUS_TY);
		model.addAttribute("grade", CodeMap.GRADE);

		return "/manage/promotion/coupon/list";
	}

	@RequestMapping(value="form")
	public String form(
			CouponVO couponVO
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception{

		int couponNo = EgovStringUtil.string2integer((String) reqMap.get("couponNo"));

		if(couponNo == 0){
			couponVO.setCrud(CRUD.CREATE);
		}else{
			couponVO = couponService.selectCoupon(couponNo);
			couponVO.setCrud(CRUD.UPDATE);
		}

		model.addAttribute("couponVO", couponVO);
		model.addAttribute("param", reqMap);
		model.addAttribute("useYn", CodeMap.USE_YN);
		model.addAttribute("couponTy", CodeMap.COUPON_TY);
		model.addAttribute("dscntTy", CodeMap.DSCNT_TY);
		model.addAttribute("issuTy", CodeMap.ISSU_TY);
		model.addAttribute("sttsTy", CodeMap.STTUS_TY);
		model.addAttribute("issuMbrTy", CodeMap.RECIPTER_YN);
		model.addAttribute("grade", CodeMap.GRADE);
		model.addAttribute("issuGds", CodeMap.ISSU_GDS);
		model.addAttribute("usePdTy", CodeMap.USE_PD_TY);

		return "/manage/promotion/coupon/form";
	}

	@RequestMapping(value="view")
	@SuppressWarnings({"unchecked","rawtypes"})
	public String view(
			HttpServletRequest request
			, Model model
			, CouponVO couponVO
			, @RequestParam Map <String, Object> reqMap
			)throws Exception {

		int couponNo = EgovStringUtil.string2integer((String) reqMap.get("couponNo"));

		//잔여수량
		Map paramMap = new HashMap();
		paramMap.put("couponNo", couponNo);
		int cnt = couponLstService.selectCouponCnt(paramMap);

		couponVO = couponService.selectCoupon(couponNo);

		//개별상품
		if(couponVO.getIssuGds().equals("I")){
			List<CouponVO> itemList =  couponAplcnTrgtService.selectAplcnTrgtList(couponNo);
			model.addAttribute("itemList", itemList);
		}

		model.addAttribute("couponVO", couponVO);
		model.addAttribute("cnt", cnt);
		model.addAttribute("couponTy", CodeMap.COUPON_TY);
		model.addAttribute("dscntTy", CodeMap.DSCNT_TY);
		model.addAttribute("issuTy", CodeMap.ISSU_TY);
		model.addAttribute("sttusTy", CodeMap.STTUS_TY);
		model.addAttribute("issuMbr", CodeMap.ISSU_MBR);
		model.addAttribute("issuGds", CodeMap.ISSU_GDS);
		model.addAttribute("useYn", CodeMap.USE_YN);

		return "/manage/promotion/coupon/view";
	}

	@RequestMapping(value="action")
	public View action(
			CouponVO couponVO
			, @RequestParam Map<String,Object> reqMap
			, HttpSession session
			, HttpServletRequest request) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));


		// 관리자정보
		couponVO.setRegUniqueId(mngrSession.getUniqueId());
		couponVO.setRegId(mngrSession.getMngrId());
		couponVO.setRgtr(mngrSession.getMngrNm());
		couponVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		couponVO.setMdfcnId(mngrSession.getMngrId());
		couponVO.setMdfr(mngrSession.getMngrNm());

		switch (couponVO.getCrud()) {
			case CREATE:

				// 날짜 시간
				String Bdate = request.getParameter("bgngDt");
				String Btime = request.getParameter("bgngTime");
				String Edate = request.getParameter("endDt");
				String Etime = request.getParameter("endTime");

				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				Date bgngDt = formatter.parse(Bdate + " " + Btime);
				Date endDt = formatter.parse(Edate + " " + Etime);

				couponVO.setIssuBgngDt(bgngDt);
				couponVO.setIssuEndDt(endDt);

				couponService.insertCoupon(couponVO,request);

				javaScript.setMessage(getMsg("action.complete.insert"));
				javaScript.setLocation("./list?" + pageParam);
				break;

			case UPDATE:
				couponService.updateCoupon(couponVO);

				javaScript.setMessage(getMsg("action.complete.update"));
				javaScript.setLocation(
					"./view?couponNo=" + couponVO.getCouponNo() + ("".equals(pageParam) ? "" : "&amp;" + pageParam));
				break;

			default:
				break;
		}

		return new JavaScriptView(javaScript);
	}

	/**
	 * 쿠폰 발행내역 -> 리스트
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="publish/list")
	public String publish(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = couponService.couponListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("couponTyCode", CodeMap.COUPON_TY);
		model.addAttribute("issuTyCode", CodeMap.ISSU_TY);
		model.addAttribute("sttusTyCode", CodeMap.STTUS_TY);
		model.addAttribute("gradeCode", CodeMap.GRADE);


		return "/manage/promotion/coupon/publish/list";
	}

	/**
	 * 쿠폰 발행내역 -> 상세
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="publish/view")
	public String view(
			HttpServletRequest request
			, CouponLstVO couponLstVO
			, @RequestParam Map<String ,Object> reqMap
			, Model model) throws Exception {

		int couponNo = EgovStringUtil.string2integer((String)reqMap.get("couponNo"));

		//회원목록
		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("couponNo", couponNo);
		listVO = couponLstService.couponLstListVO(listVO);

		//쿠폰 정보
		CouponVO couponVO = couponService.selectCoupon(couponNo);

		model.addAttribute("listVO", listVO);
		model.addAttribute("couponVO", couponVO);
		model.addAttribute("couponTyCode", CodeMap.COUPON_TY);


		return "/manage/promotion/coupon/publish/view";
	}

	/**
	 * 회원 검색
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="modalMbrSearch")
	public String modalMbrSearch(
				HttpServletRequest request
				, Model model
				)throws Exception {
	        model.addAttribute("keyWordCode",	CodeMap.SRCH_MBR_KEYWORD);
			model.addAttribute("gradeCode",		CodeMap.GRADE);
			model.addAttribute("mbrTyCode",		CodeMap.RECIPTER_YN);
			model.addAttribute("genderCode",		CodeMap.GENDER);

			return "/manage/promotion/include/mbr-search-modal";
	}

	//회원 검색 datatable
	@RequestMapping("mbrSearchList.json")
	@ResponseBody
	public DataTablesVO<MbrVO> mbrSearchList(
			@RequestParam Map<String, Object> reqMap,
			HttpServletRequest request) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = mbrService.mbrListVO(listVO);

		// DataTable
		DataTablesVO<MbrVO> dataTableVO = new DataTablesVO<MbrVO>();
		dataTableVO.setsEcho(MapUtil.getString(reqMap, "sEcho"));
		dataTableVO.setiTotalRecords(listVO.getTotalCount());
		dataTableVO.setiTotalDisplayRecords(listVO.getTotalCount());
		dataTableVO.setAaData(listVO.getListObject());

		return dataTableVO;
	}

	/**
	 * 회원 목록 파일 업로드
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "modalFileUpload")
	public String modalFileUpload(
		HttpServletRequest request
		, Model model
			)throws Exception {


		return "/manage/promotion/include/excel-file-upload";
	}

	/**
	 * 목록 > 발급수량 리스트
	 * @param request
	 * @param model
	 * @param reqMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "couponCntList")
	public String couponCntList(
			HttpServletRequest request
			, Model model
			, @RequestParam Map <String, Object> reqMap
			)throws Exception {

		//해당 쿠폰 발행 내역
		List<CouponLstVO> itemList = couponLstService.selectCouponIssuList(reqMap);

		//쿠폰 정보
		CouponVO couponVO = couponService.selectCoupon(EgovStringUtil.string2integer((String)reqMap.get("couponNo")));

		model.addAttribute("itemList", itemList);
		model.addAttribute("couponVO", couponVO);

		return  "/manage/promotion/include/coupon-cnt-list";
	}


	/**
	 * 관리자 발급 > 개별 회원 수동 발급 처리
	 * @param reqMap
	 * @param session
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "issuList.json")
	@ResponseBody
	@SuppressWarnings({"unchecked","rawtypes"})
	public int issuAction(
			@RequestParam Map<String,Object> reqMap
			, HttpSession session
			, HttpServletRequest request) throws Exception {


		//잔여수량 확인 msg
		int result = 0;
		int fail = 10;
		int couponNo = EgovStringUtil.string2integer((String)reqMap.get("couponNo"));
		int issuQy = EgovStringUtil.string2integer((String)reqMap.get("issuQy"));

		Map paramMap = new HashMap();
		paramMap.put("couponNo", couponNo);


		//회원 선택 목록
		String[] mbrList = request.getParameterValues("arrMbrList[]");
		ArrayList arrMbr = new ArrayList(Arrays.asList(mbrList));


		//쿠폰 정보 세팅
		CouponLstVO couponLstVO = new CouponLstVO();
		couponLstVO.setCouponNo(couponNo);

		// 무제한 체크
		if(issuQy == 9999) {
			couponLstVO.setUltYn("Y");
		}

		//현재 등록 수량
		int qtt  = couponLstService.selectCouponCnt(paramMap);
		CouponVO couponVO = couponService.selectCoupon(couponNo);

		if((issuQy - qtt) >= arrMbr.size()) {

			for(int i=0; i < arrMbr.size(); i++) {
				//중복 체크
				paramMap.put("uniqueId", mbrList[i]);
				int dpQtt = couponLstService.selectCouponCnt(paramMap);

				if(dpQtt < 1) {
					couponLstVO.setUniqueId(mbrList[i]);
					if(couponVO.getUsePdTy().equals("ADAY")) {
						couponLstVO.setUseDay(couponVO.getUsePsbltyDaycnt());
					}else {
						couponLstVO.setUseBgngYmd(couponVO.getUseBgngYmd());
						couponLstVO.setUseEndYmd(couponVO.getUseEndYmd());
					}

					couponLstService.insertCouponLst(couponLstVO);

					// 발행 완료
					result = 1;
				}else {
					//중복 확인 msg
					result = fail;
				}
			}
		}
		return result;
	}

	/**
	 * 쿠폰 목록 엑셀 다운로드
	 * @param request
	 * @param reqMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="excel")
	public String excelDownload(
			HttpServletRequest request
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception{

		List<CouponLstVO> itemList = couponLstService.selectCouponIssuList(reqMap);


		model.addAttribute("itemList", itemList);

		return "/manage/promotion/include/excel";
	}

	/**
	 * 쿠폰 타입 개수 체크
	 * @param request
	 * @param model
	 * @return resultMap
	 */
	@RequestMapping(value = "checkCouponTy.json")
	@ResponseBody
	public Map<String, Object> checkCouponTy(
			HttpServletRequest request
			, Model model
			, @RequestParam(value = "couponTy", required=true) String couponTy
			) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> paramMap = new HashMap<String, Object>();

		boolean result = false;

		if(couponTy.equals("BIRTH") || couponTy.equals("JOIN") || couponTy.equals("FIRST")) {
			paramMap.put("srchCouponTy", couponTy);
			paramMap.put("srchSttusTy", "USE");
			int cnt = couponService.selectCouponCount(paramMap);
			if(cnt < 1) {
				result = true;
			}
		}else {
			result = true;
		}

		resultMap.put("result", result);
		return resultMap;
	}

}
