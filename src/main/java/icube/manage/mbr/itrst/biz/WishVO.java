package icube.manage.mbr.itrst.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import icube.manage.gds.gds.biz.GdsVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("wishVO")
public class WishVO extends CommonBaseVO {

	private int wishlistNo;
	private int gdsNo;
	private String uniqueId;
	
	private GdsVO gdsInfo; // 상품정보
}
