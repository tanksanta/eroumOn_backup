<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<jsp:include page="../layout/page_header.jsp" >
		<jsp:param value="자주 묻는 질문" name="pageTitle"/>
	</jsp:include>

	<div id="page-container">

		<jsp:include page="../layout/page_sidenav.jsp" />

		<div id="page-content">
			<ul class="tabs is-cols-4 tabs-question">
				<li><a href="${_marketPath}/etc/faq/list" class="tabs-link sortBy">전체</a></li>
				<c:forEach var="ctgry" items="${bbsSetupVO.ctgryList}">
					<li><a href="${_marketPath}/etc/faq/list?ctgryNo=${ctgry.ctgryNo}" class="tabs-link sortBy${ctgry.ctgryNo}">${ctgry.ctgryNm}</a></li>
				</c:forEach>
			</ul>

			<c:if test="${empty listVO.listObject}"><div class="box-result is-large mt-3 md:mt-5">등록된 게시물이 없습니다.</div></c:if>

			<c:if test="${!empty listVO.listObject}">
				<div class="accordion-question mt-7.5 md:mt-13" id="accordion-question">
					<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
						<div class="accordion-item">
							<div class="accordion-container">
								<a href="#collapse-item${status.index}" class="accordion-header" data-bs-toggle="collapse" data-bs-target="#collapse-item${status.index}" aria-expanded="false"> ${resultList.ctgryNm} <strong>${resultList.ttl}</strong>
								</a>
								<div id="collapse-item${status.index}" class="accordion-collapse collapse" data-bs-parent="#accordion-question">
									<div class="accordion-body">${resultList.cn}</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</c:if>

			<div class="pagination">
				<front:paging listVO="${listVO}" />
			</div>
		</div>
	</div>
</main>

<script>
$(function(){
	const uri = "/market/etc/faq/list?ctgryNo=";

	//카테고리
	if("${param.ctgryNo}" == ''){
		$(".sortBy").addClass("active");
	}

	for(var i=1; i<7; i++){
		var href = $(".sortBy"+i).attr("href").replaceAll(uri,'');
		if(href == "${param.ctgryNo}"){
			$(".sortBy"+i).addClass("active");
		}else{
			$(".sortBy"+i).removeClass("active");
		}
	}

});
</script>