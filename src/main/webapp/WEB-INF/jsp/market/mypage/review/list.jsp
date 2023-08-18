<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
var active_html = "";
active_html += '<button type="button">';
active_html += '<img src="/html/page/market/assets/images/content2/star_active.png" alt="">';
active_html += '</button>';

var normal_html = "";
normal_html += '<button type="button">';
normal_html += '<img src="/html/page/market/assets/images/content2/star_normal.png" alt="">';
normal_html += '</button>';
</script>
<main id="container" class="is-mypage">
	<jsp:include page="../../layout/page_header.jsp">
		<jsp:param value="상품 후기" name="pageTitle" />
	</jsp:include>

	<div id="page-container">

		<jsp:include page="../../layout/page_sidenav.jsp" />

		<div id="page-content">
			<jsp:include page="../../layout/mobile_userinfo.jsp" />

			<link rel="stylesheet" href="/html/page/market/assets/style/mypage-jh.css">
			<div class="mypage-content">
				<!-- <div class="expected-point">
					<div class="box">
						<div class="left">
							<div class="white">
								<dl>
									<dt>
										<strong>적립 예상 포인트</strong>
									</dt>
									<dd><fmt:formatNumber value="${resultMap.avCount * 500}" pattern="###,###" /></dd>
								</dl>
							</div>
						</div>
						<div class="right">
							<dl>
								<dt>
									<strong class="red">상품후기</strong> 작성시
								</dt>
								<dd>200 포인트 적립</dd>
							</dl>
							<dl>
								<dt>
									<strong class="blue">포토후기</strong> 작성시
								</dt>
								<dd>500 포인트 적립</dd>
							</dl>
						</div>
					</div>
				</div> -->
				<ul class="tabs mt30">
					<li><a href="${_marketPath}/mypage/review/doList" class="tabs-link">작성 가능한 상품후기 (${resultMap.avCount})</a></li>
					<li><a href="${_marketPath}/mypage/review/list" class="tabs-link active">등록한 상품후기 (${resultMap.rgCount})</a></li>
				</ul>
				<c:if test="${empty itemList}">
					<div class="box-result is-large mt40">아직 구매하신 상품이 없습니다</div>
				</c:if>


				<div class="product-review mt30">
					<ul class="review-body">
						<c:forEach var="resultList" items="${itemList}" varStatus="status">
						<script>var starCount = "${resultList.dgstfn}";</script>
							<c:if test="${resultList.imgUseYn eq 'Y'}">
								<li>
									<div class="img">
										<c:set var="imgFile" value="${resultList.imgFile}" />
										<img src="/comm/getImage?srvcId=REVIEW&amp;upNo=${resultList.gdsReivewNo}&amp;fileNo=${resultList.imgFile.fileNo}" alt="">
									</div>
									<div class="title product-num">
										<span>${resultList.gdsCd}</span><br> ${resultList.ttl}
									</div>
									<div class="content">
										<span class="text">${resultList.cn}</span>
										<span class="date"><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd" /></span>
										<div class="del-btn-box">
											<button type="button" class="btn btn-primary btn-small updBtn" data-review-no="${resultList.gdsReivewNo}">수정</button>
											<!-- <button type="button" class="btn btn-secondary btn-small">삭제</button> -->
										</div>
										<div class="score">
											<div class="star-score starview${status.index}">
												<span class="score-text">${resultList.dgstfn}.0</span>
												<script language="JavaScript">
													for(var i=0; i<starCount; i++){
														$(".starview"+${status.index}).append(active_html);
													}
													for(var i=0; i<(5-starCount); i++){
														$(".starview"+${status.index}).append(normal_html);
													}
												</script>
											</div>
										</div>
									</div>
								</li>
							</c:if>

							<c:if test="${resultList.imgUseYn eq 'N'}">
								<li class="img-none">
									<div class="title product-num">
										<span>${resultList.gdsCd}</span><br> ${resultList.ttl }
									</div>
									<div class="content">
										<span class="text">${resultList.cn}</span> <span class="date"><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd" /></span>
										<div class="del-btn-box">
											<button type="button" class="btn btn-primary btn-small updBtn" data-review-no="${resultList.gdsReivewNo}" data-gds-no="${resultList.gdsNo}" data-gds-cd="${resultList.gdsCd}" data-ordr-cd="${resultList.ordrCd}" data-ordr-dtl="${resultList.ordrDtlNo}" data-ordr-no="${resultList.ordrNo}">수정</button>
										</div>
										<div class="score">
											<div class="star-score starviewNon${status.index}">
												<span class="score-text">${resultList.dgstfn}.0</span>
												<script language="JavaScript">
													for(var i=0; i<starCount; i++){
														$(".starviewNon"+${status.index}).append(active_html);
													}
													for(var i=0; i<(5-starCount); i++){
														$(".starviewNon"+${status.index}).append(normal_html);
													}
												</script>
											</div>
										</div>
									</div>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>

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

		$("#gdsReviewFrm").load("./gdsReviewModal"
				, {gdsReviewNo : reviewNo
					, gdsNo : 0
					, ordrDtlNo : 0
					, ordrNo : 0}
				, function(){
					$("#reviewModal").addClass("fade").modal("show");
		});

	});

});
</script>