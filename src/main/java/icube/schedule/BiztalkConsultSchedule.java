package icube.schedule;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.context.annotation.Profile;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import icube.common.api.biz.BiztalkConsultService;
import icube.common.framework.abst.CommonAbstractController;
import icube.manage.consult.biz.MbrConsltResultDAO;
import icube.manage.consult.biz.MbrConsltResultVO;
import icube.manage.members.bplc.biz.BplcService;
import icube.manage.members.bplc.biz.BplcVO;

@EnableScheduling
@Service("biztalkConsultSchedule")
@Profile(value = {"test", "real"}) /*개발, 운영서버에서만 실행*/
public class BiztalkConsultSchedule  extends CommonAbstractController  {
    
	@Resource(name = "mbrConsltResultDAO")
	private MbrConsltResultDAO mbrConsltResultDAO;

	@Resource(name = "bplcService")
	private BplcService bplcService;

	@Resource(name = "biztalkConsultService")
	private BiztalkConsultService biztalkConsultService;
    
    /*
     * 매칭 완료 후 다음날 오전 10시까지
       이로움케어 > 수급자 상담관리에서 '상담 신청 접수' 상태인 경우

       * 오전 10시 확인 시 즉시 발송 (상담건당 최초 1회 발송)
       * 다음날은 '24시간'이 아닌 날짜로 계산되어야 합니다.
    */
    @Scheduled(cron="0 0 10 * * *")
	public void selectListForCareTalkDelayed() throws Exception {

    	Map<String,Object> reqMap = new HashMap<>();
		
        List<MbrConsltResultVO> list = mbrConsltResultDAO.selectListForCareTalkDelayed(reqMap);
		MbrConsltResultVO crVo;
		BplcVO bplcVO = null;
		String bplcUniqueId = "";
		int ifor, ilen = list.size();
		for(ifor=0 ; ifor<ilen ; ifor++) {
			crVo = list.get(ifor);
			if (!EgovStringUtil.equals(bplcUniqueId, crVo.getBplcId())){
				bplcUniqueId = crVo.getBplcUniqueId();
				bplcVO = bplcService.selectBplcByUniqueId(bplcUniqueId);
			}

			biztalkConsultService.sendCareTalkDelayed(bplcVO, crVo.getConsltNo(), crVo.getBplcConsltNo());
		}

		
	}

    /*
        이로움케어 > 수급자 상담관리에서
        상담 수락되어 '상담 진행 중'인 상담건이
        이틀 후 오후 3시까지 '상담 완료' 상태로 변경되지 않은 경우

        * 오후 3시 확인 시 즉시 발송 (상담건당 최초 1회 발송)
        * 이틀은 48시간으로 계산하지 않고, 날짜로 계산되어야 합니다.
    */
    @Scheduled(cron="0 0 15 * * *")
	public void selectListForCareTalkAttention() throws Exception {

    	Map<String,Object> reqMap = new HashMap<>();
		List<MbrConsltResultVO> list = mbrConsltResultDAO.selectListForCareTalkAttention(reqMap);
		MbrConsltResultVO crVo;
		BplcVO bplcVO = null;
		String bplcUniqueId = "";
		int ifor, ilen = list.size();
		for(ifor=0 ; ifor<ilen ; ifor++) {
			crVo = list.get(ifor);
			if (!EgovStringUtil.equals(bplcUniqueId, crVo.getBplcId())){
				bplcUniqueId = crVo.getBplcUniqueId();
				bplcVO = bplcService.selectBplcByUniqueId(bplcUniqueId);
			}

			biztalkConsultService.sendCareTalkDelayed(bplcVO, crVo.getConsltNo(), crVo.getBplcConsltNo());
		}
	}
}
