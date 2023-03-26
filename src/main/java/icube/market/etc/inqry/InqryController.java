package icube.market.etc.inqry;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import icube.common.file.biz.FileService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.WebUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.consult.biz.MbrInqryService;
import icube.manage.consult.biz.MbrInqryVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.ordr.ordr.biz.OrdrService;
import icube.market.mbr.biz.MbrSession;

/**
 * 고객센터 1:1 문의
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/etc/inqry")
public class InqryController extends CommonAbstractController{

	@Resource(name="mbrInqryService")
	private MbrInqryService inqryService;

	@Resource(name="fileService")
	private FileService fileService;

	@Resource(name="ordrService")
	private OrdrService ordrService;

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	/**
	 * 회원 주문 폼
	 * @param request
	 * @param model
	 * @param mbrInqryVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="form")
	public String form(
			HttpServletRequest request
			, Model model
			, @RequestParam Map<String, Object> reqMap
			, MbrInqryVO mbrInqryVO
			)throws Exception {

		if(!mbrSession.isLoginCheck()) {
			return "redirect:/" + marketPath + "/login";
		}

		// 회원 휴대폰, 이메일 정보
		MbrVO mbrVO = mbrService.selectMbrByUniqueId(mbrSession.getUniqueId());

		int inqryNo = EgovStringUtil.string2integer((String) reqMap.get("inqryNo"));

		if(inqryNo == 0){
			mbrInqryVO.setCrud(CRUD.CREATE);
		}else{
			mbrInqryVO = inqryService.selectMbrInqry(inqryNo);
			mbrInqryVO.setCrud(CRUD.UPDATE);
		}

		model.addAttribute("inqryTy1", CodeMap.INQRY_TY_NO1);
		model.addAttribute("inqryTy2", CodeMap.INQRY_TY_NO2);
		model.addAttribute("mbrInqryVO", mbrInqryVO);
		model.addAttribute("mbrVO", mbrVO);

		return "/market/etc/inqry/form";
	}

	/**
	 * 주문 모달
	 * @param request
	 */
	@RequestMapping(value="modalOrdrSearch")
	public String modalOrdrSearch(
			HttpServletRequest request
			, Model model
			)throws Exception {

		CommonListVO listVO = new CommonListVO(request, 1, 1 );
		listVO.setParam("srchUniqueId", mbrSession.getUniqueId());
		listVO.setParam("ordrSttsTy", "ALL");
		listVO = ordrService.ordrListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);

		return "/market/etc/include/modal-search-ordr";
	}

	/**
	 * 주문 모달 리스트
	 * @param request
	 */
	@RequestMapping(value="modalOrdrList")
	public String modalOrdrList(
			HttpServletRequest request
			, Model model
			) throws Exception {

		CommonListVO listVO = new CommonListVO(request,EgovStringUtil.string2integer(request.getParameter("curPage")), 1);
		listVO.setParam("srchUniqueId", mbrSession.getUniqueId());
		listVO.setParam("ordrSttsTy", "ALL");
		listVO = ordrService.ordrListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);

		return "/market/etc/include/modal-ordr-list";
	}

	/**
	 * 회원 문의 정보 처리
	 * @param mbrInqryVO
	 * @param reqMap
	 * @param multiReq
	 * @param session
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="action")
	public View action(
			MbrInqryVO mbrInqryVO
			, @RequestParam Map<String,Object> reqMap
			, MultipartHttpServletRequest multiReq
			, HttpSession session
			, HttpServletRequest request) throws Exception {

		JavaScript javaScript = new JavaScript();
		Map<String, MultipartFile> fileMap = multiReq.getFileMap();

		// 사용자정보
		mbrInqryVO.setRegUniqueId(mbrSession.getUniqueId());
		mbrInqryVO.setRegId(mbrSession.getMbrId());
		mbrInqryVO.setRgtr(mbrSession.getMbrNm());
		mbrInqryVO.setMdfcnUniqueId(mbrSession.getUniqueId());
		mbrInqryVO.setMdfcnId(mbrSession.getMbrId());
		mbrInqryVO.setMdfr(mbrSession.getMbrNm());

		//알림 서비스
		mbrInqryVO.setSmsAnsYn((String)reqMap.get("telnoChk"));
		mbrInqryVO.setEmlAnsYn((String)reqMap.get("emlChk"));

		switch (mbrInqryVO.getCrud()) {
			case CREATE:

				//정보 등록
				inqryService.insertMbrInqry(mbrInqryVO);

				//첨부파일 등록
				fileService.creatFileInfo(fileMap, mbrInqryVO.getInqryNo(), "INQRY");

				javaScript.setMessage(getMsg("action.complete.insert"));
				javaScript.setLocation("./form");
				break;

			case UPDATE:

				// 첨부파일 수정
				String delAttachFileNo = WebUtil.clearSqlInjection((String) reqMap.get("delAttachFileNo"));
				String[] arrDelAttachFile = delAttachFileNo.split(",");
				if (!EgovStringUtil.isEmpty(arrDelAttachFile[0])) {
					fileService.deleteFilebyNo(arrDelAttachFile, mbrInqryVO.getInqryNo(), "INQRY", "ATTACH");
				}

				// file upload & data insert
				fileService.creatFileInfo(fileMap, mbrInqryVO.getInqryNo(), "INQRY");

				// 정보 수정
				inqryService.updateMbrInqry(mbrInqryVO);

				javaScript.setMessage(getMsg("action.complete.update"));
				javaScript.setLocation(
						"./form?inqryNo=" + mbrInqryVO.getInqryNo());
				break;

				default:
					break;

			}
			return new JavaScriptView(javaScript);
		}



}
