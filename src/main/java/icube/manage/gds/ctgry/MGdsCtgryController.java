package icube.manage.gds.ctgry;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import icube.common.file.biz.FileService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CodeMap;
import icube.manage.gds.ctgry.biz.GdsCtgryService;
import icube.manage.gds.ctgry.biz.GdsCtgryVO;


@Controller
@RequestMapping(value="/_mng/gds/ctgry")
public class MGdsCtgryController extends CommonAbstractController {

	@Resource(name = "gdsCtgryService")
	private GdsCtgryService gdsCtgryService;

	@Resource(name = "fileService")
	private FileService fileService;

	@Value("#{props['Globals.Server.Dir']}")
	private String serverDir;

	@Value("#{props['Globals.File.Upload.Dir']}")
	private String fileUploadDir;

	@RequestMapping(value="form")
	public String form(
			GdsCtgryVO gdsCtgryVO
			, HttpServletRequest request
			, Model model) throws Exception{

		model.addAttribute("useYnCode", CodeMap.USE_YN);
		model.addAttribute("gdsCtgryVO", gdsCtgryVO);

		return "/manage/gds/ctgry/form";
	}


	@RequestMapping(value={"action.json"})
	@ResponseBody
	public Map<String, Object> action(
			GdsCtgryVO gdsCtgryVO
			, HttpSession session
			, @RequestParam Map<String, Object> reqMap
			) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();

		boolean result = false;

		switch (gdsCtgryVO.getCrud()) {
		case CREATE:
			gdsCtgryService.insertGdsCtgry(gdsCtgryVO);

			result = true;
			resultMap.put("msg", getMsg("action.complete.insert"));
			break;

		case UPDATE:
			gdsCtgryService.updateGdsCtgry(gdsCtgryVO);

			result = true;
			resultMap.put("msg", getMsg("action.complete.update"));
			break;

		case DELETE:
			gdsCtgryService.deleteGdsCtgry(gdsCtgryVO);

			result = true;
			resultMap.put("msg", getMsg("action.complete.delete"));
			break;

		default:
			break;
		}

		resultMap.put("result", result);

		return resultMap;
	}


	@ResponseBody
	@RequestMapping("setNewGdsCtgry.json")
	public Map<String, Object> setNewMenu(
			GdsCtgryVO gdsCtgryVO
			, @RequestParam Map<String, String> reqMap
			, HttpServletRequest request
			, HttpSession session) throws Exception {

		Map<String, Object> resMap = new HashMap<String, Object>();

		gdsCtgryService.insertGdsCtgry(gdsCtgryVO);

		resMap.put("oldNo", reqMap.get("id"));
		resMap.put("vo", gdsCtgryVO);

		return resMap;
	}


	@ResponseBody
	@RequestMapping("setGdsCtgryNm.json")
	public Map<String, Object> setMenuName(
			@RequestParam(required = true) int ctgryNo
			, @RequestParam(required = false) int upCtgryNo
			, @RequestParam(required = true) String ctgryNm
			, HttpServletRequest request) throws Exception {

		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put("ctgryNo", ctgryNo);
		resMap.put("upCtgryNo", upCtgryNo);
		resMap.put("ctgryNm", ctgryNm);

		int result = gdsCtgryService.updateGdsCtgryNm(resMap);
		resMap.put("result", result == 1);
		return resMap;
	}


	@ResponseBody
	@RequestMapping("moveGdsCtgry.json")
	public Map<String, Object> moveMenu(
			@RequestParam(required = true) int ctgryNo
			, @RequestParam(required = true) int upCtgryNo
			, @RequestParam(required = true) int sortNo
			, @RequestParam(required = true) int levelNo
			, @RequestParam(required = true) String sortSeq
			, HttpServletRequest request) throws Exception {

		GdsCtgryVO gdsCtgryVO = new GdsCtgryVO();
		gdsCtgryVO.setCtgryNo(ctgryNo);
		gdsCtgryVO.setUpCtgryNo(upCtgryNo);
		gdsCtgryVO.setSortNo(sortNo);
		gdsCtgryVO.setLevelNo(levelNo);

		boolean ok = false;
		try {
			gdsCtgryService.moveGdsCtgry(gdsCtgryVO, sortSeq);
			ok = true;
		} catch (Exception e) {
			log.debug(e.getMessage());
		}

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("result", ok);

		return result;
	}


	@RequestMapping("getGdsCtgry.json")
	public GdsCtgryVO getGdsCtgry(
			@RequestParam(required = true, value="upCtgryNo") int upCtgryNo
			, @RequestParam(required = true, value="ctgryNo") int ctgryNo) throws Exception{

		GdsCtgryVO gdsCtgryVO = gdsCtgryService.selectGdsCtgry(upCtgryNo, ctgryNo);

		return gdsCtgryVO;
	}

	@ResponseBody
	@RequestMapping("getGdsCtgryList.json")
	public List<GdsCtgryVO> getGdsCtgryList(
			HttpServletRequest request) throws Exception {

		List<GdsCtgryVO> gdsCtgryList = gdsCtgryService.selectGdsCtgryListForMng();

		return gdsCtgryList;
	}

	@ResponseBody
	@RequestMapping("getGdsCtgryListByFilter.json")
	public Map<Integer, String> getGdsCtgryListByFilter(
			@RequestParam(required = true, value="upCtgryNo") int upCtgryNo
			, HttpServletRequest request) throws Exception {

		Map<Integer, String> gdsCtgryList = gdsCtgryService.selectGdsCtgryListToMap(upCtgryNo);

		return gdsCtgryList;
	}
	
	@ResponseBody
	@RequestMapping("getGdsCtgryListByFilterForMng.json")
	public Map<Integer, String> getGdsCtgryListByFilterForMng(
			@RequestParam(required = true, value="upCtgryNo") int upCtgryNo
			, HttpServletRequest request) throws Exception {

		Map<Integer, String> gdsCtgryList = gdsCtgryService.selectGdsCtgryListToMapForMng(upCtgryNo);

		return gdsCtgryList;
	}

	@ResponseBody
	@RequestMapping("ctgryImg.json")
	public Map<String, Object> ctgryImg(
			@RequestParam Map<String,MultipartFile> fileMap
			, @RequestParam(value = "ctgryNo", required=true) int ctgryNo
			, @RequestParam(value = "upCtgryNo", required=true) int upCtgryNo
			, @RequestParam(value = "orgCtgryNo", required=true) String orgCtgryNo
			)throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		boolean result = false;

		try {
			if(fileMap != null) {
				String ctgryImg = fileService.uploadFile(fileMap.get("attachFile"), serverDir.concat(fileUploadDir), "CTGRY_IMG");

				GdsCtgryVO ctgryVO = gdsCtgryService.selectGdsCtgry(upCtgryNo, ctgryNo);
				ctgryVO.setCtgryImg(ctgryImg);
				ctgryVO.setOrgCtgryNo(orgCtgryNo);
				gdsCtgryService.updateGdsCtgryImg(ctgryVO);
				result = true;
			}

		}catch(Exception e) {
			e.printStackTrace();
			log.debug("카테고리 이미지 등록 실패 : " + e.toString());
		}

		resultMap.put("result", result);

		return resultMap;
	}

	@ResponseBody
	@RequestMapping("delCtgryImg.json")
	public Map<String, Object> delCtgryImg(
			@RequestParam(value = "ctgryNo", required=true) int ctgryNo
			, @RequestParam(value = "upCtgryNo", required=true) int upCtgryNo
			, @RequestParam(value = "orgCtgryNo", required=true) String orgCtgryNo
			)throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		boolean result = false;

		try {
			GdsCtgryVO ctgryVO = gdsCtgryService.selectGdsCtgry(upCtgryNo, ctgryNo);
			ctgryVO.setCtgryImg(null);
			ctgryVO.setOrgCtgryNo(orgCtgryNo);
			gdsCtgryService.updateGdsCtgryImg(ctgryVO);
			result = true;

		}catch(Exception e) {
			e.printStackTrace();
			log.debug("카테고리 이미지 삭제 실패 : " + e.toString());
		}

		resultMap.put("result", result);

		return resultMap;
	}



}
