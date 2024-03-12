package icube.app.matching.welfareinfo;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.app.matching.membership.mbr.biz.MatMbrSession;
import icube.common.framework.abst.CommonAbstractController;
import icube.manage.consult.biz.MbrConsltService;
import icube.manage.mbr.recipients.biz.MbrRecipientsGdsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;

@Controller
@RequestMapping(value={"#{props['Globals.Matching.path']}/welfareinfo"})
public class MatWelfareinfoController  extends CommonAbstractController {
    @Autowired
	private MatMbrSession matMbrSession;

    @Resource(name= "mbrRecipientsService")
	private MbrRecipientsService mbrRecipientsService;

    @Resource(name= "mbrRecipientsGdsService")
	private MbrRecipientsGdsService mbrRecipientsGdsService;

    @Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;

    @RequestMapping(value={"list"})
	public String list(
        Model model) throws Exception {
        return "/app/matching/welfareinfo/list";
    }

	@RequestMapping(value={"interest/intro"})
	public String interestIntro(
        @RequestParam(required = false) Integer recipientsNo/*수급자 번호*/
		, Model model) throws Exception {

        if (matMbrSession.isLoginCheck()){
            MbrRecipientsVO mbrRecipientsVO = mbrRecipientsService.selectMbrRecipientsByNoOrMain(matMbrSession.getUniqueId(), recipientsNo);

            model.addAttribute("recipientsNo", (mbrRecipientsVO == null)?0:mbrRecipientsVO.getRecipientsNo());
        }else{
            model.addAttribute("recipientsNo", 0);
        }

        
		
        return "/app/matching/welfareinfo/interest/intro";
    }
    @RequestMapping(value={"interest/choice"})
	public String interestChoice(
        @RequestParam(required = false) Integer recipientsNo/*수급자 번호*/
		, @RequestParam(required = false, defaultValue="") String careCtgryList/*선택된 카테고리 ,로 구분 1080,1050*/
		, Model model) throws Exception {
        
        MbrRecipientsVO mbrRecipientsVO = mbrRecipientsService.selectMbrRecipientsByNoOrMain(matMbrSession.getUniqueId(), recipientsNo);
        
        String prevPath = "equip_ctgry";
        
        //수급자 최근 상담 조회(진행 중인 상담 체크)
        Map <String, Object> resultMap = mbrConsltService.selectRecipientConsltSttus(matMbrSession.getUniqueId(), mbrRecipientsVO.getRecipientsNo(), prevPath);
        //equip_ctgry

        model.addAttribute("recipientsNo", mbrRecipientsVO.getRecipientsNo());
        model.addAttribute("isExistRecipientConslt", resultMap.get("isExistRecipientConslt"));
        
        model.addAttribute("careCtgryList", careCtgryList);
		
        return "/app/matching/welfareinfo/interest/choice";
    }

    /**
	 * 수급자 관심 복지용구 선택값 저장 API
	 */
	@ResponseBody
	@RequestMapping(value = "interest/addMbrRecipientsGdCds.json")
	public Map<String, Object> addMbrRecipientsGdCds(
			int recipientsNo
			, @RequestParam(value="ctgryCds[]", required = true) String[] ctgryCds//카테고리코드
		)throws Exception {

        Map <String, Object> resultMap = new HashMap<String, Object>();

        try {
			mbrRecipientsGdsService.insertMbrRecipientsGdCds(matMbrSession, recipientsNo, ctgryCds);
			
			resultMap.put("success", true);
		} catch (Exception ex) {
			resultMap.put("success", false);
			resultMap.put("msg", "관심 복지용구 선택정보 저장에 실패하였습니다");
		}

        return resultMap;
    }
}
