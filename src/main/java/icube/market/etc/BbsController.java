package icube.market.etc;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.vo.CommonListVO;
import icube.manage.sysmng.bbs.biz.BbsService;
import icube.manage.sysmng.bbs.biz.BbsSetupService;
import icube.manage.sysmng.bbs.biz.BbsSetupVO;

/**
 * 고객 센터 > 공지 사항
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/etc/bbs")
public class BbsController extends CommonAbstractController{

	@Resource(name="bbsService")
	private BbsService bbsService;

	@Resource(name="bbsSetupService")
	private BbsSetupService bbsSetupService;
	

	/**
	 * 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="{srvcCd}/{bbsCd}/list.json")
	public Map<String, Object> list(
			HttpServletRequest request
			// , @RequestParam (value="bbsCd", required=false) String bbsCd
			, @PathVariable String srvcCd // 카테고리 1
			, @PathVariable String bbsCd // 카테고리 2
			, @RequestParam (value="pageSize", required=false, defaultValue="10") int pageSize
			, @RequestParam (value="pageNo", required=false, defaultValue="1") int pageNo
			, Model model
			) throws Exception{

		Map<String, Object> resultMap = new HashMap<String, Object>();
		CommonListVO listVO = new CommonListVO(request);

		if (pageSize < 1) pageSize = 10;
		if (pageNo < 1) pageNo = 1;

		BbsSetupVO bbsSetupVO = bbsSetupService.selectBbsSetup(srvcCd, bbsCd);

		listVO.setParam("srchSrvcCd", srvcCd);
		listVO.setParam("srchBbsCd", bbsCd);
		listVO.setParam("startNum", (pageNo-1)*pageSize);
		listVO.setParam("endNumMysql", pageSize);

		// 블라인드 상태
		listVO.setParam("srchSttsTy", "C");
		listVO = bbsService.selectNttListVO(listVO);

		resultMap.put("resultList", listVO.getListObject());
		resultMap.put("resultSetup", bbsSetupVO);

		return resultMap;
	}


}
