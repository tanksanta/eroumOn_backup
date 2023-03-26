package icube.manage.sysmng.mngr.biz;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;

import icube.common.framework.request.RequestHolder;
import icube.manage.sysmng.menu.biz.MngMenuVO;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MngrSession implements Serializable {

	private static final long serialVersionUID = 1043144152379377173L;

	private String uniqueId;
	private String mngrId;
	private String mngrNm;
	private String authrtTy = "";
	private String authrtTyNm = "";
	private int authrtNo = 0;
	private String authrtNm = "";
	private String dplctCnfirmCode;

	private String proflImg;
	private Date recentLgnDt;

	private boolean loginCheck = false;

	private List<MngMenuVO> mngMenuList;

	@Setter(AccessLevel.NONE)
	@Value("#{props['Globals.Manager.session.key']}")
	private String MNGR_SESSION_KEY;

	public void setRequest(RequestHolder requestHolder) {
		HttpSession session = requestHolder.getSession();
		session.setAttribute(MNGR_SESSION_KEY, this);
	}

}
