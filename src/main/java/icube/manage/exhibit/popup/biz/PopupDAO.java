package icube.manage.exhibit.popup.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("popupDAO")
public class PopupDAO extends CommonAbstractMapper {

	public CommonListVO selectPopupListVO(CommonListVO listVO) throws Exception {
		return selectListVO("popup.selectPopupCount", "popup.selectPopupListVO", listVO);
	}

	public PopupVO selectPopup(int popNo) throws Exception {
		return selectOne("popup.selectPopup", popNo);
	}

	public void insertPopup(PopupVO popupVO) throws Exception {
		insert("popup.insertPopup", popupVO);
	}

	public void updatePopup(PopupVO popupVO) throws Exception {
		update("popup.updatePopup", popupVO);
	}

	public List<PopupVO> selectPopupListAll(Map<String, Object> paramMap) throws Exception {
		return selectList("popup.selectPopupListAll",paramMap);
	}
}