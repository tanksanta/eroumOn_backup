package icube.main.biz;

import java.util.HashMap;
import java.util.LinkedHashMap;

public class ItemMap {

	// 품목
		public static final HashMap<String, String> RECIPTER_ITEM= new LinkedHashMap<String, String>() {
			private static final long serialVersionUID = -6250081480521394189L;
			{
				put("이동변기", "mobileToilet");
				put("목욕의자", "bathChair");
				put("성인용보행기", "walkerForAdults");
				put("안전손잡이", "safetyHandle");
				put("미끄럼 방지용품", "antiSlipProduct");
				put("간이변기", "portableToilet");
				put("지팡이", "cane");
				put("욕창예방방석", "cushion");
				put("자세변환용구", "changeTool");
				put("요실금팬티", "panties");
				put("경사로(실내용)", "inRunway");
				put("수동휠체어", "wheelchair");
				put("전동침대", "electricBed");
				put("수동침대", "manualBed");
				put("이동욕조", "bathtub");
				put("목욕리프트", "bathLift");
				put("배회감지기", "detector");
				put("경사로(실외용)", "outRunway");
				put("욕창예방 매트리스", "mattress");
			}
		};

		// 사용연한
		public static final HashMap<String, Object> RECIPTER_DATE= new LinkedHashMap<String, Object>() {
			private static final long serialVersionUID = -3421159888612434656L;
			{
				put("이동변기", 5);
				put("목욕의자", 5);
				put("성인용보행기", 5);
				put("안전손잡이", 0);
				put("미끄럼 방지용품", 0);
				put("간이변기", 0);
				put("지팡이", 2);
				put("욕창예방방석", 3);
				put("자세변환용구", 0);
				put("요실금팬티", 0);
				put("경사로(실내용)", 8);
				put("수동휠체어", 5);
				put("전동침대", 10);
				put("수동침대", 10);
				put("이동욕조", 5);
				put("목욕리프트", 3);
				put("배회감지기", 5);
				put("경사로(실외용)", 2);
				put("욕창예방 매트리스", 3);
			}
		};

}
