<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/page_header.jsp">
	<jsp:param value="공지사항" name="pageTitle" />
</jsp:include>
<div id="page-content">
	<p class="p-3 rounded-md bg-gray2">* 이로움마켓 공지사항은 이로움마켓에서 멤버스(사업소)로 전달하는 공지사항입니다.</p>

	<p class="text-title2 mt-13">공지사항 상세</p>
	<table class="table-detail">
		<colgroup>
			<col class="w-43">
			<col>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">제목</th>
				<td>${noticeVO.ttl}</td>
			</tr>
			<tr>
				<th scope="row">내용</th>
				<td>${noticeVO.cn}</td>
			</tr>
			<tr>
				<th scope="row"><label for="form-item7">첨부파일</label></th>
				<td>
					<c:forEach var="fileList" items="${noticeVO.fileList}" varStatus="status">
					<div id="attachFileViewDiv${fileList.fileNo}">
						<a href="/comm/getFile?srvcId=${fileList.srvcId }&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">${fileList.orgnlFileNm} (다운로드 : ${fileList.dwnldCnt}회)</a>&nbsp;&nbsp;
					</div>
					</c:forEach>
				</td>
			</tr>
		</tbody>
	</table>
	<c:set var="pageParam" value="curPage=${param.curPage }&amp;cntPerPage=${param.cntPerPage}" />
	<div class="btn-group mt-8 right">
		<a href="./list?${pageParam}" class="btn-primary large shadow">목록</a>
	</div>
</div>