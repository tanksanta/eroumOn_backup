package icube.manage.members.notice.biz;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("bplcNoticeDAO")
public class BplcNoticeDAO extends CommonAbstractMapper {

	public CommonListVO bplcNoticeListVO(CommonListVO listVO) throws Exception {
		return selectListVO("bplc.notice.selectBplcNoticeCount", "bplc.notice.selectBplcNoticeListVO", listVO);
	}

	public BplcNoticeVO selectBplcNotice(int bplcNoticeNo) throws Exception {
		return (BplcNoticeVO)selectOne("bplc.notice.selectBplcNotice", bplcNoticeNo);
	}

	public void insertBplcNotice(BplcNoticeVO bplcNoticeVO) throws Exception {
		insert("bplc.notice.insertBplcNotice", bplcNoticeVO);
	}

	public void updateBplcNotice(BplcNoticeVO bplcNoticeVO) throws Exception {
		update("bplc.notice.updateBplcNotice", bplcNoticeVO);
	}

	public void updateInqcnt(BplcNoticeVO bplcNoticeVO) {
		update("bplc.notice.updateInqcnt", bplcNoticeVO);

	}
}