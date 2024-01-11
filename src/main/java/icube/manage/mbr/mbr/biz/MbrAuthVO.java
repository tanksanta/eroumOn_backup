package icube.manage.mbr.mbr.biz;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@NoArgsConstructor
@Setter
@Getter
@Alias("mbrAuthVO")
public class MbrAuthVO {
	private int authNo;
    private String mbrUniqueId;
    private String joinTy;
    private String mbrId;
    private String pswd;
    private String naverAppId;
    private String kakaoAppId;
    private Date regDt;
    private Date delDt;
    private String delYn = "N";
    
    private MbrVO mbrVO;
}