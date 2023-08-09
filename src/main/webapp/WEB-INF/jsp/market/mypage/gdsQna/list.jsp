<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container" class="is-mypage">
	<jsp:include page="../../layout/page_header.jsp">
		<jsp:param value="상품 Q&A" name="pageTitle" />
	</jsp:include>

	<div id="page-container">

	<jsp:include page="../../layout/page_sidenav.jsp" />

		<div id="page-content">
			<script>
				$(function() {
					$('.product-qnaitem .answer .btn').on('click', function() {
						$(this).closest('.product-qnaitem').toggleClass('is-active');
					});
				})
			</script>

			<div class="global-user mb-9 ${_mbrSession.mberGrade eq 'E' ? 'is-grade1' : _mbrSession.mberGrade eq 'B' ? 'is-grade2' : _mbrSession.mberGrade eq 'S' ? 'is-grade3' : _mbrSession.mberGrade eq 'N' ? '' : ''} lg:hidden">
				<div class="user-name">
				    <strong>${_mbrSession.mbrNm} <small>님</small></strong>
					<span>${recipterYnCode[_mbrSession.recipterYn]}</span>
                       <button type="button" class="user-toggle">메뉴 열기</button>
				</div>
				<div class="user-info">
				    <div class="grade">
				        <strong>${gradeCode[_mbrSession.mberGrade]}</strong>
						<a href="${_marketPath}/etc/bnft/list">등급별혜택</a>
					</div>
					<div class="point">
					    <dl>
					        <dt>쿠폰</dt>
					        <dd>
					        	<a href="${_marketPath}/mypage/coupon/list">
                               		<strong>11</strong> 장
						   		</a>
						 	</dd>
						</dl>
						<dl>
						    <dt>포인트</dt>
						    <dd>
						   		<a href="${_marketPath}/mypage/point/list">
                               		<strong>11</strong>
									<img src="/html/page/members/assets/images/txt-point-white.svg" alt="포인트">
								</a>
							</dd>
	                    </dl>
	                    <dl>
	                        <dt>마일리지</dt>
	                        <dd>
	                        	<a href="${_marketPath}/mypage/mlg/list">
                               		<strong>11</strong>
									<img src="/html/page/members/assets/images/txt-mileage-white.svg" alt="마일리지">
								</a>
							</dd>
	                    </dl>
	                </div>
	            </div>
            </div>
            
			<div class="space-y-1.5 mb-12 md:mb-16">
				<p class="text-alert">문의하신 상품 Q&A를 쉽고 빠르게 확인하실 수 있습니다.</p>
				<p class="text-alert">상품과 관계가 없는 내용이나 비방성 글은 등록자에게 사전 동의 없이 임의로 삭제될 수 있습니다.</p>
				<p class="text-alert">답변완료된 문의는 수정, 삭제 하실 수 없습니다.</p>
			</div>

			<c:if test="${empty listVO.listObject}"><div class="box-result is-large">아직 작성한 Q&A가 없습니다</div></c:if>

			<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
				<div class="mypage-myinfo-qna-item">
					<div class="item-thumb">
						<c:forEach var="fileList" items="${resultList.gdsImgList}" varStatus="status">
							<img src="/comm/getImage?srvcId=GDS&amp;upNo=${fileList.upNo}&amp;fileTy=THUMB&amp;fileNo=${fileList.fileNo}" alt="">
						</c:forEach>
					</div>
					<a href="${_marketPath}/gds/${resultList.gdsInfo.ctgryNo}/${resultList.gdsCd}" target="_blank">
						<div class="item-product">
							<p class="code">${resultList.gdsCd}</p>
							<p class="name">${resultList.gdsNm}</p>
						</div>
					</a>
					<div class="product-qnaitem">
						<div class="question">
							<span class="label-primary"> <span>${resultList.ansYn eq 'Y'?'답변 완료':'답변 대기'}</span> <i></i>
							</span>
							<p class="subject">${resultList.qestnCn}</p>
							<p class="datetime"><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd HH:mm" /></p>
						</div>
						<c:if test="${resultList.ansYn eq 'Y' }">
						<div class="answer">
							<div class="context">
								${resultList.ansCn}
							</div>
							<button class="btn btn-fold">펼쳐보기</button>
						</div>
						</c:if>
						<c:if test="${resultList.ansYn eq 'N' && resultList.regUniqueId eq (_mbrSession.uniqueId)}">
                            <div class="modify">
								<button type="button" class="btn btn-primary h-9 md:h-10 updFrm" data-qa-no="${resultList.qaNo}" >수정</button>
								<button type="button" class="btn btn-outline-primary h-9 md:h-10 delQa" data-qa-no="${resultList.qaNo}">삭제</button>
							</div>
						</c:if>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<div id="updateFrm"></div>

</main>

<script>
$(function(){

	// modal callback
	$(".updFrm").on("click",function(){
		var qaNo =$(this).data("qaNo");
		$("#updateFrm").load("./modalGdsQnaForm"
				, {qaNo : qaNo}
				, function(){
					$("#qnaModal").addClass("fade").modal("show");
		});
	});

	// 펼쳐보기
	$(".btn-fold").on("click",function(){
		if($(this).closest(".product-qnaitem").hasClass("is-active")){
			$(this).text("접기");
		}else{
			$(this).text("펼쳐보기");
		}
	});

	// 게시글 삭제
	$(".delQa").on("click",function(){
		var qaNo = $(this).data("qaNo");
		if(confirm("삭제하시겠습니까?")){
			$.ajax({
				type: 'post',
				url : '/market/mypage/gdsQna/deleteQna.json',
				data: {qaNo : qaNo},
				dataType: 'json' ,
			})
			.done(function(data){
				if(data.result==true){
					alert("삭제되었습니다");
					location.reload();
				}else{
					alert("게시글 삭제 중 오류가 발생하였습니다. \n 관리자에게 문의바랍니다.");
				}
			})
			.fail(function(){
				alert("게시글 삭제 중 오류가 발생하였습니다. \n 관리자에게 문의바랍니다.");
			})
		}else{
			return false;
		}
	});
})
</script>