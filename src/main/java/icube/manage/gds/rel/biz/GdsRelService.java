package icube.manage.gds.rel.biz;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.manage.gds.gds.biz.GdsVO;

@Service("gdsRelService")
public class GdsRelService extends CommonAbstractServiceImpl {

	@Resource(name="gdsRelDAO")
	private GdsRelDAO gdsRelDAO;

	public void registerGdsRel(GdsVO gdsVO) throws Exception {


		//정방향+역방향 삭제
		this.deleteGdsRel(gdsVO.getGdsNo());

		if(gdsVO.getRelGdsNo() != null && gdsVO.getRelGdsNo().length > 0) {
			//동적쿼리는 사용x
			//정방향 등록
			for (String relGdsNo : gdsVO.getRelGdsNo()) {
				GdsRelVO gdsRelVO = new GdsRelVO();
				gdsRelVO.setGdsNo(gdsVO.getGdsNo());
				gdsRelVO.setRelGdsNo(EgovStringUtil.string2integer(relGdsNo));
				this.insertGdsRel(gdsRelVO);
			}

			//역방향 등록
			for (String relGdsNo : gdsVO.getRelGdsNo()) {
				GdsRelVO gdsRelVO = new GdsRelVO();
				gdsRelVO.setGdsNo(EgovStringUtil.string2integer(relGdsNo));
				gdsRelVO.setRelGdsNo(gdsVO.getGdsNo());
				this.insertGdsRel(gdsRelVO);
			}
		}
	}

	private void insertGdsRel(GdsRelVO gdsRelVO) throws Exception {
		gdsRelDAO.insertGdsRel(gdsRelVO);

	}

	private void deleteGdsRel(int gdsNo) throws Exception {
		gdsRelDAO.deleteGdsRel(gdsNo);
	}

}
