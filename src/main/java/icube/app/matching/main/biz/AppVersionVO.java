package icube.app.matching.main.biz;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("appVersionVO")
public class AppVersionVO {
	private int versionNo;
	private String appNm;
	private String version;
	private String forceYn;
	private Date regDt;
}
