package icube.manage.sysmng.auth.biz;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.util.WebUtil;
import icube.common.vo.CommonListVO;
import icube.manage.sysmng.mngr.biz.MngrSession;
import icube.manage.sysmng.mngr.biz.MngrVO;

@Service("mngrAuthLogService")
public class MngrAuthLogService extends CommonAbstractServiceImpl {

	@Resource(name="mngrAuthLogDAO")
	private MngrAuthLogDAO mngrAuthLogDAO;

	@Autowired
	private MngrSession mngrSession;

	public CommonListVO selectMngrAuthLogListVO(CommonListVO listVO) throws Exception {
		return mngrAuthLogDAO.selectMngrAuthLogListVO(listVO);
	}

	public MngrAuthLogVO selectMngrAuthLog(int logNo) throws Exception {
		return mngrAuthLogDAO.selectMngrAuthLog(logNo);
	}

	public void insertMngrAuthLog(MngrAuthLogVO mngrAuthLogVO) throws Exception {
		mngrAuthLogDAO.insertMngrAuthLog(mngrAuthLogVO);
	}

	public void updateMngrAuthLog(MngrAuthLogVO mngrAuthLogVO) throws Exception {
		mngrAuthLogDAO.updateMngrAuthLog(mngrAuthLogVO);
	}

	public void deleteMngrAuthLog(int logNo) throws Exception {
		mngrAuthLogDAO.deleteMngrAuthLog(logNo);
	}

	public void insertMngrAuthLog(MngrVO mngrVO, String logTy, String logCn) throws Exception {
		insertMngrAuthLog(mngrVO.getUniqueId(), mngrVO.getMngrId(), mngrVO.getMngrNm(), logTy, logCn);
	}

	public void insertMngrAuthLog(String uniqueId, String mngrId, String mngrNm, String logTy, String logCn) throws Exception {

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

		MngrAuthLogVO mngrAuthLogVO = new MngrAuthLogVO();
		mngrAuthLogVO.setRegUniqueId(mngrSession.getUniqueId());
		mngrAuthLogVO.setRegId(mngrSession.getMngrId());
		mngrAuthLogVO.setRgtr(mngrSession.getMngrNm());

		mngrAuthLogVO.setUniqueId(uniqueId);
		mngrAuthLogVO.setMngrId(mngrId);
		mngrAuthLogVO.setMngrNm(mngrNm);
		mngrAuthLogVO.setLogTy(logTy);
		mngrAuthLogVO.setLogCn(logCn);
		mngrAuthLogVO.setDmndIp(WebUtil.getIp(request));

		mngrAuthLogDAO.insertMngrAuthLog(mngrAuthLogVO);
	}

}