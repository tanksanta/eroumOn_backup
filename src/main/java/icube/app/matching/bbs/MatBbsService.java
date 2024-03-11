package icube.app.matching.bbs;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Service;

import icube.common.vo.CommonListVO;
import icube.manage.sysmng.bbs.biz.BbsDAO;
import icube.manage.sysmng.bbs.biz.BbsService;

@Service("matBbsService")
public class MatBbsService extends BbsService {
    @Resource(name = "bbsDAO")
	private BbsDAO bbsDAO;

	protected String srchSrvcCd = "machingapp";

    public CommonListVO selectNttListWithSocialWelfareFailVO(
		HttpServletRequest request
		, String testTy /*simple, care*/
		) throws Exception {
		CommonListVO listVO = new CommonListVO(request);

		String bbsCd = "socialwelfare";

		listVO.setParam("srchSrvcCd", srchSrvcCd);
		listVO.setParam("srchBbsCd", bbsCd);
		listVO.setParam("endNumMysql", 9999);
		listVO.setParam("srchSttsTy", "C");

		if (EgovStringUtil.equals("simple", testTy)){
			listVO.setParam("addValueChk01", "Y");
		}else if (EgovStringUtil.equals("care", testTy)){
			listVO.setParam("addValueChk02", "Y");
		}

		return bbsDAO.selectNttListWithSocialWelfareFailVO(listVO);
	}
}
