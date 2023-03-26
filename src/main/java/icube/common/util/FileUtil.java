package icube.common.util;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Base64;

import org.apache.commons.io.FileUtils;
import org.egovframe.rte.fdl.string.EgovDateUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class FileUtil {

	private static final Logger LOGGER = LoggerFactory.getLogger(FileUtil.class);

	/** 디렉토리 생성 */
	public static void createDir(String path) {
		File dir = new File(path);
    	if(!dir.exists()){
    		dir.mkdirs();
    	}
	}

	/** 디렉토리(파일) 이름 변경 */
	public static void renameDir(String prePath, String nxtPath) {
		File predir = new File(prePath);
		File nxtDir = new File(nxtPath);
    	if(predir.exists()){
    		predir.renameTo(nxtDir);
    	}
	}

	/** 파일 생성 */
	public static void createFile(String file, String contents) {
		File dir = new File(file);
    	if(!dir.getParentFile().exists()){
    		dir.getParentFile().mkdirs();
    	}
		Writer writer = null;
		try {
		    writer = new BufferedWriter(new OutputStreamWriter(
		          new FileOutputStream(dir), "utf-8"));
		    writer.write(contents);
		} catch (IOException e) {
			LOGGER.error("Exception: {}", e.getClass().getName());
			LOGGER.error("Exception  Message: {}", e.getMessage());
		} finally {
		   try {writer.close();} catch (Exception ex) {
			   ex.printStackTrace();
		   }
		}
	}


	public static boolean createFile(String file, InputStream inputStream) {

		boolean result = false;

		File dir = new File(file);
		LOGGER.debug(dir.getAbsolutePath());
		LOGGER.debug(dir.getParent());
		try {
			LOGGER.debug(dir.getCanonicalPath());
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

    	if(!dir.getParentFile().exists()){
    		dir.getParentFile().mkdirs();
    	}

    	try {
			FileUtils.copyInputStreamToFile(inputStream, dir);

			result = true;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return result;
	}

	/** 파일 읽기 */
	public static String readFile(String file) {
		StringBuffer contents = new StringBuffer();
		BufferedReader in = null;
		try {
	      in = new BufferedReader(new FileReader(file));
	      String line;

	      while ((line = in.readLine()) != null) {
	    	  contents.append(line + "\n");
	      }
	    } catch (IOException e) {
	    	LOGGER.error("Exception: {}", e.getClass().getName());
			LOGGER.error("Exception  Message: {}", e.getMessage());
	    } finally {
	    	try {in.close();} catch(Exception e) {
	    		e.printStackTrace();
	    	}
	    }
		return contents.toString();
	}

	/**파일 확장자 가져오기*/
	public static String fileExt(String fileName) throws Exception {
		String ext = fileName.substring(fileName.lastIndexOf(".")+1).toLowerCase();
		return ext;
	}

	public static String getBase64Binary(String filename) {
		String result = "ERR-FILETOBINARY";
		FileInputStream fis = null;
		BufferedInputStream input = null;
		ByteArrayOutputStream output = null;
//		BASE64Encoder b64 = new BASE64Encoder();
		try {
			fis = new FileInputStream(filename);
			input = new BufferedInputStream(fis);
			output = new ByteArrayOutputStream();
			byte[] buffer = new byte[5120];
			int count = 0;
			while ((count = input.read(buffer)) != -1) {
				output.write(buffer, 0, count);
			}
			result = Base64.getMimeEncoder().encodeToString(output.toByteArray());
//			result = b64.encode(output.toByteArray());
		} catch(Exception e) {
			return result;
		} finally {
			try {
				if (input != null)
					input.close();
			} catch (Exception ignore) {
				ignore.printStackTrace();
			}
		}
		return result;
	}

	public static String generatStreFileNameExt(String fileName,  String path) {
		String ext = fileName.substring( fileName.lastIndexOf(".") + 1 );
		String uploadTime = EgovDateUtil.getCurrentDateTimeAsString() + EgovDateUtil.getCurrentMilliSecondAsString();

		int index = 1;
		String uploadName =  uploadTime + index + "." + ext;
		while( new File( path + File.separator + uploadName).exists() ) {
			index++;
			uploadName = uploadTime + index + "." + ext;
		}
		return uploadName;

	}

}
