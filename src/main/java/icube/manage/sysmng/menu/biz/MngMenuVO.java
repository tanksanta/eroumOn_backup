package icube.manage.sysmng.menu.biz;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("mngMenuVO")
public class MngMenuVO extends CommonBaseVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private int menuNo;
	private int upMenuNo;
	private String upMenuNm;
	private String menuNm;
	private String menuUrl = "";
	private String icon = "";
	private String menuTy = "3";
	private int levelNo = 1;
	private int sortNo = 1;
	private String useYn;
	private int linkTy;

	private String authrtYn = "N"; // 통합 권한

	private String inqYn = "N"; // 조회 권한
	private String wrtYn = "N"; // CRD 권한

	private String menuPath;
	private String menuNmPath;

	private String dspyMenuUrl;

	private int childCnt = 0;

	public boolean isMyParent(int menuNo) {
		return isMyParent(String.valueOf(menuNo));
	}

	public boolean isMyParent(String menuNo) {
		if(menuPath!=null&&!menuPath.isEmpty()) {
			String[] menuNos = menuPath.replaceAll("^/", "").split("/");
			for(String menuNoStr : menuNos) {
				if(menuNo.equals(menuNoStr)) {
					return true;
				}
			}
		}
		return false;
	}
}
