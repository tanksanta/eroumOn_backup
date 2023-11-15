package icube.manage.sysmng.mngr.biz;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.util.WebUtil;
import icube.common.vo.CommonListVO;

@Service("mngrLogService")
public class MngrLogService extends CommonAbstractServiceImpl {

	@Resource(name = "mngrDetailLogDAO")
	private MngrDetailLogDAO mngrDetailLogDAO;

	@Resource(name = "mngrExcelLogDAO")
	private MngrExcelLogDAO mngrExcelLogDAO;
	
	@Autowired
	private MngrSession mngrSession;

	public CommonListVO selectMngrExcelLogListVO(CommonListVO listVO) throws Exception {
		return mngrExcelLogDAO.selectMngrExcelLogListVO(listVO);
	}
	
	/**
	 * 관리자 상세조회 로그 쌓기 
	 */
	public void insertMngrDetailLog(HttpServletRequest request) throws Exception {
		MngrDetailLogVO mngrDetailLogVO = new MngrDetailLogVO();
		mngrDetailLogVO.setUniqueId(mngrSession.getUniqueId());
		mngrDetailLogVO.setMngrId(mngrSession.getMngrId());
		mngrDetailLogVO.setMngrNm(mngrSession.getMngrNm());
		mngrDetailLogVO.setUrl(request.getRequestURI());
		mngrDetailLogVO.setDmndIp(WebUtil.getIp(request));
		mngrDetailLogVO.setUseHist(getUseHistForDetail(mngrDetailLogVO.getUrl()));
		mngrDetailLogVO.setResn("관리자 상세보기 조회");
		mngrDetailLogDAO.insertMngrDetailLog(mngrDetailLogVO);
	}
	
	/**
	 * 관리자 엑셀다운로드 로그 쌓기
	 */
	public void insertMngrExcelLog(HttpServletRequest request, String resn) throws Exception {
		MngrExcelLogVO mngrExcelLogVO = new MngrExcelLogVO();
		mngrExcelLogVO.setUniqueId(mngrSession.getUniqueId());
		mngrExcelLogVO.setMngrId(mngrSession.getMngrId());
		mngrExcelLogVO.setMngrNm(mngrSession.getMngrNm());
		mngrExcelLogVO.setUrl(request.getRequestURI());
		mngrExcelLogVO.setDmndIp(WebUtil.getIp(request));
		mngrExcelLogVO.setUseHist(getUseHistForExcel(mngrExcelLogVO.getUrl()));
		mngrExcelLogVO.setResn(resn);   //엑셀 다운로드 사유(입력 받음)
		mngrExcelLogDAO.insertMngrExcelLog(mngrExcelLogVO);
	}
	
	
	private String getUseHistForDetail(String url) {
		String useHist = null;
		
		if (url.startsWith("/_mng/mbr/")) {
			useHist = "회원 > 회원정보 상세 조회";
		} else if (url.startsWith("/_mng/ordr/include/ordrDtlView")) {
			useHist = "주문 > 주문정보 상세 조회";
		} else if (url.startsWith("/_mng/consult/recipter/view")) {
			useHist = "고객상담 > 수급자 상담관리 상세 조회";
		}
		return useHist;
	}
	
	private String getUseHistForExcel(String url) {
		return "이용내역";
	}
}
