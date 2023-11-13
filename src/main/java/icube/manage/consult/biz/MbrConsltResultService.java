package icube.manage.consult.biz;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.mail.MailService;
import icube.common.util.DateUtil;
import icube.common.util.FileUtil;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.members.bplc.biz.BplcService;
import icube.manage.members.bplc.biz.BplcVO;

@Service("mbrConsltResultService")
public class MbrConsltResultService extends CommonAbstractServiceImpl {

	@Resource(name="mbrConsltDAO")
	private MbrConsltDAO mbrConsltDAO;

	@Resource(name="mbrConsltResultDAO")
	private MbrConsltResultDAO mbrConsltResultDAO;
	
	@Resource(name = "bplcService")
	private BplcService bplcService;
	
	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;
	
	@Resource(name = "mailService")
	private MailService mailService;
	
	@Value("#{props['Profiles.Active']}")
	private String activeMode;
	
	@Value("#{props['Mail.Form.FilePath']}")
	private String mailFormFilePath;

	@Value("#{props['Mail.Username']}")
	private String sendMail;
	
	private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
	

	public CommonListVO selectMbrConsltResultListVO(CommonListVO listVO) throws Exception {

		listVO = mbrConsltResultDAO.selectMbrConsltResultListVO(listVO);

		List<MbrConsltResultVO> consltList = listVO.getListObject();
		for(MbrConsltResultVO mbrConsltResultVO : consltList) {
			int yyyy =  EgovStringUtil.string2integer(mbrConsltResultVO.getMbrConsltInfo().getBrdt().substring(0, 4));
			int mm =  EgovStringUtil.string2integer(mbrConsltResultVO.getMbrConsltInfo().getBrdt().substring(4, 6));
			int dd =  EgovStringUtil.string2integer(mbrConsltResultVO.getMbrConsltInfo().getBrdt().substring(6, 8));
			mbrConsltResultVO.getMbrConsltInfo().setAge(DateUtil.getRealAge(yyyy, mm, dd));
		}

		return listVO;
	}

	public int insertMbrConsltBplc(MbrConsltResultVO mbrConsltResultVO) throws Exception {
		return mbrConsltResultDAO.insertMbrConsltBplc(mbrConsltResultVO);
	}

	public int updateDtlsConslt(MbrConsltResultVO mbrConsltResultVO) throws Exception {

		Map<String, Object> paramMap = new HashMap<String,Object>();
		paramMap.put("consltNo", mbrConsltResultVO.getConsltNo());
		paramMap.put("consltSttus", "CS06"); // 상담완료
		mbrConsltDAO.updateSttus(paramMap);

		return mbrConsltResultDAO.updateDtlsConslt(mbrConsltResultVO);
	}

	public MbrConsltResultVO selectMbrConsltBplc(Map<String, Object> paramMap) throws Exception {
		return mbrConsltResultDAO.selectMbrConsltBplc(paramMap);
	}
	
	public MbrConsltResultVO selectMbrConsltResultByBplcNo(int bplcConsltNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("srchBplcConsltNo", bplcConsltNo);
		return mbrConsltResultDAO.selectMbrConsltBplc(paramMap);
	}
	
	//상담에 연결된 사업소 상담 수 가져오기
	public int selectMbrConsltBplcCntByConsltNo(int consltNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String,Object>();
		paramMap.put("srchConsltNo", consltNo);
		return mbrConsltResultDAO.selectMbrConsltResultCount(paramMap);
	}

	// 사업소에서 취소(같은 상태로 업데이트)
	public int updateCanclConslt(Map<String, Object> paramMap) throws Exception {
		mbrConsltDAO.updateCanclConslt(paramMap); // 상담취소
		return mbrConsltResultDAO.updateCanclConslt(paramMap); // 사업소 상담취소
	}

	// 사업소에서 상태 변경 (같은 상태로 업데이트)
	public int updateSttus(Map<String, Object> paramMap) throws Exception {
		mbrConsltDAO.updateSttus(paramMap);
		return mbrConsltResultDAO.updateSttus(paramMap);
	}
	
	// 사업소 제외하고 상담만 상태 변경
	public int updateSttusWithOutResult(Map<String, Object> paramMap) throws Exception {
		return mbrConsltDAO.updateSttus(paramMap);
	}

	public void deleteMbrConsltBplc(MbrConsltResultVO mbrConsltResultVO) throws Exception {
		mbrConsltResultDAO.deleteMbrConsltBplc(mbrConsltResultVO);
	}

	// 상담 재신청
	public int updateReConslt(MbrConsltResultVO mbrConsltResultVO) throws Exception {

		//상태값 변경
		Map<String, Object> paramMap = new HashMap<String,Object>();
		paramMap.put("consltNo", mbrConsltResultVO.getConsltNo());
		paramMap.put("consltSttus", "CS07"); // 재접수
		mbrConsltDAO.updateSttus(paramMap);

		//재신청 사유만 업데이트
		return mbrConsltResultDAO.updateReConslt(mbrConsltResultVO);

	}

	public List<MbrConsltResultVO> selectListForExcel(Map<String, Object> paramMap) throws Exception {
		return mbrConsltResultDAO.selectListForExcel(paramMap);
	}

	
	/**
	 * 사업소 전용 상담승인/거부 로직
	 */
	public Map<String, Object> changeSttusForBplc(int bplcConsltNo, String consltSttus) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", false);
		
		MbrConsltResultVO resultVO = selectMbrConsltResultByBplcNo(bplcConsltNo);
		if (resultVO == null) {
			resultMap.put("msg", "해당 사업소의 상담을 찾을 수 없습니다.");
			resultMap.put("code", "err_01");
			return resultMap;
		}
		BplcVO bplcVO = bplcService.selectBplcByUniqueId(resultVO.getBplcUniqueId());
		if (bplcVO == null) {
			resultMap.put("msg", "해당 사업소를 찾을 수 없습니다.");
			resultMap.put("code", "err_02");
			return resultMap;
		}
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("consltSttus", consltSttus);
		paramMap.put("consltNo", resultVO.getConsltNo());
		paramMap.put("bplcConsltNo", bplcConsltNo);

		int resultCnt = updateSttus(paramMap);

		if(resultCnt > 0) {
			String resn = "CS05".equals(consltSttus) ? CodeMap.CONSLT_STTUS_CHG_RESN.get("진행") : CodeMap.CONSLT_STTUS_CHG_RESN.get("사업소 취소"); 
			
			//1:1 상담 수락/거부 이력 추가
			MbrConsltChgHistVO mbrConsltChgHistVO = new MbrConsltChgHistVO();
			mbrConsltChgHistVO.setConsltNo(resultVO.getConsltNo());
			mbrConsltChgHistVO.setConsltSttusChg(consltSttus);
			mbrConsltChgHistVO.setBplcConsltNo(bplcConsltNo);
			mbrConsltChgHistVO.setBplcConsltSttusChg(consltSttus);
			mbrConsltChgHistVO.setConsltBplcUniqueId(bplcVO.getUniqueId());
			mbrConsltChgHistVO.setConsltBplcNm(bplcVO.getBplcNm());
			mbrConsltChgHistVO.setResn(resn);
			mbrConsltChgHistVO.setBplcUniqueId(bplcVO.getUniqueId());
			mbrConsltChgHistVO.setBplcId(bplcVO.getBplcId());
			mbrConsltChgHistVO.setBplcNm(bplcVO.getBplcNm());
			mbrConsltService.insertMbrConsltChgHist(mbrConsltChgHistVO);
			
			
			//상담 거부에 대한 이메일 발송 처리
			if ("CS04".equals(consltSttus)) {
				sendBplcRejectEmail(bplcVO);
			}
		}
		
		resultMap.put("success", true);
		return resultMap;
	}
	
	/**
	 * 사업소 상담거부 이메일 발송
	 */
	public void sendBplcRejectEmail(BplcVO bplcVO) throws Exception {
		String MAIL_FORM_PATH = mailFormFilePath;
		String mailForm = FileUtil.readFile(MAIL_FORM_PATH + "mail_conslt_bplc_reject.html");
		String mailSj = "[이로움케어] 장기요양기관에서 상담을 취소하였습니다.";
		String putEml = "help_cx@thkc.co.kr";
		
		mailForm = mailForm.replace("((bplc_nm))", bplcVO.getBplcNm());
		mailForm = mailForm.replace("((bplc_id))", bplcVO.getBplcId());
		mailForm = mailForm.replace("((bplc_telno))", bplcVO.getTelno());
		mailForm = mailForm.replace("((cancel_date))", simpleDateFormat.format(new Date()));
		
		if("real".equals(activeMode)) {
			mailService.sendMail(sendMail, putEml, mailSj, mailForm);
		} else {
			putEml = "gr1993@naver.com";
			mailService.sendMail(sendMail, putEml, mailSj, mailForm);
		}
	}
}