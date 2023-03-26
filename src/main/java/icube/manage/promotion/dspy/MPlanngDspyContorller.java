package icube.manage.promotion.dspy;

import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.util.HtmlUtils;

import icube.common.file.biz.FileService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.CommonUtil;
import icube.common.util.MapUtil;
import icube.common.util.StringUtil;
import icube.common.util.WebUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.common.vo.DataTablesVO;
import icube.manage.gds.gds.biz.GdsService;
import icube.manage.gds.gds.biz.GdsVO;
import icube.manage.promotion.dspy.biz.PlanngDspyGrpGdsService;
import icube.manage.promotion.dspy.biz.PlanngDspyGrpService;
import icube.manage.promotion.dspy.biz.PlanngDspyGrpVO;
import icube.manage.promotion.dspy.biz.PlanningDspyService;
import icube.manage.promotion.dspy.biz.PlanningDspyVO;
import icube.manage.sysmng.mngr.biz.MngrSession;

/**
 * 관리자 프로모션 기획전
 * @author ogy
 *
 */
@Controller
@RequestMapping(value = "/_mng/promotion/dspy")
public class MPlanngDspyContorller extends CommonAbstractController {

	@Resource(name = "planningDspyService")
	private PlanningDspyService planningDspySrv;

	@Resource(name = "planngDspyGrpService")
	private PlanngDspyGrpService pdgsService;

	@Resource(name = "planngDspyGrpGdsService")
	private PlanngDspyGrpGdsService pdgsGdsService;

	@Resource(name = "gdsService")
	private GdsService gdsService;

	@Resource(name = "fileService")
	private FileService fileService;

	@Autowired
	private MngrSession mngrSession;

	private static String[] targetParams = { "curPage", "cntPerPage", "srchYn", "srchText", "sortBy", "srchBgngDt", "srchEndDt" };

	/**
	 * 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "list")
	public String list(HttpServletRequest request, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = planningDspySrv.pDspyListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("dspyYn", CodeMap.DSPY_YN);

		return "/manage/promotion/dspy/list";
	}

	/**
	 * 정보 작성
	 * @param planningDspyVO
	 * @param reqMap
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "form")
	public String form(PlanningDspyVO planningDspyVO, @RequestParam Map<String, Object> reqMap,
			HttpServletRequest request, Model model) throws Exception {

		int planngDspyNo = EgovStringUtil.string2integer((String) reqMap.get("planningDspyNo"));

		if (planngDspyNo == 0) {
			planningDspyVO.setCrud(CRUD.CREATE);
		} else {
			//기획전 정보
			planningDspyVO = planningDspySrv.selectPdspy(planngDspyNo);
			planningDspyVO.setCrud(CRUD.UPDATE);

			//그룹 정보
			List <PlanngDspyGrpVO> dspyGrpList =  pdgsService.selectGrpList(planngDspyNo);
			model.addAttribute("dspyGrpList", dspyGrpList);
		}
		model.addAttribute("planningDspyVO", planningDspyVO);
		model.addAttribute("param", reqMap);
		model.addAttribute("dspyYnCode", CodeMap.DSPY_YN);
		//model.addAttribute("exhibiCo", CodeMap.EXHIBI_CO);  고정개수로 수정
		model.addAttribute("useYn", CodeMap.USE_YN);

		return "/manage/promotion/dspy/form";
	}

	/**
	 * 처리
	 * @param planningDspyVO
	 * @param reqMap
	 * @param request
	 * @param multiReq
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "action")
	public View action(PlanningDspyVO planningDspyVO, @RequestParam Map<String, Object> reqMap,
			HttpServletRequest request, MultipartHttpServletRequest multiReq, HttpSession session) throws Exception {

		JavaScript javaScript = new JavaScript();

		String pageParam = HtmlUtils
				.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));

		Map<String, MultipartFile> fileMap = multiReq.getFileMap();

		// 관리자정보
		planningDspyVO.setRegUniqueId(mngrSession.getUniqueId());
		planningDspyVO.setRegId(mngrSession.getMngrId());
		planningDspyVO.setRgtr(mngrSession.getMngrNm());
		planningDspyVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		planningDspyVO.setMdfcnId(mngrSession.getMngrId());
		planningDspyVO.setMdfr(mngrSession.getMngrNm());

		// 날짜 시간
		String Bdate = request.getParameter("bgngDt");
		String Btime = request.getParameter("bgngTime");
		String Edate = request.getParameter("endDt");
		String Etime = request.getParameter("endTime");

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date bgngDt = formatter.parse(Bdate + " " + Btime);
		Date endDt = formatter.parse(Edate + " " + Etime);

		planningDspyVO.setBgngDt(bgngDt);
		planningDspyVO.setEndDt(endDt);

		switch (planningDspyVO.getCrud()) {
		case CREATE:

			//정보 등록
			planningDspySrv.insertPdspy(planningDspyVO);

			 // 첨부파일
			fileService.creatFileInfo(fileMap, planningDspyVO.getPlanngDspyNo(), "DSPY", reqMap);

			 //상품 그룹	등록
			pdgsService.insertPlanngDspyGrp(reqMap,planningDspyVO);

			javaScript.setMessage(getMsg("action.complete.insert"));
			javaScript.setLocation("./list?" + pageParam);
			break;

		case UPDATE:

			// 첨부파일 삭제
			String delAttachFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delAttachFileNo"));
			String[] arrDelAttachFile = delAttachFileNo.split(",");
			if (!EgovStringUtil.isEmpty(arrDelAttachFile[0]))
				fileService.deleteFilebyNo(arrDelAttachFile, planningDspyVO.getPlanngDspyNo(), "DSPY", "ATTACH");

			// 첨부파일 등록
			fileService.creatFileInfo(fileMap, planningDspyVO.getPlanngDspyNo(), "DSPY", reqMap);

			// 업데이트
			planningDspySrv.updatePdspy(planningDspyVO);

			// 대체 텍스트
			String updtImgFileDc = WebUtil.clearSqlInjection((String) reqMap.get("updtImgFileDc"));

			if (!"".equals(updtImgFileDc)) {
				String[] arrUptImgFileDc = updtImgFileDc.split(",");
				for (String uptImgFileDcNm : arrUptImgFileDc) {
					String[] uptImgFileElm = uptImgFileDcNm.split("FileDc");
					fileService.updateFileDc("DSPY", planningDspyVO.getPlanngDspyNo(),
							StringUtil.nvl(uptImgFileElm[1], 0), "ATTACH", (String) reqMap.get(uptImgFileDcNm));
				}
			}

			//상품
			pdgsService.updatePlanngDspyGrp(reqMap,planningDspyVO);

			javaScript.setMessage(getMsg("action.complete.update"));
			javaScript.setLocation("./form?planningDspyNo=" + planningDspyVO.getPlanngDspyNo()
					+ ("".equals(pageParam) ? "" : "&" + pageParam));
			break;

		default:
			break;
		}
		return new JavaScriptView(javaScript);
	}

	/**
	 * 관리자 기획전 DATATABLE
	 * @param request
	 * @param reqMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("modalDspyList.json")
	@ResponseBody
	public  DataTablesVO<PlanningDspyVO> modalDspyList(
			HttpServletRequest request
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception{

		int gdsNo = EgovStringUtil.string2integer((String) request.getParameter("gdsNo"));

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("gdsNo", gdsNo);
		listVO = planningDspySrv.selectDspyListVO(listVO);

		// DataTable
		DataTablesVO<PlanningDspyVO> dataTableVO = new DataTablesVO<PlanningDspyVO>();
		dataTableVO.setsEcho(MapUtil.getString(reqMap, "sEcho"));
		dataTableVO.setiTotalRecords(listVO.getTotalCount());
		dataTableVO.setiTotalDisplayRecords(listVO.getTotalCount());
		dataTableVO.setAaData(listVO.getListObject());

		return	dataTableVO;
	}

	/**
	 * 상품코드 검색
	 * @param gdsNo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("modalTextGdsCd.json")
	@ResponseBody
	public GdsVO ModalTextGdsCd(
			@RequestParam(value="gdsNo", required=true) int gdsNo
			)throws Exception {

		GdsVO gdsVO = gdsService.selectGds(gdsNo);

		return gdsVO;
	}
}