package icube.manage.sysmng.bbs.biz;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.type.Alias;
import org.egovframe.rte.fdl.string.EgovStringUtil;

import icube.common.values.CRUD;
import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("bbsCtgryVO")
public class BbsCtgryVO extends CommonBaseVO {

	private int bbsNo;
	private int ctgryNo;
	private String ctgryValue;
	private String ctgryNm;
	private String useYn;

	/** 카테고리 사용 타입( BBS : 게시판 , NTT : 게시물) */
	private String ctgryUseTy;

	public BbsCtgryVO() {}
	public BbsCtgryVO(BbsSetupVO bbsSetupVO, String ctgryUseTy) {
		int bbsNo = bbsSetupVO.getBbsNo();
		String[] values = bbsSetupVO.getCtgryValues();
		String[] texts = bbsSetupVO.getCtgryTexts();

		makeCtgryList(bbsNo, values, texts, ctgryUseTy);
	}


	/** 카테고리 목록 */
	private List<BbsCtgryVO> list;
	public void makeCtgryList(int bbsNo, String[] values, String[] texts, String ctgryUseTy) {
		if( values != null ) {
			int aryLength = values.length;
			this.list = new ArrayList<BbsCtgryVO>();
			for( int i = 0; i < aryLength ; i++  ) {
				String value = values[i];
				String text = texts[i];
				String[] spValue = value.split("-");
				if(  !EgovStringUtil.isEmpty(value) && !EgovStringUtil.isEmpty(text) && spValue.length > 1 ) {
					String action = spValue[0];
					int ctgryNo = Integer.parseInt(spValue[1]);
					if( "C".equals(action) || "U".equals(action) || "D".equals(action)  ){
						BbsCtgryVO ctgry = new BbsCtgryVO();
						ctgry.setBbsNo(bbsNo);
						ctgry.setCtgryNm(text);
						ctgry.setCtgryUseTy(ctgryUseTy);
						if( "C".equals(action) ) {
							ctgry.setCrud(CRUD.CREATE);
							ctgry.setUseYn("Y");
						} else  {
							ctgry.setCtgryNo(ctgryNo);
							ctgry.setUseYn("Y");
							ctgry.setCrud(CRUD.UPDATE);
							if( "D".equals(action)) {
								ctgry.setUseYn("N");
							}
						}
						this.list.add(ctgry);
					}
				}
			}
		}
	}
}
