package icube.manage.stats.mbr;

import java.util.HashMap;
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
import icube.manage.stats.mbr.biz.StatsMbrService;
import icube.manage.stats.mbr.biz.StatsMbrVO;

@Controller
@RequestMapping(value="/_mng/stats/mbr")
public class MStatsMbrController extends CommonAbstractController {

	@Resource(name = "statsMbrService")
	private StatsMbrService statsMbrService;

	/**
	 * 가입/탈퇴현황
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "join")
	public String join(
			HttpServletRequest request
			, Model model
			, @RequestParam Map<String, Object> reqMap
			) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();

		// 현재 회원 누계
		resultMap = statsMbrService.selectJoinMap(reqMap);

		// 리스트
		List<StatsMbrVO> resultList = statsMbrService.selectJoinList(reqMap);

		model.addAttribute("resultMap", resultMap);
		model.addAttribute("resultList", resultList);

		return "/manage/stats/mbr/mbr_join";
	}

	/**
	 * 가입/탈퇴현황 엑셀
	 * @param request
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="joinExcel")
	public String joinExcel(
			HttpServletRequest request
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception{

		// 현재 회원 누계
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = statsMbrService.selectJoinMap(reqMap);

		List<StatsMbrVO> resultList = statsMbrService.selectJoinList(reqMap);

		model.addAttribute("resultList", resultList);
		model.addAttribute("resultMap", resultMap);

		return "/manage/stats/include/mbr_excel_join";
	}

	/**
	 * 휴면회원 현황
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping(value = "drmc")
	public String drmc(
			HttpServletRequest request
			, Model model
			, @RequestParam Map<String, Object> reqMap
			) throws Exception {

		List<StatsMbrVO> resultList = statsMbrService.selectDrmcList(reqMap);
		Map<String, Object> resultMap = statsMbrService.selectDrmcMap(reqMap);

		model.addAttribute("resultList", resultList);
		model.addAttribute("resultMap", resultMap);

		return "/manage/stats/mbr/mbr_drmc";
	}

	/**
	 * 휴면회원 엑셀
	 * @param request
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="drmcExcel")
	public String drmcExcel(
			HttpServletRequest request
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception{

		// 휴면 회원 누계
		List<StatsMbrVO> resultList = statsMbrService.selectDrmcList(reqMap);
		Map<String, Object> resultMap = statsMbrService.selectDrmcMap(reqMap);

		model.addAttribute("resultList", resultList);
		model.addAttribute("resultMap", resultMap);

		return "/manage/stats/include/mbr_excel_drmc";
	}

	/**
	 * 성별/연령별 현황
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping(value = "gender")
	public String gender(
			HttpServletRequest request
			, Model model
			, @RequestParam Map<String, Object> reqMap
			) throws Exception {

		List<StatsMbrVO> resultList = statsMbrService.selectGenderList(reqMap);
		Map<String, Object> resultMap = statsMbrService.selectGenderMap(reqMap);

		model.addAttribute("resultList", resultList);
		model.addAttribute("resultMap", resultMap);

		return "/manage/stats/mbr/mbr_gender";
	}

	/**
	 * 성별/연령별 엑셀
	 * @param request
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="genderExcel")
	public String genderExcel(
			HttpServletRequest request
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception{

		List<StatsMbrVO> resultList = statsMbrService.selectGenderList(reqMap);
		Map<String, Object> resultMap = statsMbrService.selectGenderMap(reqMap);

		model.addAttribute("resultList", resultList);
		model.addAttribute("resultMap", resultMap);

		return "/manage/stats/include/mbr_excel_gender";
	}

	/**
	 * 가입경로 현황
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping(value = "cours")
	public String cours(
			HttpServletRequest request
			, Model model
			, @RequestParam Map<String, Object> reqMap
			) throws Exception {

		List<StatsMbrVO> resultList = statsMbrService.selectCoursList(reqMap);

		model.addAttribute("resultList", resultList);

		return "/manage/stats/mbr/mbr_cours";
	}

	/**
	 * 가입경로 엑셀
	 * @param request
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="coursExcel")
	public String coursExcel(
			HttpServletRequest request
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception{

		List<StatsMbrVO> resultList = statsMbrService.selectCoursList(reqMap);

		model.addAttribute("resultList", resultList);

		return "/manage/stats/include/mbr_excel_cours";
	}

	/**
	 * 등급별 현황
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping(value = "grade")
	public String grade(
			HttpServletRequest request
			, Model model
			, @RequestParam Map<String, Object> reqMap
			) throws Exception {

		List<StatsMbrVO> resultList = statsMbrService.selectGradeList(reqMap);

		model.addAttribute("resultList", resultList);
		model.addAttribute("gradeCode", CodeMap.GRADE);

		return "/manage/stats/mbr/mbr_grade";
	}

	/**
	 * 가입경로 엑셀
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="gradeExcel")
	public String gradeExcel(
			HttpServletRequest request
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception{

		List<StatsMbrVO> resultList = statsMbrService.selectGradeList(reqMap);

		model.addAttribute("resultList", resultList);
		model.addAttribute("gradeCode", CodeMap.GRADE);

		return "/manage/stats/include/mbr_excel_grade";
	}

}
