package icube.main.biz;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import icube.common.api.biz.BokjiApiService;
import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;
import icube.manage.members.bplc.biz.BplcService;
import icube.manage.members.bplc.biz.BplcVO;

@Service("mainService")
public class MainService extends CommonAbstractServiceImpl {

	@Resource(name = "bplcService")
	private BplcService bplcService;

	@Resource(name="bokjiService")
	private BokjiApiService bokjiService;

	public Map<String, Object> srchInst(
			boolean isAllow
			, Map<String, Object> paramMap
			, HttpServletRequest request) throws Exception {

		// param check
		log.debug("@@ 사업소 S @@");
		paramMap.put("srchAprvTy","C"); // 승인
		paramMap.put("srchUseYn","Y"); // 사용중
		paramMap.put("srchMode","LOCATION"); // 사용중

		String sido = (String) paramMap.get("sido");
		paramMap.put("sido", sido.substring(0, 1));

		// 멤버스(사업소) 리스트
		List<BplcVO> bplcList = bplcService.selectBplcListAll(paramMap);
		int bplcCnt = bplcList.size();
		log.debug("@@ 사업소 E @@ : " + bplcCnt);

		log.debug("@@ 복지시설 S @@");
		CommonListVO listVO = new CommonListVO(request, 1, 500);
		listVO.setParam("sprName", sido);
		listVO.setParam("cityName", (String) paramMap.get("gugun"));

		if(isAllow) {
			listVO.setParam("lat", (String) paramMap.get("lat")); // 위도
			listVO.setParam("lng", (String) paramMap.get("lot")); // 경도
			listVO.setParam("distance", (String) paramMap.get("dist")); // 검색범위
		}

		listVO = bokjiService.getInstList(listVO);
		int bokjiInstCnt = listVO.getTotalCount();
		log.debug("@@ 복지시설 E @@ : " + bokjiInstCnt);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("bplcList", bplcList);
		resultMap.put("bplcCnt", bplcCnt);

		resultMap.put("instList", listVO.getListObject());
		resultMap.put("instCnt", bokjiInstCnt);

		return resultMap;
	}

	public List<String> replaceItemList(List<String> ownList) throws Exception {
		List<String> replaceList = new ArrayList<String>();
		
		for(Map.Entry<String, String>entry : ItemMap.RECIPTER_ITEM.entrySet()) {
			int idx = 0;
			if(entry.getValue().equals(ownList.get(idx))) {
				replaceList.add(entry.getKey());
			}
			idx += 1;
		}
		
		return replaceList;
	}


}
