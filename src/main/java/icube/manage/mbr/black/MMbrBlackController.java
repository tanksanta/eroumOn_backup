package icube.manage.mbr.black;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.util.StringUtil;
import icube.common.framework.abst.CommonAbstractController;
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
        	MbrVO vo;
        	for(ifor=0 ; ifor<ilen ; ifor++) {
        		vo = (MbrVO)listVO.getListObject().get(ifor);
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

	 @RequestMapping("excel")
		public String excelDownload(
				HttpServletRequest request
				, @RequestParam Map<String, Object> reqMap
				, Model model) throws Exception{

			reqMap.put("srchMngTy", "BLACK");
			reqMap.put("srchNmngSe", "NONE");
			List<MbrMngInfoVO> mbrList = mbrMngInfoService.selectMbrMngInfoListAll(reqMap);

			model.addAttribute("mbrList", mbrList);
			model.addAttribute("mngSeCode", CodeMap.MNG_SE_BLACK);
			model.addAttribute("genderCode", CodeMap.GENDER);
			model.addAttribute("resnCdCode", CodeMap.BLACK_RESN_CD);

			return "/manage/mbr/black/excel";
		}
}
