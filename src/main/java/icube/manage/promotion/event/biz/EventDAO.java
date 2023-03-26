package icube.manage.promotion.event.biz;

import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("eventDAO")
public class EventDAO extends CommonAbstractMapper {

	public CommonListVO eventListVO(CommonListVO listVO) throws Exception {
		return selectListVO("event.selectEventCount", "event.selectEventListVO", listVO);
	}

	@SuppressWarnings("rawtypes")
	public EventVO selectEvent(Map paramMap) throws Exception {
		return (EventVO)selectOne("event.selectEvent", paramMap);
	}

	public void insertEvent(EventVO eventVO) throws Exception {
		insert("event.insertEvent", eventVO);
	}

	public void updateEvent(EventVO eventVO) throws Exception {
		update("event.updateEvent", eventVO);
	}
}