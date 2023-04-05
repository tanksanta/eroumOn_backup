package icube.common.api.biz;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@Alias("bokjiProviderVO")
public class BokjiProviderVO {

	private int id;
	//private String shortInstitutionName;	// 복지기관명
	private String institutionName;	// 복지기관명
	private String contactNumber;

	private String countryName;
	private String cityName;
	private String sprName;
	private String address;

	private double lat;
	private double lng;
	private double distance;

}
