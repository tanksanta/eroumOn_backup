package icube.common.api.biz;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class EroumcareApiResponseVO {
	private boolean success;
	private String code;
	private String msg;
	private Object data;
}
