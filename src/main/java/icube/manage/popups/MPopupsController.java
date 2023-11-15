
package icube.manage.popups;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;


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

    /* 엑셀 다운로드 전 패스워드 확인*/
    @RequestMapping(value = {"excelPwd.json"})
    @ResponseBody
	public Map<String, Object> excelPwd(
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "pwd", required=true) int pwd, 
			@RequestParam(value = "txt", required=true) String txt, 
			HttpSession session) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", "1");

        /*패스워드 체크*/

        /*사유 저장하는 부분*/


		return resultMap;
	}
}