package icube.manage.exhibit.recommend.biz;

import java.util.List;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("gdsRcmdDAO")
public class GdsRcmdDAO extends CommonAbstractMapper {

	public List<GdsRcmdVO> selectRcmdList() throws Exception {
		return selectList("rcmd.selectRcmdList");
	}

	public void deleteRcmd() throws Exception {
		delete("rcmd.deleteRcmd");
	}

	public void insertRcmd(GdsRcmdVO gdsRcmdVO) throws Exception{
		insert("rcmd.insertRcmd", gdsRcmdVO);
	}

}
