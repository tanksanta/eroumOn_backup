package icube.common.file.biz;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.helper.ResourceCloseHelper;
import icube.common.util.FileUtil;
import icube.common.util.WebUtil;

@Controller
public class ImageProcess extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private static final Logger log = LoggerFactory.getLogger(ImageProcess.class);

	@Value("#{props['Globals.Server.Dir']}")
	private String serverDir;

	@Resource( name = "fileService" )
	private FileService fileService;

	@Value("#{props['Globals.File.Upload.Dir']}")
	private String fileUploadDir;

	@RequestMapping("/comm/getImage")
    public void getImageInf(
    		@RequestParam Map<String,Object> reqMap
    		, HttpServletRequest request
    		, HttpServletResponse response) throws Exception {

		String srvcId = WebUtil.clearSqlInjection((String) reqMap.get("srvcId"));
		String upNo = WebUtil.clearSqlInjection((String) reqMap.get("upNo"));
		String fileTy = WebUtil.clearSqlInjection((String) reqMap.get("fileTy"));
		String fileNo = WebUtil.clearSqlInjection((String) reqMap.get("fileNo"));
		String thumbYn = WebUtil.clearSqlInjection((String) reqMap.get("thumbYn"));

		Map<String, Object> fileMap = new HashMap<String, Object>();
		fileMap.put("srvcId", srvcId);
		fileMap.put("upNo", upNo);
		fileMap.put("fileTy", fileTy);
		fileMap.put("fileNo", fileNo);

		FileVO fileVO = fileService.selectFileByFilter(fileMap);

		if (fileVO != null) {
			String flpth = fileVO.getFlpth();
			String streFileNm = fileVO.getStrgFileNm();
			String fileExtsn = fileVO.getFileExtn();

			if (!EgovStringUtil.isEmpty(thumbYn) && EgovStringUtil.equals("Y", thumbYn)) {
				streFileNm = "T_" + streFileNm;
			}

			flpth = serverDir + "/" + flpth;

			File file = null;
			FileInputStream fis = null;

			BufferedInputStream in = null;
			ByteArrayOutputStream bStream = null;

			try {
				file = new File(flpth + File.separator + streFileNm);
				fis = new FileInputStream(file);

				in = new BufferedInputStream(fis);
				bStream = new ByteArrayOutputStream();

				int imgByte;
				while ((imgByte = in.read()) != -1) {
					bStream.write(imgByte);
				}

				String type = "";

				if (fileExtsn != null && !"".equals(fileExtsn)) {
					if ("jpg".equals(fileExtsn.toLowerCase())) {
						type = "image/jpeg";
					} else {
						type = "image/" + fileExtsn.toLowerCase();
					}
					type = "image/" + fileExtsn.toLowerCase();

				} else {
					log.debug("Image fileType is null.");
				}

				response.setHeader("Content-Type", type);
				response.setContentLength(bStream.size());

				bStream.writeTo(response.getOutputStream());

				response.getOutputStream().flush();
				response.getOutputStream().close();

			} catch (Exception ignore) {
				file = new File(flpth + File.separator + fileVO.getStrgFileNm());
				fis = new FileInputStream(file);

				in = new BufferedInputStream(fis);
				bStream = new ByteArrayOutputStream();

				int imgByte;
				while ((imgByte = in.read()) != -1) {
					bStream.write(imgByte);
				}

				String type = "";

				if (fileExtsn != null && !"".equals(fileExtsn)) {
					if ("jpg".equals(fileExtsn.toLowerCase())) {
						type = "image/jpeg";
					} else {
						type = "image/" + fileExtsn.toLowerCase();
					}
					type = "image/" + fileExtsn.toLowerCase();

				} else {
					log.debug("Image fileType is null.");
				}

				response.setHeader("Content-Type", type);
				response.setContentLength(bStream.size());

				bStream.writeTo(response.getOutputStream());

				response.getOutputStream().flush();
				response.getOutputStream().close();
			} finally {
				ResourceCloseHelper.close(bStream, in, fis);
			}

		}

	}


	@RequestMapping(value = "/comm/editorImage/{path}")
    public void getEditorImage(
		@PathVariable String path
		, @RequestParam Map<String,Object> reqMap
		, HttpServletRequest request
		, HttpServletResponse response) {

    	String filePath = WebUtil.fileInjectPathReplaceAll(path);
    	String fileName = WebUtil.removeOSCmdRisk((String) reqMap.get("fileName"));

    	String flpth = serverDir + fileUploadDir + "/EDITOR/" + filePath + "/" + fileName;

    	log.debug("flpth : " + flpth);
    	log.debug("fileName: " + fileName);

    	File file = null;
		FileInputStream fis = null;

		BufferedInputStream in = null;
		ByteArrayOutputStream bStream = null;

    	try {

    		file = new File(flpth);
			fis = new FileInputStream(file);

			in = new BufferedInputStream(fis);
			bStream = new ByteArrayOutputStream();

			int imgByte;
			while ((imgByte = in.read()) != -1) {
				bStream.write(imgByte);
			}

			String type = "";
			String fileExtsn = FileUtil.fileExt(fileName);

			if (fileExtsn != null && !"".equals(fileExtsn)) {
				if ("jpg".equals(fileExtsn.toLowerCase())) {
					type = "image/jpeg";
				} else {
					type = "image/" + fileExtsn.toLowerCase();
				}
				type = "image/" + fileExtsn.toLowerCase();

			} else {
				log.error("Image fileType is null.");
			}

			response.setContentType(type);
			response.setHeader("Content-Type", type);
			response.setContentLength(bStream.size());

			bStream.writeTo(response.getOutputStream());

			response.getOutputStream().flush();
			response.getOutputStream().close();

    	} catch(Exception ignore) {

    		ResourceCloseHelper.close(bStream, in, fis);
    	}

	}


	@RequestMapping(value = "/comm/proflImg")
    public void getProfileImage(
		@RequestParam Map<String,Object> reqMap
		, HttpServletRequest request
		, HttpServletResponse response) {

		String fileName = (String) reqMap.get("fileName");
    	String flpth = serverDir + fileUploadDir + "/PROFL/" + WebUtil.removeSQLInjectionRisk(fileName);

        File file = null;
		FileInputStream fis = null;

		BufferedInputStream in = null;
		ByteArrayOutputStream bStream = null;

    	try {

    		flpth = serverDir + fileUploadDir + "/PROFL/" + WebUtil.removeSQLInjectionRisk(fileName);

    		file = new File(flpth);
			fis = new FileInputStream(file);

			in = new BufferedInputStream(fis);
			bStream = new ByteArrayOutputStream();

			int imgByte;
			while ((imgByte = in.read()) != -1) {
				bStream.write(imgByte);
			}

			String type = "";
			String fileExtsn = FileUtil.fileExt(fileName);

			if (fileExtsn != null && !"".equals(fileExtsn)) {
				if ("jpg".equals(fileExtsn.toLowerCase())) {
					type = "image/jpeg";
				} else {
					type = "image/" + fileExtsn.toLowerCase();
				}
				type = "image/" + fileExtsn.toLowerCase();

			} else {
				log.error("Image fileType is null.");
			}

			response.setContentType(type);
			response.setHeader("Content-Type", type);
			response.setContentLength(bStream.size());

			bStream.writeTo(response.getOutputStream());

			response.getOutputStream().flush();
			response.getOutputStream().close();

    	} catch(Exception ignore) {

    		ResourceCloseHelper.close(bStream, in, fis);
    	}


	}

}
