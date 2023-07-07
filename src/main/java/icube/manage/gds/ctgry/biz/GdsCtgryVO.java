package icube.manage.gds.ctgry.biz;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("gdsCtgryVO")
public class GdsCtgryVO extends CommonBaseVO {

	private int ctgryNo;
	private String ctgryNm;
	private String ctgryImg;
	private String tag;
	private int upCtgryNo;
	private String upCtgryNm;
	private int levelNo = 1;
	private int sortNo = 1;
	private String orgCtgryNo; //업데이트시 사용

	private int childCnt = 0;

	private String ctgryPath;

	private List<GdsCtgryVO> childList;

	public GdsCtgryVO() {
        this.childList = new ArrayList<>(); // childList 초기화
    }

    public void addChild(GdsCtgryVO child) {
    	this.childList.add(child);
    }

    public void buildChildList(List<GdsCtgryVO> dataList) {
        for (GdsCtgryVO category : dataList) {
            if (category.getUpCtgryNo() == ctgryNo) {
            	category.setChildList(new ArrayList<>()); // 자식 카테고리의 childList 초기화
                addChild(category);
                category.buildChildList(dataList);
            }
        }
        this.childCnt = this.childList.size();
    }


}
