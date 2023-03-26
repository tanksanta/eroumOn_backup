package icube.manage.exhibit.recommend.biz;

import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;

@Service("gdsRcmdService")
public class GdsRcmdService extends CommonAbstractServiceImpl {

	@Resource(name="gdsRcmdDAO")
	private GdsRcmdDAO gdsRcmdDAO;

	public List<GdsRcmdVO> selectRcmdList() throws Exception {
		return gdsRcmdDAO.selectRcmdList();
	}

	public void updateRcmd(String[] noList) throws Exception {
		this.deleteRcmd();

		for(int i=0; i<noList.length; i++) {
			GdsRcmdVO gdsRcmdVO = new GdsRcmdVO();
			gdsRcmdVO.setGdsNo(EgovStringUtil.string2integer(noList[i]));
			gdsRcmdVO.setRcmdSortNo(i+1);
			gdsRcmdDAO.insertRcmd(gdsRcmdVO);
		}
	}

	public void deleteRcmd() throws Exception {
		gdsRcmdDAO.deleteRcmd();
	}



}
