package icube.manage.promotion.event.biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("eventApplcnService")
public class EventApplcnService extends CommonAbstractServiceImpl {

	@Resource(name="eventApplcnDAO")
	private EventApplcnDAO eventApplcnDAO;

	public CommonListVO eventApplcnListVO(CommonListVO listVO) throws Exception {
		return eventApplcnDAO.eventApplcnListVO(listVO);
	}

	/**
	 * 응모자 내역
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public List<EventApplcnVO> eventApplcnListByIemNo(Map paramMap) throws Exception{
		return eventApplcnDAO.eventApplcnListByIemNo(paramMap);
	}

	/**
	 * 응모 확인 카운트
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectApplcnCount(Map <String,Object>paramMap) throws Exception {
		return eventApplcnDAO.selectApplcnCount(paramMap);
	}

	public EventApplcnVO selectEventApplcn(int eventApplcnNo) throws Exception {
		return eventApplcnDAO.selectEventApplcn(eventApplcnNo);
	}

	public void insertEventApplcn(EventApplcnVO eventApplcnVO) throws Exception {
		eventApplcnDAO.insertEventApplcn(eventApplcnVO);
	}

	public void updateEventApplcn(EventApplcnVO eventApplcnVO) throws Exception {
		eventApplcnDAO.updateEventApplcn(eventApplcnVO);
	}

	public List<EventApplcnVO> selectApplcnListByMap(Map<String, Object> eventParamMap) throws Exception{
		return eventApplcnDAO.selectApplcnListByMap(eventParamMap);
	}

}