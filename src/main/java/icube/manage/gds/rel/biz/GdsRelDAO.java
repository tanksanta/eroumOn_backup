package icube.manage.gds.rel.biz;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("gdsRelDAO")
public class GdsRelDAO extends CommonAbstractMapper {

	public void insertGdsRel(GdsRelVO gdsRelVO) throws Exception {
		insert("gds.rel.insertGdsRel", gdsRelVO);
	}

	public void deleteGdsRel(int gdsNo) throws Exception {
		delete("gds.rel.deleteGdsRel", gdsNo);
	}


}
