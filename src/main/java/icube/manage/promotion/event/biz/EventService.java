package icube.manage.promotion.event.biz;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("eventService")
public class EventService extends CommonAbstractServiceImpl {

	@Resource(name="eventDAO")
	private EventDAO eventDAO;

	public CommonListVO eventListVO(CommonListVO listVO) throws Exception {
		return eventDAO.eventListVO(listVO);
	}

	@SuppressWarnings({"unchecked","rawtypes"})
	public EventVO selectEvent(int eventNo) throws Exception {
		Map paramMap = new HashMap();
		paramMap.put("eventNo",eventNo);
		return eventDAO.selectEvent(paramMap);
	}

	public void insertEvent(EventVO eventVO) throws Exception {
		eventDAO.insertEvent(eventVO);
	}

	public void updateEvent(EventVO eventVO) throws Exception {
		eventDAO.updateEvent(eventVO);
	}
}