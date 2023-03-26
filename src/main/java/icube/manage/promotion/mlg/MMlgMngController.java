package icube.manage.promotion.mlg;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.promotion.mlg.biz.MbrMlgService;
import icube.manage.promotion.mlg.biz.MbrMlgVO;
import icube.manage.promotion.mlg.biz.MlgMngService;
import icube.manage.promotion.mlg.biz.MlgMngVO;
import icube.manage.sysmng.mngr.biz.MngrSession;

/**
 * 관리자 마일리지
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="/_mng/promotion/mlgMng")
public class MMlgMngController extends CommonAbstractController {

	@Resource(name = "mlgMngService")
	private MlgMngService mlgMngService;

	@Resource(name = "mbrMlgService")
	private MbrMlgService mbrMlgService;

	@Autowired
	private MngrSession mngrSession;

	//private static String[] targetParams = {"curPage", "cntPerPage", "sortBy", "srchMlgSe","srchMlgCn","srchMngrMemo","srchBgngDt","srchEndDt"};


    /**
     * 마일리지 리스트
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = mlgMngService.mlgMngListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("mlgSeCode", CodeMap.POINT_SE);
		model.addAttribute("mlgCnCode", CodeMap.POINT_CN);

		return "/manage/promotion/mlg/list";
	}

	/**
	 * 마일리지 목록 엑셀
	 * @param request
	 * @param reqMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="mlgExcel")
	public String excelDownload(
			HttpServletRequest request
			, @RequestParam Map<String, Object> paramMap
			, Model model) throws Exception{

		List<MlgMngVO> itemList = mlgMngService.selectMlgMngListAll(paramMap);

		model.addAttribute("itemList", itemList);
		model.addAttribute("pointSeCode", CodeMap.POINT_SE);
		model.addAttribute("pointCnCode", CodeMap.POINT_CN);

		return "/manage/promotion/mlg/include/mlg_excel";
	}

	/**
	 * 마일리지 적립/차감
	 * @param mlgMngVO
	 * @param reqMap
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="form")
	public String form(
			MlgMngVO mlgMngVO
			, HttpServletRequest request
			, Model model) throws Exception{

		mlgMngVO.setCrud(CRUD.CREATE);
		model.addAttribute("mlgSeCode", CodeMap.POINT_SE);
		model.addAttribute("mlgCnCode", CodeMap.POINT_CN);

		return "/manage/promotion/mlg/form";
	}


	/**
	 * 마일리지 처리
	 * @param mlgMngVO
	 * @param reqMap
	 * @param multiReq
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="action")
	public View action(
			MlgMngVO mlgMngVO
			, @RequestParam Map<String,Object> reqMap
			, @RequestParam (value="arrUniqueId", required= true) String[] arrUniqueId
			) throws Exception {

		JavaScript javaScript = new JavaScript();
		//String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));


		// 관리자정보
		mlgMngVO.setRegUniqueId(mngrSession.getUniqueId());
		mlgMngVO.setRegId(mngrSession.getMngrId());
		mlgMngVO.setRgtr(mngrSession.getMngrNm());

		switch (mlgMngVO.getCrud()) {
			case CREATE:

				try {
					if(arrUniqueId.length > 0) {
						mlgMngService.insertMng(mlgMngVO, arrUniqueId);
					}else {
						javaScript.setMessage("대상 조회에 실패했습니다. 다시 시도해주세요");
						javaScript.setMethod("window.history.back()");
					}

					javaScript.setMessage(getMsg("action.complete.insert"));
					javaScript.setLocation("./list?");
				}catch(Exception e) {
					e.printStackTrace();
				}

				break;


			default:
				break;
		}

		return new JavaScriptView(javaScript);
	}

	/**
	 * 대상 회원 리스트 모달
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="searchTargetList.json")
	@SuppressWarnings({"unchecked","rawtypes"})
	public String searchTargetList(
			HttpServletRequest request
			, Model model
			, @RequestParam(value="mlgMngNo", required=true) int mlgMngNo
			) throws Exception {

		Map<String, Object> resultMap = new HashMap();

		// 1. 대상 정보
		MlgMngVO mlgMngVO = mlgMngService.selectMlgMng(mlgMngNo);


		// 2. 대상 회원 정보
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("srchMlgMngNo", mlgMngNo);

		List<MbrMlgVO> mbrList = mbrMlgService.selectMbrMlgList(paramMap);

		resultMap.put("pointMng", mlgMngVO);
		resultMap.put("mbrList", mbrList);



		model.addAttribute("resultMap", resultMap);
		model.addAttribute("pointCnCode", CodeMap.POINT_CN);
		model.addAttribute("pointSeCode", CodeMap.POINT_SE);

		return "/manage/promotion/include/mbr-target-modal";
	}



}
