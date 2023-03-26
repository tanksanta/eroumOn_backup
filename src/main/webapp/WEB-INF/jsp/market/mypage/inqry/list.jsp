<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<jsp:include page="../../layout/page_header.jsp">
		<jsp:param value="1:1 문의" name="pageTitle" />
	</jsp:include>


	<div id="page-container">

	<jsp:include page="../../layout/page_sidenav.jsp" />

		<div id="page-content">
            <div class="items-center justify-between md:flex">
                <div class="space-y-1.5 md:mr-3">
					<p class="text-alert">문의하신 내용과 답변내용 확인하실 수 있습니다.</p>
					<p class="text-alert">질문 내용에 만족 하실 만한 답변 작성을 위해서 시간 소요가 될 수 있는 점 양해 부탁드립니다.</p>
					<p class="text-alert">답변 완료된 문의는 수정, 삭제 하실 수 없습니다.</p>
                </div>
                <div class="ml-auto my-3 w-46 md:w-53">
					<a href="${_marketPath}/mypage/inqry/form" class="btn btn-primary btn-large w-full">1:1 문의하기</a>
                </div>
            </div>
            
            <p class="text-title2 mt-11 md:mt-15">1:1 문의 <strong class="text-danger">${listVO.totalCount}</strong>건</p>
            
            <div class="mt-4 md:mt-5 space-y-3 md:space-y-4">
				<c:if test="${empty listVO.listObject}">
				<div class="box-result is-large">아직 문의하신 내용이 없습니다</div>
				</c:if>
				<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
	            <div class="mypage-inquiry-items">
					<c:if test="${resultList.ansYn eq 'Y' }">
	                <span class="label-primary">
	                    <span>답변완료</span>
	                    <i></i>
	                </span>
					</c:if>
	                <dl>
	                    <dt>
							<a href="${_marketPath}/mypage/inqry/view?inqryNo=${resultList.inqryNo}">
	                            <span class="part">${inqryTyCode[resultList.inqryTy]}</span>
	                            <span class="date"><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd HH:mm" /></span>
	                            <strong class="name">${resultList.ttl}</strong>
	                        </a>
	                    </dt>
	                    <dd>
	                        <div class="text">
								<c:if test="${resultList.ansYn eq 'Y'}">${resultList.ansCn}</c:if>
								<c:if test="${resultList.ansYn eq 'N' }">답변이 아직 등록되지 않았습니다</c:if>
	                        </div>
							<c:if test="${resultList.ansYn eq 'N' }">
	                        <div class="button">
	                            <a href="${_marketPath}/mypage/inqry/form?inqryNo=${resultList.inqryNo}" class="btn btn-primary btn-small">수정</a>
	                            <button type="button" class="btn btn-outline-primary btn-small delBtn" data-inqry-no="${resultList.inqryNo}">삭제</button>
	                        </div>
							</c:if>
	                    </dd>
	                </dl>
	            </div>
				</c:forEach>
            </div>
		</div>
	</div>
</main>

<script>
$(function(){

	//삭제
	$(".delBtn").on("click",function(){
		var inqryNos = $(this).data("inqryNo");

		if(confirm("삭제하시겠습니까?")){
			$.ajax({
				type: 'post',
				url : 'deleteInqry.json',
				data: {
					inqryNo : inqryNos
				},
				dataType: 'json'
			})
			.done(function(data){
				if(data==true){
					alert("삭제되었습니다");
					location.reload();
				}else{
					alert("삭제 처리 중 오류가 발생하였습니다. \n 관리자에게 문의바랍니다.");
				}
			})
			.fail(function(){
				alert("삭제 처리 중 오류가 발생하였습니다. \n 관리자에게 문의바랍니다.");
			})
		}else{
			return false;
		}
	});
});
</script>