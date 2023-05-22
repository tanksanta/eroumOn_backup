package icube.manage.gds.gds.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringJoiner;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import icube.common.file.biz.FileService;
import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.util.HtmlUtil;
import icube.common.values.StaticValues;
import icube.common.vo.CommonListVO;
import icube.manage.gds.ctgry.biz.GdsCtgryService;
import icube.manage.gds.gds.ReverseCodeMap;
import icube.manage.gds.optn.biz.GdsOptnService;
import icube.manage.gds.rel.biz.GdsRelService;
import icube.manage.sysmng.brand.biz.BrandService;
import icube.manage.sysmng.mkr.biz.MkrService;
import icube.manage.sysmng.mngr.biz.MngrSession;
import icube.members.bplc.mng.biz.BplcGdsService;

@Service("gdsService")
public class GdsService extends CommonAbstractServiceImpl {

	@Resource(name="gdsDAO")
	private GdsDAO gdsDAO;

	@Resource(name = "mkrService")
	private MkrService mkrService;

	@Resource(name = "fileService")
	private FileService fileService;

	@Resource(name = "brandService")
	private BrandService brandService;

	@Resource(name="gdsRelService")
	private GdsRelService gdsRelService;

	@Resource(name = "bplcGdsService")
	private BplcGdsService bplcGdsService;

	@Resource(name = "gdsOptnService")
	private GdsOptnService gdsOptnService;

	@Resource(name = "gdsCtgryService")
	private GdsCtgryService gdsCtgryService;

	@Autowired
	private MngrSession mngrSession;

	/**
	 * 상품정보 목록
	 * @param listVO
	 */
	public CommonListVO gdsListVO(CommonListVO listVO) throws Exception {
		return gdsDAO.gdsListVO(listVO);
	}

	/**
	 * 상품 카운트
	 * @param paramMap
	 */
	public int selectGdsCnt(Map<String, Object> paramMap) throws Exception{
		return gdsDAO.selectGdsCnt(paramMap);
	}

	/**
	 * 상품정보 by PK
	 * @param gdsNo
	 */
	public GdsVO selectGds(int gdsNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("gdsNo", gdsNo);

		return this.selectGdsByFilter(paramMap);
	}

	/**
	 * 상품정보(다중 조건)
	 * @param paramMap
	 */
	public GdsVO selectGdsByFilter(Map<String, Object> paramMap) throws Exception {
		return gdsDAO.selectGdsByFilter(paramMap);
	}

	/**
	 * 상품정보 저장
	 * @param gdsVO
	 */
	public Integer insertGds(GdsVO gdsVO) throws Exception {

		// 고시정보 merge
		StringJoiner joiner = new StringJoiner(",", "{","}");
		for(int i=0;i<gdsVO.getArticle_ttl().length;i++) {
			joiner.add("\""+gdsVO.getArticle_ttl()[i]+"\":\""+HtmlUtil.escapeXmlStr(gdsVO.getArticle_val()[i].trim())+"\"");
		}
		gdsVO.setAncmntInfo(joiner.toString());

		//기본정보 저장
		int resultCnt = gdsDAO.insertGds(gdsVO);

		//관련상품
		gdsRelService.registerGdsRel(gdsVO);

		return resultCnt;
	}

	/**
	 * 상품정보 수정
	 * @param gdsVO
	 */
	public void updateGds(GdsVO gdsVO) throws Exception {

		// 고시정보 merge
		StringJoiner joiner = new StringJoiner(",", "{","}");
		for(int i=0;i<gdsVO.getArticle_ttl().length;i++) {
			joiner.add("\""+gdsVO.getArticle_ttl()[i]+"\":\""+HtmlUtil.escapeXmlStr(gdsVO.getArticle_val()[i].trim())+"\"");
		}
		gdsVO.setAncmntInfo(joiner.toString());

		//기본정보
		gdsDAO.updateGds(gdsVO);

		//관련상품
		gdsRelService.registerGdsRel(gdsVO);
	}

	/**
	 * 상품 정보 선택 수정
	 * @param paramMap
	 */
	public void updateEroumGds(Map<String, Object>paramMap) throws Exception {
		//기본정보
		gdsDAO.updateEroumGds(paramMap);
	}

	/**
	 * 상품정보 삭제
	 * @param gdsNo
	 */
	public void deleteGds(int gdsNo) throws Exception {
		gdsDAO.deleteGds(gdsNo);
	}

	/**
	 * 상품정보 사용 여부 변경
	 * @param paramMap {useYn}
	 */
	public Integer updateGdsUseYn(Map<String, Object> paramMap) throws Exception {
		return gdsDAO.updateGdsUseYn(paramMap);
	}

	/**
	 * 상품정보(목록) 사용 여부 변경
	 * @param paramMap {arrGdsNo[], useYn}
	 */
	public Integer updateGdsListUseYn(GdsVO gdsVO) throws Exception {
		return gdsDAO.updateGdsListUseYn(gdsVO);
	}

	/**
	 * 상품정보 목록
	 * @param reqMap {}
	 */
	public List<GdsVO> selectGdsListAll(Map<String, Object> paramMap) throws Exception {
		return gdsDAO.selectGdsListAll(paramMap);
	}

	/**
	 * 상품 재고수량 변경
	 * @param stockQyPlus
	 */
	public void updateGdsStockQy(Map<String, Object> stockQyPlus) throws Exception {
		gdsDAO.updateGdsStockQy(stockQyPlus);
	}

	/**
	 * 상품 조회수 증가
	 * @param gdsVO
	 */
	public void updateInqcnt(GdsVO gdsVO) throws Exception {
		gdsDAO.updateInqcnt(gdsVO);
	}

	/**
	 * 상품 태그 업데이트
	 * @param paramMap
	 * @throws Exception
	 */
	public void updateGdsTag(Map<String, Object> paramMap) throws Exception {
		gdsDAO.updateGdsTag(paramMap);
	}

	public Integer updateGdsTags(Map<String, Object> paramMap) throws Exception {
		return gdsDAO.updateGdsTags(paramMap);
	}

	public int updateGdsTagAll(List<Integer> arrGdsNo) throws Exception {
		int resultCnt = 0;

		for(int gdsNo : arrGdsNo) {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("gdsNo", gdsNo);
			paramMap.put("gdsTag", "A");
			resultCnt += this.updateGdsTags(paramMap);
		}

		return resultCnt;
	}

	/**
	 * 상품 일괄등록 엑셀 파싱
	 * @param jsonObj
	 * @return gdsVO
	 * @throws Exception
	 */
	public GdsVO setGdsParam(JSONObject jsonObj) throws Exception{
		GdsVO gdsVO = new GdsVO();

		gdsVO.setWt((String)jsonObj.get("중량"));
		gdsVO.setModl((String)jsonObj.get("모델"));
		gdsVO.setPlor((String)jsonObj.get("원산지"));
		gdsVO.setMtrqlt((String)jsonObj.get("재질"));
		gdsVO.setSize((String)jsonObj.get("사이즈"));
		gdsVO.setMemo((String)jsonObj.get("메모"));
		gdsVO.setStndrd((String)jsonObj.get("규격"));
		//gdsVO.setOptnTtl((String)jsonObj.get("옵션_명"));
		//gdsVO.setOptnVal((String)jsonObj.get("옵션_항목_명"));
		gdsVO.setGdsNm((String)jsonObj.get("상품_명"));
		gdsVO.setGdsDc((String)jsonObj.get("상품_설명"));
		gdsVO.setBnefCd((String)jsonObj.get("급여_코드"));
		gdsVO.setItemCd((String)jsonObj.get("품목_코드"));
		gdsVO.setBassDc((String)jsonObj.get("기본_설명"));
		gdsVO.setMngrMemo((String)jsonObj.get("관리자_메모"));
		gdsVO.setYoutubeUrl((String)jsonObj.get("유튜브_URL"));
		//gdsVO.setAditOptnTtl((String)jsonObj.get("추가_옵션_명"));
		//gdsVO.setAditOptnVal((String)jsonObj.get("추가_옵션_항목_명"));
		gdsVO.setAditGdsDc((String)jsonObj.get("추가_상품_설명"));

		gdsVO.setSeoDesc((String)jsonObj.get("SEO_DESC"));
		gdsVO.setSeoAuthor((String)jsonObj.get("SEO_AUTHOR"));
		gdsVO.setSeoKeyword((String)jsonObj.get("SEO_KEYWORD"));

		gdsVO.setPc(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("가격"))));
		gdsVO.setMkr(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("제조사"))));
		gdsVO.setBrand(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("브랜드"))));
		gdsVO.setCtgryNo(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("카테고리"))));
		gdsVO.setInqcnt(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("조회수"))));
		gdsVO.setDscntRt(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("할인_율"))));
		gdsVO.setSortNo(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("정렬_번호"))));
		gdsVO.setBnefPc(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("급여_가격"))));
		gdsVO.setLendPc(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("대여_가격"))));
		gdsVO.setDscntPc(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("할인_가격"))));
		gdsVO.setStockQy(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("재고_수량"))));
		gdsVO.setBnefPc6(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("급여_가격_6%"))));
		gdsVO.setBnefPc9(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("급여_가격_9%"))));
		gdsVO.setBnefPc15(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("급여_가격_15%"))));
		gdsVO.setExtnLendPc(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("연장_대여_가격"))));
		gdsVO.setExtnLendTrm(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("연장_대여_연한"))));
		gdsVO.setUsePsbltyTrm(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("사용_가능_연한"))));
		gdsVO.setStockNtcnQy(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("재고_알림_수량"))));

		// 배송
		gdsVO.setDlvyQy(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("배송_수량"))));
		gdsVO.setDlvyAmt(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("배송_금액"))));
		gdsVO.setDlvyAditAmt(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("배송_추가_금액"))));
		gdsVO.setDlvyBassAmt(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("배송_기본_금액"))));
		gdsVO.setDlvyMummQy(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("배송_최소_수량"))));
		gdsVO.setDlvyMummAmt(EgovStringUtil.string2integer(String.valueOf(jsonObj.get("배송_최소_금액"))));

		// 설명
		gdsVO.setDlvyDc(StaticValues.DLVY_DC);
		gdsVO.setDcCmmn(StaticValues.DC_CMMN);
		gdsVO.setDcFreeSalary(StaticValues.DC_FREE_SALARY);
		gdsVO.setDcPchrgSalary(StaticValues.DC_PCHRG_SALARY);
		gdsVO.setDcPchrgSalaryGnrl(StaticValues.DC_PCHRG_SALARY_GNRL);
		gdsVO.setDcPchrgGnrl(StaticValues.DC_PCHRG_GNRL);

		// 임시 고시정보
		String articleTtl = "색상, 구성품";
		String articleVal = "상세설명페이지 참고, 상세설명페이지 참고";
		gdsVO.setArticle_ttl(articleTtl.split(","));
		gdsVO.setArticle_val(articleVal.split(","));

		//CodeTy
		gdsVO.setGdsTy(ReverseCodeMap.GDS_TY.get((String)jsonObj.get("상품_유형")));
		gdsVO.setGdsTagVal(ReverseCodeMap.GDS_TAG.get((String)jsonObj.get("상품_태그")));
		gdsVO.setAncmntTy(ReverseCodeMap.GDS_ANCMNT_TY.get((String)jsonObj.get("고시_유형")));
		gdsVO.setDlvyCtTy(ReverseCodeMap.DLVY_COST_TY.get((String)jsonObj.get("배송_최소_유형")));
		gdsVO.setDlvyCtStlm(ReverseCodeMap.DLVY_PAY_TY.get((String)jsonObj.get("배송_비용_결제")));

		gdsVO.setUseYn(ReverseCodeMap.USE_YN.get((String)jsonObj.get("사용_여부")));
		gdsVO.setDspyYn(ReverseCodeMap.USE_YN.get((String)jsonObj.get("전시_여부")));
		gdsVO.setSoldoutYn(ReverseCodeMap.USE_YN.get((String)jsonObj.get("품절_여부")));
		gdsVO.setLendDuraYn(ReverseCodeMap.USE_YN.get((String)jsonObj.get("대여_내구_여부")));
		gdsVO.setMlgPvsnYn(ReverseCodeMap.USE_YN.get((String)jsonObj.get("마일리지_제공_여부")));
		gdsVO.setCouponUseYn(ReverseCodeMap.USE_YN.get((String)jsonObj.get("쿠폰_사용_여부")));

		return gdsVO;

	}

	public Map<String, Object> setParamAndInsert(JSONObject jsonObj) throws Exception {
		GdsVO gdsVO = this.setGdsParam(jsonObj);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		gdsVO.setRegUniqueId(mngrSession.getUniqueId());
		gdsVO.setRegId(mngrSession.getMngrId());
		gdsVO.setRgtr(mngrSession.getMngrNm());

		int resultCnt = this.insertGds(gdsVO);

		resultMap.put("resultCnt", resultCnt);
		resultMap.put("gdsNm", gdsVO.getGdsNm());

		return resultMap;
	}

	public void insertGdsAndBplc(GdsVO gdsVO, Map<String, MultipartFile> fileMap) throws Exception {
		this.insertGds(gdsVO);

		fileService.creatFileInfo(fileMap, gdsVO.getGdsNo(), "GDS");

		//사업소 상품 등록
		int resultCnt = 0;
		if(!gdsVO.getGdsTy().equals("N")) {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("srchAprvTy", "C");
			paramMap.put("srchGdsNo", gdsVO.getGdsNo());

			resultCnt += bplcGdsService.selectInsertBplcGds(paramMap);

			System.out.println("###### " + resultCnt + " 개의 사업소에 등록 완료 ########");
		}
	}
}