package icube.manage.consult.biz;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.common.file.biz.FileVO;
import icube.common.vo.CommonBaseVO;
import icube.manage.gds.gds.biz.GdsVO;
import lombok.Getter;
import lombok.Setter;



@Setter
@Getter
@Alias("gdsQaVO")
public class GdsQaVO extends CommonBaseVO {
    private int qaNo;
    private int gdsNo;
    private String gdsCd;

    private String qestnCn;
    private String secretYn = "Y";

    private String ansYn = "N";
    private String ansCn;

    private String ansUniqueId;
    private Date ansDt;
    private String ansId;
    private String answr;

    private int enterCnt = 0;
    private int waitCnt = 0;


    //gdsVO
    private String gdsNm;
    private String eml;
    private List<FileVO> gdsImgList;

    private GdsVO gdsInfo;
}