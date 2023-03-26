<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<h2 class="page-title">공지사항</h2>

	<!-- 게시물 본문 -->
	<div class="board-detail">
		<h3 class="name">${bbsVO.ttl}</h3>
		<div class="info">
			<p>${bbsVO.wrtYmd}</p>
			<p>조회수 ${bbsVO.inqcnt}</p>
		</div>
		<div class="cont">
			${bbsVO.cn}
		</div>


		<!-- 첨부파일 : TO-DO 첨부파일 퍼블리싱 체크 -->
		<c:if test="${!empty bbsVO.bplcFileList }">
        <dl class="file">
            <dt>첨부파일</dt>
            <dd>
			<c:forEach var="fileList" items="${bbsVO.bplcFileList}" varStatus="status">
				<div id="attachFileViewDiv${fileList.fileNo}">
					<a href="/comm/getFile?srvcId=BPLCBBS&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">${fileList.orgnlFileNm} (다운로드 : ${fileList.dwnldCnt}회)</a>
				</div>
			</c:forEach>
            </dd>
        </dl>
		</c:if>

		<c:set var="pageParam" value="curPage=${param.curPage }&amp;cntPerPage=${param.cntPerPage}" />
		<div class="link">
	        <a href="./list?${pageParam}" class="btn">목록</a>
	    </div>
	</div>
	<!-- //게시물 본문 -->

</main>