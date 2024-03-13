package icube.app.matching.main.debug.biz;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("appLogVO")
public class AppLogVO {
	private int appLogNo;
	private String log;
	private Date regDt;
}
