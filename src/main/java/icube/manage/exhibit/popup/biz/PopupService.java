package icube.manage.exhibit.popup.biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("popupService")
public class PopupService extends CommonAbstractServiceImpl {

	@Resource(name="popupDAO")
	private PopupDAO popupDAO;

	public CommonListVO selectPopupListVO(CommonListVO listVO) throws Exception {
		return popupDAO.selectPopupListVO(listVO);
	}

	public PopupVO selectPopup(int popNo) throws Exception {
		return popupDAO.selectPopup(popNo);
	}

	public void insertPopup(PopupVO popupVO) throws Exception {
		popupDAO.insertPopup(popupVO);
	}

	public void updatePopup(PopupVO popupVO) throws Exception {
		popupDAO.updatePopup(popupVO);
	}

	public List<PopupVO> selectPopupListAll(Map<String, Object> paramMap) throws Exception {
		return popupDAO.selectPopupListAll(paramMap);
	}


}