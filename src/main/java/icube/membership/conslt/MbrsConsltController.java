package icube.membership.conslt;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.api.biz.BiztalkApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.consult.biz.MbrConsltChgHistVO;
import icube.manage.consult.biz.MbrConsltResultService;
import icube.manage.consult.biz.MbrConsltResultVO;
import icube.manage.consult.biz.MbrConsltService;
import icube.manage.consult.biz.MbrConsltVO;
import icube.manage.mbr.recipients.biz.MbrRecipientsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;
import icube.market.mbr.biz.MbrSession;
import icube.members.bplc.rcmd.biz.BplcRcmdService;
import icube.members.bplc.rcmd.biz.BplcRcmdVO;
import icube.membership.conslt.biz.ItrstService;
import icube.membership.conslt.biz.ItrstVO;

@Controller
@RequestMapping(value="#{props['Globals.Membership.path']}/conslt/appl")
public class MbrsConsltController extends CommonAbstractController {

	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;

	@Resource(name = "mbrConsltResultService")
	private MbrConsltResultService mbrConsltResultService;

	@Resource(name= "mbrRecipientsService")
	private MbrRecipientsService mbrRecipientsService;
	
	@Resource(name = "itrstService")
	private ItrstService itrstService;
	
	@Resource(name="bplcRcmdService")
	private BplcRcmdService bplcRcmdService;
	
	@Resource(name = "biztalkApiService")
	private BiztalkApiService biztalkApiService;
	
	@Autowired
	private MbrSession mbrSession;

	// 상담 신청목록
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("srchUseYn", "Y");
		listVO.setParam("srchUniqueId", mbrSession.getUniqueId());
		listVO = mbrConsltService.selectMbrConsltListVO(listVO);

		List<MbrRecipientsVO> mbrRecipientList = mbrRecipientsService.selectMbrRecipientsByMbrUniqueId(mbrSession.getUniqueId());
		
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());
		paramMap.put("srchItrstTy", "B");
		//회원의 관심 멤버스 정보
		List <ItrstVO> itrstList = itrstService.selectItrstListAll(paramMap);
		model.addAttribute("itrstList", itrstList);
		
		//회원의 추천 멤버스 정보
		List<BplcRcmdVO> bplcRcmdList = bplcRcmdService.selectBplcRcmdByUniqueId(mbrSession.getUniqueId());
		model.addAttribute("bplcRcmdList", bplcRcmdList);
		
		model.addAttribute("listVO", listVO);
		model.addAttribute("mbrRecipientList", mbrRecipientList);
		model.addAttribute("mbrRelationCd", CodeMap.MBR_RELATION_CD);

		return "/membership/conslt/appl/list";
	}

	// 재상담 신청
	@ResponseBody
	@RequestMapping(value="reConslt.json")
	public Map<String, Object> reConslt(
			@RequestParam(value="consltNo", required=true) int consltNo
			, @RequestParam(value="reconsltResn", required=true) String reconsltResn
			, @RequestParam(value="bplcUniqueId", required=true) String bplcUniqueId
			, @RequestParam(value="bplcConsltNo", required=true) int bplcConsltNo

			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request) throws Exception {

		boolean result = false;

		try {
			MbrConsltResultVO mbrConsltResultVO = new MbrConsltResultVO();
			mbrConsltResultVO.setConsltNo(consltNo);
			mbrConsltResultVO.setReconsltResn(reconsltResn);
			mbrConsltResultVO.setBplcUniqueId(bplcUniqueId);
			mbrConsltResultVO.setBplcConsltNo(bplcConsltNo);

			mbrConsltResultService.updateReConslt(mbrConsltResultVO);

			//재접수 이력 저장
			MbrConsltChgHistVO mbrConsltChgHistVO = new MbrConsltChgHistVO();
			mbrConsltChgHistVO.setConsltNo(consltNo);
			mbrConsltChgHistVO.setConsltSttusChg("CS07");
			mbrConsltChgHistVO.setResn(CodeMap.CONSLT_STTUS_CHG_RESN.get("재접수"));
			mbrConsltChgHistVO.setMbrUniqueId(mbrSession.getUniqueId());
			mbrConsltChgHistVO.setMbrId(mbrSession.getMbrId());
			mbrConsltChgHistVO.setMbrNm(mbrSession.getMbrNm());
			mbrConsltService.insertMbrConsltChgHist(mbrConsltChgHistVO);
			
			result = true;
		} catch (Exception e) {
			result = false;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}

	// 상담 취소
	@RequestMapping(value = "canclConslt.json")
	@ResponseBody
	public Map<String, Object> cancelConslt(
			@RequestParam(value = "consltNo", required=true) int consltNo
			, @RequestParam(value = "canclResn", required=true) String canclResn
			, @RequestParam(value = "consltmbrNm") String consltmbrNm
			, @RequestParam(value = "consltmbrTelno") String consltmbrTelno
			, HttpServletRequest request
			) throws Exception {

		boolean result = false;

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("consltSttus", "CS03"); //상담자 취소
		paramMap.put("canclResn", canclResn);
		paramMap.put("consltNo", consltNo);

		int resultCnt = mbrConsltService.updateCanclConslt(paramMap);

		if(resultCnt > 0) {
			result = true;
			
			//1:1 상담 취소 이력 추가(접수, 재접수일 때만 취소가 되므로 사업소 상담 정보는 없음)
			MbrConsltChgHistVO mbrConsltChgHistVO = new MbrConsltChgHistVO();
			mbrConsltChgHistVO.setConsltNo(consltNo);
			mbrConsltChgHistVO.setConsltSttusChg("CS03");
			mbrConsltChgHistVO.setResn(CodeMap.CONSLT_STTUS_CHG_RESN.get("상담자 취소"));
			mbrConsltChgHistVO.setMbrUniqueId(mbrSession.getUniqueId());
			mbrConsltChgHistVO.setMbrId(mbrSession.getMbrId());
			mbrConsltChgHistVO.setMbrNm(mbrSession.getMbrNm());
			mbrConsltService.insertMbrConsltChgHist(mbrConsltChgHistVO);
			
			//사용자 상담취소
			biztalkApiService.sendOnTalkCancel(consltmbrNm, consltmbrTelno);
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}
	
	/**
	 * 상담정보조회 API
	 */
	@ResponseBody
	@RequestMapping(value = "getConsltInfo.json")
	public Map<String, Object> getConsltInfo(
		@RequestParam Integer consltNo) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			MbrConsltVO mbrConsltVO = mbrConsltService.selectMbrConsltByConsltNo(consltNo);
			//본인 계정의 상담만 조회 가능
			if (mbrConsltVO.getRegUniqueId().equals(mbrSession.getUniqueId()) == false) {
				resultMap.put("success", false);
				resultMap.put("msg", "본인의 상담만 조회가능합니다");
			}
			
			Map<String, String> mbrConsltInfo = new HashMap<>(); 
			mbrConsltInfo.put("relationText", CodeMap.MBR_RELATION_CD.get(mbrConsltVO.getRelationCd()));
			mbrConsltInfo.put("mbrNm", mbrConsltVO.getMbrNm());
			mbrConsltInfo.put("rcperRcognNo", "L" + mbrConsltVO.getRcperRcognNo());
			mbrConsltInfo.put("mbrTelno", mbrConsltVO.getMbrTelno());
			if (EgovStringUtil.isNotEmpty(mbrConsltVO.getZip()) && EgovStringUtil.isNotEmpty(mbrConsltVO.getAddr()) && EgovStringUtil.isNotEmpty(mbrConsltVO.getDaddr())) {
				mbrConsltInfo.put("address", mbrConsltVO.getZip() + " " + mbrConsltVO.getAddr() + " " + mbrConsltVO.getDaddr());
			}
			if (EgovStringUtil.isNotEmpty(mbrConsltVO.getBrdt())) {
				mbrConsltInfo.put("brdt", mbrConsltVO.getBrdt().substring(0, 4) + "/" + mbrConsltVO.getBrdt().substring(4, 6) + "/" + mbrConsltVO.getBrdt().substring(6, 8));
			}
			if (EgovStringUtil.isNotEmpty(mbrConsltVO.getGender())) {
				mbrConsltInfo.put("gender", CodeMap.GENDER.get(mbrConsltVO.getGender()));
			}
			if (EgovStringUtil.isNotEmpty(mbrConsltVO.getPrevPath())) {
				mbrConsltInfo.put("prevPath", CodeMap.PREV_PATH.get(mbrConsltVO.getPrevPath()));
			}
			
			resultMap.put("mbrConsltInfo", mbrConsltInfo);
			resultMap.put("success", true);
		} catch (Exception ex) {
			resultMap.put("success", false);
			resultMap.put("msg", "상담정보조회 중 오류가 발생하였습니다");
		}
		
		return resultMap;
	}
}
