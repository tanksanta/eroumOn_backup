package icube.manage.consult.biz;

import java.util.Date;

import org.egovframe.rte.fdl.string.EgovStringUtil;

import com.ibm.icu.text.SimpleDateFormat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ConsltHistory implements Comparable<ConsltHistory>{ 
	private Date regDt;
	private String name;
	private String mbrUniqueId;
	private String id;
	private String content;
	
	private static SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	@Override
    public int compareTo(ConsltHistory consltHistory) {
		return regDt.compareTo(consltHistory.getRegDt());
	}
	
	@Override
    public String toString() {
        return simpleDateFormat.format(regDt) + " " + name + "(" + (EgovStringUtil.isNotEmpty(mbrUniqueId) ? mbrUniqueId : id) + ")" + " / " + content;
    }
}
