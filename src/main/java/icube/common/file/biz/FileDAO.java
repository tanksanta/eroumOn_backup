package icube.common.file.biz;

import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("fileDAO")
public class FileDAO extends CommonAbstractMapper {

	public void createFileInfo(Map<String, Object> fileMap) throws Exception {
		String srvcId = MapUtils.getString(fileMap, "srvcId", "");
		if (srvcId.startsWith("BBS")) {
			insert("bbs.file.insertFileInfo", fileMap);
		} else if (srvcId.startsWith("GDS")) {
			insert("gds.file.insertFileInfo", fileMap);
		} else if(srvcId.startsWith("BPLC")) {
			insert("bplc.bbs.file.insertFileInfo", fileMap);
		}else {
			insert("file.insertFileInfo", fileMap);
		}
	}

	public FileVO selectFileByFilter(Map<String, Object> fileMap) throws Exception {
		String srvcId = MapUtils.getString(fileMap, "srvcId");
		if (srvcId.startsWith("BBS")) {
			return selectOne("bbs.file.selectFileByFilter", fileMap);
		} else if (srvcId.startsWith("GDS")) {
			return selectOne("gds.file.selectFileByFilter", fileMap);
		} else if(srvcId.startsWith("BPLC")) {
			return selectOne("bplc.bbs.file.selectFileByFilter", fileMap);
		} else {
			return selectOne("file.selectFileByFilter", fileMap);
		}
	}

	public void updateDwldCo(Map<String, Object> fileMap) throws Exception {
		String srvcId = MapUtils.getString(fileMap, "srvcId");
		if (srvcId.startsWith("BBS")) {
			update("bbs.file.updateDwldCo", fileMap);
		} else if (srvcId.startsWith("GDS")) {
			update("gds.file.updateDwldCo", fileMap);
		} else if(srvcId.startsWith("BPLC")) {
			update("bplc.bbs.file.updateDwldCo", fileMap);
		} else {
			update("file.updateDwldCo", fileMap);
		}
	}

	public void updateFileDc(Map<String, Object> fileMap) throws Exception {
		String srvcId = MapUtils.getString(fileMap, "srvcId");
		if (srvcId.startsWith("BBS")) {
			update("bbs.file.updateFileDc", fileMap);
		} else if (srvcId.startsWith("GDS")) {
			update("gds.file.updateFileDc", fileMap);
		} else {
			update("file.updateFileDc", fileMap);
		}
	}

	public void deleteFileByNo(Map<String, Object> fileMap) throws Exception {
		String srvcId = MapUtils.getString(fileMap, "srvcId");
		if (srvcId.startsWith("BBS")) {
			update("bbs.file.deleteFileByNo", fileMap);
		} else if (srvcId.startsWith("GDS")) {
			update("gds.file.deleteFileByNo", fileMap);
		} else if(srvcId.startsWith("BPLC")) {
			update("bplc.bbs.file.deleteFileByNo", fileMap);
		}else {
			update("file.deleteFileByNo", fileMap);
		}
	}

	public void deleteFileByUpperNo(Map<String, Object> fileMap) throws Exception {
		String srvcId = MapUtils.getString(fileMap, "srvcId");
		if (srvcId.startsWith("BBS")) {
			update("bbs.file.deleteFileByUpperNo", fileMap);
		} else if (srvcId.startsWith("GDS")) {
			update("gds.file.deleteFileByUpperNo", fileMap);
		} else {
			update("file.deleteFileByUpperNo", fileMap);
		}
	}

	public List<FileVO> selectFileList(Map<String, Object> fileMap) throws Exception {
		String srvcId = MapUtils.getString(fileMap, "srvcId");
		if (srvcId.startsWith("BBS")) {
			return selectList("bbs.file.selectFileList", fileMap);
		} else if (srvcId.startsWith("GDS")) {
			return selectList("gds.file.selectFileList", fileMap);
		} else {
			return selectList("file.selectFileList", fileMap);
		}
	}

	public List<FileVO> selectFileListAll(Map<String, Object> reqMap) throws Exception{
		return selectList("file.selectFileListAll", reqMap);
	}

}
