package icube.manage.sysmng.terms;


import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("termsVO")
public class TermsVO extends CommonBaseVO {
    private int cnt;
    private int termsNo;
	private String termsKind;

    private String termsDt;
    private String useYn;
    private String publicYn;

    private String contentHeader;
    private String contentBody;
}
