package icube.common.api.biz;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("tilkoApiVO")
public class TilkoApiVO {

	private int mobileToilet = 1;			//이동변기
	private int bathChair = 1;			//목욕의자
	private int walkerForAdults = 2;	// 성인용보행기
	private int safetyHandle = 10;		//안전손잡이
	private int antiSlipProduct = 11; 	//미끄럼 방지용품
	private int portableToilet = 2;		//간이변기
	private int cane = 1;					//지팡이
	private int cushion = 1;				//욕창예방방석
	private int changeTool = 5;			//자세변환용구
	private int panties = 4; 				//요실금팬티
	private int inRunway = 6;			//실내용 경사로
	private int wheelchair = 1;			//수동휠체어
	private int electricBed = 1;			//전동침대
	private int manualBed = 1;			//수동침대
	private int bathtub = 1;				//이동욕조
	private int bathLift = 1;				//목욕리프트
	private int detector = 1;				//배회감지기
	private int outRunway = 1;			//경사로
	private int mattress = 1;				//욕창예방 매트리스
}
