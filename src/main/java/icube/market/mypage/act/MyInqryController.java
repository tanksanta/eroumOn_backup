package icube.market.mypage.act;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import icube.common.file.biz.FileService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.HtmlUtil;
import icube.common.util.WebUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.consult.biz.MbrInqryService;
import icube.manage.consult.biz.MbrInqryVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 마이페이지 > 쇼핑활동 > 1:1문의
 */

@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/mypage/inqry")
public class MyInqryController extends CommonAbstractController {

	@Resource(name="mbrInqryService")
	private MbrInqryService inqryService;

	@Resource(name="fileService")
	private FileService fileService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	/**
	 * 1:1 문의 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="list")
	@SuppressWarnings("unchecked")
	public String list(
			HttpServletRequest request
			, Model model
			) throws Exception{

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("uniqueId", mbrSession.getUniqueId());
		listVO.setParam("srchUseYn", "Y");
		listVO = inqryService.mbrInqryListVO(listVO);

		// 답변 내용 태그 처리
		List<MbrInqryVO> inqryList = listVO.getListObject();
		for(MbrInqryVO mbrInqryVO : inqryList) {
			mbrInqryVO.setAnsCn(HtmlUtil.clean(mbrInqryVO.getAnsCn()));
		}

		model.addAttribute("listVO", listVO);
		model.addAttribute("inqryTyCode", CodeMap.INQRY_TY_NO1);

		return "/market/mypage/inqry/list";
	}

	/**
	 * 1:1 문의 작성
	 * @param request
	 * @param model
	 * @param inqryVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="form")
	public String form(
			HttpServletRequest request
			, Model model
			, MbrInqryVO inqryVO
			, @RequestParam Map<String, Object> reqMap
			) throws Exception{

		int inqryNo = EgovStringUtil.string2integer((String)reqMap.get("inqryNo"));

		if(inqryNo == 0) {
			inqryVO.setCrud(CRUD.CREATE);
		}else {
			inqryVO = inqryService.selectMbrInqry(inqryNo);
			inqryVO.setCrud(CRUD.UPDATE);
		}

		model.addAttribute("inqryVO", inqryVO);
		model.addAttribute("inqryTy1Code", CodeMap.INQRY_TY_NO1);
		model.addAttribute("inqryTy2Code", CodeMap.INQRY_TY_NO2);

		return "/market/mypage/inqry/form";
	}

	/**
	 * 1:1문의 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="action")
	public View action(
			HttpServletRequest request
			, Model mode
			, MbrInqryVO inqryVO
			, MultipartHttpServletRequest multiReq
			, @RequestParam Map<String, Object> reqMap
			, @RequestParam (value="telnoChk", required=false) String telnoChk
			, @RequestParam (value="emlChk", required=false) String emlChk
			) throws Exception{

		JavaScript javaScript = new JavaScript();
		Map<String, MultipartFile> fileMap = multiReq.getFileMap();

		//사용자 정보
		inqryVO.setRegUniqueId(mbrSession.getUniqueId());
		inqryVO.setRegId(mbrSession.getMbrId());
		inqryVO.setRgtr(mbrSession.getMbrNm());
		inqryVO.setMdfcnUniqueId(mbrSession.getUniqueId());
		inqryVO.setMdfcnId(mbrSession.getMbrId());
		inqryVO.setMdfr(mbrSession.getMbrNm());

		//답변 여부
		inqryVO.setSmsAnsYn(telnoChk);
		inqryVO.setEmlAnsYn(emlChk);

		switch (inqryVO.getCrud()) {
			case CREATE:

				inqryService.insertMbrInqry(inqryVO);

				fileService.creatFileInfo(fileMap, inqryVO.getInqryNo(), "INQRY");

				javaScript.setMessage(getMsg("action.complete.insert"));
				javaScript.setLocation("/" + marketPath + "/mypage/inqry/list");
				break;

			case UPDATE:

				// 첨부파일 수정
				String delAttachFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delAttachFileNo"));
				String[] arrDelAttachFile = delAttachFileNo.split(",");
				if (!EgovStringUtil.isEmpty(arrDelAttachFile[0])) {
					fileService.deleteFilebyNo(arrDelAttachFile, inqryVO.getInqryNo(), "INQRY", "ATTACH");
				}

				// file upload & data insert
				fileService.creatFileInfo(fileMap, inqryVO.getInqryNo(), "INQRY");

				// 정보 수정
				inqryService.updateMbrInqry(inqryVO);

				javaScript.setMessage(getMsg("action.complete.update"));
				javaScript.setLocation("/"+ marketPath +"/mypage/inqry/list");

				break;

			default:
				break;
		}

		return new JavaScriptView(javaScript);

	}

	/**
	 * 1:1문의 상세
	 * @param request
	 * @param model
	 * @param inqryNo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="view")
	public String view(
			HttpServletRequest request
			, Model model
			, @RequestParam(value="inqryNo", required=true) int inqryNo
			) throws Exception {

		MbrInqryVO inqryVO = inqryService.selectMbrInqry(inqryNo);

		model.addAttribute("inqryVO", inqryVO);
		model.addAttribute("inqryTyCode", CodeMap.INQRY_TY_NO1);
		model.addAttribute("inqryDtlTyCode", CodeMap.INQRY_TY_NO2);

		return "/market/mypage/inqry/view";
	}

	/**
	 * 1:1문의 삭제
	 * @param request
	 * @param inqryNo
	 * @return
	 */
	@RequestMapping(value="deleteInqry.json")
	@ResponseBody
	public boolean deleteInqry(
			HttpServletRequest request
			, @RequestParam (value="inqryNo", required=true) int inqryNo) {

		boolean result = false;

		try{
			inqryService.deleteInqry(inqryNo);
			result = true;
		}catch(Exception e){
			e.printStackTrace();
			log.debug("INQRY DELETE ERROR");
		}

		return result;
	}
}
