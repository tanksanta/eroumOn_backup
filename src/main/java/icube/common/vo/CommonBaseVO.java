package icube.common.vo;

import java.util.Date;

import icube.common.values.CRUD;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class CommonBaseVO {

    private CRUD crud;

    private String regUniqueId;	// 등록자 유일 아이디
    private Date regDt;			// 등록 일시
    private String regId;		// 등록 아이디
    private String rgtr;		// 등록자
    private String mdfcnUniqueId;	// 수정 유일 아이디
    private Date mdfcnDt;			// 수정 일시
    private String mdfcnId;			// 수정 아이디
    private String mdfr;			// 수정자

    private String srchTarget;
    private String srchCondition;
    private String srchText;

    private String sortBy;
    private String sortOrder;

    private String useYn = "Y";	// 사용여부(삭제여부)
    //private String delYn = "N";	// 삭제여부

    private int _nextSeq; 			// MariaDB용 sequence

}
