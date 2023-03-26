package icube.common.file.biz;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.util.WebUtil;

@Controller
public class FileDownload {

	@Value("#{props['Globals.Server.Dir']}")
	private String serverDir;

	@Value("#{props['Globals.File.Upload.Dir']}")
	private String fileUploadDir;

	@Resource( name = "fileService" )
	private FileService fileService;

	@RequestMapping("/comm/getFile")
	public void getFile(
			@RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			) throws Exception {

		String srvcId = WebUtil.clearSqlInjection((String) reqMap.get("srvcId"));
		String upNo = WebUtil.clearSqlInjection((String) reqMap.get("upNo"));
		String fileTy = WebUtil.clearSqlInjection((String) reqMap.get("fileTy"));
		String fileNo = WebUtil.clearSqlInjection((String) reqMap.get("fileNo"));

		Map<String, Object> fileMap = new HashMap<String, Object>();
		fileMap.put("srvcId", srvcId);
		fileMap.put("upNo", upNo);
		fileMap.put("fileTy", fileTy);
		fileMap.put("fileNo", fileNo);

		FileVO fileVO = fileService.selectFileByFilter(fileMap);

		if( fileVO != null ){

			fileService.updateDwldCo(fileMap);

			String flpth = fileVO.getFlpth();
			String streFileNm = fileVO.getStrgFileNm();

			flpth = serverDir + "/" + flpth;
			File file = new File(flpth + File.separator + streFileNm);
			File file2 = new File(flpth + File.separator + fileVO.getOrgnlFileNm());

			boolean fileExists = false;

			if (file.exists()){
				fileExists = true;
			}else if (file2.exists()){
				fileExists = true;
			    file = new File(flpth + File.separator + fileVO.getOrgnlFileNm());
			}


			if (fileExists){

				String fileNm = URLEncoder.encode(fileVO.getOrgnlFileNm(), "UTF-8").replace("+", "%20"); //다국어 처리 브라우저 분기 필요 없음

				response.setContentType("application/octet-stream");
				response.setHeader("Content-Transfer-Encoding", "binary");
				response.setHeader("Accept-Ranges", "bytes");
				response.setHeader("Pragma", "no-cache;");
				response.setHeader("Content-Disposition", "attachment; filename=\"" + fileNm + "\""+ ";filename*= UTF-8''" + fileNm);

				InputStream fileIn = new FileInputStream(file);
				IOUtils.copy(fileIn, response.getOutputStream());
				fileIn.close();
				response.flushBuffer();

			}
		}
	}


	/**
	 *
	 * @param dirPath 파일경로
	 * @param fileName 파일명
	 * @throws Exception
	 */
	@RequestMapping("/comm/{dirPath}/getFile")
	public void getFile(
			@PathVariable String dirPath
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			) throws Exception {

		String filePath = WebUtil.fileInjectPathReplaceAll(dirPath);
		String fileName = (String) reqMap.get("fileName");
		fileName = fileName.replaceAll("\\.\\.", "");
		fileName = fileName.replaceAll("\\/", "");

    	String flpth = serverDir + fileUploadDir + "/"+ filePath +"/" + fileName;

		File file = new File(flpth);

		boolean fileExists = false;

		if (file.exists()){
			fileExists = true;
		}

		if (fileExists){
			String fileNm = URLEncoder.encode(fileName, "UTF-8").replace("+", "%20"); //다국어 처리 브라우저 분기 필요 없음

			response.setContentType("application/octet-stream");
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Accept-Ranges", "bytes");
			response.setHeader("Pragma", "no-cache;");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + fileNm + "\""+ ";filename*= UTF-8''" + fileNm);

			InputStream fileIn = new FileInputStream(file);
			IOUtils.copy(fileIn, response.getOutputStream());
			fileIn.close();
			response.flushBuffer();
		}
	}

}
