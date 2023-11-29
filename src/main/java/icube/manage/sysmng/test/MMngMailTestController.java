package icube.manage.sysmng.test;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.schedule.DscntSchedule;
import icube.schedule.MailSchedule;
import icube.schedule.MbrSchedule;

/**
 * 관리자에 사용하는 메뉴가 아닌 IT 본부에서 이메일 전송 테스트 용으로 사용
 */
@Controller
@RequestMapping(value="/_mng/sysmng/test/mail")
public class MMngMailTestController {

	@Resource(name = "mailSchedule")
	private MailSchedule mailSchedule;
	
	@Resource(name = "dscntSchedule")
	private DscntSchedule dscntSchedule;
	
	@Resource(name = "mbrSchedule")
	private MbrSchedule mbrSchedule;
	
	
	@RequestMapping(value="list")
	public String list() {
		return "/manage/sysmng/test/mail/list";
	}
	
	@ResponseBody
	@RequestMapping(value="brdt.json")
	public Map<String, Object> sendBrdtEmail() {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		boolean success = false;
		
		try {
			mailSchedule.sendBrdtEmail();
			success = true;
		} catch (Exception ex) {
			resultMap.put("msg", "생일 축하 메일 발송중 오류 발생");
		}
		
		resultMap.put("success", success);
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value="info.json")
	public Map<String, Object> sendInfoEmail() {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		boolean success = false;
		
		try {
			mailSchedule.sendInfoMail();
			success = true;
		} catch (Exception ex) {
			resultMap.put("msg", "개인정보 이용내역 통지안내 메일 발송 중 오류 발생");
		}
		
		resultMap.put("success", success);
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value="guideExtinctPoint.json")
	public Map<String, Object> guideExtinctPoint() {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		boolean success = false;
		
		try {
			dscntSchedule.guideExtinctPoint();
			success = true;
		} catch (Exception ex) {
			resultMap.put("msg", "소멸예정 포인트 메일 발송 중 오류 발생");
		}
		
		resultMap.put("success", success);
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value="guideExtinctMlg.json")
	public Map<String, Object> guideExtinctMlg() {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		boolean success = false;
		
		try {
			dscntSchedule.guideExtinctMlg();
			success = true;
		} catch (Exception ex) {
			resultMap.put("msg", "소멸예정 마일리지 메일 발송 중 오류 발생");
		}
		
		resultMap.put("success", success);
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value="guidDrmcMbrMail.json")
	public Map<String, Object> sendGuidDrmcMbrMail() {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		boolean success = false;
		
		try {
			mailSchedule.sendGuidDrmcMbrMail();
			success = true;
		} catch (Exception ex) {
			resultMap.put("msg", "휴면계정 대상 안내 메일 발송 중 오류 발생");
		}
		
		resultMap.put("success", success);
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value="sleepMbr.json")
	public Map<String, Object> sleepMbr() {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		boolean success = false;
		
		try {
			mbrSchedule.sleepMbr();
			success = true;
		} catch (Exception ex) {
			resultMap.put("msg", "휴면계정 전환 안내 메일 발송 중 오류 발생");
		}
		
		resultMap.put("success", success);
		return resultMap;
	}
}
