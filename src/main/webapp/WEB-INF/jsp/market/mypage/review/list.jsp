<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<main id="container" class="is-mypage">
	<jsp:include page="../../layout/page_header.jsp">
		<jsp:param value="상품 후기" name="pageTitle" />
	</jsp:include>

	<div id="page-container">
		<jsp:include page="../../layout/page_sidenav.jsp" />

		<div id="page-content">
			<jsp:include page="../../layout/mobile_userinfo.jsp" />

            <div class="mypage-review-point">
                <div class="point-left">
                    <dl>
                        <dt><strong>적립 예상 포인트</strong></dt>
                        <dd><fmt:formatNumber value="${resultMap.avCount * 500}" pattern="###,###" /></dd>
                    </dl>
                </div>
                <div class="point-right">
                    <dl>
                        <dt><strong>상품후기</strong> 작성시</dt>
                        <dd>200 포인트 적립</dd>
                    </dl>
                    <dl>
                        <dt><strong>포토후기</strong> 작성시</dt>
                        <dd>500 포인트 적립</dd>
                    </dl>
                </div>
            </div>
            
			<ul class="tabs mt-8">
				<li><a href="${_marketPath}/mypage/review/doList" class="tabs-link">작성 가능한 상품후기 (${resultMap.avCount})</a></li>
				<li><a href="${_marketPath}/mypage/review/list" class="tabs-link active">등록한 상품후기 (${resultMap.rgCount})</a></li>
			</ul>
            
			<div class="mt-9 lg:mt-12">
				<c:if test="${empty itemList}">
				<div class="box-result is-large">아직 구매하신 상품이 없습니다</div>
				</c:if>
				<c:forEach var="resultList" items="${itemList}" varStatus="status">
				<div class="mypage-myinfo-review-item">
					<c:if test="${resultList.imgUseYn eq 'Y'}">
	                <div class="item-thumb">
						<c:set var="imgFile" value="${resultList.imgFile}" />
						<img src="/comm/getImage?srvcId=REVIEW&amp;upNo=${resultList.gdsReivewNo}&amp;fileNo=${resultList.imgFile.fileNo}" alt="">
	                </div>
					</c:if>
					
					<div class="item-content">
						<div class="score">
						    <strong>${resultList.dgstfn}</strong>
						    <div><div style="width: ${resultList.dgstfn * 20}%"></div></div>
						</div>
						<p class="code">${resultList.gdsCd}</p>
						<p class="name">${resultList.ttl}</p>
						<p class="cont">${resultList.cn}</p>
						<p class="date"><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd" /></p>
					</div>
					
					<div class="item-button">
						<button type="button" class="btn btn-primary btn-small updBtn" data-review-no="${resultList.gdsReivewNo}" data-gds-no="${resultList.gdsNo}" data-gds-cd="${resultList.gdsCd}" data-ordr-cd="${resultList.ordrCd}" data-ordr-dtl="${resultList.ordrDtlNo}" data-ordr-no="${resultList.ordrNo}">수정</button>
						<!-- <button type="button" class="btn btn-secondary btn-small">삭제</button> -->
					</div>
				</div>
				</c:forEach>
			</div>
		</div>
	</div>

	<div id="gdsReviewFrm"></div>
</main>

<script>
$(function(){
	//수정 modal callback
	$(".updBtn").on("click",function(){
		var reviewNo = $(this).data("reviewNo");
		
		$("#gdsReviewFrm").load("./gdsReviewModal", {
				gdsReviewNo : reviewNo,
				gdsNo : 0,
				ordrDtlNo : 0, ordrNo : 0
			}, function(){
				$("#reviewModal").addClass("fade").modal("show");
		});
	});
});
</script>