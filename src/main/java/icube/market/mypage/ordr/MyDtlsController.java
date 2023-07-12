package icube.market.mypage.ordr;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringJoiner;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.api.biz.BootpayApiService;
import icube.common.api.biz.UpdateBplcInfoApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.mail.MailFormService;
import icube.common.util.ArrayUtil;
import icube.common.util.DateUtil;
import icube.common.util.WebUtil;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.gds.gds.biz.GdsService;
import icube.manage.gds.gds.biz.GdsVO;
import icube.manage.gds.optn.biz.GdsOptnVO;
import icube.manage.ordr.chghist.biz.OrdrChgHistService;
import icube.manage.ordr.chghist.biz.OrdrChgHistVO;
import icube.manage.ordr.dtl.biz.OrdrDtlService;
import icube.manage.ordr.dtl.biz.OrdrDtlVO;
import icube.manage.ordr.ordr.biz.OrdrService;
import icube.manage.ordr.ordr.biz.OrdrVO;
import icube.manage.ordr.rebill.biz.OrdrRebillService;
import icube.manage.ordr.rebill.biz.OrdrRebillVO;
import icube.manage.sysmng.dlvy.biz.DlvyCoMngService;
import icube.manage.sysmng.dlvy.biz.DlvyCoMngVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 마이페이지 > 내역 > 주문/배송 조회 + 취소/교환/반품 조회 통합
 */

@Controller
@RequestMapping(value = "#{props['Globals.Market.path']}/mypage/ordr")
public class MyDtlsController extends CommonAbstractController {

	@Resource(name = "ordrService")
	private OrdrService ordrService;

	@Resource(name = "ordrDtlService")
	private OrdrDtlService ordrDtlService;

	@Resource(name = "ordrChgHistService")
	private OrdrChgHistService ordrChgHistService;

	@Resource(name = "dlvyCoMngService")
	private DlvyCoMngService dlvyCoMngService;

	@Resource(name = "gdsService")
	private GdsService gdsService;

	@Resource(name= "bootpayApiService")
	private BootpayApiService bootpayApiService;

	@Resource(name = "mailFormService")
	private MailFormService mailFormService;

	@Resource(name="ordrRebillService")
	private OrdrRebillService ordrRebillService;

	@Resource(name = "updateBplcInfoApiService")
	private UpdateBplcInfoApiService updateBplcInfoApiService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	// 주문/배송
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("srchUniqueId", mbrSession.getUniqueId());
		listVO.setParam("ordrSttsTy", "ALL");
		listVO = ordrService.ordrListVO(listVO);
		model.addAttribute("listVO", listVO);

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchRegUniqueId", mbrSession.getUniqueId());
		Map<String, Integer> ordrSttsTyCntMap = ordrService.selectSttsTyCnt(paramMap);
		model.addAttribute("ordrSttsTyCntMap", ordrSttsTyCntMap);

		paramMap.clear();
		paramMap = new HashMap<String, Object>();
		paramMap.put("srchUseYn", "Y");
		List<DlvyCoMngVO> dlvyCoList = dlvyCoMngService.selectDlvyCoListAll(paramMap);
		model.addAttribute("dlvyCoList", dlvyCoList);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("bassStlmTyCode", CodeMap.BASS_STLM_TY);
		model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);
		model.addAttribute("ordrCancelTyCode", CodeMap.ORDR_CANCEL_TY);

		return "/market/mypage/ordr/list";
	}


	@RequestMapping(value="view/{ordrCd}")
	public String view(
			@PathVariable String ordrCd
			, HttpServletRequest request
			, Model model) throws Exception {
		OrdrVO ordrVO = ordrService.selectOrdrByCd(ordrCd);

		if(ordrVO == null) {
			model.addAttribute("alertMsg", getMsg("alert.author.common"));
			return "/common/msg";
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUseYn", "Y");
		List<DlvyCoMngVO> dlvyCoList = dlvyCoMngService.selectDlvyCoListAll(paramMap);
		model.addAttribute("dlvyCoList", dlvyCoList);

		model.addAttribute("recipterYnCode", CodeMap.RECIPTER_YN);
		model.addAttribute("gradeCode", CodeMap.GRADE);
		model.addAttribute("bassStlmTyCode", CodeMap.BASS_STLM_TY);
		model.addAttribute("bankTyCode", CodeMap.BANK_TY);
		model.addAttribute("ordrCancelTyCode", CodeMap.ORDR_CANCEL_TY);
		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);

		model.addAttribute("ordrVO", ordrVO);

		return "/market/mypage/ordr/view";
	}




	// 주문취소 모달
	@RequestMapping(value="ordrRtrcn")
	public String ordrRtrcn(
			@RequestParam(value="ordrCd", required=true) String ordrCd
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {

		// 주문정보
		OrdrVO ordrVO = ordrService.selectOrdrByCd(ordrCd);

		// result
		model.addAttribute("recipterYnCode", CodeMap.RECIPTER_YN);
		model.addAttribute("gradeCode", CodeMap.GRADE);
		model.addAttribute("bassStlmTyCode", CodeMap.BASS_STLM_TY);
		model.addAttribute("bankTyCode", CodeMap.BANK_TY);
		model.addAttribute("ordrCancelTyCode", CodeMap.ORDR_CANCEL_TY);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);

		model.addAttribute("ordrVO", ordrVO);

		return "/market/mypage/ordr/include/modal_rtrcn";
	}

	// 주문건 전체/취소 저장
	@ResponseBody
	@RequestMapping(value="ordrRtrcnSave.json")
	public Map<String, Object> ordrRtrcnSave(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlCds[]", required=true) String[] ordrDtlCds
			, @RequestParam(value="resnTy", required=true) String resnTy
			, @RequestParam(value="resn", required=false) String resn

			, @RequestParam(value="rfndBank", required=false) String rfndBank
			, @RequestParam(value="rfndActno", required=false) String rfndActno
			, @RequestParam(value="rfndDpstr", required=false) String rfndDpstr

			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;

		List<String> ordrDtlCdList = new ArrayList<String>(Arrays.asList(ordrDtlCds)); //취소할 상품 CD
		OrdrVO oldOrdrVO = ordrService.selectOrdrByNo(ordrNo); //주문정보
		
		//주문에 관련된 전체 상품정보
		List<OrdrDtlVO> ordrDtlList = oldOrdrVO.getOrdrDtlList();
		String[] ordrDtlNos = ordrDtlList.stream().filter(f -> ordrDtlCdList.contains(f.getOrdrDtlCd()))
												  .map(m -> String.valueOf(m.getOrdrDtlNo()))
												  .toArray(String[]::new);

		OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
		ordrDtlVO.setOrdrNo(ordrNo);
		ordrDtlVO.setOrdrDtlNos(ordrDtlNos);
		ordrDtlVO.setResnTy(resnTy);
		ordrDtlVO.setResn(resn);
		ordrDtlVO.setRegUniqueId(mbrSession.getUniqueId());
		ordrDtlVO.setRegId(mbrSession.getMbrId());
		ordrDtlVO.setRgtr(mbrSession.getMbrNm());

		//환불정보
		ordrDtlVO.setRfndBank(rfndBank); //은행
		ordrDtlVO.setRfndActno(rfndActno); //계좌
		ordrDtlVO.setRfndDpstr(rfndDpstr); //예금주

		Integer resultCnt = 0;

		if("VBANK".equals(oldOrdrVO.getStlmTy()) && "Y".equals(oldOrdrVO.getStlmYn())) { //가상계좌 + 결제완료 = 취소접수
			ordrDtlVO.setSttsTy("CA01"); // 취소접수
			resultCnt = ordrDtlService.updateOrdrCA01(ordrDtlVO);
		} else { // 카드, 계좌이체
			ordrDtlVO.setSttsTy("CA02"); // 취소승인
			resultCnt = ordrDtlService.updateCA02AndReturnCoupon(ordrNo, ordrDtlVO, ordrDtlNos);
		}

		// 주문 상태 전달
		// 전체 취소 일때만 API 송신
		// 부분 취소는 1.5 내부 처리
		Map<String, Object> returnMap = new HashMap<String, Object>();

		// 주문승인상태 또는 취소상태인지를 검사
		boolean isSttsTyOR02 = true;
		
		//이미 주문 취소된 상품 + 현재 취소 하려는 상품 리스트
		List<String> tmpOrdrDtlNos = ordrDtlCdList;
		for(OrdrDtlVO ordrDtlInfo : ordrDtlList) {
			if ("CA02".equals(ordrDtlInfo.getSttsTy()) && !tmpOrdrDtlNos.contains(ordrDtlInfo.getOrdrDtlCd())) {
				tmpOrdrDtlNos.add(ordrDtlInfo.getOrdrDtlCd());
			}
			if ("OR01".equals(ordrDtlInfo.getSttsTy()) || "OR05".equals(ordrDtlInfo.getSttsTy())) {
				isSttsTyOR02 = false;
			}
		};
		
		// 전체 취소 일때
		if(isSttsTyOR02 && tmpOrdrDtlNos.size() == ordrDtlList.size()) {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("ordrNo", ordrNo);
			paramMap.put("resnTy", resnTy);
			paramMap.put("dataType", "cancel");
			returnMap = updateBplcInfoApiService.putStlmYnSttus(paramMap);

			if((boolean)returnMap.get("result")) {
				if(!EgovStringUtil.equals((String)returnMap.get("resultCode"), "200")) {
					ordrDtlVO.setSttsTy("CA01");
					ordrDtlService.updateOrdrCA01(ordrDtlVO);
				}
			}else {
				System.out.println("###### 결제 API 통신 실패 ##### : " + (String)returnMap.get("resultMsg"));
			}
		}

		if(resultCnt == 1){
			result = true;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}



	// 상품옵션
	@RequestMapping(value="optnChg")
	public String optnChg(
			@RequestParam(value="ordrDtlNo", required=true) int ordrDtlNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd
			, @RequestParam(value="gdsNo", required=true) int gdsNo
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {


		/* 상품 1 +추가옵션 상품*/
		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
		model.addAttribute("ordrDtlList", ordrDtlList);
		model.addAttribute("ordrDtlCd", ordrDtlCd);


		GdsVO gdsVO = gdsService.selectGds(gdsNo);
		// 상품옵션 set
		List<String> optnVal1 = new ArrayList<String>()
				, optnVal2 = new ArrayList<String>()
				, optnVal3 = new ArrayList<String>();
		for(GdsOptnVO gdsoOtnVO : gdsVO.getOptnList()) {
			String[] optnVal = gdsoOtnVO.getOptnNm().split("[*]");
			if(optnVal.length > 0 && !ArrayUtil.isContainsInList(optnVal1, optnVal[0].trim())) {
				optnVal1.add(optnVal[0].trim());
			}
			if(optnVal.length > 1 && !ArrayUtil.isContainsInList(optnVal2, optnVal[1].trim())) {
				optnVal2.add(optnVal[1].trim());
			}
			if(optnVal.length > 2 && !ArrayUtil.isContainsInList(optnVal3, optnVal[2].trim())) {
				optnVal3.add(optnVal[2].trim());
			}
		}
		String optnVal1Str = optnVal1.toString().replace("[", "").replace("]", "").replace(", ", ",");
		String optnVal2Str = optnVal2.toString().replace("[", "").replace("]", "").replace(", ", ",");
		String optnVal3Str = optnVal3.toString().replace("[", "").replace("]", "").replace(", ", ",");

		StringJoiner joiner = new StringJoiner("|");
		if(EgovStringUtil.isNotEmpty(optnVal1Str)) {
			joiner.add(optnVal1Str); }
		if(EgovStringUtil.isNotEmpty(optnVal2Str)) {
			joiner.add(optnVal2Str); }
		if(EgovStringUtil.isNotEmpty(optnVal3Str)) {
			joiner.add(optnVal3Str); }
		gdsVO.setOptnVal(joiner.toString());

		model.addAttribute("gdsVO", gdsVO);
		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);

		return "/market/mypage/ordr/include/modal_optn_chg";
	}


	/**
	 * 옵션 항목/수량 변경
	 */
	@ResponseBody
	@RequestMapping(value="optnChgSave.json")
	public Map<String, Object> optnChgSave(
			@RequestParam(value="ordrNo", required=true) String ordrNo
			, @RequestParam(value="ordrCd", required=true) String ordrCd
			, @RequestParam(value="ordrDtlNo", required=true) String ordrDtlNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd

			, @RequestParam(value="gdsNo", required=true) String gdsNo
			, @RequestParam(value="gdsCd", required=true) String gdsCd
			, @RequestParam(value="bnefCd", required=true) String bnefCd
			, @RequestParam(value="gdsNm", required=true) String gdsNm
			, @RequestParam(value="gdsPc", required=true) String gdsPc

			, @RequestParam(value="ordrOptnTy", required=true) String ordrOptnTy
			, @RequestParam(value="ordrOptn", required=true) String ordrOptn
			, @RequestParam(value="ordrOptnPc", required=true) String ordrOptnPc
			, @RequestParam(value="ordrQy", required=true) String ordrQy

			, @RequestParam(value="recipterUniqueId", required=false) String recipterUniqueId
			, @RequestParam(value="bplcUniqueId", required=false) String bplcUniqueId

			, @RequestParam(value="sttsTy", required=true) String sttsTy
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request) throws Exception {

		boolean result = false;
		Integer resultCnt = 0;

		try {
			for(int i=0;i < ordrDtlNo.split(",").length;i++) {
				OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
				ordrDtlVO.setOrdrNo(EgovStringUtil.string2integer(ordrNo.split(",")[i]));
				ordrDtlVO.setOrdrCd(ordrCd.split(",")[i]);
				ordrDtlVO.setOrdrDtlNo(EgovStringUtil.string2integer(ordrDtlNo.split(",")[i]));
				ordrDtlVO.setOrdrDtlCd(ordrDtlCd.split(",")[i]);
				ordrDtlVO.setGdsNo(EgovStringUtil.string2integer(gdsNo.split(",")[i]));
				ordrDtlVO.setGdsCd(gdsCd.split(",")[i]);

				// 급여코드
				if(bnefCd.split(",").length > 0) { // bnefCd null일수 있음
					ordrDtlVO.setBnefCd(bnefCd.split(",")[i]);
				}else {
					ordrDtlVO.setBnefCd("");
				}
				ordrDtlVO.setGdsNm(gdsNm.split(",")[i]);
				ordrDtlVO.setGdsPc(EgovStringUtil.string2integer(gdsPc.split(",")[i]));
				ordrDtlVO.setOrdrOptnTy(ordrOptnTy.split(",")[i]);
				ordrDtlVO.setOrdrOptn(ordrOptn.split(",")[i]);
				ordrDtlVO.setOrdrOptnPc(EgovStringUtil.string2integer(ordrOptnPc.split(",")[i]));
				ordrDtlVO.setOrdrQy(EgovStringUtil.string2integer(ordrQy.split(",")[i]));

				// 수혜자
				if(recipterUniqueId.split(",").length > 0) {
					ordrDtlVO.setRecipterUniqueId(recipterUniqueId.split(",")[i]);
				} else {
					ordrDtlVO.setRecipterUniqueId("");
				}

				// 사업소
				if(bplcUniqueId.split(",").length > 0) {
					ordrDtlVO.setBplcUniqueId(bplcUniqueId.split(",")[i]);
				} else {
					ordrDtlVO.setBplcUniqueId("");
				}

				ordrDtlVO.setSttsTy(sttsTy.split(",")[i]);

				int ordrPc = (ordrDtlVO.getGdsPc() +  ordrDtlVO.getOrdrOptnPc()) * ordrDtlVO.getOrdrQy();
				ordrDtlVO.setOrdrPc(ordrPc);

				resultCnt += ordrDtlService.modifyOptnChg(ordrDtlVO);

			}

			// 삭제
			String delOrdrDtlNo = WebUtil.clearSqlInjection((String) reqMap.get("delOrdrDtlNo"));
			String[] arrDelOrdrDtlNo = delOrdrDtlNo.split(",");
			if(arrDelOrdrDtlNo.length > 0) {
				ordrDtlService.deleteOrdrDtlByNos(arrDelOrdrDtlNo);
			}

			result = true;

		} catch (Exception e) {
			result = false;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}


	// 구매확정
	@ResponseBody
	@RequestMapping(value="ordrDone.json")
	public Map<String, Object> ordrDone(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd
			, @RequestParam(value="resn", required=true) String resn
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;

		ArrayList<String> tmpOrdrDtlNos = new ArrayList<String>();
		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
		int totalAccmlMlg = 0;
		for (OrdrDtlVO ordrDtlVO : ordrDtlList) {
			tmpOrdrDtlNos.add(EgovStringUtil.integer2string(ordrDtlVO.getOrdrDtlNo()));
			totalAccmlMlg += ordrDtlVO.getAccmlMlg();
		}

		String[] ordrDtlNos = tmpOrdrDtlNos.toArray(new String[tmpOrdrDtlNos.size()]);

		OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
		ordrDtlVO.setOrdrNo(ordrNo);
		ordrDtlVO.setOrdrDtlCd(ordrDtlCd);
		ordrDtlVO.setOrdrDtlNos(ordrDtlNos);
		ordrDtlVO.setSttsTy("OR09");
		ordrDtlVO.setResn(resn);
		ordrDtlVO.setRegUniqueId(mbrSession.getUniqueId());
		ordrDtlVO.setRegId(mbrSession.getMbrId());
		ordrDtlVO.setRgtr(mbrSession.getMbrNm());

		ordrDtlVO.setTotalAccmlMlg(totalAccmlMlg);

		Integer resultCnt = ordrDtlService.updateOrdrOR09(ordrDtlVO);

		if(resultCnt == 1){
			result = true;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}


	// 교환접수 모달
	@RequestMapping(value="ordrExchng")
	public String ordrExchng(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {

		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
		model.addAttribute("ordrDtlList", ordrDtlList);

		model.addAttribute("ordrNo", ordrNo);
		model.addAttribute("ordrDtlCd", ordrDtlCd);
		// result
		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("ordrExchngTyCode", CodeMap.ORDR_EXCHNG_TY);

		return "/market/mypage/ordr/include/modal_exchng";
	}


	//교환신청 접수 (EX01)
	@ResponseBody
	@RequestMapping(value="ordrExchngRcpt.json")
	public Map<String, Object> ordrExchngRcpt(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd
			, @RequestParam(value="resnTy", required=false) String resnTy
			, @RequestParam(value="resn", required=true) String resn
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;

		ArrayList<String> tmpOrdrDtlNos = new ArrayList<String>();
		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
		for (OrdrDtlVO ordrDtlVO : ordrDtlList) {
			tmpOrdrDtlNos.add(EgovStringUtil.integer2string(ordrDtlVO.getOrdrDtlNo()));
		}
		String[] ordrDtlNos = tmpOrdrDtlNos.toArray(new String[tmpOrdrDtlNos.size()]);

		OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
		ordrDtlVO.setOrdrNo(ordrNo);
		ordrDtlVO.setOrdrDtlNos(ordrDtlNos);
		ordrDtlVO.setSttsTy("EX01");
		ordrDtlVO.setResnTy(resnTy);
		ordrDtlVO.setResn(resn);
		ordrDtlVO.setRegUniqueId(mbrSession.getUniqueId());
		ordrDtlVO.setRegId(mbrSession.getMbrId());
		ordrDtlVO.setRgtr(mbrSession.getMbrNm());

		Integer resultCnt = ordrDtlService.updateOrdrEA01(ordrDtlVO);
		if(resultCnt == 1){
			result = true;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}


	// 반품접수 모달
	@RequestMapping(value="ordrReturn")
	public String ordrReturn(
			@RequestParam(value="ordrCd", required=true) String ordrCd
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {

		// 주문정보
		OrdrVO ordrVO = ordrService.selectOrdrByCd(ordrCd);

		// result
		model.addAttribute("recipterYnCode", CodeMap.RECIPTER_YN);
		model.addAttribute("gradeCode", CodeMap.GRADE);
		model.addAttribute("bassStlmTyCode", CodeMap.BASS_STLM_TY);
		model.addAttribute("bankTyCode", CodeMap.BANK_TY);
		model.addAttribute("ordrReturnTyCode", CodeMap.ORDR_RETURN_TY);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);



		model.addAttribute("ordrVO", ordrVO);

		return "/market/mypage/ordr/include/modal_return";
	}


	// 반품접수
	@ResponseBody
	@RequestMapping(value="ordrReturnSave.json")
	public Map<String, Object> ordrReturnSave(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlCds[]", required=true) String[] ordrDtlCds
			, @RequestParam(value="resnTy", required=true) String resnTy
			, @RequestParam(value="resn", required=false) String resn
			, @RequestParam(value="rfndBank", required=false) String rfndBank // 환불 은행
			, @RequestParam(value="rfndActno", required=false) String rfndActno // 환불 계좌
			, @RequestParam(value="rfndDpstr", required=false) String rfndDpstr // 환불계좌 예금주
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;

		ArrayList<String> tmpOrdrDtlNos = new ArrayList<String>();
		for(String ordrDtlCd : ordrDtlCds) {
			List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
			for (OrdrDtlVO ordrDtlVO : ordrDtlList) {
				tmpOrdrDtlNos.add(EgovStringUtil.integer2string(ordrDtlVO.getOrdrDtlNo()));
			}
		}
		String[] ordrDtlNos = tmpOrdrDtlNos.toArray(new String[tmpOrdrDtlNos.size()]);

		OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
		ordrDtlVO.setOrdrNo(ordrNo);
		ordrDtlVO.setOrdrDtlNos(ordrDtlNos);
		ordrDtlVO.setSttsTy("RE01"); // 반품접수
		ordrDtlVO.setResnTy(resnTy);
		ordrDtlVO.setResn(resn);
		ordrDtlVO.setRfndBank(rfndBank);
		ordrDtlVO.setRfndActno(rfndActno);
		ordrDtlVO.setRfndDpstr(rfndDpstr);
		ordrDtlVO.setRegUniqueId(mbrSession.getUniqueId());
		ordrDtlVO.setRegId(mbrSession.getMbrId());
		ordrDtlVO.setRgtr(mbrSession.getMbrNm());

		//환불정보
		Map<String, Object> rfndMap = new HashMap<String, Object>();
		rfndMap.put("rfndYn", "N");
		rfndMap.put("rfndBank", rfndBank);
		rfndMap.put("rfndActno", rfndActno);
		rfndMap.put("rfndDpstr", rfndDpstr);
		rfndMap.put("mdfcnUniqueId", mbrSession.getUniqueId());
		rfndMap.put("mdfcn_id", mbrSession.getMbrId());
		rfndMap.put("mdfr", mbrSession.getMbrNm());

		Integer resultCnt = ordrDtlService.updateOrdrRE01(ordrDtlVO, rfndMap);
		if(resultCnt == 1){
			result = true;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}


	// 마이페이지 -> 결제진행 (입금대기 or 결제완료)
	// 마이페이지에서는 결제상태만 변경 처리한다.
	@RequestMapping(value = "ordrPayAction")
	public String ordrPayAction(
			OrdrVO ordrVO
			, @RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="stlmYn", required=true) String stlmYn
			, @RequestParam(value="stlmTy", required=true) String stlmTy
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {


		OrdrVO oldOrdrVO = ordrService.selectOrdrByNo(ordrNo);
		if(oldOrdrVO == null) { //
			model.addAttribute("alertMsg", "주문정보가 없습니다.");
			return "/common/msg";
		}

		//DATE CONVERT
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
		SimpleDateFormat output = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(EgovStringUtil.isNotEmpty(ordrVO.getStlmDt())) {
			Date parseStlmDt = format.parse(ordrVO.getStlmDt());
			String convertStlmDt =  output.format(parseStlmDt);
			oldOrdrVO.setStlmDt(convertStlmDt); //결제일
		}
		if(EgovStringUtil.isNotEmpty(ordrVO.getDpstTermDt())) {
			Date parseDpstTermDt = format.parse(ordrVO.getDpstTermDt());
			String convertDpstTermDt =  output.format(parseDpstTermDt);
			oldOrdrVO.setDpstTermDt(convertDpstTermDt);
		}

		int selfBndRt = oldOrdrVO.getOrdrDtlList().get(0).getRecipterInfo().getSelfBndRt();  // 본인부담율

		if(selfBndRt == 0) {
			oldOrdrVO.setStlmYn("Y");

			if("L".equals(oldOrdrVO.getOrdrTy())) {
			 	// 최초 결제 정보 INSERT
				OrdrRebillVO ordrRebillVO = new OrdrRebillVO();
				ordrRebillVO.setOrdrNo(oldOrdrVO.getOrdrNo());
				ordrRebillVO.setOrdrCd(oldOrdrVO.getOrdrCd());
				ordrRebillVO.setOrdrCnt(1);

				ordrRebillVO.setStlmAmt(ordrVO.getStlmAmt());
				ordrRebillVO.setStlmYn("Y");
				ordrRebillVO.setStlmDt(oldOrdrVO.getStlmDt()); //oldOrdrVO

				ordrRebillVO.setDelngNo(ordrVO.getDelngNo());
				ordrRebillVO.setCardCoNm(ordrVO.getCardCoNm());
				ordrRebillVO.setCardNo(ordrVO.getCardNo());
				ordrRebillVO.setCardAprvno(ordrVO.getCardAprvno());

				ordrRebillService.insertOrdrRebill(ordrRebillVO);
			}
		}else if("L".equals(oldOrdrVO.getOrdrTy())) { //대여
			try {
				HashMap<String, Object> res = bootpayApiService.lookupBillingKey(ordrVO.getDelngNo());
				JSONObject json =  new JSONObject(res);
				if(res.get("error_code") == null) { //success
			       	System.out.println("getReceipt success: " + res);
			       	String billingKey = (String) res.get("billing_key");

			       	oldOrdrVO.setStlmYn("Y");
			       	oldOrdrVO.setBillingYn("Y");
			       	oldOrdrVO.setBillingKey(billingKey);
			       	oldOrdrVO.setBillingDay(DateUtil.getDate("dd"));

			       	// 최초 결제 정보 INSERT
					OrdrRebillVO ordrRebillVO = new OrdrRebillVO();
					ordrRebillVO.setOrdrNo(oldOrdrVO.getOrdrNo());
					ordrRebillVO.setOrdrCd(oldOrdrVO.getOrdrCd());
					ordrRebillVO.setOrdrCnt(1);

					ordrRebillVO.setStlmAmt(ordrVO.getStlmAmt());
					ordrRebillVO.setStlmYn("Y");
					ordrRebillVO.setStlmDt(oldOrdrVO.getStlmDt()); //oldOrdrVO

					ordrRebillVO.setDelngNo(ordrVO.getDelngNo());
					ordrRebillVO.setCardCoNm(ordrVO.getCardCoNm());
					ordrRebillVO.setCardNo(ordrVO.getCardNo());
					ordrRebillVO.setCardAprvno(ordrVO.getCardAprvno());

					ordrRebillService.insertOrdrRebill(ordrRebillVO);

			   } else {
			       System.out.println("getReceipt false: " + res);
			       oldOrdrVO.setStlmYn("N");
			   }
			} catch (Exception e) {
			   e.printStackTrace();
			}

		} else {

			// 결제 정보 검증
			try {
				HashMap<String, Object> res = bootpayApiService.confirm(ordrVO.getDelngNo());
				if(res.get("error_code") == null) { //success
					oldOrdrVO.setStlmYn("Y");
				} else {
					oldOrdrVO.setStlmYn("N");
				}
			} catch (Exception e) {
				e.printStackTrace();
				oldOrdrVO.setStlmYn("N");
			}
		}


		//카드정보
		oldOrdrVO.setDelngNo(ordrVO.getDelngNo());
		oldOrdrVO.setCardAprvno(ordrVO.getCardAprvno());
		oldOrdrVO.setCardCoNm(ordrVO.getCardCoNm());
		oldOrdrVO.setCardNo(ordrVO.getCardNo());

		//가상계좌정보
		oldOrdrVO.setVrActno(ordrVO.getVrActno());
		oldOrdrVO.setDpstBankCd(ordrVO.getDpstBankCd());
		oldOrdrVO.setDpstBankNm(ordrVO.getDpstBankNm());
		oldOrdrVO.setDpstr(ordrVO.getDpstr());
		oldOrdrVO.setPyrNm(ordrVO.getPyrNm());


		oldOrdrVO.setStlmAmt(ordrVO.getStlmAmt()); //결제금액
		oldOrdrVO.setStlmDevice(WebUtil.getDevice(request));
		oldOrdrVO.setStlmTy(ordrVO.getStlmTy().toUpperCase());

		ordrDtlService.updateOrdrDtlAndInsertChgHist(oldOrdrVO);

		ordrVO = ordrService.selectOrdrByCd(ordrVO.getOrdrCd());

		String mailHtml = "mail_ordr.html";
		String mailSj = "[이로움ON] 회원님의 주문이 접수 되었습니다.";
		mailFormService.makeMailForm(ordrVO, null, mailHtml, mailSj);

		return "redirect:/"+ marketPath +"/ordr/ordrPayDone/"+ordrVO.getOrdrCd();
	}



	// 사업소 메시지
	@RequestMapping(value="partnersMsg")
	public String partnersMsg(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlNo", required=true) int ordrDtlNo
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {


		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ordrNo", ordrNo);
		paramMap.put("ordrDtlNo", ordrDtlNo);
		paramMap.put("chgStts", "OR03");

		OrdrChgHistVO ordrChgHistVO = ordrChgHistService.selectOrdrChgHist(paramMap);

		model.addAttribute("ordrChgHistVO", ordrChgHistVO);

		return "/market/mypage/ordr/include/modal_partners_msg";
	}


	// 취소 메시지
	@RequestMapping(value="rtrcnMsg")
	public String rtrcnMsg(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlNo", required=true) int ordrDtlNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {


		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ordrNo", ordrNo);
		paramMap.put("ordrDtlNo", ordrDtlNo);
		paramMap.put("chgStts", "OR03");

		OrdrChgHistVO ordrChgHistVOForOR03 = ordrChgHistService.selectOrdrChgHist(paramMap);

		//사업소에서 반려된 상품인 경우 반려 이력으로 반환
		if (ordrChgHistVOForOR03 != null) {
			model.addAttribute("ordrChgHistVO", ordrChgHistVOForOR03);
		} else {
			paramMap.put("chgStts", "CA01");
			
			OrdrChgHistVO ordrChgHistVO = ordrChgHistService.selectOrdrChgHist(paramMap);
			
			model.addAttribute("ordrChgHistVO", ordrChgHistVO);
		}
		

		// 취소상품 정보
		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
		model.addAttribute("ordrDtlList", ordrDtlList);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("ordrCancelTyCode", CodeMap.ORDR_CANCEL_TY);
		model.addAttribute("ordrExchngTyCode", CodeMap.ORDR_EXCHNG_TY);
		model.addAttribute("ordrReturnTyCode", CodeMap.ORDR_RETURN_TY);

		return "/market/mypage/ordr/include/modal_rtrcn_msg";
	}


	// 교환 메시지
	@RequestMapping(value="exchngMsg")
	public String exchngMsg(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlNo", required=true) int ordrDtlNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {


		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ordrNo", ordrNo);
		paramMap.put("ordrDtlNo", ordrDtlNo);
		paramMap.put("chgStts", "EX01");

		OrdrChgHistVO ordrChgHistVO = ordrChgHistService.selectOrdrChgHist(paramMap);

		model.addAttribute("ordrChgHistVO", ordrChgHistVO);


		// 취소상품 정보
		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
		model.addAttribute("ordrDtlList", ordrDtlList);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("ordrCancelTyCode", CodeMap.ORDR_CANCEL_TY);
		model.addAttribute("ordrExchngTyCode", CodeMap.ORDR_EXCHNG_TY);
		model.addAttribute("ordrReturnTyCode", CodeMap.ORDR_RETURN_TY);

		return "/market/mypage/ordr/include/modal_exchng_msg";
	}


	// 반품 메시지
	@RequestMapping(value="returnMsg")
	public String returnMsg(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlNo", required=true) int ordrDtlNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {


		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ordrNo", ordrNo);
		paramMap.put("ordrDtlNo", ordrDtlNo);
		paramMap.put("chgStts", "RE01");

		OrdrChgHistVO ordrChgHistVO = ordrChgHistService.selectOrdrChgHist(paramMap);

		model.addAttribute("ordrChgHistVO", ordrChgHistVO);


		// 환불을 위한 주문정보
		OrdrVO ordrVO = ordrService.selectOrdrByNo(ordrNo);
		model.addAttribute("ordrVO", ordrVO);

		// 취소상품 정보
		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
		model.addAttribute("ordrDtlList", ordrDtlList);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("ordrCancelTyCode", CodeMap.ORDR_CANCEL_TY);
		model.addAttribute("ordrExchngTyCode", CodeMap.ORDR_EXCHNG_TY);
		model.addAttribute("ordrReturnTyCode", CodeMap.ORDR_RETURN_TY);

		return "/market/mypage/ordr/include/modal_return_msg";
	}


}
