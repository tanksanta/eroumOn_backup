package icube.manage.promotion.event.biz;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import icube.common.file.biz.FileService;
import icube.common.file.biz.FileVO;
import icube.common.framework.abst.CommonAbstractServiceImpl;

@Service("eventIemService")

public class EventIemService  extends CommonAbstractServiceImpl{

	@Resource(name="fileService")
	private FileService fileService;

	@Resource(name="eventIemDAO")
	private EventIemDAO iemDAO;

	/**
	 * 이벤트 항목 등록
	 * @param eventNo
	 * @param reqMap
	 * @param fileMap
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked","rawtypes"})
	public void insertEventIem(int eventNo, Map<String, Object> reqMap, Map<String, MultipartFile> fileMap) throws Exception{
		Map paramMap = new HashMap();
		paramMap.put("eventNo", eventNo);
			//텍스트 항목
			if("text".equals((String)reqMap.get("textBtn"))) {
				paramMap.put("iemTy", reqMap.get("textBtn"));
					Iterator<Entry<String, Object>> iteratorE = reqMap.entrySet().iterator();
					while(iteratorE.hasNext()) {{
						Map.Entry<String, Object> entry = (Map.Entry<String, Object>) iteratorE.next();
						if(entry.getKey().contains("ttems") == true) {
							String Key = (entry.getKey()).replace("ttems", "");
							String value = (String) entry.getValue();
							paramMap.put("iemCn", value);
							int key = EgovStringUtil.string2integer(Key);
							paramMap.put("sortNo", key);

							iemDAO.insertEventIem(paramMap);
						}
					}
				}
			}else {
				//이미지 항목
				paramMap.put("iemTy", reqMap.get("textBtn"));
				Iterator<Entry<String, MultipartFile>> iteratorE = fileMap.entrySet().iterator();
				while(iteratorE.hasNext()) {{
					Entry<String, MultipartFile> entry = (Map.Entry<String, MultipartFile>) iteratorE.next();
					if(entry.getKey().contains("imgFile")) {
						paramMap.put("iemCn", entry.getValue().getOriginalFilename());
						iemDAO.insertEventIem(paramMap);
					}
				}}
			}
		}

	/**
	 * 이벤트 항목 이미지와 첨부파일 매핑을 위함
	 * @param fileParamMap
	 * @return
	 * @throws Exception
	 */
/*	private int selectIemImgFileNo(Map<String, Object> fileParamMap) throws Exception {
		return iemDAO.selectIemImgFileNo(fileParamMap);
	}*/

	public void deleteIem(int eventNo) throws Exception {
		iemDAO.deleteIem(eventNo);
	}

	public List<EventIemVO> selectListEventIem(int eventNo) throws Exception {
		return iemDAO.selectListEventIem(eventNo);
	}

	/**
	 * 이벤트 항목 업데이트
	 * @param eventNo
	 * @param textBtn
	 * @param fileMap
	 * @param reqMap
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked","rawtypes"})
	public void updateIem(int eventNo, String textBtn, Map<String, MultipartFile> fileMap, Map<String, Object> reqMap) throws Exception{
		this.deleteIem(eventNo);
		Map paramMap = new HashMap();
		paramMap.put("eventNo", eventNo);
		//이미지 항목
		if(textBtn.equals("img")) {
			paramMap.put("iemTy", textBtn);
			paramMap.put("srvcId", "EVENT");
			paramMap.put("upNo", eventNo);
			paramMap.put("fileTy", "IMG");
			List<FileVO> fileList = fileService.selectFileList(paramMap);
			for(int i=0; i<fileList.size(); i++) {
				paramMap.put("iemCn", fileList.get(i).getOrgnlFileNm());
				iemDAO.insertEventIem(paramMap);
			}
		}else {
			//텍스트 항목
			this.insertEventIem(eventNo, reqMap, fileMap);
		}

	}

	}



