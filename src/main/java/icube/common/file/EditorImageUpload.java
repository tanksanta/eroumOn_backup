package icube.common.file;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.egovframe.rte.fdl.string.EgovDateUtil;
import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class EditorImageUpload {
	
	private static final Logger log = LoggerFactory.getLogger(EditorImageUpload.class);

	@Value("#{props['Globals.Server.Dir']}")
	private String serverDir;
	
	@Value("#{props['Globals.File.Upload.Dir']}")
	private String fileUploadDir;

	
    /**
     * ckeditor의 이미지 업로드 처리.
     * 2023-07-04 파일 다중 업로드 되도록 수정
     */
	@ResponseBody
    @RequestMapping(value = "/comm/uploadEditor")
	public Map<String, Object> upload(
			HttpServletResponse response
			, HttpServletRequest request
			, List<MultipartFile> upload) {
    	
		Map<String, Object> resMap = new HashMap<String, Object>();
		
		if (upload != null && upload.size() == 1) {
			MultipartFile file = upload.get(0);
			
			String orginlFileNm = file.getOriginalFilename();
	    	String fileExtsn = FilenameUtils.getExtension(orginlFileNm).toLowerCase();
	    	
	    	SimpleDateFormat formatter = new SimpleDateFormat("MMddHHmmssSSS", new Locale("ko", "KR"));
			String uuid = UUID.randomUUID().toString().replaceAll("\\-", "");
			String newFileName = formatter.format(new Date()) + "-" + uuid + (!EgovStringUtil.isEmpty(fileExtsn) ? "." + fileExtsn : "");
			String toDay = EgovDateUtil.getCurrentDateAsString();//현재 년월일
	    	
	        File tempFile = null;

			String filePath = serverDir.concat(fileUploadDir);
			tempFile = new File(filePath + "/EDITOR/" + toDay + "/" + newFileName);

			// 도메인이 필요할 경우
	        String url = request.getRequestURL().toString();
	        Integer inx = url.lastIndexOf("/");
	        url = url.substring(0, inx);
	        url = url + "/comm/editorImage/"+toDay+"?fileName="+newFileName;
	        
	        try {
	    		//파일 디렉토리 존재 여부 확인
	    		if(!tempFile.exists()) {tempFile.mkdirs();}
	    		file.transferTo(tempFile);
	        } catch (IOException ex) {
	        	url = "";
	        	log.error("Error: upload4ckeditor");
	        }
	        
			//resMap.put("url", url);
	        resMap.put("url", "/comm/editorImage/"+toDay+"?fileName="+newFileName);
	        resMap.put("title", orginlFileNm);
		}
		//다중 파일 업로드
		else if (upload != null && upload.size() > 1) {
			String toDay = EgovDateUtil.getCurrentDateAsString();//현재 년월일
	        // /comm/editorImage/20230704?fileName={file1.jpg,file2.jpg} 형식
	        String url = "/comm/editorImage/"+toDay+"?fileName={";
			String title = "";
			
			for (int i = 0; i < upload.size(); i++) {
				MultipartFile file = upload.get(i);
				
				String orginlFileNm = file.getOriginalFilename();
		    	String fileExtsn = FilenameUtils.getExtension(orginlFileNm).toLowerCase();
		    	
		    	SimpleDateFormat formatter = new SimpleDateFormat("MMddHHmmssSSS", new Locale("ko", "KR"));
				String uuid = UUID.randomUUID().toString().replaceAll("\\-", "");
				String newFileName = formatter.format(new Date()) + "-" + uuid + (!EgovStringUtil.isEmpty(fileExtsn) ? "." + fileExtsn : "");
				
		        File tempFile = null;

				String filePath = serverDir.concat(fileUploadDir);
				tempFile = new File(filePath + "/EDITOR/" + toDay + "/" + newFileName);
		        
				if (i == 0) {
					url += newFileName;
					title = orginlFileNm;
				} else {
					url += "," + newFileName;
				}
				
		        try {
		    		//파일 디렉토리 존재 여부 확인
		    		if(!tempFile.exists()) {tempFile.mkdirs();}
		    		file.transferTo(tempFile);
		        } catch (IOException ex) {
		        	url = "";
		        	log.error("Error: upload4ckeditor");
		        }
			}
			
			url += "}";
	        resMap.put("url", url);
	        resMap.put("title", title);
		}
		
		return resMap;
    }
    
}