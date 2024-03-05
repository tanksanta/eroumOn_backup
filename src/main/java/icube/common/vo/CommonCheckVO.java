package icube.common.vo;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class CommonCheckVO {

	private boolean success;
	private String errorMsg;
	private String errorCode;
}
