package icube.manage.promotion.event.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("eventApplcnDAO")
public class EventApplcnDAO extends CommonAbstractMapper {

	public CommonListVO eventApplcnListVO(CommonListVO listVO) throws Exception {
		return selectListVO("event.applcn.selectEventApplcnCount", "event.applcn.selectEventApplcnListVO", listVO);
	}

	/**
	 * 응모자 내역
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public List<EventApplcnVO> eventApplcnListByIemNo(Map paramMap) throws Exception {
		return selectList("event.applcn.eventApplcnListByIemNo",paramMap);
	}

	/**
	 * 응모 확인 카운트
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectApplcnCount(Map<String,Object> paramMap) throws Exception {
		return selectOne("event.applcn.selectApplcnCount",paramMap);
	}

	public EventApplcnVO selectEventApplcn(int eventApplcnNo) throws Exception {
		return (EventApplcnVO)selectOne("event.applcn.selectEventApplcn", eventApplcnNo);
	}

	public void insertEventApplcn(EventApplcnVO eventApplcnVO) throws Exception {
		insert("event.applcn.insertEventApplcn", eventApplcnVO);
	}

	public void updateEventApplcn(EventApplcnVO eventApplcnVO) throws Exception {
		update("event.applcn.updateEventApplcn", eventApplcnVO);
	}

	public List<EventApplcnVO> selectApplcnListByMap(Map<String, Object> eventParamMap) throws Exception {
		return selectList("event.applcn.selectApplcnListByMap",eventParamMap);
	}

}