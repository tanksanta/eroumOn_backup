package icube.manage.consult.biz;

import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.common.file.biz.FileVO;
import icube.common.vo.CommonBaseVO;
import icube.manage.gds.gds.biz.GdsVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("gdsReviewVO")
public class GdsReviewVO extends CommonBaseVO {
    private int gdsReivewNo;
    private int gdsNo;
    private String gdsCd;
    private String gdsNm;

    private String ttl;
    private String cn;
    private String imgUseYn;
    private int dgstfn;
    private String dspyYn;

    private int ordrDtlNo;
    private String ordrCd;
    private int ordrNo;

    private boolean boolDt; // 작성기간 경과 유무
    private int avCount;    //작성한 상품 후기
    private int rgCount;    //작성한 상품 후기
    private int reviewCnt;



    //후기 이미지
    private FileVO imgFile;

    // 상품 정보
    private GdsVO gdsInfo;

    //작성자 프로필 이미지
    private String proflImg;

    //상품 이미지
    private List<FileVO> thumbnailFile;

    // ordr-dtl
    private String ordrOptn;
    private String ordrOptnTy;
    private int ordrQy;
    private int ordrPc;

}