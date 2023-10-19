package icube.manage.promotion.point;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.ExcelExporter;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.promotion.point.biz.MbrPointService;
import icube.manage.promotion.point.biz.MbrPointVO;
import icube.manage.promotion.point.biz.PointMngService;
import icube.manage.promotion.point.biz.PointMngVO;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Controller
@RequestMapping(value="/_mng/promotion/point")
public class MPointMngController extends CommonAbstractController {

	@Resource(name = "pointMngService")
	private PointMngService pointMngService;

	@Resource(name = "mbrPointService")
	private MbrPointService mbrPointService;

	@Autowired
	private MngrSession mngrSession;

    /**
     * 포인트 리스트
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value="list")
	public String history(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = pointMngService.pointMngListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("pointSeCode", CodeMap.POINT_SE);
		model.addAttribute("pointCnCode", CodeMap.POINT_CN);

		return "/manage/promotion/point/list";
	}

	/**
	 * 포인트 목록 엑셀
	 * @param request
	 * @param reqMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="pointExcel")
	public void excelDownload(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam Map<String, Object> paramMap
			, Model model) throws Exception{

		List<PointMngVO> itemList = pointMngService.selectPointMngListAll(paramMap);

		// excel data
        Map<String, Function<Object, Object>> mapping = new LinkedHashMap<>();
        mapping.put("번호", obj -> "rowNum");
        mapping.put("구분", obj -> "A".equals(((PointMngVO)obj).getPointSe())?"적립":"차감");
        mapping.put("내역", obj -> CodeMap.POINT_CN.get(((PointMngVO)obj).getPointCn()));
        mapping.put("관리자 메모", obj -> ((PointMngVO)obj).getMngrMemo());
        mapping.put("개별 포인트", obj -> String.format("%,d", ((PointMngVO)obj).getPoint()));
        mapping.put("대상 인원수", obj -> String.format("%,d", ((PointMngVO)obj).getTargetCnt()));
        mapping.put("총 포인트", obj -> String.format("%,d", ((PointMngVO)obj).getTargetCnt() * ((PointMngVO)obj).getPoint()) );
        mapping.put("처리자", obj -> ((PointMngVO)obj).getRgtr() + "(" + ((PointMngVO)obj).getRegId() + ")");
        mapping.put("처리일", obj -> new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(((PointMngVO)obj).getRegDt()));


        List<LinkedHashMap<String, Object>> dataList = new ArrayList<>();
        for (PointMngVO pointMngVO : itemList) {
 		    LinkedHashMap<String, Object> tempMap = new LinkedHashMap<>();
 		    for (String header : mapping.keySet()) {
 		        Function<Object, Object> extractor = mapping.get(header);
 		        if (extractor != null) {
 		            tempMap.put(header, extractor.apply(pointMngVO));
 		        }
 		    }
		    dataList.add(tempMap);
		}

		ExcelExporter exporter = new ExcelExporter();
		try {
			exporter.export(response, "포인트_목록", dataList, mapping);
		} catch (IOException e) {
		    e.printStackTrace();
 		}
	}


	/**
	 * 포인트 적립 / 차감
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="form")
	public String form(
			HttpServletRequest request
			, Model model
			, MbrPointVO mbrPointVO
			) throws Exception {

		mbrPointVO.setCrud(CRUD.CREATE);
		model.addAttribute("pointCnCode", CodeMap.POINT_CN);
		model.addAttribute("pointSeCode", CodeMap.POINT_SE);


		return "/manage/promotion/point/form";
	}

	/**
	 * 포인트 적립 && 차감
	 * @param pointMngVO
	 * @param reqMap
	 * @param multiReq
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="action")
	public View action(
			PointMngVO pointMngVO
			, @RequestParam Map<String,Object> reqMap
			, @RequestParam (value="arrUniqueId", required= true) String[] arrUniqueId
			, HttpSession session) throws Exception {

		JavaScript javaScript = new JavaScript();

		// 관리자정보
		pointMngVO.setRegUniqueId(mngrSession.getUniqueId());
		pointMngVO.setRegId(mngrSession.getMngrId());
		pointMngVO.setRgtr(mngrSession.getMngrNm());

		switch (pointMngVO.getCrud()) {
			case CREATE:

				try {
					if(arrUniqueId.length > 0) {
						pointMngService.insertPoint(pointMngVO, arrUniqueId);
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
			, @RequestParam(value="pointMngNo", required=true) int pointMngNo
			) throws Exception {

		Map<String, Object> resultMap = new HashMap();

		// 1. 대상 정보
		PointMngVO pointMngVO = pointMngService.selectPointMng(pointMngNo);

		// 2. 대상 회원 정보
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("srchPointMngNo", pointMngNo);

		List<MbrPointVO> mbrList = mbrPointService.selectMbrPointList(paramMap);

		resultMap.put("pointMng", pointMngVO);
		resultMap.put("mbrList", mbrList);

		model.addAttribute("resultMap", resultMap);
		model.addAttribute("pointCnCode", CodeMap.POINT_CN);
		model.addAttribute("pointSeCode", CodeMap.POINT_SE);

		return "/manage/promotion/include/mbr-target-modal";
	}


}
