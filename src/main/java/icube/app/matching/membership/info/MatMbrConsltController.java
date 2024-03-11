package icube.app.matching.membership.info;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.app.matching.membership.mbr.biz.MatMbrSession;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CodeMap;
import icube.manage.consult.biz.MbrConsltChgHistVO;
import icube.manage.consult.biz.MbrConsltResultVO;
import icube.manage.consult.biz.MbrConsltService;
import icube.manage.consult.biz.MbrConsltVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.mbr.recipients.biz.MbrRecipientsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;

/**
 * 상담 관련
 */
@Controller
@RequestMapping(value="#{props['Globals.Matching.path']}/membership/conslt")
public class MatMbrConsltController extends CommonAbstractController {
	
	@Resource(name = "mbrService")
	private MbrService mbrService;
	
	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;
	
	@Resource(name= "mbrRecipientsService")
	private MbrRecipientsService mbrRecipientsService;
	
	@Autowired
	private MatMbrSession matMbrSession; 
	
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
	
	/**
	 * 특정 수급자의 진행중인 상담 조회(서비스 > swipe 구성)
	 */
	@ResponseBody
	@RequestMapping("progress.json")
	public Map<String, Object> getConsltInProgress(@RequestParam int recipientsNo) {
		Map <String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", false);
		
		try {
			List<MbrConsltVO> mbrConsltList = mbrConsltService.getConsltInProgress(recipientsNo);
			List<String> prevPathList = mbrConsltList.stream().map(m -> m.getPrevPath()).distinct().collect(Collectors.toList());
			resultMap.put("success", true);
			resultMap.put("prevPathList", prevPathList);
		} catch (Exception ex) {
			log.error("===== 진행중인 상담 조회 API 오류", ex);
		}
		
		return resultMap;
	}
	
	/**
	 * 상담신청 전 상담 정보 확인 페이지
	 */
	@RequestMapping(value = "infoConfirm")
	public String infoConfirm(
		@RequestParam String prevPath
		, @RequestParam(required = false) Integer recipientsNo
		, Model model) throws Exception {
		
		List<MbrRecipientsVO> mbrRecipientList = mbrRecipientsService.selectMbrRecipientsByMbrUniqueId(matMbrSession.getUniqueId());
		MbrRecipientsVO recipientInfo = null;
		if (recipientsNo == null) {
			//수급자 번호가 없으면 메인수급자 검색
			recipientInfo = mbrRecipientList.stream().filter(f -> "Y".equals(f.getMainYn())).findAny().orElse(null);
		} else {
			recipientInfo = mbrRecipientList.stream().filter(f -> f.getRecipientsNo() == recipientsNo).findAny().orElse(null);
		}
		
		if (recipientInfo == null) {
			model.addAttribute("appMsg", "등록된 수급자가 아닙니다.");
			model.addAttribute("appLocation", "/matching/main/service");
			return "/app/matching/common/appMsg";
		}
		
		model.addAttribute("prevPath", prevPath);
		model.addAttribute("recipientInfo", recipientInfo);
		
		model.addAttribute("prevPathCtgryMap", CodeMap.PREV_PATH_CTGRY);
		model.addAttribute("prevPathMap", CodeMap.PREV_PATH_FOR_APP);
		
		return "/app/matching/membership/conslt/regist/infoConfirm";
	}
	
	/**
	 * 상담신청 페이지
	 */
	@RequestMapping(value = "request")
	public String request() throws Exception {
		return "/app/matching/membership/conslt/regist/request";
	}
	
	/**
	 * 상담신청 AJAX
	 */
	@ResponseBody
	@RequestMapping(value = "/addMbrConslt.json")
	public synchronized Map<String, Object> addMbrConslt(
			@RequestParam String prevPath
			, @RequestParam Integer recipientsNo
			, @RequestParam String tel
			, @RequestParam String sido
			, @RequestParam String sigugun) throws Exception {
		List<MbrRecipientsVO> mbrRecipientList = mbrRecipientsService.selectMbrRecipientsByMbrUniqueId(matMbrSession.getUniqueId());
		MbrRecipientsVO recipientInfo = mbrRecipientList.stream().filter(f -> f.getRecipientsNo() == recipientsNo).findAny().orElse(null);
		
		boolean saveRecipientInfo = false;
		MbrConsltVO mbrConsltVO = new MbrConsltVO();
		mbrConsltVO.setPrevPath(prevPath);
		mbrConsltVO.setRecipientsNo(recipientInfo.getRecipientsNo());
		mbrConsltVO.setRelationCd(recipientInfo.getRelationCd());
		mbrConsltVO.setMbrNm(recipientInfo.getRecipientsNm());
		mbrConsltVO.setMbrTelno(tel);
		mbrConsltVO.setGender(recipientInfo.getGender());
		mbrConsltVO.setBrdt(recipientInfo.getBrdt());
		mbrConsltVO.setZip(sido);
		mbrConsltVO.setAddr(sigugun);
		if ("simple_test".equals(prevPath) || "care".equals(prevPath)) {
			mbrConsltVO.setSimpleYn("Y");
		}
		mbrConsltVO.setConsltCours("MOBILE");
		
		return mbrConsltService.addMbrConslt(mbrConsltVO, saveRecipientInfo, matMbrSession);
	}
	
	/**
	 * 상담 신청 완료 페이지
	 */
	@RequestMapping(value = "complete")
	public String complete(@RequestParam Integer recipientsNo, Model model) throws Exception {
		List<MbrRecipientsVO> mbrRecipientList = mbrRecipientsService.selectMbrRecipientsByMbrUniqueId(matMbrSession.getUniqueId());
		MbrRecipientsVO recipientInfo = mbrRecipientList.stream().filter(f -> f.getRecipientsNo() == recipientsNo).findAny().orElse(null);
		
		MbrConsltVO mbrConsltVO = mbrConsltService.selectRecentConsltByRecipientsNo(recipientInfo.getRecipientsNo());
		
		model.addAttribute("mbrConsltVO", mbrConsltVO);
		model.addAttribute("prevPathCtgryMap", CodeMap.PREV_PATH_CTGRY);
		model.addAttribute("prevPathMap", CodeMap.PREV_PATH_FOR_APP);
		
		return "/app/matching/membership/conslt/regist/complete";
	}
	
	/**
	 * 상담 받을 연락처 변경 페이지
	 */
	@RequestMapping(value = "telChange")
	public String telChange() throws Exception {
		return "/app/matching/membership/conslt/regist/telChange";
	}
	
	
	/**
	 * 상담목록
	 */
	@RequestMapping(value = "list")
	public String list(@RequestParam Integer recipientsNo, Model model) throws Exception {
		List<MbrRecipientsVO> mbrRecipientList = mbrRecipientsService.selectMbrRecipientsByMbrUniqueId(matMbrSession.getUniqueId());
		MbrRecipientsVO recipientInfo = mbrRecipientList.stream().filter(f -> f.getRecipientsNo() == recipientsNo).findAny().orElse(null);
		
		if (recipientInfo == null) {
			model.addAttribute("appMsg", "잘못된 접근입니다.");
			return "/app/matching/common/appMsg";
		}
		
		List<MbrConsltVO> mbrConsltList = mbrConsltService.selectMbrConsltByRecipientsNo(recipientInfo.getRecipientsNo());
		model.addAttribute("mbrConsltList", mbrConsltList);
		model.addAttribute("prevPathCtgryMap", CodeMap.PREV_PATH_CTGRY);
		model.addAttribute("prevPathMap", CodeMap.PREV_PATH_FOR_APP);
		
		return "/app/matching/membership/conslt/list";
	}
	
	/**
	 * 상담내역
	 */
	@RequestMapping(value = "detail")
	public String detail(@RequestParam Integer consltNo, Model model) throws Exception {
		MbrConsltVO mbrConsltVO = mbrConsltService.selectMbrConsltByConsltNo(consltNo);
		
		if (mbrConsltVO == null || !matMbrSession.getUniqueId().equals(mbrConsltVO.getRegUniqueId())) {
			model.addAttribute("appMsg", "잘못된 접근입니다.");
			return "/app/matching/common/appMsg";
		}
		
//		MbrVO mbrVO = mbrService.selectMbrByUniqueId(matMbrSession.getUniqueId());
//		MbrRecipientsVO mbrRecipientsVO = mbrRecipientsService.selectMbrRecipientsByRecipientsNo(mbrConsltVO.getRecipientsNo());
//		model.addAttribute("mbrVO", mbrVO);
//		model.addAttribute("mbrRecipientsVO", mbrRecipientsVO);
		
		model.addAttribute("mbrConsltVO", mbrConsltVO);
		
		//상담에 매칭된 최근 사업소
		MbrConsltResultVO recentConsltResultVO = null;
		if (mbrConsltVO.getConsltResultList().size() > 0) {
			recentConsltResultVO = mbrConsltVO.getConsltResultList().get(mbrConsltVO.getConsltResultList().size() - 1);
			model.addAttribute("mbrConsltResultVO", recentConsltResultVO);
		}
		
		//상담 신청, 재신청 이력
		int phaseNum = 1;
		List<MbrConsltChgHistVO> searchChgList = mbrConsltVO.getConsltChgHistList();
		MbrConsltChgHistVO reuqestChgHistVO = searchChgList
			.stream()
			.filter(f -> "CS01".equals(f.getConsltSttusChg()) || "CS07".equals(f.getConsltSttusChg()))
			.findFirst()
			.orElse(null);
		model.addAttribute("reuqestChgHistVO", reuqestChgHistVO);
		
		if (recentConsltResultVO != null) {
			int searchBplcConsltNo = recentConsltResultVO.getBplcConsltNo();
			
			//상담 연결중 이력
			MbrConsltChgHistVO connectChgHistVO = searchChgList
				.stream()
				.filter(f -> f.getBplcConsltNo() != null && f.getBplcConsltNo() == searchBplcConsltNo && ("CS02".equals(f.getConsltSttusChg()) || "CS08".equals(f.getConsltSttusChg())))
				.findFirst()
				.orElse(null);
			model.addAttribute("connectChgHistVO", connectChgHistVO);
			if (connectChgHistVO != null) {
				phaseNum = 2;
			}
			
			//상담 진행중 이력
			MbrConsltChgHistVO progressChgHistVO = searchChgList
				.stream()
				.filter(f -> f.getBplcConsltNo() != null && f.getBplcConsltNo() == searchBplcConsltNo && "CS05".equals(f.getConsltSttusChg()))
				.findFirst()
				.orElse(null);
			model.addAttribute("progressChgHistVO", progressChgHistVO);
			if (progressChgHistVO != null) {
				phaseNum = 3;
			}
			
			//상담 완료 이력
			MbrConsltChgHistVO completeChgHistVO = searchChgList
				.stream()
				.filter(f -> f.getBplcConsltNo() != null && f.getBplcConsltNo() == searchBplcConsltNo && "CS06".equals(f.getConsltSttusChg()))
				.findFirst()
				.orElse(null);
			model.addAttribute("completeChgHistVO", completeChgHistVO);
			if (completeChgHistVO != null) {
				phaseNum = 4;
			}
		}
		model.addAttribute("phaseNum", phaseNum);
		
		
		model.addAttribute("prevPathCtgryMap", CodeMap.PREV_PATH_CTGRY);
		model.addAttribute("prevPathMap", CodeMap.PREV_PATH_FOR_APP);
		model.addAttribute("relationCdMap", CodeMap.MBR_RELATION_CD_FOR_READ);
		
		return "/app/matching/membership/conslt/detail";
	}
}
