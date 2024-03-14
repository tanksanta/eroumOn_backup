<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/html/core/script/ckeditor5-online-builder/sample/ckview.css?v=<spring:eval expression="@version['assets.version']"/>"/>

<main id="container">
	<jsp:include page="../../layout/page_header.jsp" >
		<jsp:param value="공지사항" name="pageTitle"/>
	</jsp:include>

	<div id="page-container">

		<jsp:include page="../../layout/page_sidenav.jsp" />

		<div id="page-content">
			<div class="board-detail">
				<div class="detail-header">
					<div class="name">
						<strong>${nttVO.ttl}</strong> <small><fmt:formatDate value="${nttVO.regDt}" pattern="yyyy-MM-dd" /></small>
					</div>
				</div>
				<div class="detail-body ck-content">
					${nttVO.cn}
				</div>
				<c:if test="${bbsSetupVO.atchfileUseYn eq 'Y' && bbsSetupVO.atchfileCnt > 0}">
					<dl class="detail-file">
						<dt>첨부파일</dt>
						<dd>
							<c:forEach var="fileList" items="${nttVO.bbsFileList }" varStatus="status">
								<div id="attachFileViewDiv${fileList.fileNo}">
									<a href="/comm/getFile?srvcId=BBS&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">
									${fileList.orgnlFileNm} (용량 : ${fnc:fileSize(fileList.fileSz)}, 다운로드 : ${fileList.dwnldCnt}회)</a>&nbsp; <a href="#f_delFile" onclick="f_delFile('${fileList.fileNo}', 'ATTACH', '${status.index}'); return false;"><i class="fa fa-trash"></i></a>
								</div>
							</c:forEach>
						</dd>
					</dl>
				</c:if>
				<a href="${_marketPath}/etc/ntce/list?curPage=${param.curPage}" class="detail-golist">목록으로</a>
			</div>
		</div>
	</div>
</main>