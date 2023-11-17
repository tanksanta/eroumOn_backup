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
		String host = request.getRequestURL().toString().replace(request.getRequestURI(), "");
		String referer = request.getHeader("Referer");
		referer = referer.replace(host, "");
		mngrExcelLogVO.setUrl(referer);
		mngrExcelLogVO.setDmndIp(WebUtil.getIp(request));
		mngrExcelLogVO.setUseHist(getUseHistForExcel(referer));
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
		String useHist = null;
		
		if (url.startsWith("/_mng/mbr/list")) {
			useHist = "회원 > 일반회원관리에서 개인정보가 포함된 엑셀 다운로드";
		} else if (url.startsWith("/_mng/mbr/black/list")) {
			useHist = "회원 > 블랙리스트회원관리에서 개인정보가 포함된 엑셀 다운로드";
		} else if (url.startsWith("/_mng/mbr/human/list")) {
			useHist = "회원 > 휴면회원관리에서 개인정보가 포함된 엑셀 다운로드";
		} else if (url.startsWith("/_mng/ordr")) {
			String sttus = url.replace("/_mng/ordr/", "").replace("/list", "").split("\\?")[0];
			String sttusText = "";
			
			switch (sttus) {
				case "all" : sttusText = "전체주문"; break;
				case "or01" : sttusText = "승인대기"; break;
				case "or02" : sttusText = "승인완료"; break;
				case "or03" : sttusText = "승인반려"; break;
				case "or04" : sttusText = "결제대기"; break;
				case "or05" : sttusText = "결제완료"; break;
				case "or06" : sttusText = "배송관리"; break;
				case "or09" : sttusText = "구매확정"; break;
				case "ca01" : sttusText = "취소관리"; break;
				case "ex01" : sttusText = "교환관리"; break;
				case "re01" : sttusText = "반품관리"; break;
				case "rf01" : sttusText = "환불관리"; break;
			}
			
			useHist = "주문 > " + sttusText + "에서 개인정보가 포함된 엑셀 다운로드";
		} else if (url.startsWith("/_mng/consult/recipter/list")) {
			useHist = "고객상담 > 수급자 상담관리에서 개인정보가 포함된 엑셀 다운로드";
		} else if (url.startsWith("/_mng/clcln/market/list")) {
			useHist = "정산 > 마켓정산에서 개인정보가 포함된 엑셀 다운로드";
		}
		return useHist;
	}
}
