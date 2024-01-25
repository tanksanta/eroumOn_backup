package icube.manage.mbr.human;

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

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.ExcelExporter;
import icube.common.util.StringUtil;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;

/**
 * 관리자 > 회원 > 휴면회원관리
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="/_mng/mbr/human")
public class MMbrHumanContoller extends CommonAbstractController{

	@Resource(name = "mbrService")
	private MbrService mbrService;

	/**
	 * 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model)throws Exception {

		CommonListVO listVO = new CommonListVO(request);

		listVO.setParam("srchMbrSttus","HUMAN");
		listVO = mbrService.mbrListVO(listVO);

		if (listVO.getListObject() != null && !listVO.getListObject().isEmpty()) {
        	int ifor, ilen = listVO.getListObject().size();
        	MbrVO vo;
        	for(ifor=0 ; ifor<ilen ; ifor++) {
        		vo = (MbrVO)listVO.getListObject().get(ifor);
                vo.setMbrNm(StringUtil.nameMasking(vo.getMbrNm()));
				vo.setMblTelno(StringUtil.phoneMasking(vo.getMblTelno()));
        	}
        }

		model.addAttribute("listVO", listVO);
		model.addAttribute("gender", CodeMap.GENDER);
		model.addAttribute("mbrJoinTy", CodeMap.MBR_JOIN_TY2);

		return "/manage/mbr/human/list";
	}

	@RequestMapping("excel")
	public void excelDownload(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception {

		reqMap.put("srchMbrSttus","HUMAN");
		List<MbrVO> mbrList = mbrService.selectMbrListAll(reqMap);

		// excel data
        Map<String, Function<Object, Object>> mapping = new LinkedHashMap<>();
        mapping.put("번호", obj -> "rowNum");
        mapping.put("회원코드", obj -> ((MbrVO)obj).getUniqueId());
        mapping.put("회원이름", obj -> ((MbrVO)obj).getMbrNm());
        mapping.put("성별", obj -> CodeMap.GENDER.get(((MbrVO)obj).getGender()));

        mapping.put("이메일", obj -> ((MbrVO)obj).getEml());
        mapping.put("휴대폰번호", obj -> ((MbrVO)obj).getMblTelno());
        mapping.put("휴면처리일", obj -> new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(((MbrVO)obj).getMdfcnDt()));

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
			exporter.export(response, "휴면_회원목록", dataList, mapping);
		} catch (IOException e) {
		    e.printStackTrace();
 		}

	}
}
