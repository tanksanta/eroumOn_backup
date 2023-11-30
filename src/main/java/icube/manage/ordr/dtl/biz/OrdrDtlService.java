package icube.manage.ordr.dtl.biz;

import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Service;

import icube.common.api.biz.BootpayApiService;
import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.values.CodeMap;
import icube.manage.gds.gds.biz.GdsService;
import icube.manage.gds.optn.biz.GdsOptnService;
import icube.manage.ordr.chghist.biz.OrdrChgHistService;
import icube.manage.ordr.chghist.biz.OrdrChgHistVO;
import icube.manage.ordr.ordr.biz.OrdrService;
import icube.manage.ordr.ordr.biz.OrdrVO;
import icube.manage.promotion.coupon.biz.CouponLstService;
import icube.manage.promotion.mlg.biz.MbrMlgService;
import icube.manage.promotion.mlg.biz.MbrMlgVO;
import icube.manage.promotion.point.biz.MbrPointService;
import icube.manage.promotion.point.biz.MbrPointVO;

/**
 * 주문상태 변경
 * 20221122
 * - 관리자 설계와 사용자 설계가 상이함(상태처리)
 * - 최초 상태코드(sttsTy) 변경처리를 통합으로 관리하였으나 수정사항이 너무 많이 발생하여 상태별 변경 메소드를 전체 분리하였음
 * 20221219
 * - 마일리지, 포인트 작업
 *
 */
@Service("ordrDtlService")
public class OrdrDtlService extends CommonAbstractServiceImpl {

	@Resource(name="ordrDtlDAO")
	private OrdrDtlDAO ordrDtlDAO;

	@Resource(name="ordrService")
	private OrdrService ordrService;

	@Resource(name = "gdsService")
	private GdsService gdsService;

	@Resource(name = "gdsOptnService")
	private GdsOptnService gdsOptnService;

	@Resource(name = "mbrMlgService")
	private MbrMlgService mbrMlgService;

	@Resource(name="mbrPointService")
	private MbrPointService mbrPointService;

	@Resource(name = "couponLstService")
	private CouponLstService couponLstService;

	@Resource(name = "ordrChgHistService")
	private OrdrChgHistService ordrChgHistService;

	@Resource(name= "bootpayApiService")
	private BootpayApiService bootpayApiService;

	// 상세(그룹) 주문코드 > 주문리스트
	public List<OrdrDtlVO> selectOrdrDtlList(String ordrDtlCd) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ordrDtlCd", ordrDtlCd);

		return ordrDtlDAO.selectOrdrDtlList(paramMap);
	}

	public OrdrDtlVO selectOrdrDtl(int ordrDtlNo) throws Exception {
		return ordrDtlDAO.selectOrdrDtl(ordrDtlNo);
	}

	public void insertOrdrDtl(OrdrDtlVO ordrDtlVO) throws Exception {

		this.updateOrdrDtlAdjustStock(ordrDtlVO, false);

		ordrDtlDAO.insertOrdrDtl(ordrDtlVO);
	}

	/*재고 조정 
		bAdd : true ==>재고 증가
			: false ==>재고 감소		
	*/
	public void updateOrdrDtlAdjustStock(OrdrDtlVO ordrDtlVO, boolean bAdd) throws Exception {

		Map<String, Object> stockQyMinus = new HashMap<String, Object>();

		/* 재고 처리 */
		if(EgovStringUtil.isEmpty(ordrDtlVO.getOrdrOptn())) {
			stockQyMinus.put("gdsNo", ordrDtlVO.getGdsNo());
			stockQyMinus.put("stockQy", (ordrDtlVO.getOrdrQy() * (bAdd?1:-1)));
			gdsService.updateGdsStockQy(stockQyMinus);
		}else {
			stockQyMinus.put("gdsNo", ordrDtlVO.getGdsNo());
			stockQyMinus.put("optnNm", ordrDtlVO.getOrdrOptn());
			stockQyMinus.put("optnStockQy", (ordrDtlVO.getOrdrQy() * (bAdd?1:-1)));
			gdsOptnService.updateGdsOptnStockQy(stockQyMinus);
		}

	}

	public void updateOrdrDtl(OrdrDtlVO ordrDtlVO) throws Exception {
		ordrDtlDAO.updateOrdrDtl(ordrDtlVO);
	}

	public void updateOrdrDtlCancel(String ordrUniqueId, OrdrDtlVO ordrDtlVO, OrdrChgHistVO chgHistVO) throws Exception {
		
		if (!EgovStringUtil.isEmpty(ordrDtlVO.getCouponCd())){
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("uniqueId", ordrUniqueId);
			paramMap.put("couponNo", ordrDtlVO.getCouponNo());
			paramMap.put("useYn", "N");
			couponLstService.updateCouponUseYn(paramMap);

			ordrDtlVO.setCouponCd("");
			ordrDtlVO.setCouponNo(0);
			ordrDtlVO.setCouponAmt(0);
		}

		ordrDtlVO.setMdfcnId(chgHistVO.getRegId());
		ordrDtlVO.setMdfr(chgHistVO.getRgtr());
		ordrDtlVO.setSttsTy(chgHistVO.getChgStts());

		ordrChgHistService.insertOrdrSttsChgHist(chgHistVO);

		ordrDtlDAO.updateOrdrDtl(ordrDtlVO);

		this.updateOrdrDtlAdjustStock(ordrDtlVO, true);/*재고처리*/

	}

	public void deleteOrdrDtl(int ordrDtlNo) throws Exception {
		ordrDtlDAO.deleteOrdrDtl(ordrDtlNo);
	}

	public void deleteOrdrDtlByNos(String[] arrDelOrdrDtlNo) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ordrDtlNos", arrDelOrdrDtlNo);

		ordrDtlDAO.deleteOrdrDtlByNos(paramMap);
	}

	//옵션변경시 상세주문내역 + 옵션재고 변경 : TO-DO DELETE
	public Integer updateoOptnChg(OrdrDtlVO ordrDtlVO) throws Exception {
		int result = 0;

		try {

			OrdrDtlVO oldOrdrDtlVO = this.selectOrdrDtl(ordrDtlVO.getOrdrDtlNo());

			// 상세주문내역 업데이트
			// 주문가격 = (상품가격 + 옵션가격) * 수량
			ordrDtlVO.setOrdrPc((oldOrdrDtlVO.getGdsPc() +  ordrDtlVO.getOrdrOptnPc()) * ordrDtlVO.getOrdrQy());
			ordrDtlDAO.updateoOptnChg(ordrDtlVO);

			// 전체주문금액 업데이트
			// 결제금액 = ((기존)결제금액 - (기존)주문금액) + 변경급액((상품가격+옵션가격)*수량)
			// OrdrVO ordrVO = ordrService.selectOrdrByNo(ordrDtlVO.getOrdrNo());
			// int stlmAmt = (ordrVO.getStlmAmt() - oldOrdrDtlVO.getOrdrPc()) + ordrDtlVO.getOrdrPc();
			// ordrVO.setStlmAmt(stlmAmt);
			// ordrService.updateStlmAmt(ordrVO);


			// 상품재고 업데이트
			Map<String, Object> stockQyPlus = new HashMap<String, Object>();
			stockQyPlus.put("gdsNo", oldOrdrDtlVO.getGdsNo());
			stockQyPlus.put("optnNm", oldOrdrDtlVO.getOrdrOptn());
			stockQyPlus.put("optnStockQy", ordrDtlVO.getOrdrQy()); // 증가
			gdsOptnService.updateGdsOptnStockQy(stockQyPlus);

			Map<String, Object> stockQyMinus = new HashMap<String, Object>();
			stockQyMinus.put("gdsNo", oldOrdrDtlVO.getGdsNo());
			stockQyMinus.put("optnNm", ordrDtlVO.getOrdrOptn());
			stockQyMinus.put("optnStockQy", (ordrDtlVO.getOrdrQy()*-1)); // 감소
			gdsOptnService.updateGdsOptnStockQy(stockQyMinus);


			result = 1;
		} catch (Exception e) {
			log.debug("FAIL : 상태변경 실패 [" + e.getMessage() + "]");
		}
		return result;
	}


	// 옵션변경
	public Integer modifyOptnChg(OrdrDtlVO ordrDtlVO) throws Exception {
		return ordrDtlDAO.mergeOptnChg(ordrDtlVO);
	}

	// 주문 승인/반려
	public Integer updateOrdrOR02OR03(OrdrDtlVO ordrDtlVO) throws Exception {
		int result = 0;

		try {
			log.debug("STEP.1 : 주문상태 변경(승인/반려) START > " + ordrDtlVO.getSttsTy());
			ordrDtlDAO.updateOrdrStts(ordrDtlVO);

			log.debug("STEP.2 : 주문상태 변경 내역 기록 START : " + ordrDtlVO.getSttsTy());
			for(String dtlno : ordrDtlVO.getOrdrDtlNos()) {
				ordrDtlVO.setOrdrDtlNo(EgovStringUtil.string2integer(dtlno));
				insertOrdrSttsChgHist(ordrDtlVO);
			}
			log.debug("STEP.2 : 주문상태 변경 내역 기록 END");

			result = 1;
		} catch (Exception e) {
			log.debug("FAIL : 상태변경 실패 [" + e.getMessage() + "]");
		}

		return result;
	}


	// 배송준비중 <-> 결제완료
	public Integer updateOrdrOR05OR06(OrdrDtlVO ordrDtlVO) throws Exception {

		int result = 0;
		try {
			ordrDtlDAO.updateOrdrConfrm(ordrDtlVO);
			result = 1;
		} catch (Exception e) {
			log.debug("FAIL : 상태변경 실패 [" + e.getMessage() + "]");
		}

		return result;
	}

	// 배송사+송장번호 저장
	//public Integer updateDlvyCoInfo(Map<String, Object> paramMap) throws Exception {
	public Integer updateOrdrOR07(OrdrDtlVO ordrDtlVO) throws Exception {
		int result = 0;

		try {
			log.debug("STEP.1 : 주문상태 변경(배송+송장번호) START");
			ordrDtlDAO.updateDlvyCoInfo(ordrDtlVO);

			log.debug("STEP.2 : 주문상태 변경 내역 기록 START : " + ordrDtlVO.getSttsTy());
			for(String dtlno : ordrDtlVO.getOrdrDtlNos()) {
				ordrDtlVO.setOrdrDtlNo(EgovStringUtil.string2integer(dtlno));
				insertOrdrSttsChgHist(ordrDtlVO);
			}
			log.debug("STEP.2 : 주문상태 변경 내역 기록 END");

			result = 1;

		} catch (Exception e) {
			log.debug("FAIL : 상태변경 실패 [" + e.getMessage() + "]");
		}

		return result;
	}

	/**
	 * 배송완료 (OR08)
	 * @param ordrDtlVO
	 * @return
	 * @throws Exception
	 */
	public int updateOrdrOR08(OrdrDtlVO ordrDtlVO) throws Exception {
		int result = 0;

		try {
			log.debug("STEP.1 : 주문상태 변경(배송완료) START");
			ordrDtlDAO.updateOrdrStts(ordrDtlVO);

			log.debug("STEP.2 : 주문상태 변경 내역 기록 START : " + ordrDtlVO.getSttsTy());
			for(String dtlno : ordrDtlVO.getOrdrDtlNos()) {
				ordrDtlVO.setOrdrDtlNo(EgovStringUtil.string2integer(dtlno));
				insertOrdrSttsChgHist(ordrDtlVO);
			}

			log.debug("STEP.2 : 주문상태 변경 내역 기록 END");

			result = 1;
		} catch (Exception e) {
			log.debug("FAIL : 상태변경 실패 [" + e.getMessage() + "]");
		}

		return result;
	}

	/**
	 * 구매확정 (OR09)
	 * @param ordrDtlVO
	 * @return
	 * @throws Exception
	 */
	public int updateOrdrOR09(OrdrDtlVO ordrDtlVO) throws Exception {
		int result = 0;

		try {

			OrdrVO ordrVO = ordrService.selectOrdrByNo(ordrDtlVO.getOrdrNo());

			log.debug("STEP.1 : 주문상태 변경(구매확정) START");
			ordrDtlDAO.updateOrdrStts(ordrDtlVO);

			log.debug("STEP.2 : 주문상태 변경 내역 기록 START : " + ordrDtlVO.getSttsTy());
			if(ordrDtlVO.getOrdrDtlNos() != null) {
				for(String dtlno : ordrDtlVO.getOrdrDtlNos()) {
					ordrDtlVO.setOrdrDtlNo(EgovStringUtil.string2integer(dtlno));
					insertOrdrSttsChgHist(ordrDtlVO);
				}
			}else {
				insertOrdrSttsChgHist(ordrDtlVO);
			}

			log.debug("STEP.2 : 주문상태 변경 내역 기록 END");

			// 마일리지 적립
			log.debug("STEP.3 : 마일리지 적립 START : " + ordrDtlVO.getTotalAccmlMlg()); // 1건
			if(ordrDtlVO.getTotalAccmlMlg() > 0) {
				log.debug("STEP.3-1 : 마일리지 내역 기록 ");
				MbrMlgVO mbrMlgVO = new MbrMlgVO();
				mbrMlgVO.setUniqueId(ordrVO.getUniqueId());
				//mbrMlgVO.setOrdrNo(ordrVO.getOrdrNo());
				mbrMlgVO.setOrdrCd(ordrVO.getOrdrCd());
				mbrMlgVO.setOrdrDtlCd(ordrDtlVO.getOrdrDtlCd());
				mbrMlgVO.setMlgSe("A");
				mbrMlgVO.setMlgCn("32");
				mbrMlgVO.setGiveMthd("SYS");
				mbrMlgVO.setMlg(ordrDtlVO.getTotalAccmlMlg());
				log.debug("mlg: " + mbrMlgVO.toString());

				mbrMlgService.insertMbrMlg(mbrMlgVO);
			}
			log.debug("STEP.3 : 마일리지 적립 END");

			result = 1;
		} catch (Exception e) {
			log.debug("FAIL : 상태변경 실패 [" + e.getMessage() + "]");
		}

		return result;
	}
	
	/**
	 * 구매확정 취소(OR09 -> OR08)
	 */
	public int updateCancelOrdrOR09(OrdrDtlVO ordrDtlVO) throws Exception {
		int result = 0;

		try {
			OrdrVO ordrVO = ordrService.selectOrdrByNo(ordrDtlVO.getOrdrNo());
	
			log.debug("STEP.1 : 주문상태 변경(구매확정) START");
			ordrDtlDAO.updateOrdrStts(ordrDtlVO);
	
			log.debug("STEP.2 : 주문상태 변경 내역 기록 START : " + ordrDtlVO.getSttsTy());
			if(ordrDtlVO.getOrdrDtlNos() != null) {
				for(String dtlno : ordrDtlVO.getOrdrDtlNos()) {
					ordrDtlVO.setOrdrDtlNo(EgovStringUtil.string2integer(dtlno));
					insertOrdrSttsChgHist(ordrDtlVO);
				}
			}else {
				insertOrdrSttsChgHist(ordrDtlVO);
			}
	
			log.debug("STEP.2 : 주문상태 변경 내역 기록 END");
			
			// 적립된 마일리지 차감
			log.debug("STEP.3 : 마일리지 차감 START : " + ordrDtlVO.getTotalAccmlMlg()); // 1건
			if(ordrDtlVO.getTotalAccmlMlg() > 0) {
				log.debug("STEP.3-1 : 마일리지 내역 기록 ");
				MbrMlgVO mbrMlgVO = new MbrMlgVO();
				mbrMlgVO.setUniqueId(ordrVO.getUniqueId());
				//mbrMlgVO.setOrdrNo(ordrVO.getOrdrNo());
				mbrMlgVO.setOrdrCd(ordrVO.getOrdrCd());
				mbrMlgVO.setOrdrDtlCd(ordrDtlVO.getOrdrDtlCd());
				mbrMlgVO.setMlgSe("M");
				mbrMlgVO.setMlgCn("32");
				mbrMlgVO.setGiveMthd("SYS");
				mbrMlgVO.setMlg(ordrDtlVO.getTotalAccmlMlg());
				log.debug("mlg: " + mbrMlgVO.toString());
	
				mbrMlgService.insertMbrMlg(mbrMlgVO);
			}
			log.debug("STEP.3 : 마일리지 차감 END");
			
			result = 1;
		} catch (Exception e) {
			log.debug("FAIL : 상태변경 실패 [" + e.getMessage() + "]");
		}

		return result;
	}


	/**
	 * 주문취소 접수 (CA01)
	 * @param ordrDtlVO
	 * @throws Exception
	 */
	public int updateOrdrCA01(OrdrDtlVO ordrDtlVO) throws Exception {
		int result = 0;

		try {
			log.debug("STEP.1 : 전체 주문상태 호출");
			OrdrVO ordrVO = ordrService.selectOrdrByNo(ordrDtlVO.getOrdrNo());

			// STEP.1 : 주문상태 업데이트
			log.debug("STEP.2 : 주문상태 변경(취소접수) START");
			ordrDtlDAO.updateOrdrStts(ordrDtlVO);

			if("VBANK".equals(ordrVO.getStlmTy()) && "Y".equals(ordrVO.getStlmYn())) { //가상계좌 + 결제완료 = 취소접수
				for(String dtlno : ordrDtlVO.getOrdrDtlNos()) { // 주문상세 처리
					OrdrDtlVO oldOrdrDtlVO = this.selectOrdrDtl(EgovStringUtil.string2integer(dtlno));//주문취소는 N건
					//가상계좌 주문취소시 환불정보 입력
					Map<String, Object> rfndMap = new HashMap<String, Object>();
					rfndMap.put("ordrNo", ordrDtlVO.getOrdrNo());
					rfndMap.put("ordrDtlNo", dtlno);

					rfndMap.put("rfndBank", ordrDtlVO.getRfndBank());
					rfndMap.put("rfndActno", ordrDtlVO.getRfndActno());
					rfndMap.put("rfndDpstr", ordrDtlVO.getRfndDpstr());

					Map<String, Object> paramMap = new HashMap<String, Object>();
					paramMap.put("ordrOptnTy", "BASE");
					paramMap.put("ordrCd", ordrVO.getOrdrCd());
					paramMap.put("sttusTy", "CA");
					int lastObj = this.selectLastReturn(paramMap);

					// 주문취소는 배송전 이니 배송비를 차감하지 않음
					// 마지막 건수 판별
					if(lastObj != 1) {
						rfndMap.put("rfndAmt", oldOrdrDtlVO.getOrdrPc() + oldOrdrDtlVO.getDlvyBassAmt() + oldOrdrDtlVO.getDlvyAditAmt() - oldOrdrDtlVO.getCouponAmt());
					}else {
						rfndMap.put("rfndAmt", oldOrdrDtlVO.getOrdrPc() + oldOrdrDtlVO.getDlvyBassAmt() + oldOrdrDtlVO.getDlvyAditAmt() - oldOrdrDtlVO.getCouponAmt() - ordrVO.getUseMlg() - ordrVO.getUsePoint());
					}

					rfndMap.put("mdfcnUniqueId", ordrDtlVO.getRegUniqueId());
					rfndMap.put("mdfcn_id", ordrDtlVO.getRegId());
					rfndMap.put("mdfr", ordrDtlVO.getRgtr());

					ordrDtlDAO.updateOrdrDtlRfndInfo(rfndMap);
				}
			}

			String resn = "";
			log.debug("STEP.3 : 주문상태 변경 내역 기록 START : " + ordrDtlVO.getSttsTy());
			for(String dtlno : ordrDtlVO.getOrdrDtlNos()) {
				ordrDtlVO.setOrdrDtlNo(EgovStringUtil.string2integer(dtlno));
				if("Y".equals(ordrVO.getStlmYn())) {
					ordrDtlVO.setResn("\n환불요청정보 : ["+ordrDtlVO.getRfndBank()+"/"+ordrDtlVO.getRfndActno()+"/"+ordrDtlVO.getRfndDpstr()+"]");
				}
				insertOrdrSttsChgHist(ordrDtlVO);
			}
			log.debug("STEP.4 : 주문상태 변경 내역 기록 END");

			result = 1;
		} catch (Exception e) {
			log.debug("FAIL : 상태변경 실패 [" + e.getMessage() + "]");
		}

		return result;
	}

	/**
	 * 주문취소 완료 (CA02)
	 * @param ordrDtlVO
	 * @return
	 * @throws Exception
	 */
	public int updateOrdrCA02(OrdrDtlVO ordrDtlVO) throws Exception {
		return CancelOrdrDtl(ordrDtlVO);
	}

	/**
	 * 교환접수 (EX01)
	 * @param ordrDtlVO
	 * @throws Exception
	 */
	public int updateOrdrEA01(OrdrDtlVO ordrDtlVO) throws Exception {
		int result = 0;
		try {
			// STEP.1 : 주문상태 업데이트
			log.debug("STEP.1 : 주문상태 변경(교환접수) START");
			ordrDtlDAO.updateOrdrStts(ordrDtlVO);


			log.debug("STEP.2 : 주문상태 변경 내역 기록 START : " + ordrDtlVO.getSttsTy());
			for(String dtlno : ordrDtlVO.getOrdrDtlNos()) {
				ordrDtlVO.setOrdrDtlNo(EgovStringUtil.string2integer(dtlno));
				insertOrdrSttsChgHist(ordrDtlVO);
			}
			log.debug("STEP.2 : 주문상태 변경 내역 기록 END");

			result = 1;
		} catch (Exception e) {
			log.debug("FAIL : 상태변경 실패 [" + e.getMessage() + "]");
		}

		return result;
	}

	/**
	 * 교환접수 승인 (EX02)
	 * @param ordrDtlVO
	 * @return
	 * @throws Exception
	 */
	public int updateOrdrEX02(OrdrDtlVO ordrDtlVO) throws Exception {
		int result = 0;
		try {
			log.debug("STEP.1 : 전체 주문상태 호출");
			OrdrVO ordrVO = ordrService.selectOrdrByNo(ordrDtlVO.getOrdrNo());
			String newOrdrDtlCd = ordrVO.getOrdrCd() +"_"+ (ordrVO.getOrdrDtlList().size()+1);

			log.debug("STEP.2 : 주문상태 변경(교환접수 승인) START");
			ordrDtlDAO.updateOrdrStts(ordrDtlVO);
			log.debug("STEP.3 : 주문상태 변경(교환접수 승인) END");

			LocalDate now = LocalDate.now();
			Date date = java.sql.Date.valueOf(now);

			log.debug("STEP.4 : 동일상품 배송 시작 START");
			for(String dtlno : ordrDtlVO.getOrdrDtlNos()) {
				OrdrDtlVO newOrdrDtlVO = this.selectOrdrDtl(EgovStringUtil.string2integer(dtlno));
				newOrdrDtlVO.setOrdrDtlCd(newOrdrDtlCd);//신규 그룹
				newOrdrDtlVO.setOrdrPc(0);
				newOrdrDtlVO.setSttsTy("OR06");
				newOrdrDtlVO.setSndngDt(date);
				newOrdrDtlVO.setDlvyTy("");
				newOrdrDtlVO.setDlvyHopeYmd("");
				newOrdrDtlVO.setDlvyStlmTy("");
				newOrdrDtlVO.setDlvyBassAmt(0); // 교환 배송비 추가 가능성 있음(니탓? or 내탓?)
				newOrdrDtlVO.setDlvyAditAmt(0);
				newOrdrDtlVO.setDlvyCoNo(0);
				newOrdrDtlVO.setDlvyCoNm("");
				newOrdrDtlVO.setDlvyDt(null);
				newOrdrDtlVO.setDlvyInvcNo("");

				newOrdrDtlVO.setRegUniqueId(ordrDtlVO.getUniqueId());
				newOrdrDtlVO.setRegId(ordrDtlVO.getRegId());
				newOrdrDtlVO.setRgtr(ordrDtlVO.getRgtr());

				newOrdrDtlVO.setResn("교환상품");

				this.insertOrdrDtl(newOrdrDtlVO);

				log.debug("STEP.4-1 : 동일상품 변경내역 기록 START");
				insertOrdrSttsChgHist(newOrdrDtlVO);
				log.debug("STEP.4-1 : 동일상품 변경내역 기록 END");
			}

			log.debug("STEP.4 : 동일상품 배송 시작 END");


			log.debug("STEP.5 : 주문상태 변경 내역 기록 START : " + ordrDtlVO.getSttsTy());
			for(String dtlno : ordrDtlVO.getOrdrDtlNos()) {
				ordrDtlVO.setOrdrDtlNo(EgovStringUtil.string2integer(dtlno));
				insertOrdrSttsChgHist(ordrDtlVO);
			}
			log.debug("STEP.5 : 주문상태 변경 내역 기록 END");

			result = 1;
		} catch (Exception e) {
			log.debug("FAIL : 상태변경 실패 [" + e.getMessage() + "]");
		}

		return result;
	}


	/**
	 * 교환완료 (EX03)
	 * @param ordrDtlVO
	 * @return
	 * @throws Exception
	 */
	public int updateOrdrEX03(OrdrDtlVO ordrDtlVO) throws Exception {
		int result = 0;
		try {
			// STEP.1 : 주문상태 업데이트
			log.debug("STEP.1 : 주문상태 변경(교환완료) START");
			ordrDtlDAO.updateOrdrStts(ordrDtlVO);


			log.debug("STEP.2 : 주문상태 변경 내역 기록 START : " + ordrDtlVO.getSttsTy());
			for(String dtlno : ordrDtlVO.getOrdrDtlNos()) {
				ordrDtlVO.setOrdrDtlNo(EgovStringUtil.string2integer(dtlno));
				insertOrdrSttsChgHist(ordrDtlVO);
			}
			log.debug("STEP.2 : 주문상태 변경 내역 기록 END");

			result = 1;
		} catch (Exception e) {
			log.debug("FAIL : 상태변경 실패 [" + e.getMessage() + "]");
		}
		return result;
	}


	/**
	 * 반품접수 (RE01)
	 * @param ordrDtlVO
	 */
	public int updateOrdrRE01(OrdrDtlVO ordrDtlVO, Map<String, Object> rfndMap) throws Exception {
		int result = 0;
		try {

			log.debug("STEP.1 : 전체 주문상태 호출");
			OrdrVO ordrVO = ordrService.selectOrdrByNo(ordrDtlVO.getOrdrNo());

			log.debug("STEP.2 : 주문상태 변경(반품접수) START");
			ordrDtlDAO.updateOrdrStts(ordrDtlVO);

			log.debug("STEP.3 : 환불정보 입력 START");
			for(String dtlno : ordrDtlVO.getOrdrDtlNos()) {
				OrdrDtlVO oldOrdrDtlVO = this.selectOrdrDtl(EgovStringUtil.string2integer(dtlno));//주문취소는 N건
				rfndMap.put("ordrNo", oldOrdrDtlVO.getOrdrNo());
				rfndMap.put("ordrDtlNo", oldOrdrDtlVO.getOrdrDtlNo());
				rfndMap.put("rfndAmt", oldOrdrDtlVO.getOrdrPc() ); //반품의 경우 배송비 처리?

				ordrDtlDAO.updateOrdrDtlRfndInfo(rfndMap);


				log.debug("STEP.3-1 : 주문상태 변경 내역 기록 START : " + ordrDtlVO.getSttsTy());
				ordrDtlVO.setOrdrDtlNo(EgovStringUtil.string2integer(dtlno));

				if("CARD".equals(ordrVO.getStlmTy())) { //결제타입이 카드면
					//ordrDtlVO.setResn(ordrDtlVO.getResn().concat("카드 승인취소 요청"));
				}

				insertOrdrSttsChgHist(ordrDtlVO);
				log.debug("STEP.3-1 : 주문상태 변경 내역 기록 END");
			}
			log.debug("STEP.3 : 환불정보 입력 END");

			// 진행사항 > 반품사유 추가
			// resn = resn.concat("\n환불요청정보:["+rfndBank+"/"+rfndActno+"/"+rfndDpstr+"/"+rfndAmt+"원]");

			result = 1;
		} catch (Exception e) {
			log.debug("FAIL : 상태변경 실패 [" + e.getMessage() + "]");
		}
		return result;
	}

	/**
	 * 반품접수 승인 (RE02)
	 * @param ordrDtlVO
	 * @return
	 * @throws Exception
	 */
	public int updateOrdrRE02(OrdrDtlVO ordrDtlVO) throws Exception {
		int result = 0;
		try {
			// STEP.1 : 주문상태 업데이트
			log.debug("STEP.1 : 주문상태 변경(반품접수 승인) START");
			ordrDtlDAO.updateOrdrStts(ordrDtlVO);


			log.debug("STEP.2 : 주문상태 변경 내역 기록 START : " + ordrDtlVO.getSttsTy());
			for(String dtlno : ordrDtlVO.getOrdrDtlNos()) {
				ordrDtlVO.setOrdrDtlNo(EgovStringUtil.string2integer(dtlno));
				insertOrdrSttsChgHist(ordrDtlVO);
			}
			log.debug("STEP.2 : 주문상태 변경 내역 기록 END");

			result = 1;
		} catch (Exception e) {
			log.debug("FAIL : 상태변경 실패 [" + e.getMessage() + "]");
		}
		return result;
	}


	/**
	 * 반품완료 (RE03)
	 * @param ordrDtlVO
	 * @return
	 * @throws Exception
	 */
	public int updateOrdrRE03(OrdrDtlVO ordrDtlVO, String[] ordrDtlNos) throws Exception {
		int resultCtn = CancelOrdrDtl(ordrDtlVO);
		
		//쿠폰 사용 처리 취소
		for(String ordrDtlNo : ordrDtlNos) {
			OrdrDtlVO ordrrDtlVO = this.selectOrdrDtl(EgovStringUtil.string2integer(ordrDtlNo));
			String couponCd = ordrrDtlVO.getCouponCd();

			if (EgovStringUtil.isNotEmpty(couponCd)) {
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("srchUseYn", "N");
				paramMap.put("srchCouponCd", couponCd);

				couponLstService.updateCouponUseYnNull(paramMap);
			}
		}
		
		return resultCtn;
	}


	public Integer updateOrdrRF02(OrdrDtlVO ordrDtlVO) throws Exception {
		int result = 0;
		try {
			// STEP.1 : 주문상태 업데이트
			log.debug("STEP.1 : 주문상태 변경(환불완료) START");
			ordrDtlDAO.updateOrdrStts(ordrDtlVO);


			/*
			//무통장 입금해주는 경우
			OrdrVO ordrVO = ordrService.selectOrdrByNo(ordrDtlVO.getOrdrNo());
			OrdrDtlVO oldOrdrDtlVO = this.selectOrdrDtl(ordrDtlVO.getOrdrDtlNo());

			// 결제금액
			int stlmAmt = ordrVO.getStlmAmt() - oldOrdrDtlVO.getRfndAmt();
			ordrVO.setStlmAmt(stlmAmt);
			ordrService.updateStlmAmt(ordrVO);

			Map<String, Object> rfndMap = new HashMap<String, Object>();
			rfndMap.put("ordrNo", oldOrdrDtlVO.getOrdrNo());
			rfndMap.put("ordrDtlNos", ArrayUtil.stringToArray(EgovStringUtil.integer2string(oldOrdrDtlVO.getOrdrDtlNo())) );
			rfndMap.put("rfndYn", "Y"); //환불완료
			rfndMap.put("rfndBank", oldOrdrDtlVO.getRfndBank());
			rfndMap.put("rfndActno", oldOrdrDtlVO.getRfndActno());
			rfndMap.put("rfndDpstr", oldOrdrDtlVO.getRfndDpstr());
			rfndMap.put("rfndAmt", oldOrdrDtlVO.getRfndAmt());

			if(mngrSession.isLoginCheck()) { // 관리자 로그인
				rfndMap.put("mdfcnUniqueId", mngrSession.getUniqueId());
				rfndMap.put("mdfcn_id", mngrSession.getMngrId());
				rfndMap.put("mdfr", mngrSession.getMngrNm());
			} else if(partnersSession.isLoginCheck()) { // 파트너스 로그인
				rfndMap.put("mdfcnUniqueId", partnersSession.getUniqueId());
				rfndMap.put("mdfcn_id", partnersSession.getPartnersId());
				rfndMap.put("mdfr", partnersSession.getPartnersNm());
			}

			//this.updateOrdrDtlRfndInfo(rfndMap);
			ordrDtlDAO.updateOrdrDtlRfndInfo(rfndMap);

			resn = resn.concat("\n[반품완료 > 관리자 환불처리]");

			log.debug("주문상세 상태변경내역 기록 S");
			*/


			log.debug("STEP.2 : 주문상태 변경 내역 기록 START : " + ordrDtlVO.getSttsTy());
			for(String dtlno : ordrDtlVO.getOrdrDtlNos()) {
				ordrDtlVO.setOrdrDtlNo(EgovStringUtil.string2integer(dtlno));
				insertOrdrSttsChgHist(ordrDtlVO);
			}
			log.debug("STEP.2 : 주문상태 변경 내역 기록 END");

			result = 1;
		} catch (Exception e) {
			log.debug("FAIL : 상태변경 실패 [" + e.getMessage() + "]");
		}
		return result;

	}

	/**
	 * 결제완료 처리
	 * @param ordrDtlCd
	 */
	public void updateOrdrOR05(String ordrCd) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ordrCd", ordrCd);

		log.debug("STEP.1 : 결제완료 처리 START");
		ordrDtlDAO.updateOrdrSttsByOrdrCd(paramMap);
		log.debug("STEP.1 : 결제완료 처리 END");



		log.debug("STEP.2 : 전체 주문상태 호출");
		OrdrVO ordrVO = ordrService.selectOrdrByCd(ordrCd);

		log.debug("STEP.3 : 주문상태 변경 내역 기록 START");
		for(OrdrDtlVO ordrDtlVO : ordrVO.getOrdrDtlList()) {
			if(EgovStringUtil.equals("OR04", ordrDtlVO.getSttsTy())) { //결제대기 상태만 변경 처리
				OrdrChgHistVO chgHistVO = new OrdrChgHistVO();
				chgHistVO.setOrdrNo(ordrDtlVO.getOrdrNo());
				chgHistVO.setOrdrDtlNo(ordrDtlVO.getOrdrDtlNo());
				chgHistVO.setChgStts("OR05");
				chgHistVO.setResnTy(null);
				chgHistVO.setResn("결제완료 확인");

				chgHistVO.setRegUniqueId(null);
				chgHistVO.setRegId("SYSTEM");
				chgHistVO.setRgtr("BOOTPAY");
				ordrChgHistService.insertOrdrSttsChgHist(chgHistVO);
			}
		}
		log.debug("STEP.3 : 주문상태 변경 내역 기록 END");
	}


	/**
	 * 상태 변경내역 기록
	 * @param ordrDtlVO
	 * @throws Exception
	 */
	public int insertOrdrSttsChgHist(OrdrDtlVO ordrDtlVO) throws Exception {
		OrdrChgHistVO chgHistVO = new OrdrChgHistVO();
		chgHistVO.setOrdrNo(ordrDtlVO.getOrdrNo());
		chgHistVO.setOrdrDtlNo(ordrDtlVO.getOrdrDtlNo());
		chgHistVO.setChgStts(ordrDtlVO.getSttsTy());
		chgHistVO.setResnTy(ordrDtlVO.getResnTy());
		chgHistVO.setResn(ordrDtlVO.getResn());

		chgHistVO.setRegUniqueId(ordrDtlVO.getRegUniqueId());
		chgHistVO.setRegId(ordrDtlVO.getRegId());
		chgHistVO.setRgtr(ordrDtlVO.getRgtr());
		return ordrChgHistService.insertOrdrSttsChgHist(chgHistVO);
	}


	/**
	 * 특정 단계 제외 카운트
	 * @param paramMap
	 * @throws Exception
	 */
	public int selectExSttsTyCnt(Map<String, Object> paramMap) throws Exception{
		return ordrDtlDAO.selectExSttsTyCnt(paramMap);
	}

	/**
	 * 이전 선택 사업소
	 * @param dtlMap
	 * @throws Exception
	 */
	public OrdrDtlVO selectOrdrDtlHistory(Map<String, Object> dtlMap) throws Exception {
		return ordrDtlDAO.selectOrdrDtlHistory(dtlMap);
	}

	/**
	 * 스케줄러 상태조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<OrdrDtlVO> selectOrdrSttsList(Map<String, Object> paramMap) throws Exception {
		return ordrDtlDAO.selectOrdrSttsList(paramMap);
	}

	/**
	 * 마지막 상품 판별
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectLastReturn(Map<String, Object> paramMap) throws Exception {
		return ordrDtlDAO.selectLastReturn(paramMap);
	}

	/**
	 * API 용 사업소 승인/반려 업데이트
	 * @param paramMap
	 * @throws Exception
	 */
	public Integer updateBplcSttus(Map<String, Object> paramMap) throws Exception {
		return ordrDtlDAO.updateBplcSttus(paramMap);
	}

	/**
	 * 주문 취소 && 쿠폰 환급 통합
	 * @param ordrNo
	 * @param ordrDtlVO
	 * @param ordrDtlNos
	 * @return resultMap
	 */
	public Integer updateCA02AndReturnCoupon(int ordrNo, OrdrDtlVO ordrDtlVO, String[] ordrDtlNos) throws Exception {
		Integer resultCnt = this.updateOrdrCA02(ordrDtlVO);

		//쿠폰 사용 처리 취소
		for(String ordrDtlNo : ordrDtlNos) {
			OrdrDtlVO ordrrDtlVO = this.selectOrdrDtl(EgovStringUtil.string2integer(ordrDtlNo));
			String couponCd = ordrrDtlVO.getCouponCd();

			if (EgovStringUtil.isNotEmpty(couponCd)) {
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("srchUseYn", "N");
				paramMap.put("srchCouponCd", couponCd);

				couponLstService.updateCouponUseYnNull(paramMap);
			}
		}

		return resultCnt;
	}

	/**
	 * 주문 확정 && 히스토리 변경 통합
	 * @param ordrDtlVO
	 * @throws Exception
	 */
	public void updateOrdr0506AndOrdrChgHist(OrdrDtlVO ordrDtlVO) throws Exception {

		Integer resultCnt = this.updateOrdrOR05OR06(ordrDtlVO);

		if(resultCnt > 1){
			String resn = "주문확정";
			if("OR05".equals(ordrDtlVO.getSttsTy())) {
				resn = "주문확정 취소";
			}
			ordrChgHistService.insertOrdrSttsChgHist(ordrDtlVO.getOrdrNo(), ordrDtlVO.getOrdrDtlNo(), "", resn, ordrDtlVO.getSttsTy());
		}
	}
	
	/**
	 * 배송중 -> 배송준비중 && 히스토리 변경 통합
	 * @param ordrDtlVO
	 * @throws Exception
	 */
	public void updateOrdr06AndOrdrChgHist(OrdrDtlVO ordrDtlVO) throws Exception {
		
		ordrDtlDAO.updateDlvyPreparing(ordrDtlVO);
		
		ordrChgHistService.insertOrdrSttsChgHist(ordrDtlVO.getOrdrNo(), ordrDtlVO.getOrdrDtlNo(), "", "배송중 취소", "OR06");
	}

	/**
	 * 결제완료, 대기 업데이트 && 히스토리 기록
	 * @param oldOrdrVO
	 * @throws Exception
	 */
	public void updateOrdrDtlAndInsertChgHist(OrdrVO oldOrdrVO) throws Exception {

		ordrService.updateOrdr(oldOrdrVO);

		for(OrdrDtlVO ordrDtlVO : oldOrdrVO.getOrdrDtlList()) {
			if("OR02".equals(ordrDtlVO.getSttsTy())) { //승인완료건만
				String resn = "";
				if(EgovStringUtil.equals("Y", oldOrdrVO.getStlmYn())) {
					ordrDtlVO.setSttsTy("OR05");
					resn = "결제완료";
				}else {
					ordrDtlVO.setSttsTy("OR04");
					resn = "결제대기";
				}

				this.updateOrdrDtl(ordrDtlVO);

				// 히스토리 기록
				ordrDtlVO.setResn(resn);
				this.insertOrdrSttsChgHist(ordrDtlVO);
			}
		}

	}

	/**
	 * 주문취소, 반품완료 시 사용(결제 취소 및 결제 이전 상황으로 복원)
	 * @param ordrDtlVO
	 */
	private int CancelOrdrDtl(OrdrDtlVO ordrDtlVO) {
		int result = 0;
		try {
			log.debug("STEP.1 : 전체 주문상태 호출");
			OrdrVO ordrVO = ordrService.selectOrdrByNo(ordrDtlVO.getOrdrNo());
			int asisStlmAmt = ordrVO.getStlmAmt(); //이전 결제금액

			
			log.debug("STEP.2 : 주문취소 금액 계산 START >> "+ ordrVO.getStlmTy());

			int totalOrdrPc = 0; //환불 받을 전체 상품 주문금액
			int totalDlvyPc = 0; //환불 받을 전체 배송비
			
			// 취소금액 계산
			for(String dtlno : ordrDtlVO.getOrdrDtlNos()) { 
				OrdrDtlVO oldOrdrDtlVO = this.selectOrdrDtl(EgovStringUtil.string2integer(dtlno)); //주문취소는 N건
				totalOrdrPc += oldOrdrDtlVO.getOrdrPc();
				
				//결제완료, 배송준비중은 배송비 환불 (배솧비는 배송중 이후에는 환불 받을 수 없다.)
				if ("OR05".equals(oldOrdrDtlVO.getSttsTy()) || "OR06".equals(oldOrdrDtlVO.getSttsTy())) {
					totalDlvyPc += oldOrdrDtlVO.getDlvyBassAmt() + oldOrdrDtlVO.getDlvyAditAmt();
				}
			}
			
			
			//전체 환불 금액(상품 가격 + 배송비)
			int totalCancelPc = totalOrdrPc + totalDlvyPc;
			//pg사 취소 요청 금액
			int requestCancelPriceForPG = 0;
			//pg사 취소 후 남은 환불 금액
			int remindCancelPc = 0;
			if(asisStlmAmt >= totalCancelPc) {  // 결제금액이 취소할 금액보다 많거나 같은 경우는 전체 금액 PG사 취소 요청
				requestCancelPriceForPG = totalCancelPc;
			} else { // 결재금액이 취소할 금액보다 적은 경우 결재금액 만큼만 PG사 취소 요청
				requestCancelPriceForPG = asisStlmAmt;
				remindCancelPc = totalCancelPc - requestCancelPriceForPG;
			}
			
			

			log.debug("STEP.3 : 주문결제 상태 확인 START >> " + ordrVO.getStlmTy() + "/" + ordrVO.getStlmYn());
			boolean rfndAction = false;
			
			//PG에 취소 요청할 필요가 없는 경우(전부 마일리지 or 포인트 결제인 경우)
			if (requestCancelPriceForPG == 0) {
				log.debug("PG사에 취소할 결제금액이 없음");
			} else if(("CARD".equals(ordrVO.getStlmTy()) && "Y".equals(ordrVO.getStlmYn()))
					|| ("BANK".equals(ordrVO.getStlmTy()) && "Y".equals(ordrVO.getStlmYn()))
					|| ("VBANK".equals(ordrVO.getStlmTy()) && "N".equals(ordrVO.getStlmYn()))){ // (카드/계좌이체) 결제완료 상태 or 가상계좌 발급(결제x) 상태

				log.debug("STEP.3-1 : PG취소 START >> 금액 : " + totalOrdrPc);
				try {
					HashMap<String, Object> res = bootpayApiService.receiptCancel(ordrVO.getDelngNo(), ordrDtlVO.getRgtr(), (double) requestCancelPriceForPG);

				    if(res.get("error_code") == null) { //success
				        log.debug("receiptCancel success: " + res);
				        rfndAction = true;
				    } else {
				        log.debug("receiptCancel false: " + res);

				        //기존 취소거래 일수 있음
				        if("기 취소 거래".equals(res.get("message"))) {
				        	rfndAction = true;
				        }
				    }
				} catch (Exception e) {
				    log.error("====PG사 결제 취소 오류====", e);
				}

				log.debug("STEP.3-1 : PG취소 END");

			} else if("VBANK".equals(ordrVO.getStlmTy()) && "Y".equals(ordrVO.getStlmYn())){ // 가상계좌 결제o 상태 -> CMS특약이 있어야 취소 가능
				log.debug("STEP.3-2 : 가상계좌 결제 취소 START");
				rfndAction = true;
				log.debug("STEP.3-2 : 가상계좌 결제 취소 END");
			} else {
				log.debug("STEP.3-2 : 결제 취소 없음");
			}

			
			//결제 취소가 된 경우 결제금액을 차감
			if(rfndAction && asisStlmAmt > 0) {
				log.debug("STEP.3-3 : 주문상태 > 전체 결제금액 조정");
				
				int stlmAmt = asisStlmAmt - requestCancelPriceForPG; //전체결제금액 - PG사 취소 금액
				ordrVO.setStlmAmt(stlmAmt);
				ordrService.updateStlmAmt(ordrVO);
			}
			
				
			log.debug("STEP.3-4 : 주문상태 상세정보 loop > 환불정보 업데이트");

			for(String dtlno : ordrDtlVO.getOrdrDtlNos()) { // 주문상세 처리
				OrdrDtlVO oldOrdrDtlVO = this.selectOrdrDtl(EgovStringUtil.string2integer(dtlno)); //주문취소는 N건

				Map<String, Object> rfndMap = new HashMap<String, Object>();
				String resn = "";
				
				rfndMap.put("ordrNo", ordrDtlVO.getOrdrNo());
				rfndMap.put("ordrDtlNo", oldOrdrDtlVO.getOrdrDtlNo());
				rfndMap.put("rfndBank", oldOrdrDtlVO.getRfndBank());
				rfndMap.put("rfndActno", oldOrdrDtlVO.getRfndActno());
				rfndMap.put("rfndDpstr", oldOrdrDtlVO.getRfndDpstr());
				rfndMap.put("rfndYn", "Y");

				
				int totalRfndAmt = oldOrdrDtlVO.getOrdrPc();
				//결제완료, 배송준비중은 배송비까지 환불 금액에 추가
				if ("OR05".equals(oldOrdrDtlVO.getSttsTy()) || "OR06".equals(oldOrdrDtlVO.getSttsTy())) {
					totalRfndAmt += oldOrdrDtlVO.getDlvyBassAmt() + oldOrdrDtlVO.getDlvyAditAmt();
				}
				
				//각 상품별 PG사 환불금액 입력
				if (requestCancelPriceForPG >= totalRfndAmt) {
					rfndMap.put("rfndAmt", totalRfndAmt);
					requestCancelPriceForPG -= totalRfndAmt;
				} else {
					rfndMap.put("rfndAmt", requestCancelPriceForPG);
					requestCancelPriceForPG = 0;
				}
				
				rfndMap.put("mdfcnUniqueId", ordrDtlVO.getRegUniqueId());
				rfndMap.put("mdfcn_id", ordrDtlVO.getRegId());
				rfndMap.put("mdfr", ordrDtlVO.getRgtr());
				ordrDtlDAO.updateOrdrDtlRfndInfo(rfndMap);


				log.debug("STEP.3-5 : 상품 재고 업데이트 START");
				Map<String, Object> stockQyPlus = new HashMap<String, Object>();
				if(EgovStringUtil.isNotEmpty(oldOrdrDtlVO.getOrdrOptn())){
					log.debug("STEP.3-5-1 : 옵션 있음");
					stockQyPlus.put("gdsNo", oldOrdrDtlVO.getGdsNo());
					stockQyPlus.put("optnNm", oldOrdrDtlVO.getOrdrOptn());
					stockQyPlus.put("optnStockQy", oldOrdrDtlVO.getOrdrQy()); // 증가
					gdsOptnService.updateGdsOptnStockQy(stockQyPlus);
				}else {
					log.debug("STEP.3-5-1 : 옵션 없음");
					stockQyPlus.put("gdsNo", oldOrdrDtlVO.getGdsNo());
					stockQyPlus.put("stockQy", oldOrdrDtlVO.getOrdrQy()); // 증가
					gdsService.updateGdsStockQy(stockQyPlus);
				}
				log.debug("STEP.3-5 : 상품 재고 업데이트 END");


				log.debug("STEP.3-6 : 주문상태 변경 내역 기록 START : " + ordrDtlVO.getSttsTy());
				//기본은 CA02 주문취소
				if(EgovStringUtil.isNotEmpty(ordrVO.getStlmTy())) {
					resn = "\n주문취소:["+ CodeMap.BASS_STLM_TY.get(ordrVO.getStlmTy()) +":"+ totalRfndAmt +"원]";
				}
				
				//RE03 반품완료 인경우
				if ("RE03".equals(ordrDtlVO.getSttsTy())) {
					if(ordrVO.getStlmTy().equals("CARD")) {
						resn = "\n반품완료 : [신용카드 승인 취소]";
					} else if (ordrVO.getStlmTy().equals("FREE")) {
						resn = "\n반품완료 : [마일리지, 포인트 결제 취소]";
					} else {
						resn = "\n반품완료 : [계좌이체(" +ordrDtlVO.getRfndBank() +" : "+ ordrDtlVO.getRfndActno()+") : "+ totalOrdrPc +"원]";
					}
				}
				

				OrdrChgHistVO chgHistVO = new OrdrChgHistVO();
				chgHistVO.setOrdrNo(oldOrdrDtlVO.getOrdrNo());
				chgHistVO.setOrdrDtlNo(oldOrdrDtlVO.getOrdrDtlNo());
				chgHistVO.setChgStts(ordrDtlVO.getSttsTy());
				chgHistVO.setResnTy(ordrDtlVO.getResnTy());
				chgHistVO.setResn(ordrDtlVO.getResn().concat(resn));

				chgHistVO.setRegUniqueId(ordrDtlVO.getRegUniqueId());
				chgHistVO.setRegId(ordrDtlVO.getRegId());
				chgHistVO.setRgtr(ordrDtlVO.getRgtr());

				log.debug("chgHistVO: " + chgHistVO.toString());
				ordrChgHistService.insertOrdrSttsChgHist(chgHistVO);
				log.debug("STEP.3-6 : 주문상태 변경 내역 기록 END");


				log.debug("STEP.3-7 : 적립마일리지 취소 START" + ordrDtlVO.getAccmlMlg());

				//구매확정 시 마일리지가 쌓이므로 구매확정 상태확인하여 적립 마일리지 취소 처리
				if("OR09".equals(oldOrdrDtlVO.getSttsTy()) && ordrDtlVO.getAccmlMlg() > 0) {
					// 적립마일리지 취소
					MbrMlgVO mbrMlgVO = new MbrMlgVO();
					mbrMlgVO.setUniqueId(ordrVO.getUniqueId());
					mbrMlgVO.setOrdrCd(ordrVO.getOrdrCd());
					mbrMlgVO.setOrdrDtlCd(ordrDtlVO.getOrdrDtlCd());
					mbrMlgVO.setMlgSe("M"); // 차감
					mbrMlgVO.setMlgCn("12"); // 상품 취소
					mbrMlgVO.setGiveMthd("SYS");
					mbrMlgVO.setMlg(ordrDtlVO.getAccmlMlg());

					mbrMlgService.insertMbrMlg(mbrMlgVO);
				}
				log.debug("STEP.3-7 : 적립마일리지 취소 기록 END");
			}

			
			log.debug("STEP.4 : 주문상태 변경(취소완료 or 반품완료) START");
			ordrDtlDAO.updateOrdrStts(ordrDtlVO);
			log.debug("STEP.4 : 주문결제 상태 확인 END");

			
			log.debug("STEP.5 : 마일리지, 포인트 환원 START");

			// PG 결제 취소 후 환불해야할 금액이 남는다면 포인트 환원
			if(remindCancelPc > 0) {
				// 사용 포인트
				int usePoint = ordrVO.getUsePoint();
				
				if(usePoint > 0) {
					// 환불 포인트 계산
					int returnPoint = 0;
					if (remindCancelPc > usePoint) {
						returnPoint = usePoint;
						remindCancelPc -= usePoint;
					} else {
						returnPoint = remindCancelPc;
						remindCancelPc = 0;
					}
					
					MbrPointVO mbrPointVO = new MbrPointVO();
					mbrPointVO.setPointMngNo(0);
					mbrPointVO.setUniqueId(ordrVO.getUniqueId());
					mbrPointVO.setPointSe("A");
					mbrPointVO.setPointCn("33");
					mbrPointVO.setPoint(returnPoint);
					mbrPointVO.setRgtr("System");
					mbrPointVO.setGiveMthd("SYS");

					mbrPointService.insertMbrPoint(mbrPointVO);
					
					//사용 포인트 업데이트
					ordrVO.setUsePoint(usePoint - returnPoint);
					ordrService.updateUsePoint(ordrVO);
				}
			}
			//PG 결제 취소 후 환불해야할 금액이 남는다면 마일리지 환원
			if(remindCancelPc > 0) {
				// 사용 마일리지
				int useMlg = ordrVO.getUseMlg();

				if(useMlg > 0) {
					// 환불 마일리지 계산
					int returnMlg = 0;
					if (remindCancelPc > useMlg) {
						returnMlg = useMlg;
						remindCancelPc -= useMlg;
					} else {
						returnMlg = remindCancelPc;
						remindCancelPc = 0;
					}
					
					MbrMlgVO mbrMlgVO = new MbrMlgVO();
					mbrMlgVO.setMlgMngNo(0);
					mbrMlgVO.setUniqueId(ordrVO.getUniqueId());
					mbrMlgVO.setMlgSe("A");
					mbrMlgVO.setMlgCn("33");
					mbrMlgVO.setMlg(returnMlg);
					mbrMlgVO.setGiveMthd("SYS");
					mbrMlgVO.setRgtr("System");

					mbrMlgService.insertMbrMlg(mbrMlgVO);
					
					//사용 마일리지 업데이트
					ordrVO.setUseMlg(useMlg - returnMlg);
					ordrService.updateUseMlg(ordrVO);
				}
			}
			log.debug("STEP.5 : 마일리지, 포인트 환원 END");

			result = 1;
		} catch (Exception e) {
			log.debug("FAIL : 상태변경 실패 [" + e.getMessage() + "]");
		}

		return result;
	}
}
