package icube.manage.promotion.event.biz;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("eventPrzwinService")
public class EventPrzwinService extends CommonAbstractServiceImpl {

	@Resource(name="eventPrzwinDAO")
	private EventPrzwinDAO eventPrzwinDAO;

	public CommonListVO eventPrzwinListVO(CommonListVO listVO) throws Exception {
		return eventPrzwinDAO.eventPrzwinListVO(listVO);
	}

	public EventPrzwinVO selectEventPrzwin(Map<String,Object> paramMap) throws Exception {
		return eventPrzwinDAO.selectEventPrzwin(paramMap);
	}

	public void insertEventPrzwin(EventPrzwinVO eventPrzwinVO) throws Exception {
		eventPrzwinDAO.insertEventPrzwin(eventPrzwinVO);
	}

	public void updateEventPrzwin(EventPrzwinVO eventPrzwinVO) throws Exception {
		eventPrzwinDAO.updateEventPrzwin(eventPrzwinVO);
	}
}