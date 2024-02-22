package icube.app.matching.simpletest;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
@Alias("simpleTestVO")
public class SimpleTestVO {
    private Integer mbrTestNo;
    private String uniqueId;      //회원 unique id
    private Integer recipientsNo; //회원에 등록된 수급자 no
    private String testTy;
    private Integer age;     //만나이
    private Integer grade;   //등급
    private Integer score;     //점수

    private String selectedValue;
    
    private Date regDt;
    private Date mdfcnDt;
}