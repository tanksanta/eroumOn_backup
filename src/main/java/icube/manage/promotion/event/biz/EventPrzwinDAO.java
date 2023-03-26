package icube.manage.promotion.event.biz;

import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("eventPrzwinDAO")
public class EventPrzwinDAO extends CommonAbstractMapper {

	public CommonListVO eventPrzwinListVO(CommonListVO listVO) throws Exception {
		return selectListVO("event.przwin.selectEventPrzwinCount", "event.przwin.selectEventPrzwinListVO", listVO);
	}

	public EventPrzwinVO selectEventPrzwin(Map<String,Object> paramMap) throws Exception {
		return (EventPrzwinVO)selectOne("event.przwin.selectEventPrzwin", paramMap);
	}

	public void insertEventPrzwin(EventPrzwinVO eventPrzwinVO) throws Exception {
		insert("event.przwin.insertEventPrzwin", eventPrzwinVO);
	}

	public void updateEventPrzwin(EventPrzwinVO eventPrzwinVO) throws Exception {
		update("event.przwin.updateEventPrzwin", eventPrzwinVO);
	}
}