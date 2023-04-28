package icube.market.mypage.act;

import java.util.HashMap;
import java.util.List;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import icube.common.file.biz.FileService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.WebUtil;
import icube.common.values.CRUD;
import icube.manage.consult.biz.GdsReviewService;
import icube.manage.consult.biz.GdsReviewVO;
import icube.manage.gds.gds.biz.GdsService;
import icube.manage.gds.gds.biz.GdsVO;
import icube.manage.ordr.ordr.biz.OrdrService;
import icube.manage.promotion.point.biz.MbrPointService;
import icube.manage.promotion.point.biz.MbrPointVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 마이페이지 > 쇼핑활동 > 상품후기
 */
@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/mypage/review")
public class MyReviewController extends CommonAbstractController {

	@Resource(name="gdsReviewService")
	private GdsReviewService gdsReviewService;

	@Resource(name = "ordrService")
	private OrdrService ordrService;

	@Resource(name = "gdsService")
	private GdsService gdsService;

	@Resource(name="fileService")
	private FileService fileService;

	@Resource(name = "mbrPointService")
	private MbrPointService mbrPointService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	/**
	 * 작성할 후기 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="doList")
	@SuppressWarnings({"unchecked","rawtypes"})
	public String doList(
			HttpServletRequest request
			, Model model
			) throws Exception {

		// 작성 가능 상품 후기
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());
		paramMap.put("srchSttsTy", "OR09"); // 기준 상태 (주문 확정)

		List<GdsReviewVO> itemList = gdsReviewService.selectPosbleListAll(paramMap);

		paramMap.put("srchDate", 6);
		paramMap.put("srchOrdrOptnTy", "BASE");
		Map<String, Object> resultMap = gdsReviewService.selectPsbleCount(paramMap);

		model.addAttribute("itemList", itemList);
		model.addAttribute("resultMap", resultMap);

		return "/market/mypage/review/do_list";
	}


	/**
	 * 작성한 후기 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model
			) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());

		// 등록한 상품 후기 리스트
		List<GdsReviewVO> itemList = gdsReviewService.selectGdsReviewListAll(paramMap);

		paramMap.put("srchDate", 6);
		paramMap.put("srchOrdrOptnTy", "BASE");
		paramMap.put("srchSttsTy", "OR09"); // 기준 상태 (주문 확정)
		Map<String, Object> resultMap = gdsReviewService.selectPsbleCount(paramMap);

		model.addAttribute("itemList", itemList);
		model.addAttribute("resultMap", resultMap);

		return "/market/mypage/review/list";
	}

	/**
	 * 상품 작성 모달
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="gdsReviewModal")
	public String gdsReviewModal(
			HttpServletRequest request
			, Model model
			, @RequestParam(value="gdsReviewNo", required=false) int gdsReviewNo
			, @RequestParam(value="gdsNo", required=false) int gdsNo
			, @RequestParam(value="gdsCd", required=false) String gdsCd
			, @RequestParam(value="ordrCd", required=false) String ordrCd
			, @RequestParam(value="ordrDtlNo", required=false) int ordrDtlNo
			, @RequestParam(value="ordrNo", required=false) int ordrNo
			, GdsReviewVO gdsReviewVO
			) throws Exception {

		if(gdsReviewNo != 0) {
			gdsReviewVO = gdsReviewService.selectGdsReview(gdsReviewNo);
			gdsReviewVO.setCrud(CRUD.UPDATE);
		}else {
			// params
			gdsReviewVO.setGdsCd(gdsCd);
			gdsReviewVO.setGdsNo(gdsNo);
			gdsReviewVO.setOrdrCd(ordrCd);
			gdsReviewVO.setOrdrDtlNo(ordrDtlNo);
			gdsReviewVO.setOrdrNo(ordrNo);


			gdsReviewVO.setCrud(CRUD.CREATE);
		}

		// 상품 이미지
		if(gdsNo != 0) {
			GdsVO gdsVO = gdsService.selectGds(gdsNo);
			model.addAttribute("gdsVO", gdsVO);
		}



		model.addAttribute("gdsReviewVO", gdsReviewVO);

		return "/market/mypage/review/include/gds_review_modal";
	}

	/**
	 * 상품 후기 수정
	 * @param gdsReviewVO
	 * @param starScore
	 * @param multiReq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="action")
	public View action(
			HttpServletRequest request
			, Model model
			, GdsReviewVO gdsReviewVO
			, @RequestParam (value="starScore", required=true) int starScore
			, @RequestParam Map<String, Object> reqMap
			, MultipartHttpServletRequest multiReq
			)throws Exception {

		JavaScript javaScript = new JavaScript();
		Map<String, MultipartFile> fileMap = multiReq.getFileMap();

		// 사용자 정보
		gdsReviewVO.setMdfcnId(mbrSession.getMbrId());
		gdsReviewVO.setMdfcnUniqueId(mbrSession.getUniqueId());
		gdsReviewVO.setMdfr(mbrSession.getMbrNm());
		gdsReviewVO.setRegId(mbrSession.getMbrId());
		gdsReviewVO.setRegUniqueId(mbrSession.getUniqueId());
		gdsReviewVO.setRgtr(mbrSession.getMbrNm());
		gdsReviewVO.setDspyYn("Y");

		// 별점
		gdsReviewVO.setDgstfn(starScore);

		// 포인트
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());
		MbrPointVO pointVO = mbrPointService.selectMbrPoint(paramMap);

		MbrPointVO mbrPointVO = new MbrPointVO();
		mbrPointVO.setPointMngNo(0);
		mbrPointVO.setUniqueId(mbrSession.getUniqueId());
		mbrPointVO.setOrdrCd(gdsReviewVO.getOrdrCd());
		mbrPointVO.setPointSe("A");
		mbrPointVO.setPointCn("35");
		mbrPointVO.setPoint(200);
		if(pointVO != null) {
			mbrPointVO.setPointAcmtl(pointVO.getPointAcmtl() + 200);
		}else {
			mbrPointVO.setPointAcmtl(200);
		}
		mbrPointVO.setGiveMthd("SYS");
		mbrPointVO.setRegId(mbrSession.getMbrId());
		mbrPointVO.setRegUniqueId(mbrSession.getUniqueId());
		mbrPointVO.setRgtr(mbrSession.getMbrNm());


		switch(gdsReviewVO.getCrud()) {

		case CREATE:
			// 포토 && 일반 판별
			if(!fileMap.get("uploadFile").isEmpty()) {
				gdsReviewVO.setImgUseYn("Y");
				mbrPointVO.setPoint(500);
			}else {
				gdsReviewVO.setImgUseYn("N");
			}

			gdsReviewService.insertGdsReview(gdsReviewVO);

			fileService.creatFileInfo(fileMap, gdsReviewVO.getGdsReivewNo(), "REVIEW");

			mbrPointService.insertMbrPoint(mbrPointVO);

			javaScript.setMessage(getMsg("action.complete.insert"));
			javaScript.setLocation("/" + marketPath + "/mypage/review/doList");

			break;
		case UPDATE:

			// 첨부파일 수정
			String delAttachFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delAttachFileNo"));
			String[] arrDelAttachFile = delAttachFileNo.split(",");

			if (!EgovStringUtil.isEmpty(arrDelAttachFile[0])) {
				gdsReviewVO.setImgUseYn("N");
				fileService.deleteFilebyNo(arrDelAttachFile, gdsReviewVO.getGdsReivewNo(), "REVIEW", "UPLOAD");
			}

			fileService.creatFileInfo(fileMap, gdsReviewVO.getGdsReivewNo(), "REVIEW");

			if(!fileMap.get("uploadFile").isEmpty()) {
				gdsReviewVO.setImgUseYn("Y");
			}

			gdsReviewService.updateGdsReview(gdsReviewVO);

			javaScript.setMessage(getMsg("action.complete.update"));
			javaScript.setLocation("/" + marketPath + "/mypage/review/list");

			break;
		default:
			break;

		}

		return new JavaScriptView(javaScript);
	}



}
