package icube.manage.mbr.human;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
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
                vo.setMbrNm(icube.common.util.StringUtil.nameMasking(vo.getMbrNm()));
				vo.setMblTelno(icube.common.util.StringUtil.phoneMasking(vo.getMblTelno()));
        	}
        }

		model.addAttribute("listVO", listVO);
		model.addAttribute("gender", CodeMap.GENDER);

		return "/manage/mbr/human/list";
	}

	@RequestMapping("excel")
	public String excelDownload(HttpServletRequest request
			, @RequestParam Map<String, Object> reqMap
			, Model model)
			throws Exception {

		reqMap.put("srchMbrSttus","HUMAN");
		List<MbrVO> mbrList = mbrService.selectMbrListAll(reqMap);

		model.addAttribute("mbrList", mbrList);
		model.addAttribute("gender", CodeMap.GENDER);

		return "/manage/mbr/human/excel";
	}
}
