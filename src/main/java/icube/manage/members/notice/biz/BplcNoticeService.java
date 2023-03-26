package icube.manage.members.notice.biz;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;

@Service("bplcNoticeService")
public class BplcNoticeService extends CommonAbstractServiceImpl {

	@Resource(name="bplcNoticeDAO")
	private BplcNoticeDAO bplcNoticeDAO;

	public CommonListVO bplcNoticeListVO(CommonListVO listVO) throws Exception {
		return bplcNoticeDAO.bplcNoticeListVO(listVO);
	}

	public BplcNoticeVO selectBplcNotice(int bplcNoticeNo) throws Exception {
		return bplcNoticeDAO.selectBplcNotice(bplcNoticeNo);
	}

	public void insertBplcNotice(BplcNoticeVO bplcNoticeVO) throws Exception {
		bplcNoticeDAO.insertBplcNotice(bplcNoticeVO);
	}

	public void updateBplcNotice(BplcNoticeVO bplcNoticeVO) throws Exception {
		bplcNoticeDAO.updateBplcNotice(bplcNoticeVO);
	}

	public void updateInqcnt(BplcNoticeVO bplcNoticeVO) {
			//조회수 증가
			int inq = bplcNoticeVO.getInqcnt();
			bplcNoticeVO.setInqcnt(inq+1);
			bplcNoticeDAO.updateInqcnt(bplcNoticeVO);
	}
}