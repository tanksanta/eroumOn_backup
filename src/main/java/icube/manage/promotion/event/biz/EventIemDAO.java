package icube.manage.promotion.event.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("eventIemDAO")
public class EventIemDAO extends CommonAbstractMapper{

	public void insertEventIem(Map <String, Object> paramMap)  throws Exception{
		insert("event.iem.insertEventIem", paramMap);
	}

	public void deleteIem(int eventNo) throws Exception {
		delete("event.iem.deleteEventItem", eventNo);
	}

	public List<EventIemVO> selectListEventIem(int eventNo) throws Exception {
		return selectList("event.iem.selectEventIem",eventNo);
	}

	// 이벤트 항목 이미지와 첨부파일 매핑을 위함
	/*public int selectIemImgFileNo(Map<String, Object> fileParamMap) throws Exception {
		return selectOne("event.iem.selectIemImgFileNo",fileParamMap);
	}*/

}
