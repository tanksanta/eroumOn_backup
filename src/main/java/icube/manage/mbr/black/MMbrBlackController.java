package icube.manage.mbr.black;

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

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.util.StringUtil;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.ExcelExporter;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.mbr.mbr.biz.MbrMngInfoService;
import icube.manage.mbr.mbr.biz.MbrMngInfoVO;
import icube.manage.mbr.mbr.biz.MbrVO;

@Controller
@RequestMapping(value="/_mng/mbr/black")
public class MMbrBlackController extends CommonAbstractController{

	@Resource(name = "mbrMngInfoService")
	private MbrMngInfoService mbrMngInfoService;

	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model
			) throws Exception{

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("srchMngTy", "BLACK");
		listVO.setParam("srchNmngSe", "NONE");
		listVO = mbrMngInfoService.selectMbrMngInfoListVO(listVO);

		if (listVO.getListObject() != null && !listVO.getListObject().isEmpty()) {
        	int ifor, ilen = listVO.getListObject().size();
        	MbrMngInfoVO vo;
        	for(ifor=0 ; ifor<ilen ; ifor++) {
        		vo = (MbrMngInfoVO)listVO.getListObject().get(ifor);
                vo.setMbrNm(StringUtil.nameMasking(vo.getMbrNm()));
				vo.setMblTelno(StringUtil.phoneMasking(vo.getMblTelno()));
        	}
        }

		model.addAttribute("listVO", listVO);
		model.addAttribute("mngSeCode", CodeMap.MNG_SE_BLACK);
		model.addAttribute("genderCode", CodeMap.GENDER);
		model.addAttribute("resnCdCode", CodeMap.BLACK_RESN_CD);
		model.addAttribute("mbrJoinTy", CodeMap.MBR_JOIN_TY2);

		return "/manage/mbr/black/list";
	}

	/**
	 * 변경 내역 모달
	 */
	@RequestMapping(value="mbrMngInfoList.json")
	@SuppressWarnings({"rawtypes","unchecked"})
	public String mbrMngInfoBlackList(
			HttpServletRequest request
			, Model model
			, @RequestParam(value="uniqueId", required=true) String uniqueId
			)throws Exception{

		Map<String, Object> paramMap = new HashMap();
		paramMap.put("srchUniqueId", uniqueId);
		paramMap.put("srchMngTy", "WARNING");

		// 경고내역
		List<MbrMngInfoVO> warnList = mbrMngInfoService.selectMbrMngInfoListAll(paramMap);

		// 정지, 해제 내역
		paramMap.put("srchMngTy", "BLACK");
		List<MbrMngInfoVO> blackList = mbrMngInfoService.selectMbrMngInfoListAll(paramMap);

		model.addAttribute("mdfrList", warnList);
		model.addAttribute("blackList", blackList);
		model.addAttribute("resnCdCode", CodeMap.RESN_CD);
		model.addAttribute("blackResnCdCode", CodeMap.BLACK_RESN_CD);
		model.addAttribute("warningCode", CodeMap.MNG_SE_WARNING);
		model.addAttribute("blackCode", CodeMap.MNG_SE_BLACK);

		return "/manage/mbr/manage/include/mng_info_modal";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("excel")
	public void excelDownload(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception{

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("srchMngTy", "BLACK");
		listVO.setParam("srchNmngSe", "NONE");
		listVO = mbrMngInfoService.selectMbrMngInfoListVO(listVO);
		
		List<MbrMngInfoVO> mbrList = (List<MbrMngInfoVO>)listVO.getListObject();

		
		// excel data
        Map<String, Function<Object, Object>> mapping = new LinkedHashMap<>();
        mapping.put("번호", obj -> "rowNum");
        mapping.put("회원아이디", obj -> ((MbrMngInfoVO)obj).getMbrId());
        mapping.put("회원이름", obj -> ((MbrMngInfoVO)obj).getMbrNm());
        mapping.put("성별", obj -> CodeMap.GENDER.get(((MbrMngInfoVO)obj).getGender()));

        mapping.put("이메일", obj -> ((MbrMngInfoVO)obj).getEml());
        mapping.put("휴대폰번호", obj -> ((MbrMngInfoVO)obj).getMblTelno());
        mapping.put("블랙리스트 유형", obj -> CodeMap.MNG_SE_BLACK.get( ((MbrMngInfoVO)obj).getMngSe()) );
        mapping.put("사유", obj -> CodeMap.BLACK_RESN_CD.get(((MbrMngInfoVO)obj).getResnCd()));
        mapping.put("블랙리스트 처리일", obj -> new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(((MbrMngInfoVO)obj).getRegDt()));


        List<LinkedHashMap<String, Object>> dataList = new ArrayList<>();

        for (MbrMngInfoVO mbrMngInfoVO : mbrList) {
 		    LinkedHashMap<String, Object> tempMap = new LinkedHashMap<>();
 		    for (String header : mapping.keySet()) {
 		        Function<Object, Object> extractor = mapping.get(header);
 		        if (extractor != null) {
 		            tempMap.put(header, extractor.apply(mbrMngInfoVO));
 		        }
 		    }
		    dataList.add(tempMap);
		}

		ExcelExporter exporter = new ExcelExporter();
		try {
			exporter.export(response, "블랙리스트_회원목록", dataList, mapping);
		} catch (IOException e) {
		    e.printStackTrace();
 		}

	}
}
