package icube.manage.mbr.exit;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
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
                vo.setMbrNm(icube.common.util.StringUtil.nameMasking(vo.getMbrNm()));
        	}
        }

		model.addAttribute("listVO", listVO);
		model.addAttribute("exitTyCode", CodeMap.EXIT_TY);
		model.addAttribute("authResnCode", CodeMap.AUTH_RESN_CD);
		model.addAttribute("norResnCode", CodeMap.NOR_RESN_CD);

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

		// 20221113 kkm, 무슨 기능인지 확인 못했으나 > 오류방지 수정

		MbrVO mbrVO = mbrService.selectMbrByUniqueId(uniqueId);
		if(!mbrVO.getWhdwlYn().equals("Y")) {
			result = true;
		}

		return result;
	}

	@RequestMapping("excel")
	public String excelDownload(HttpServletRequest request
			, @RequestParam Map<String, Object> reqMap
			, Model model)
			throws Exception {


		reqMap.put("srchWhdwlYn", "Y");
		reqMap.put("srchMbrStts", "EXIT");
		List<MbrVO> mbrList = mbrService.selectMbrListAll(reqMap);

		model.addAttribute("mbrList", mbrList);
		model.addAttribute("exitTyCode", CodeMap.EXIT_TY);
		model.addAttribute("authResnCode", CodeMap.AUTH_RESN_CD);
		model.addAttribute("norResnCode", CodeMap.NOR_RESN_CD);

		return "/manage/mbr/exit/excel";	}

}
