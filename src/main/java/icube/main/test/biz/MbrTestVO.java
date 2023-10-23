package icube.main.test.biz;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
@Alias("mbrTestVO")
public class MbrTestVO {
    private Integer mbrTestNo;
    private String uniqueId;      //회원 unique id
    private Integer recipientsNo; //회원에 등록된 수급자 no
    private Integer grade;   //등급
    private Float score;     //점수
    
    private Float physicalScore;       //신체기능 점수
    private String physicalSelect;     //신체기능 선택정보
    private Float cognitiveScore;      //인지기능 점수
    private String cognitiveSelect;    //인지기능 선택정보
    private Float behaviorScore;       //행동변화 점수
    private String behaviorSelect;     //행동변화 선택정보
    private Float nurseScore;          //간호처치 점수
    private String nurseSelect;        //간호처지 선택정보
    private Float rehabilitateScore;   //재활 점수
    private String rehabilitateSelect; //재활 선택정보
    private Float diseaseScore1;       //질병1 점수
    private String diseaseSelect1;     //질병1 선택정보
    private Float diseaseScore2;       //질병2 점수
    private String diseaseSelect2;     //질병2 선택정보
    
    //수형분석도 8개 항목
    private Float diagramBehaviorScore;      //청결 점수
    private Float diagramCleanScore;         //배설 점수
    private Float diagramExcretionScore;     //식사 점수
    private Float diagramFunctionalScore;    //기능보조 점수
    private Float diagramIndirectScore;      //행동변화대응 점수
    private Float diagramMealScore;          //간접지원 점수
    private Float diagramNurseScore;         //간호처치 점수
    private Float diagramRehabilitateScore;  //재활훈련 점수
    
    private Date regDt;
    private Date mdfcnDt;
}