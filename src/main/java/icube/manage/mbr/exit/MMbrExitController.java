package icube.manage.mbr.exit;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.util.StringUtil;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.ExcelExporter;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;

@Controller
@RequestMapping(value="/_mng/mbr/exit")
public class MMbrExitController extends CommonAbstractController{

	@Resource(name = "mbrService")
	private MbrService mbrService;


	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model
			) throws Exception{

		CommonListVO listVO = new CommonListVO(request);

		listVO.setParam("srchWhdwlYn", "Y");
		listVO.setParam("srchMbrStts", "EXIT");
		listVO = mbrService.mbrListVO(listVO);

		if (listVO.getListObject() != null && !listVO.getListObject().isEmpty()) {
        	int ifor, ilen = listVO.getListObject().size();
        	MbrVO vo;
        	for(ifor=0 ; ifor<ilen ; ifor++) {
        		vo = (MbrVO)listVO.getListObject().get(ifor);
                vo.setMbrNm(StringUtil.nameMasking(vo.getMbrNm()));
        	}
        }

		model.addAttribute("listVO", listVO);
		model.addAttribute("exitTyCode", CodeMap.EXIT_TY);
		model.addAttribute("authResnCode", CodeMap.AUTH_RESN_CD);
		model.addAttribute("norResnCode", CodeMap.NOR_RESN_CD);
		model.addAttribute("mbrJoinTy", CodeMap.MBR_JOIN_TY2);

		return "/manage/mbr/exit/list";
	}

	/**
	 * 탈퇴 회원 확인
	 */
	@RequestMapping(value="exitConfirm.json")
	@ResponseBody
	public boolean exitConfirm(
			@RequestParam(value="uniqueId", required=true) String uniqueId
			)throws Exception{

		boolean result = false;

		MbrVO mbrVO = mbrService.selectMbrByUniqueId(uniqueId);
		if(!mbrVO.getWhdwlYn().equals("Y")) {
			result = true;
		}

		return result;
	}

	@RequestMapping("excel")
	public void excelDownload(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception {


		reqMap.put("srchWhdwlYn", "Y");
		reqMap.put("srchMbrStts", "EXIT");
		List<MbrVO> mbrList = mbrService.selectMbrListAll(reqMap);

		// excel data
        Map<String, Function<Object, Object>> mapping = new LinkedHashMap<>();
        mapping.put("번호", obj -> "rowNum");
        mapping.put("아이디", obj -> ((MbrVO)obj).getMbrId());
        mapping.put("회원이름", obj -> ((MbrVO)obj).getMbrNm());

        mapping.put("탈퇴일", obj -> new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(((MbrVO)obj).getWhdwlDt()));
        mapping.put("탈퇴유형", obj -> CodeMap.EXIT_TY.get( ((MbrVO)obj).getWhdwlTy() ));
        mapping.put("탈퇴사유", obj -> {
        	String resn = "";
        	if(((MbrVO)obj).getWhdwlTy().equals("AUTHEXIT") && EgovStringUtil.isEmpty(((MbrVO)obj).getWhdwlEtc()) ) {
        		resn = CodeMap.AUTH_RESN_CD.get( ((MbrVO)obj).getWhdwlEtc());
        	}else if(((MbrVO)obj).getWhdwlTy().equals("AUTHEXIT") && EgovStringUtil.isNotEmpty(((MbrVO)obj).getWhdwlEtc()) ) {
        		resn = ((MbrVO)obj).getWhdwlEtc();
        	}else if(((MbrVO)obj).getWhdwlTy().equals("NORMAL") ) {
        		resn = CodeMap.NOR_RESN_CD.get( ((MbrVO)obj).getWhdwlResn());
        	}
        	return resn;
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
			exporter.export(response, "탈퇴_회원목록", dataList, mapping);
		} catch (IOException e) {
		    e.printStackTrace();
 		}

	}

}
