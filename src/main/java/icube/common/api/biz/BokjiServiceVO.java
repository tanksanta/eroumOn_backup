package icube.common.api.biz;

import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@Alias("bokjiServiceVO")
public class BokjiServiceVO extends CommonBaseVO {

	private int bokjiId;				// ID
	private String benefitName;			// 정책제목
	private String supportContent;		// 정책내용
	private String entitledCondition;	// 지원조건

	private String dueDate;				// 지원기간
	private String beginDate;			// 지원기간 시작일
	private String endDate;				// 지원기간 종료일
	private boolean availableKeyword;	// 특정단어

	private List<String> categoryList;	// 분류(목록)
	//private String category;			// 분류

	private String totalSupportAmount;	// 총지원금
	private String requiredDocuments;	// 필요서류
	private String applyMethod;			// 지원방법
	private String refUrl;				// 출처사이트
	private String bokjiResource;		// 출처(원천데이터 위치)
	private String bokjiRefUrl;			// 복지지원사이트
	private String bokjiProviderName;   // 복지제공기관명
	//private String videoUrl;			//
	//private String thumbnailImageUrl;

	private BokjiProviderVO provider;	// 기관

}
