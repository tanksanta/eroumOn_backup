
package icube.manage.popups;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.manage.sysmng.mngr.biz.MngrLogService;
import icube.manage.sysmng.mngr.biz.MngrSession;
import icube.manage.sysmng.mngr.biz.MngrVO;
import icube.manage.sysmng.mngr.biz.MngrService;
import icube.common.util.WebUtil;


/**
 * 팝업에서 데이터 호출
 * @author dylee
 *
 * @update 
 *
 */
@Controller
@RequestMapping(value="/#{props['Globals.Manager.path']}/api/popups")
public class MPopupsController extends CommonAbstractController{
    @Autowired
	private MngrSession mngrSession;

    @Resource(name = "mngrService")
	private MngrService mngrService;

	@Resource(name="mngrLogService")
	private MngrLogService mngrLogService;
	
	
    /* 엑셀 다운로드 전 패스워드 확인*/
    @RequestMapping(value = {"excelPwd.json"})
    @ResponseBody
	public Map<String, Object> excelPwd(
        HttpServletRequest request,
        HttpServletResponse response,
        @RequestParam(value = "pwd", required=true) String pwd, 
        @RequestParam(value = "txt", required=true) String txt, 
        HttpSession session) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
        if (!mngrSession.isLoginCheck()) {
			resultMap.put("result", "fail");
            return resultMap;
		}

        /*패스워드 체크*/
        pwd = WebUtil.clearSqlInjection(pwd);
        
        MngrVO mngrVO = mngrService.selectMngrByUniqueId(mngrSession.getUniqueId());

        if (mngrVO == null) {
            resultMap.put("result", "fail");
            return resultMap;
        }

        if (!BCrypt.checkpw(pwd, mngrVO.getMngrPswd())) {
            resultMap.put("result", "fail");
            resultMap.put("failCd", "difference");
            return resultMap;
        }

        /*사유 저장하는 부분*/
		mngrLogService.insertMngrExcelLog(request, txt);

        resultMap.put("result", "OK");
		return resultMap;
	}
}