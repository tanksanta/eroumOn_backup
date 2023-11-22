package icube.common.api.biz;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("logsDAO")
public class LogsDAO extends CommonAbstractMapper {
   
	public int insertLogOne(BootpayVO vo) throws Exception {
		return insert("logs.insertLogBootpayWebhook", vo);
	}

}
