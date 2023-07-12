<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<jsp:include page="../../layout/page_header.jsp">
		<jsp:param value="상품 후기" name="pageTitle" />
	</jsp:include>


	<div id="page-container">

		<jsp:include page="../../layout/page_sidenav.jsp" />

		<div id="page-content">
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
									<dd>
										<fmt:formatNumber value="${resultMap.avCount * 500}" pattern="###,###" />
									</dd>
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
					<li><a href="${_marketPath}/mypage/review/doList" class="tabs-link active">작성 가능한 상품후기 (${resultMap.avCount})</a></li>
					<li><a href="${_marketPath}/mypage/review/list" class="tabs-link">등록한 상품후기 (${resultMap.rgCount})</a></li>
				</ul>
				<c:if test="${empty itemList}">
					<div class="box-result is-large mt40">아직 구매하신 상품이 없습니다</div>
				</c:if>

				<%-- 루프 시작 --%>
				<c:forEach items="${itemList}" var="ordrDtl" varStatus="status">
					<c:set var="pageParam" value="curPage=${listVO.curPage}${!empty(listVO.urlParam)? '&amp;' : ''}${listVO.urlParam}" />

					<c:set var="spOrdrOptn" value="${fn:split(ordrDtl.ordrOptn, '*')}" />

					<c:if test="${ordrDtl.ordrOptnTy eq 'BASE'}">

						<c:set var="sumOrdrPc" value="${ordrDtl.ordrPc }" />
						<c:set var="ordrQy" value="${ordrDtl.ordrQy }" />

						<%-- 통합 주문 번호 --%>
						<c:if test="${status.first}">

							<div class="order-product member-order mt30">
								<div class="order-header">
									<dl>
										<dt>주문번호</dt>
										<dd>
											<strong><a href="${_marketPath}/mypage/ordr/view/${ordrDtl.ordrCd}">${ordrDtl.ordrCd}</a></strong>
										</dd>
									</dl>
									<dl>
										<dt>주문일시</dt>
										<dd><fmt:formatDate value="${ordrDtl.regDt}" pattern="yyyy-MM-dd HH:mm:ss" /></dd>
									</dl>
								</div>
								<div class="order-body">

						</c:if>
						<%-- 통합 주문 번호 --%>


						<div class="order-item">
							<div class="order-item-thumb">
								<c:choose>
									<c:when test="${!empty ordrDtl.gdsInfo.thumbnailFile }">
										<a href="${_marketPath}/gds/${ordrDtl.gdsInfo.ctgryNo}/${ordrDtl.gdsInfo.gdsCd}" target="_blank"><img src="/comm/getImage?srvcId=GDS&amp;upNo=${ordrDtl.gdsInfo.thumbnailFile.upNo }&amp;fileTy=${ordrDtl.gdsInfo.thumbnailFile.fileTy }&amp;fileNo=${ordrDtl.gdsInfo.thumbnailFile.fileNo }&amp;thumbYn=Y" alt=""></a>
									</c:when>
									<c:otherwise>
										<img src="/html/page/market/assets/images/noimg.jpg" alt="">
									</c:otherwise>
								</c:choose>
							</div>
							<div class="order-item-content">
								<div class="order-item-group" style="min-height: 160px;">
									<div class="order-item-base">
										<p class="code">
											<u>${ordrDtl.gdsInfo.gdsCd }</u>
										</p>
										<div class="product product-pdx">
											<p class="name">${ordrDtl.gdsInfo.gdsNm }</p>
											<c:if test="${!empty spOrdrOptn[0]}">
												<dl class="option">
													<dt>옵션</dt>
													<dd>
														<c:forEach items="${spOrdrOptn}" var="ordrOptn">
															<span class="label-flat">${ordrOptn}</span>
														</c:forEach>
													</dd>
												</dl>
											</c:if>
										</div>
									</div>
					</c:if>
					<c:if test="${ordrDtl.ordrOptnTy eq 'ADIT'}">

						<c:set var="sumOrdrPc" value="${sumOrdrPc + ordrDtl.ordrPc}" />
						<div class="order-item-add">
							<span class="label-outline-primary"> <span>${spOrdrOptn[0]}</span> <i><img src="/html/page/market/assets/images/ico-plus-white.svg" alt=""></i>
							</span>
							<div class="name">
								<p>
									<strong>${spOrdrOptn[1]}</strong>
								</p>
								<p>
									수량 ${ordrDtl.ordrQy}개 (+
									<fmt:formatNumber value="${ordrDtl.ordrPc}" pattern="###,###" />
									원)
								</p>
							</div>
						</div>
					</c:if>

					<c:if test="${itemList[status.index+1].ordrOptnTy eq 'BASE' || status.last}">
			</div>

			<c:set var="getNow" value="<%=new java.util.Date()%>" />
			<div class="count">
				<c:if test="${ordrDtl.boolDt eq true}"><button type="button" class="btn btn-primary btn-small updBtn" data-gds-no="${ordrDtl.gdsNo}" data-gds-cd="${ordrDtl.gdsCd}" data-ordr-cd="${ordrDtl.ordrCd}" data-ordr-dtl="${ordrDtl.ordrDtlNo}" data-ordr-no="${ordrDtl.ordrNo}">상품후기 작성</button></c:if>
				<c:if test="${ordrDtl.boolDt eq false}"><button type="button" class="btn btn-secondary btn-primary btn-small" disabled>작성기간 경과</button></c:if>
			</div>
		</div>
	</div>

	<%-- 통합 주문 번호 --%>
	<c:if test="${status.last || (ordrDtl.ordrCd ne itemList[status.index+1].ordrCd )}">
		</div>
		<c:set var="ordrCancelBtn" value="false" />

		</div>
	</c:if>
	<c:if test="${!status.last && ordrDtl.ordrCd ne itemList[status.index+1].ordrCd}">

		<div class="order-product member-order mt30">
			<div class="order-header">
				<dl>
					<dt>주문번호</dt>
					<dd>
						<strong>${itemList[status.index+1].ordrCd}</strong>
					</dd>
				</dl>
				<dl>
					<dt>주문일시</dt>
					<%--주문/취소 --%>
					<dd>
						<fmt:formatDate value="${itemList[status.index+1].regDt}" pattern="yyyy.MM.dd HH:mm:ss" />
						<br>
					</dd>
				</dl>
				<!-- <button type="button" class="f_all_rtrcn">전체취소</button> -->
			</div>
			<div class="order-body">

	</c:if>
	<%-- 통합 주문 번호 --%>
	</c:if>
	</c:forEach>
	<%-- 루프 시작// --%>

	</div>
	</div>
	</div>

	<div id="gdsReviewFrm"></div>
</main>

<script>
$(function(){

	//수정 modal callback
	$(".updBtn").on("click",function(){
		var gdsNo = $(this).data("gdsNo");
		var gdsCd = $(this).data("gdsCd");
		var ordrCd = $(this).data("ordrCd");
		var ordrDtlNo = $(this).data("ordrDtl");
		var ordrNo = $(this).data("ordrNo");

		$("#gdsReviewFrm").load("./gdsReviewModal"
				, {gdsReviewNo : 0
			, gdsNo : gdsNo
			, gdsCd : gdsCd
			, ordrCd : ordrCd
			, ordrDtlNo : ordrDtlNo
			, ordrNo : ordrNo}
				, function(){
					$("#reviewModal").addClass("fade").modal("show");
		});

	});

});
</script>

