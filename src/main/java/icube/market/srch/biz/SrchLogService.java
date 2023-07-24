package icube.market.srch.biz;


import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.util.DateUtil;
import icube.market.mbr.biz.MbrSession;

@Service("srchLogService")
public class SrchLogService extends CommonAbstractServiceImpl {

	@Resource(name="srchLogDAO")
	private SrchLogDAO srchLogDAO;

	@Autowired
	private MbrSession mbrSession;

	public void registSrchLog(Map<String, Object> paramMap) throws Exception {

		String srchKwd = "";
		String curPath = "";
		String gender = "M";
		String mberSe = "E"; // E = 비회원
		SrchLogVO srchLogVO = new SrchLogVO();
		String today = DateUtil.getToday("yyyy-MM-dd");

		if(EgovStringUtil.isNotEmpty((String)paramMap.get("referer"))) {
			curPath = (String)paramMap.get("referer");
		}

		/*if(!curPath.contains("/search/")) {*/
			if(EgovStringUtil.isNotEmpty((String)paramMap.get("kwd"))) {
				srchKwd = (String)paramMap.get("kwd");
			}

			if(mbrSession.isLoginCheck()) {
				gender = mbrSession.getGender();
				mberSe = mbrSession.getRecipterYn();
			}

			srchLogVO.setMberSe(mberSe);
			srchLogVO.setSexdstn(gender);
			srchLogVO.setSrchwrd(srchKwd);
			srchLogVO.setYy(today.split("-")[0]);
			srchLogVO.setMt(today.split("-")[1]);
			srchLogVO.setDd(today.split("-")[2]);
			srchLogVO.setLc(curPath);

			srchLogDAO.insertSrchLog(srchLogVO);
		}
	//}

}
