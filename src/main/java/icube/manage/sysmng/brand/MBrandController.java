package icube.manage.sysmng.brand;

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
import icube.common.util.WebUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.sysmng.brand.biz.BrandService;
import icube.manage.sysmng.brand.biz.BrandVO;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Controller
@RequestMapping(value="/_mng/sysmng/brand")
public class MBrandController extends CommonAbstractController {

	@Resource(name = "brandService")
	private BrandService brandService;

	@Resource(name="fileService")
	private FileService fileService;

	@Autowired
	private MngrSession mngrSession;

	private static String[] targetParams = {"curPage", "cntPerPage", "srchYn", "srchText", "sortBy"};

	/**
	 * 시스템 관리 > 브랜드 관리 > 리스트
	 */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = brandService.brandListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("useYn", CodeMap.USE_YN);

		return "/manage/sysmng/brand/list";
	}

	/**
	 * 시스템 관리 > 브랜드 관리 > 정보 작성
	 */
	@RequestMapping(value="form")
	public String form(
			BrandVO brandVO
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception{

		int brandNo = EgovStringUtil.string2integer((String) reqMap.get("brandNo"));

		if(brandNo == 0){
			brandVO.setCrud(CRUD.CREATE);
		}else{
			brandVO = brandService.selectBrand(brandNo);
			brandVO.setCrud(CRUD.UPDATE);
		}

		model.addAttribute("brandVO", brandVO);
		model.addAttribute("param", reqMap);
		model.addAttribute("useYn", CodeMap.USE_YN);

		return "/manage/sysmng/brand/form";
	}

	/**
	 * 시스템 관리 > 브랜드 관리 > 정보 처리
	 */
	@RequestMapping(value="action")
	public View action(
			BrandVO brandVO
			, @RequestParam Map<String,Object> reqMap
			, MultipartHttpServletRequest multiReq
			, HttpSession session) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));
		Map<String, MultipartFile> fileMap = multiReq.getFileMap();

		// 관리자정보
		brandVO.setRegUniqueId(mngrSession.getUniqueId());
		brandVO.setRegId(mngrSession.getMngrId());
		brandVO.setRgtr(mngrSession.getMngrNm());
		brandVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		brandVO.setMdfcnId(mngrSession.getMngrId());
		brandVO.setMdfr(mngrSession.getMngrNm());

		switch (brandVO.getCrud()) {
			case CREATE:

				brandService.insertBrand(brandVO);

				//첨부파일 등록
				fileService.creatFileInfo(fileMap,brandVO.getBrandNo(), "BRAND", reqMap);

				javaScript.setMessage(getMsg("action.complete.insert"));
				javaScript.setLocation("./list?" + pageParam);
				break;

			case UPDATE:

				// 첨부파일 수정
				String delAttachFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delAttachFileNo"));
				String[] arrDelAttachFile = delAttachFileNo.split(",");
				if (!EgovStringUtil.isEmpty(arrDelAttachFile[0])) {
					fileService.deleteFilebyNo(arrDelAttachFile, brandVO.getBrandNo(), "BRAND", "ATTACH");
				}

				// file upload & data insert
				fileService.creatFileInfo(fileMap, brandVO.getBrandNo(), "BRAND", reqMap);

				brandService.updateBrand(brandVO);

				javaScript.setMessage(getMsg("action.complete.update"));
				javaScript.setLocation(
					"./form?brandNo=" + brandVO.getBrandNo() + ("".equals(pageParam) ? "" : "&" + pageParam));
				break;

			default:
				break;
		}

		return new JavaScriptView(javaScript);
	}

	/**
	 * 시스템 관리 > 브랜드 관리 > 브랜드명 중복검사
	 *
	 * @author ogy
	 */
	@ResponseBody
	@RequestMapping(value = "ChkBrand.json")
	public boolean ChkDuplicate(@RequestParam(value = "nm", required = true) String brandNm,
			@RequestParam(value = "crud", required = true) String crud,
			@RequestParam(value = "no", required = true) int brandNo, HttpSession session) throws Exception {

		boolean result = false;

		BrandVO brandVO = brandService.selectBrandNm(brandNm);
		if (brandVO == null) {
			result = true;
		} else {
			return result;
		}
		return result;
	}

}
