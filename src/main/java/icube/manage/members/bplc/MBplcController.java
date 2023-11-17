package icube.manage.members.bplc;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCrypt;
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
import icube.common.mail.MailService;
import icube.common.util.CommonUtil;
import icube.common.util.FileUtil;
import icube.common.util.MapUtil;
import icube.common.util.RandomUtil;
import icube.common.util.ValidatorUtil;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.common.vo.DataTablesVO;
import icube.manage.members.bplc.biz.BplcService;
import icube.manage.members.bplc.biz.BplcVO;
import icube.manage.sysmng.mngr.biz.MngrSession;
import icube.manage.sysmng.mngr.biz.MngrVO;
import icube.members.stdg.biz.StdgCdService;
import icube.members.stdg.biz.StdgCdVO;

@Controller
@RequestMapping(value="/_mng/members/bplc")
public class MBplcController extends CommonAbstractController {

	@Resource(name = "bplcService")
	private BplcService bplcService;

	@Resource(name = "fileService")
	private FileService fileService;

	@Resource(name = "stdgCdService")
	private StdgCdService stdgCdService;

	@Autowired
	private MngrSession mngrSession;

	@Resource(name="mailService")
	private MailService mailService;

	@Value("#{props['Mail.Form.FilePath']}")
	private String mailFormFilePath;

	@Value("#{props['Mail.Username']}")
	private String sendMail;

	@Value("#{props['Mail.Testuser']}")
	private String mailTestuser;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;

	@Value("#{props['Globals.Server.Dir']}")
	private String serverDir;

	@Value("#{props['Globals.File.Upload.Dir']}")
	private String fileUploadDir;


	private static String[] targetParams = {"curPage", "cntPerPage", "srchBgngDt", "srchEndDt", "sortBy", "srchBplcId", "srchBplcNm", "srchRprsvNm", "srchBrno", "srchDspyYn", "srchUseYn"};

	//파트너 관리 리스트
	@RequestMapping(value="list")
	public String partnerlist(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("type", "C");
		listVO = bplcService.bplcListVO(listVO);


		model.addAttribute("listVO", listVO);
		model.addAttribute("aprvTy", CodeMap.APRV_TY);
		model.addAttribute("dspyYn", CodeMap.DSPY_YN);
		model.addAttribute("useYn", CodeMap.USE_YN);

		return "/manage/members/bplc/list";
	}

	// 파트너 관리 상세
	@RequestMapping(value="view")
	public String partnerview(
			@RequestParam(value="uniqueId", required=true) String uniqueId
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception{

			BplcVO bplcVO = bplcService.selectBplcByUniqueId(uniqueId);

			if (bplcVO == null) {
				model.addAttribute("alertMsg", getMsg("alert.author.common"));
				return "/common/msg";
			}

			model.addAttribute("bplcVO", bplcVO);

			model.addAttribute("aprvTyCode", CodeMap.APRV_TY);
			model.addAttribute("useYnCode", CodeMap.USE_YN);
			model.addAttribute("dspyYnCode", CodeMap.DSPY_YN);
			model.addAttribute("bankTyCode", CodeMap.BANK_TY);

			model.addAttribute("param", reqMap);

			return "/manage/members/bplc/view";
		}

	//파트너 관리 처리
	@RequestMapping(value="action")
	public View action(
			BplcVO bplcVO
			, MultipartHttpServletRequest multiReq
			, @RequestParam Map<String,Object> reqMap
			, HttpSession session) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));
		Map<String, MultipartFile> fileMap = multiReq.getFileMap();
		String profileImg = "";
		String bsnmCeregrt = "";
		String bsnmOffcs = "";


		// 관리자정보
		bplcVO.setRegUniqueId(mngrSession.getUniqueId());
		bplcVO.setRegId(mngrSession.getMngrId());
		bplcVO.setRgtr(mngrSession.getMngrNm());
		bplcVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		bplcVO.setMdfcnId(mngrSession.getMngrId());
		bplcVO.setMdfr(mngrSession.getMngrNm());

		switch (bplcVO.getCrud()) {
		/* 사용자 사용 예정
			case CREATE:

				bplcService.insertBplc(bplcVO);

				javaScript.setMessage(getMsg("action.complete.insert"));
				javaScript.setLocation("./list?" + pageParam);
				break;
		 */
			case UPDATE:

				// 대표이미지 삭제
				if (!fileMap.get("attachFile").isEmpty()) {
					profileImg = fileService.uploadFile(fileMap.get("attachFile"), serverDir.concat(fileUploadDir),
							"PROFL", fileMap.get("attachFile").getOriginalFilename());
					bplcVO.setProflImg(profileImg);
				} else if (EgovStringUtil.equals("Y", bplcVO.getDelProflImg())) {
					bplcVO.setProflImg(null);
				}

				// 사업등록증 삭제
				if (!fileMap.get("bsnmCeregrt1").isEmpty()) {
					bsnmCeregrt = fileService.uploadFile(fileMap.get("bsnmCeregrt1"), serverDir.concat(fileUploadDir),
							"CEREGRT", fileMap.get("bsnmCeregrt1").getOriginalFilename());
					bplcVO.setBsnmCeregrt(bsnmCeregrt);
				} else if (EgovStringUtil.equals("Y", bplcVO.getDelBsnmCeregrt())) {
					bplcVO.setBsnmCeregrt(null);
				}

				// 사업자 직인 삭제
				if (!fileMap.get("bsnmOffcs1").isEmpty()) {
					bsnmOffcs = fileService.uploadFile(fileMap.get("bsnmOffcs1"), serverDir.concat(fileUploadDir),
							"PROFL", fileMap.get("bsnmOffcs1").getOriginalFilename());
					bplcVO.setBsnmOffcs(bsnmOffcs);
				} else if (EgovStringUtil.equals("Y", bplcVO.getDelBsnmOffcs())) {
					bplcVO.setBsnmOffcs(null);
				}

				bplcService.updateBplc(bplcVO);

				javaScript.setMessage(getMsg("action.complete.update"));
				javaScript.setLocation("./view?uniqueId=" + bplcVO.getUniqueId() + ("".equals(pageParam) ? "" : "&" + pageParam));
				break;

			default:
				break;
		}

		return new JavaScriptView(javaScript);
	}


	/**
	 * 임시비밀번호 발송
	 * @param uniqueId
	 * @return true/false
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("sendRndPswd.json")
	public Map<String, Object> sendRndPswd(
			@RequestParam(value="uniqueId", required=true) String uniqueId
			, @RequestParam Map<String, Object> reqMap) throws Exception {

		boolean result = false;

		Map<String, Object> resultMap = new HashMap<String, Object>();

		BplcVO bplcVO = bplcService.selectBplcByUniqueId(uniqueId);

		//TO-DO : SMS전송으로 변경
		if(bplcVO != null) {

			String rndPswd = RandomUtil.getRandomPassword(10);
			String encPswd = BCrypt.hashpw(rndPswd, BCrypt.gensalt());

			bplcService.updateBplcPswd(uniqueId, encPswd);

			try {
				if(ValidatorUtil.isEmail(bplcVO.getPicEml())) {
					String MAIL_FORM = mailFormFilePath + "mail_sample.html";
					String mailForm = FileUtil.readFile(MAIL_FORM);

					mailForm = mailForm.replace("{rndPswd}", rndPswd);

					// 메일 발송
					String mailSj = "[이로움ON] 멤버스 임시비밀번호 입니다."; //TO-DO : message로 이동
					if(!EgovStringUtil.equals("local", activeMode)) {
						mailService.sendMail(sendMail, bplcVO.getPicEml(), mailSj, mailForm);
					} else {
						mailService.sendMail(sendMail, this.mailTestuser, mailSj, mailForm); //테스트
					}

					result = true;
				} else {
					log.debug("EMAIL 전송 실패 :: 이메일 체크 " + bplcVO.getPicEml());
					resultMap.put("reason", bplcVO.getPicEml());
				}
			} catch (Exception e) {
				log.debug("EMAIL 전송 실패 :: " + e.toString());
				resultMap.put("reason", e.toString());
			}
		}

		resultMap.put("result", result);

		return resultMap;
	}

	@RequestMapping("modalBplcSearch")
	public String gdsSearchModal(
			HttpServletRequest request
			, Model model) throws Exception{

		List<StdgCdVO> stdgCdList = stdgCdService.selectStdgCdListAll(1);

		model.addAttribute("stdgCdList", stdgCdList);

		return "/manage/members/bplc/include/modal-bplc-search";
	}


	//상품검색 datatable
	@SuppressWarnings("unchecked")
	@RequestMapping("bplcSearchList.json")
	@ResponseBody
	public DataTablesVO<MngrVO> gdsSearchList(
			@RequestParam(value="srchSido", required=false) String srchSido
			, @RequestParam(value="srchGugun", required=false) String srchGugun
			, @RequestParam(value="srchText", required=false) String srchText
			, @RequestParam(value="rcmdtnYn", required=false) String rcmdtnYn
			, @RequestParam(value="mbGiupMatching", required=false) String mbGiupMatching
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("srchUseYn", "Y");
		listVO.setParam("rcmdtnYn", rcmdtnYn);
		listVO.setParam("srchSido", srchSido);
		listVO.setParam("srchGugun", srchGugun);
		listVO.setParam("srchText", srchText);
		listVO.setParam("mbGiupMatching", mbGiupMatching);
		listVO = bplcService.bplcListVO(listVO);

		// DataTable
		DataTablesVO<MngrVO> dataTableVO = new DataTablesVO<MngrVO>();
		dataTableVO.setsEcho(MapUtil.getString(reqMap, "sEcho"));
		dataTableVO.setiTotalRecords(listVO.getTotalCount());
		dataTableVO.setiTotalDisplayRecords(listVO.getTotalCount());
		dataTableVO.setAaData(listVO.getListObject());

		return dataTableVO;
	}

}
