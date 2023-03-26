package icube.common.file.biz;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.IIOException;

import org.apache.commons.io.FilenameUtils;
import org.egovframe.rte.fdl.string.EgovDateUtil;
import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.util.FileUtil;
import icube.common.values.CodeList;
import net.coobird.thumbnailator.Thumbnails;

@Service("fileService")
public class FileService extends CommonAbstractServiceImpl {

	@Resource(name = "fileDAO")
	private FileDAO fileDAO;

	@Value("#{props['Globals.Server.Dir']}")
	private String serverDir;
	@Value("#{props['Globals.File.Upload.Dir']}")
	private String fileUploadDir;

	@Value("#{props['Globals.Thumb.Prefix']}")
	private String thumbPrefix;
	@Value("#{props['Globals.Thumb.Width']}")
	private int thumbWidth ;
	@Value("#{props['Globals.Thumb.Height']}")
	private int thumbHeight;

	public void creatFileInfo(
			Map<String, MultipartFile> fileMap
			, long upperNo , String srvcId
			) throws Exception {
		this.creatFileInfo(fileMap, upperNo, srvcId, new HashMap<String, Object>());
	}

	public void creatFileInfo(
			Map<String, MultipartFile> fileMap
			, long upNo, String srvcId
			, Map<String,Object> reqMap
			) throws Exception {

		List<String> savePaths = new ArrayList<String>();

		int tempDcNum = 0;

		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {

			MultipartFile mf = entity.getValue();	//file필드 name으로 종류 구분
			String fileType = mf.getName();
			String bplcUniqueId = (String)reqMap.get("bplcUniqueId");

			if (!"files".equals(fileType)) {
				int index = fileType.lastIndexOf("File");
				String dcNum = fileType.substring(index + 4);
				fileType = fileType.substring(0,index);
				String orgnlFileNm = mf.getOriginalFilename();
				String fileExtn = FilenameUtils.getExtension(orgnlFileNm).toLowerCase();
				String fileDc = (String) reqMap.get(fileType + "FileDc" + dcNum);
				if(EgovStringUtil.isEmpty(fileDc)) {
					fileDc = (String) reqMap.get(fileType + "FileDc" + tempDcNum);
					tempDcNum++;
				}

				// 첨부파일 사이즈, 확장자 체크
				if (mf.getSize() == 0 || CodeList.BAD_FILE_EXTENSION.contains(fileExtn)) {
					continue;
				}

				SimpleDateFormat formatter = new SimpleDateFormat("MMddHHmmssSSS", new Locale("ko", "KR"));
				String uuid = UUID.randomUUID().toString().replaceAll("\\-", "");
				String newFileName = formatter.format(new Date()) + "-" + uuid + (!EgovStringUtil.isEmpty(fileExtn) ? "." + fileExtn : "");
				String toDay = EgovDateUtil.getCurrentDateAsString();//현재 년월일

				File tempFile = null;

				String filePath = serverDir.concat(fileUploadDir);
				String thumPath = filePath + "/"+ srvcId +"/" + toDay + "/" + thumbPrefix+"_"+ newFileName;

				if(reqMap.containsKey("parentPath")) {
					String parentPath = reqMap.get("parentPath").toString();
					String subPath = reqMap.get("path").toString();
					filePath = filePath + "/" + parentPath + "/" + subPath;
					tempFile = new File(filePath + "/" + toDay + "/" + newFileName);
					thumPath = filePath + "/" + toDay + "/" + thumbPrefix+"_"+ newFileName;
				}else {
					tempFile = new File(filePath + "/"+ srvcId +"/" + toDay + "/" + newFileName);
				}

				//파일 디렉토리 존재 여부 확인
				if(!tempFile.exists()) tempFile.mkdirs();

				mf.transferTo(tempFile);
				savePaths.add(tempFile.getAbsolutePath());

				if ((EgovStringUtil.equals("jpg", fileExtn)
						|| EgovStringUtil.equals("gif", fileExtn)
						|| EgovStringUtil.equals("png", fileExtn)
						|| EgovStringUtil.equals("bmp", fileExtn))) {
					try {
						Thumbnails.of(tempFile).size(thumbWidth, thumbHeight)
						.toFile(new File(thumPath));
					} catch (IIOException e) {
						log.debug("Unsupported Image Type");
						//e.printStackTrace();
					}
				}

				//저장되는 파일경로는 변경하도록 함
				filePath = fileUploadDir + "/"+ srvcId +"/" + toDay + "/";

				if(reqMap.containsKey("parentPath")) {
					String parentPath = reqMap.get("parentPath").toString();
					String subPath = reqMap.get("path").toString();
					filePath = fileUploadDir + "/"+ parentPath + "/" + subPath +"/" + toDay + "/";
				}

				// 첨부파일 정보를 저장한다.
				Map<String, Object> fileParam = new HashMap<String, Object>();
				fileParam.put("srvcId", srvcId);
				fileParam.put("upNo", upNo);
				fileParam.put("fileTy", fileType.toUpperCase());
				fileParam.put("flpth", filePath);	// 실제 경로
				fileParam.put("orgnlFileNm", orgnlFileNm);
				fileParam.put("strgFileNm", newFileName);
				fileParam.put("fileExtn", fileExtn);
				fileParam.put("fileSz", mf.getSize());
				fileParam.put("fileDc", fileDc);
				fileParam.put("dwnldCnt", "0");
				fileParam.put("useYn", "Y");

				if(EgovStringUtil.isNotEmpty(bplcUniqueId)) {
					log.debug("@@@@@@@ : " + bplcUniqueId);
					fileParam.put("bplcUniqueId", bplcUniqueId);
					fileParam.put("nttNo", upNo);
				}
				fileDAO.createFileInfo(fileParam);

			}

			//end if
		}//end for

	}

	public FileVO selectFileByFilter(Map<String, Object> fileMap) throws Exception {
		return fileDAO.selectFileByFilter(fileMap);
	}


	public void updateDwldCo(Map<String, Object> fileMap) throws Exception {
		fileDAO.updateDwldCo(fileMap);
	}

	public void updateFileDc(Map<String, Object> fileMap) throws Exception {
		fileDAO.updateFileDc(fileMap);
	}

	public void updateFileDc(String srvcId, long upNo, int fileNo,
			String fileTy, String fileDc) throws Exception {

		Map<String, Object> fileMap = new HashMap<String, Object>();
		fileMap.put("srvcId", srvcId);
		fileMap.put("upNo", upNo);
		fileMap.put("fileTy", fileTy);
		fileMap.put("fileNo", fileNo);
		fileMap.put("fileDc", fileDc);

		this.updateFileDc(fileMap);
	}


	public void deleteFilebyNo(String[] arrDelFile, long upNo,
			String srvcId, String fileTy) throws Exception {

		Map<String, Object> fileMap = new HashMap<String, Object>();
		fileMap.put("fileNo", arrDelFile);
		fileMap.put("upNo", upNo);
		fileMap.put("srvcId", srvcId);
		fileMap.put("fileTy", fileTy);

		fileDAO.deleteFileByNo(fileMap);
	}

	public void deleteBbsFilebyNo(String[] arrDelFile, int nttNo,
			String uniqueId)throws Exception {
		Map<String, Object> fileMap = new HashMap<String, Object>();
		fileMap.put("fileNo", arrDelFile);
		fileMap.put("nttNo", nttNo);
		fileMap.put("bplcUniqueId", uniqueId);
		fileDAO.deleteFileByNo(fileMap);

	}


	public void deleteFileByUpperNo(long upNo, String srvcId) throws Exception {
		Map<String, Object> fileMap = new HashMap<String, Object>();
		fileMap.put("srvcId", srvcId);
		fileMap.put("upNo", upNo);

		fileDAO.deleteFileByUpperNo(fileMap);
	}


	public List<FileVO> selectFileList(Map<String, Object> paramMap) throws Exception {
		return fileDAO.selectFileList(paramMap);
	}



	// 일반 파일업로드
	public String uploadFile(MultipartFile upload, String uploadRoot, String subDir) throws IOException {
		String path = uploadRoot + File.separator + subDir;
		String fileName = FileUtil.generatStreFileNameExt(upload.getOriginalFilename(), path);

		uploadFile(upload, uploadRoot, subDir, fileName);

		return fileName;
	}

	public String uploadFile(MultipartFile upload, String uploadRoot, String subDir, String fixFileName) throws IOException {
		String path = uploadRoot + File.separator + subDir;

		File uploadDir = new File(path);
		if( !uploadDir.exists() || uploadDir.isFile() ) {
			uploadDir.mkdirs();
		}

		String fileName = null;
		try {

			fileName = fixFileName; //+ "." + FileUtil.fileExt(upload.getOriginalFilename());

			int index = 1;
			while( new File( path + File.separator + fileName).exists() ) {
				index++;
				fileName = fixFileName +"_"+ index + "." + FileUtil.fileExt(upload.getOriginalFilename());
			}

			File destFile = new File( path + File.separator + fileName );
			upload.transferTo(destFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fileName;
	}

	public List<FileVO> selectFileAll(Map<String, Object> reqMap) throws Exception{
		return fileDAO.selectFileListAll(reqMap);
	}


	/* 업로드 파일명 고정 & 덮어쓰기 */
	public String uploadFileNFixFileName(MultipartFile upload, String uploadRoot, String subDir, String fixFileName) throws IOException {
		String path = uploadRoot + File.separator + subDir;

		File uploadDir = new File(path);
		if( !uploadDir.exists() || uploadDir.isFile() ) {
			uploadDir.mkdirs();
		}

		String fileName = null;
		try {
			fileName = fixFileName + "." + FileUtil.fileExt(upload.getOriginalFilename());
			File destFile = new File( path + File.separator + fileName );
			upload.transferTo(destFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fileName;
	}


}
