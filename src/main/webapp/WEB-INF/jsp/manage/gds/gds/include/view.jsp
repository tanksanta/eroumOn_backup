<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta http-equiv="x-ua-compatible" content="ie=edge">

<title>이로움ON 마켓</title>

<link id="favicon" rel="shortcut icon" href="/html/core/images/favicon.ico" sizes="16x16">

<!-- plugin -->
<link rel="stylesheet" href="/html/core/vendor/swiperjs/swiper-bundle.css">
<script src="/html/core/vendor/jquery/jquery-3.6.0.min.js"></script>
<script src="/html/core/vendor/jquery.validate/jquery.validate.min.js"></script>
<script src="/html/core/vendor/swiperjs/swiper-bundle.min.js"></script>

<!-- market -->
<link rel="stylesheet" href="/html/page/market/assets/style/style.min.css?v=<spring:eval expression="@version['assets.version']"/>">
<script src="/html/page/market/assets/script/common.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
<script src="/html/page/market/assets/script/product.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
</head>

<body>
	<main id="container" class="is-product">
		<div id="page-header">
			<a href="#" class="page-header-back">이전 페이지 가기</a>
			<ul class="page-header-breadcrumb">
				<li><a href="#">${_gdsCtgryListMap[upCtgryNo]}</a>
					<ul>
						<c:forEach items="${_gdsCtgryList}" var="ctgry">
							<c:if test="${ctgry.upCtgryNo == 1}">
								<%--최상위--%>
								<li><a href="${_marketPath}/gds/${ctgry.ctgryNo}/list">${ctgry.ctgryNm}</a></li>
							</c:if>
						</c:forEach>
					</ul></li>
			</ul>
			<h2 class="page-header-name">${_gdsCtgryListMap[ctgryNo]}</h2>
		</div>

		<div id="page-container">

			<div class="product-detail">
				<!-- 상품 내용 -->
				<div class="product-detail-content">
					<c:if test="${!empty gdsVO.imageFileList}">
						<!-- 상품 슬라이드 -->
						<div class="product-slider">

							<div class="swiper product-swiper">
								<div class="swiper-wrapper">
									<c:forEach var="fileList" items="${gdsVO.imageFileList }" varStatus="status">
										<div class="swiper-slide">
											<img src="/comm/getImage?srvcId=GDS&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo}" alt="">
										</div>
									</c:forEach>
									<c:if test="${!empty gdsVO.youtubeUrl}">
										<div class="swiper-slide">
											<iframe width="560" height="315" src="${gdsVO.youtubeUrl}" title="YouTube video player" frameborder="0" allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
										</div>
									</c:if>
								</div>
								<div class="swiper-button-next"></div>
								<div class="swiper-button-prev"></div>
							</div>

							<div class="swiper product-swiper-thumb">
								<div class="swiper-wrapper">
									<c:forEach var="fileList" items="${gdsVO.imageFileList }" varStatus="status">
										<div class="swiper-slide">
											<img src="/comm/getImage?srvcId=GDS&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo}" alt="">
										</div>
									</c:forEach>
									<c:if test="${!empty gdsVO.youtubeUrl}">
										<div class="swiper-slide is-video">
											<img src="https://img.youtube.com/vi/${gdsVO.youtubeImg}/0.jpg" alt="">
										</div>
									</c:if>
								</div>
							</div>
						</div>
						<!-- //상품 슬라이드 -->
					</c:if>

					<c:if test="${!empty gdsVO.gdsRelList}">
						<!-- 관련 상품 -->
						<div class="product-relgood">
							<div class="mb-3 md:mb-4 flex items-center text-lg space-x-2 md:text-xl">
								<strong>관련 상품</strong>
							</div>
							<div class="swiper product-swiper">
								<div class="swiper-wrapper">
									<%--관련상품 loop--%>
									<c:forEach items="${gdsVO.gdsRelList}" var="gdsRelList" varStatus="status">
										<c:if test="${gdsRelList.useYn eq 'Y' && gdsRelList.dspyYn eq 'Y'}">
											<div class="swiper-slide">
												<div class="product-item">
													<div class="item-thumb">
														<a href="${_marketPath}/gds/${gdsRelList.upCtgryNo}/${gdsRelList.ctgryNo}/${gdsRelList.gdsCd}" class="item-content"> <c:choose>
																<c:when test="${gdsRelList.fileNo > 0}">
																	<img src="/comm/getImage?srvcId=GDS&amp;upNo=${gdsRelList.relGdsNo}&amp;fileTy=THUMB&amp;fileNo=${gdsRelList.fileNo}&amp;thumbYn=Y">
																</c:when>
																<c:otherwise>
																	<img src="/html/page/market/assets/images/noimg.jpg" alt="">
																</c:otherwise>
															</c:choose>
														</a>

													</div>
													<a href="${_marketPath}/gds/${gdsRelList.upCtgryNo}/${gdsRelList.ctgryNo}/${gdsRelList.gdsCd}" class="item-content">
														<div class="name">
															<small>${gdsRelList.ctgryNm}</small> <strong>${gdsRelList.gdsNm}</strong>
														</div>
														<div class="cost">
															<c:if test="${_mbrSession.loginCheck}">
																<c:choose>
																	<c:when test="${gdsRelList.gdsTy eq 'R' || gdsRelList.gdsTy eq 'L'}">
																		<%--급여(판매)제품--%>
																		<dl class="discount">
																			<dt>급여가</dt>
																			<dd>
																				<c:choose>
																					<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 15 }">
																						<fmt:formatNumber value="${gdsRelList.bnefPc15}" pattern="###,###" />
																						<small>원</small>
																					</c:when>
																					<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 9 }">
																						<fmt:formatNumber value="${gdsRelList.bnefPc9}" pattern="###,###" />
																						<small>원</small>
																					</c:when>
																					<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 6 }">
																						<fmt:formatNumber value="${gdsRelList.bnefPc6}" pattern="###,###" />
																						<small>원</small>
																					</c:when>
																					<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 0 }">
						                                	0<small>원</small>
																					</c:when>
																				</c:choose>
																			</dd>
																		</dl>
																	</c:when>
																</c:choose>
															</c:if>
															<dl>
																<dt>판매가</dt>
																<dd>
																	<fmt:formatNumber value="${gdsRelList.pc}" pattern="###,###" />
																	<small>원</small>
																</dd>
															</dl>
														</div>
													</a>
												</div>
											</div>
										</c:if>
									</c:forEach>
								</div>
								<div class="swiper-pagination"></div>
							</div>
							<button type="button" class="swiper-button-prev">
								<span class="sr-only">이전</span>
							</button>
							<button type="button" class="swiper-button-next">
								<span class="sr-only">다음</span>
							</button>
						</div>
						<!-- //관련 상품 -->
					</c:if>

					<!-- 상세 탭 -->
					<div id="prod-tablist" class="product-tablist" style="position:static;">
						<ul class="nav">
							<li><a class="nav-link active" href="#prod-tabcontent1">상세정보</a></li>
						</ul>
					</div>
					<!-- //상세 탭 -->

					<!-- 상품 정보 -->
					<div id="prod-tabcontent1" class="product-iteminfo mt-10 md:mt-13">
						<div class="content">${gdsVO.gdsDc}</div>
						<button type="button" class="btn btn-primary btn-large">상품 상세 펼쳐보기</button>
						<p class="mt-8 mb-3 text-base font-bold md:mb-4 md:mt-12 md:text-lg">상품정보제공고시</p>

						<%-- 고시정보 script --%>
						<jsp:include page="/WEB-INF/jsp/common/ancmnt_items.jsp" />

						<table class="table-detail" id="ancmntTable">
							<colgroup>
								<col class="min-w-30 w-[30%]">
								<col>
							</colgroup>
							<tbody>
							</tbody>
						</table>

					</div>

				</div>
				<!-- //상품 내용 -->

				<!-- 상품 정보 -->
				<div class="product-detail-infomation">
					<!-- 상품 이름 -->
					<div class="product-subject">
						<div class="label">
							<c:forEach items="${gdsVO.gdsTag}" var="tag">
								<span class="${tag eq 'A'?'label-outline-danger':'label-outline-primary' }"> <span>${_gdsTagCode[tag]}</span><i></i>
								</span>
							</c:forEach>
						</div>
						<div class="name">
							<c:if test="${!empty gdsVO.brand}">
								<%--브랜드 : 추가정보 필요할 수 있음--%>
								<c:forEach items="${brandList}" var="brand" varStatus="status">
									<c:if test="${gdsVO.brand eq brand.brandNo}">
										<small>${brand.brandNm}</small>
									</c:if>
								</c:forEach>
							</c:if>
							<strong>${gdsVO.gdsNm}</strong>
						</div>

					</div>
					<!-- //상품 이름 -->

					<!-- 상품 재원 -->
					<div class="product-resource">
						<c:choose>
							<c:when test="${(gdsVO.gdsTy eq 'R' || gdsVO.gdsTy eq 'L') && _mbrSession.prtcrRecipterYn eq 'Y' }">
								<%--급여상품(판매)--%>
								<dl class="price1">
									<dt>판매가</dt>
									<dd>
										<strong><fmt:formatNumber value="${gdsVO.pc}" pattern="###,###" /></strong> 원
									</dd>
								</dl>
								<dl class="price1">
									<dt>${gdsVO.gdsTy eq 'R'?'급여가':'대여가(월)'}</dt>
									<dd>
										<strong><fmt:formatNumber value="${gdsVO.bnefPc}" pattern="###,###" /></strong> 원
										<c:if test="${gdsVO.usePsbltyTrm > 0}"> / <strong>${gdsVO.usePsbltyTrm}</strong>년</c:if>
									</dd>
								</dl>
								<dl class="price2">
									<dt>본인부담금</dt>
									<dd>
										<em>${_mbrSession.prtcrRecipterInfo.selfBndRt }%</em>
										<c:choose>
											<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 15 }">
												<strong><fmt:formatNumber value="${gdsVO.bnefPc15}" pattern="###,###" /></strong>
											</c:when>
											<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 9 }">
												<strong><fmt:formatNumber value="${gdsVO.bnefPc9}" pattern="###,###" /></strong>
											</c:when>
											<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 6 }">
												<strong><fmt:formatNumber value="${gdsVO.bnefPc6}" pattern="###,###" /></strong>
											</c:when>
											<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 0 }">
												<strong>0</strong>
											</c:when>
										</c:choose>
										원
										<button type="button" class="text-question mycost-trigger font-normal text-primary" data-bs-toggle="popover" data-bs-html="true" data-bs-placement="bottom" data-bs-content="- 수급자는 연 한도액 160만원 범위 안에서 제공받음<br>- 복지용구 구매시 공단부담금 + 본인부담금<br>- 연 한도액 초과 시 전액 본인부담<br><br>차상위 감경(9% 본인부담) : 보험료 순위 25% 초과 50%<br>차상위 감경(6% 본인부담) : 보험료 순위 25% 이하<br>기초생활수급자(본인부담금 없이 무료)<a href='#' class='close'>닫기</a>" data-bs-title="본인부담금이란?">본인부담금이란?</button>
									</dd>
								</dl>
							</c:when>
							<c:otherwise>
								<dl class="price2">
									<dt>판매가</dt>
									<dd>
										<strong><fmt:formatNumber value="${gdsVO.pc}" pattern="###,###" /></strong> 원
									</dd>
								</dl>
							</c:otherwise>
						</c:choose>

						<dl class="border-top border-bottom">
							<dt>상품코드</dt>
							<dd class="text-lg">${gdsVO.gdsCd}</dd>
						</dl>
						<c:if test="${!empty gdsVO.bnefCd}">
							<dl>
								<dt>급여코드</dt>
								<dd class="text-lg">${gdsVO.bnefCd}</dd>
								<input type="hidden" id="bnefCd" name="bnefCd" value="${gdsVO.bnefCd}" />
							</dl>
						</c:if>

						<c:if test="${!empty gdsVO.mtrqlt}">
							<dl>
								<dt>재질</dt>
								<dd>${gdsVO.mtrqlt}</dd>
							</dl>
						</c:if>
						<c:if test="${!empty gdsVO.wt}">
							<dl>
								<dt>중량</dt>
								<dd>${gdsVO.wt}</dd>
							</dl>
						</c:if>
						<c:if test="${!empty gdsVO.size}">
							<dl>
								<dt>사이즈</dt>
								<dd>${gdsVO.size}</dd>
							</dl>
						</c:if>
						<c:if test="${!empty gdsVO.stndrd}">
							<dl>
								<dt>규격</dt>
								<dd>${gdsVO.stndrd}</dd>
							</dl>
						</c:if>
						<dl>
							<dt>배송 유형</dt>
							<dd>
								${dlvyCostTyCode[gdsVO.dlvyCtTy]}배송
								<c:if test="${gdsVO.dlvyCtTy eq 'PAY'}">
	                               	&nbsp;(${dlvyPayTyCode[gdsVO.dlvyCtStlm]})
	                               	</c:if>
							</dd>
						</dl>
						<c:if test="${gdsVO.dlvyCtTy eq 'PAY'}">
							<dl>
								<dt>배송비</dt>
								<dd>
									<fmt:formatNumber value="${gdsVO.dlvyBassAmt}" pattern="###,###" />
								</dd>
							</dl>
						</c:if>
						<%-- 추가 배송비 -> 도서산간비용, 노출x
						<c:if test="${gdsVO.dlvyAditAmt > 0}">
							<dl>
								<dt>추가 배송비</dt>
								<dd>
									<fmt:formatNumber value="${gdsVO.dlvyAditAmt}" pattern="###,###" />
								</dd>
							</dl>
						</c:if> --%>
					</div>
					<!-- //상품 재원 -->

					<!-- 상품 결제 -->
					<div class="product-payment">
						<!-- 상품 결제 토글 모바일 -->
						<button type="button" class="payment-toggle"></button>
						<!-- //상품 결제 토글 모바일 -->

						<%--from start--%>
						<form id="frmOrdr" name="frmOrdr" method="post" enctype="multipart/form-data">
							<!-- 구매 조건 선택 -->
							<c:choose>
								<c:when test="${gdsVO.gdsTy eq 'R' && _mbrSession.prtcrRecipterYn eq 'Y' }">
									<%-- 급여 & 수급자--%>
									<div class="payment-type-select">
										<label for="ordrTy1" class="select-item1"> <input type="radio" name="ordrTy" value="R" id="ordrTy1" checked="checked"> <%--R or L--%> <span>급여 구매</span>
										</label> <label for="ordrTy2" class="select-item2"> <input type="radio" name="ordrTy" value="N" id="ordrTy2"> <span>바로 구매</span>
										</label>
									</div>
								</c:when>
								<c:when test="${gdsVO.gdsTy eq 'L' && _mbrSession.prtcrRecipterYn eq 'Y' }">
									<%-- 대여 & 수급자--%>
									<div class="payment-type-select">
										<label for="ordrTy1" class="select-item1"> <input type="radio" name="ordrTy" value="L" id="ordrTy1" checked="checked"> <span>급여 구매</span>
										</label>
									</div>
								</c:when>
								<c:otherwise>
									<%-- 비급여 > 판매가 구매 --%>
									<input type="hidden" name="ordrTy" value="N">
								</c:otherwise>
							</c:choose>
							<!-- //구매 조건 선택 -->

							<div class="payment-type-content1 is-active">
								<%--고정--%>

								<div class="payment-scroller">
									<c:if test="${(gdsVO.gdsTy eq 'R' || gdsVO.gdsTy eq 'L') && _mbrSession.prtcrRecipterYn eq 'Y' }">
										<div class="space-y-1 payment-guide">
											<p class="text-alert">
												급여제품은 멤버스 <strong>승인완료 후 결제</strong>가 진행됩니다.
											</p>
											<p class="text-question underline">
												<a href="#modal-steps" data-bs-toggle="modal" data-bs-target="#modal-steps">급여제품 구매절차 안내</a>
											</p>
										</div>
									</c:if>

									<!-- 상품 옵션 -->
									<div class="payment-option">
										<!-- <p class="option-title">필수옵션</p> -->

										<c:set var="optnTtl" value="${fn:split(gdsVO.optnTtl, '|')}" />
										<c:set var="optnVal" value="${fn:split(gdsVO.optnVal, '|')}" />

										<c:if test="${!empty optnTtl[0]}">
											<div class="product-option" id="optnVal1">
												<button type="button" class="option-toggle" disabled="true">
													<small>필수</small> <strong>${optnTtl[0]} 선택</strong>
												</button>
												<ul class="option-items">
												</ul>
											</div>
										</c:if>
										<c:if test="${!empty optnTtl[1]}">
											<div class="product-option" id="optnVal2">
												<button type="button" class="option-toggle" disabled="true">
													<small>필수</small> <strong>${optnTtl[1]} 선택</strong>
												</button>
												<ul class="option-items">
												</ul>
											</div>
										</c:if>
										<c:if test="${!empty optnTtl[2]}">
											<div class="product-option" id="optnVal3">
												<button type="button" class="option-toggle" disabled="true">
													<small>필수</small> <strong>${optnTtl[2]} 선택</strong>
												</button>
												<ul class="option-items">
												</ul>
											</div>
										</c:if>

										<c:if test="${!empty gdsVO.aditOptnTtl}">
											<c:set var="aditOptnTtl" value="${fn:split(gdsVO.aditOptnTtl, '|')}" />
											<!-- <p class="option-title">추가옵션</p> -->
											<c:forEach var="aditOptn" items="${aditOptnTtl}" varStatus="status">
												<div class="product-option" id="aditOptnVal${status.index }">
													<button type="button" class="option-toggle">
														<small>추가</small> <strong>추가 ${aditOptn} 선택</strong>
													</button>
													<ul class="option-items">
														<c:forEach var="aditOptnList" items="${gdsVO.aditOptnList}" varStatus="status">
															<c:set var="spAditOptnTtl" value="${fn:split(aditOptnList.optnNm, '*')}" />
															<c:if test="${fn:trim(aditOptn) eq fn:trim(spAditOptnTtl[0])}">
																<li><a href="#" data-optn-ty="ADIT" ' data-opt-val="${aditOptnList.optnNm}|${aditOptnList.optnPc}|${aditOptnList.optnStockQy}|ADIT">${spAditOptnTtl[1]}</a></li>
															</c:if>
														</c:forEach>
													</ul>
												</div>
											</c:forEach>
										</c:if>

									</div>
									<!-- //상품 옵션 -->

									<!-- 구매 금액 -->

									<div class="payment-price">
										<p class="text-price">
											총 구매 금액 <strong id="totalPrice">0</strong> <span>원</span>
										</p>
									</div>

									<!-- //구매 금액 -->

								</div>

								<!-- 구매 버튼 -->
								<div class="payment-button">
									<button type="button" class="btn btn-danger btn-large">구매신청</button>
									<button type="button" class="btn btn-outline-primary btn-large">장바구니</button>
									<button type="button" class="btn btn-love btn-large">상품찜하기</button>
								</div>
								<!-- //구매 버튼 -->

							</div>

						</form>
						<%--//from--%>
					</div>
					<!-- //상품 결제 -->
				</div>
				<!-- //상품 정보 -->
			</div>
		</div>
	</main>

	<script src="/html/core/vendor/twelements/index.min.js"></script>
	<script src="/html/core/vendor/twelements/popper.min.js"></script>
</body>

<script>
var Goods = (function(){

	var gdsPc = ${gdsVO.pc};
	var ordrTy = $("input[name='ordrTy']:checked").val() === undefined?"N":$("input[name='ordrTy']:checked").val(); //R / L / N

	if(ordrTy === "R" || ordrTy === "L"){
		<c:choose>
			<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 15 }">
			gdsPc = ${gdsVO.bnefPc15};
			</c:when>
			<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 9 }">
			gdsPc = ${gdsVO.bnefPc9};
			</c:when>
			<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 6 }">
			gdsPc = ${gdsVO.bnefPc6};
			</c:when>
			<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 0 }">
			gdsPc = 0;
			</c:when>
		</c:choose>
	}

	function f_optnVal1(optnVal, optnTy){
		$('.product-option').removeClass('is-active');
		$("#optnVal1 ul.option-items li").remove();

		$.ajax({
			type : "post",
			url  : "${_marketPath}/gds/optn/getOptnInfo.json",
			data : {
				gdsNo:'${gdsVO.gdsNo}'
				, optnTy:optnTy
				, optnVal:optnVal
			},
			dataType : 'json'
		})
		.done(function(json) {
			if(json.result){
				$("#optnVal1 button").prop("disabled", false);
				var oldOptnNm = "";
				$.each(json.optnList, function(index, data){
					var optnNm = data.optnNm.split("*");
					if(oldOptnNm != optnNm[0]){
						if(optnNm.length < 2){
							var optnPc = "";
							var optnSoldout = "";
							if(data.optnPc > 0){ optnPc = " + " + data.optnPc +"원"; }
							if(data.optnStockQy < 1){ optnSoldout = " [품절]"; }
							$("#optnVal1 ul.option-items").append("<li><a href='#' data-optn-ty='BASE' data-opt-val='"+ data.optnNm +"|"+ data.optnPc +"|"+ data.optnStockQy +"|BASE'>"+ optnNm[0] + optnPc + optnSoldout +"</a></li>");
						}else{
							$("#optnVal1 ul.option-items").append("<li><a href='#' data-optn-ty='BASE' data-opt-val='"+ data.optnNm +"'>"+ optnNm[0] +"</li>");
						}
						oldOptnNm = optnNm[0];
					}
				});
			}else{
				$("#optnVal1 button").prop("disabled", true);
			}

		})
		.fail(function(data, status, err) {
			console.log('error forward : ' + data);
		});
	}

	function f_optnVal2(optnVal1, optnTy){ // 추후 사용자에서도 사용할 예정
		$('.product-option').removeClass('is-active');
		$("#optnVal2 ul.option-items li").remove();
		$("#optnVal3 ul.option-items li").remove();
		if(optnVal1!=""){
			$.ajax({
				type : "post",
				url  : "${_marketPath}/gds/optn/getOptnInfo.json",
				data : {
					gdsNo:'${gdsVO.gdsNo}'
					, optnTy:optnTy
					, optnVal:optnVal1
				},
				dataType : 'json'
			})
			.done(function(json) {
				if(json.result){
					$("#optnVal2 button").prop("disabled", false);
					var oldOptnNm = "";
					$.each(json.optnList, function(index, data){
						var optnNm = data.optnNm.split("*");
						if(oldOptnNm != optnNm[1]){
	    					if(optnNm.length < 3){
	    						var optnPc = "";
	    						var optnSoldout = "";
	    						if(data.optnPc > 0){ optnPc = " + " + comma(data.optnPc) +"원"; }
	    						if(data.optnStockQy < 1){ optnSoldout = " [품절]"; }
	    						$("#optnVal2 ul.option-items").append("<li><a href='#' data-optn-ty='BASE' data-opt-val='"+ data.optnNm +"|"+ data.optnPc +"|"+ data.optnStockQy +"|BASE'>"+ optnNm[1] + optnPc + optnSoldout +"</a></li>");
	    					}else{
	    						$("#optnVal2 ul.option-items").append("<li><a href='#' data-optn-ty='BASE' data-opt-val='"+ data.optnNm +"'>"+ optnNm[1] +"</li>");
	    					}
	    					oldOptnNm = optnNm[1];
						}
	                });
					$('.product-option .option-toggle')[1].click();
				}else{
					$("#optnVal2").prop("disabled", true);
				}

			})
			.fail(function(data, status, err) {
				console.log('error forward : ' + data);
			});
		}else{
			$("#optnVal2").prop("disabled", true);

			// 3번 옵션도
			$("#optnVal3").prop("disabled", true);
		}
	}

	function f_optnVal3(optnVal2, optnTy){ // 추후 사용자에서도 사용할 예정
		$('.product-option').removeClass('is-active');
		$("#optnVal3 ul.option-items li").remove();
		if(optnVal2!=""){
			$.ajax({
				type : "post",
				url  : "${_marketPath}/gds/optn/getOptnInfo.json",
				data : {
					gdsNo:'${gdsVO.gdsNo}'
					, optnTy:optnTy
					, optnVal:optnVal2
				},
				dataType : 'json'
			})
			.done(function(json) {
				if(json.result){
					$("#optnVal3 button").prop("disabled", false);
					var oldOptnNm = "";
					$.each(json.optnList, function(index, data){
						var optnNm = data.optnNm.split("*");
						var optnPc = "";
						var optnSoldout = "";
						if(data.optnPc > 0){ optnPc = " + " + data.optnPc +"원"; }
						if(data.optnStockQy < 1){ optnSoldout = " [품절]"; }
						$("#optnVal3 ul.option-items").append("<li><a href='#' data-optn-ty='BASE' data-opt-val='"+ data.optnNm +"|"+ data.optnPc +"|"+ data.optnStockQy +"|BASE'>"+ optnNm[2] + optnPc + optnSoldout +"</a></li>");
	                });
					//$('.product-option .option-toggle')[1].click();
					$('.product-option .option-toggle')[2].click();
				}else{
					$("#optnVal3").prop("disabled", true);
				}

			})
			.fail(function(data, status, err) {
				console.log('error forward : ' + data);
			});
		}else{
			$("#optnVal2").prop("disabled", true);
		}
	}

	function f_baseOptnChg(optnVal){
		var spOptnVal = optnVal.split("|");
		var spOptnTxt = spOptnVal[0].split("*");
		var skip = false;

		console.log("gdsPc", gdsPc);
		console.log("optnVal", optnVal); // R * 10 * DEF|1000|0|BASE

		$(".product-quanitem input[name='ordrOptn']").each(function(){
			if($(this).val() == spOptnVal[0].trim()){
				alert("["+spOptnVal[0] + "]은(는) 이미 추가된 옵션상품입니다.");
				skip = true;
			}

		});
		//console.log("재고:", spOptnVal[2]);
		if(spOptnVal[2] < 1){
			alert("선택하신 옵션은 품절상태입니다.");
			skip = true;
		}

		if(!skip){
			var html = '';
				html += '<div class="product-quanitem">';
				html += '	<input type="hidden" name="gdsNo" value="${gdsVO.gdsNo}">';
				html += '	<input type="hidden" name="gdsCd" value="${gdsVO.gdsCd}">';
				html += '	<input type="hidden" name="bnefCd" value="${gdsVO.bnefCd}">';
				html += '	<input type="hidden" name="gdsNm" value="${gdsVO.gdsNm}">';
				html += '	<input type="hidden" name="gdsPc" value="'+ gdsPc +'">';
				html += '	<input type="hidden" name="ordrOptnTy" value="'+ spOptnVal[3] +'">';
				html += '	<input type="hidden" name="ordrOptn" value="'+ spOptnVal[0] +'">';
				html += '	<input type="hidden" name="ordrOptnPc" value="'+ spOptnVal[1] +'">';
				html += '	<input type="hidden" name="ordrQy" value="1" data-stock-qy="'+ spOptnVal[2] +'">';

				html += '<dl class="infomation">';
				html += '<dt>${gdsVO.gdsNm}</dt>';
				html += '<dd>';
				html += '	<div class="option">';
				html += '		<div>';
				for(var i=0; i<spOptnTxt.length;i++){
					if(i == spOptnTxt.length-1 ){
						html += '       	<span>'+ spOptnTxt[i].trim() +'</span>';
					}else{
						html += '       	<span class="title">'+ spOptnTxt[i].trim() +'</span>';
					}
				}
				html += '   	</div>';
				html += '	</div>';
				html += '	<div class="quantity">';
				html += '    	<button type="button" class="btn btn-minus">수량삭제</button>';
				html += '   	<strong>1</strong>';
				html += '   	<button type="button" class="btn btn-plus">수량추가</button>';
				html += '    	<button type="button" class="btn btn-delete">상품삭제</button>';
				html += '	</div>';
				html += '	<p class="price"><strong> '+ comma(Number(gdsPc) + Number(spOptnVal[1])) +'</strong> 원</p>';
				html += '</dd>';
				html += '</dl>';
				html += '</div>';
			$(".payment-option").append(html);
		}

		$('.product-option').removeClass('is-active');

		f_totalPrice();
	}

	//추가옵션
	function f_aditOptnChg(optnVal){
		var spOptnVal = optnVal.split("|");
		var spOptnTxt = spOptnVal[0].split("*"); // AA * BB
		var skip = false;

		$(".product-quanitem input[name='ordrOptn']").each(function(){
			if($(this).val() == spOptnVal[0].trim()){
				alert("["+spOptnVal[0] + "]은(는) 이미 추가된 옵션상품입니다.");
				skip = true;
			}
		});
		if(spOptnVal[2] < 1){
			alert("선택하신 옵션은 품절상태입니다.");
			skip = true;
		}

		if(!skip){
			var html = '';
				html += '<div class="product-quanitem">';
				html += '	<input type="hidden" name="gdsNo" value="${gdsVO.gdsNo}">';
				html += '	<input type="hidden" name="gdsCd" value="${gdsVO.gdsCd}">';
				html += '	<input type="hidden" name="bnefCd" value="${gdsVO.bnefCd}">';
				html += '	<input type="hidden" name="gdsNm" value="${gdsVO.gdsNm}">';
				html += '	<input type="hidden" name="gdsPc" value="0">';
				html += '	<input type="hidden" name="ordrOptnTy" value="'+ spOptnVal[3] +'">';
				html += '	<input type="hidden" name="ordrOptn" value="'+ spOptnVal[0] +'">';
				html += '	<input type="hidden" name="ordrOptnPc" value="'+ spOptnVal[1] +'">';
				html += '	<input type="hidden" name="ordrQy" value="1" data-stock-qy="'+ spOptnVal[2] +'">';

				html += '<dl class="infomation">';
				html += '<dt><span class="label-outline-primary"><span>'+ spOptnTxt[0] +'</span><i><img src="/html/page/market/assets/images/ico-plus-white.svg" alt=""></i></span></dt>';
				html += '<dd>';
				html += '	<div class="option">';
				html += '		<div>';
				html += '       	<span>'+ spOptnTxt[1].trim() +'</span>';
				html += '   	</div>';
				html += '	</div>';
				html += '	<div class="quantity">';
				html += '    	<button type="button" class="btn btn-minus">수량삭제</button>';
				html += '   	<strong>1</strong>';
				html += '   	<button type="button" class="btn btn-plus">수량추가</button>';
				html += '    	<button type="button" class="btn btn-delete">상품삭제</button>';
				html += '	</div>';
				html += '	<p class="price"><strong> '+ comma(Number(spOptnVal[1])) +'</strong> 원</p>';
				html += '</dd>';
				html += '</dl>';
				html += '</div>';
			$(".payment-option").append(html);
		}

		$('.product-option').removeClass('is-active');

		f_totalPrice();
	}


	function f_totalPrice(){
		var totalPrice = 0;
		var gdsPc = 0;
		var gdsOptnPc = 0;
		var ordrQy = 1;
		$(".product-quanitem").each(function(){
			gdsPc = $(this).find("input[name='gdsPc']").val();
			gdsOptnPc = $(this).find("input[name='ordrOptnPc']").val();
			ordrQy = $(this).find("input[name='ordrQy']").val();

			totalPrice = Number(totalPrice) + (Number(gdsPc) + Number(gdsOptnPc)) * Number(ordrQy);
		});
		//console.log("###### totalPrice", comma(totalPrice));
		$("#totalPrice").text(comma(totalPrice));
	}


	$(function(){

		$(".option-toggle").on("click", function(){
			$(this).closest('.product-option').toggleClass('is-active');
			$('.product-option').not($(this).closest('.product-option')).removeClass('is-active');
		});

		$(document).on("click", ".btn-plus", function(e){
			var pObj = $(this).parents(".product-quanitem");
			var qyObj = pObj.find("input[name='ordrQy']");
			var stockQy = qyObj.data("stockQy");

			// 주문수량
			if(Number(qyObj.val()) < stockQy){
				qyObj.val(Number(qyObj.val()) + 1);
				if("${_mbrSession.recipterYn}" == "Y" && Number(qyObj.val()) > 15 && $("#ordrTy1").is(":checked")){
					alert("급여 상품의 최대수량은 15개 입니다.");
					qyObj.val(Number(qyObj.val()) - 1);
				}
				pObj.find(".quantity strong").text(qyObj.val());
			} else {
				alert("현재 상품의 재고수량은 총 ["+ stockQy +"] 입니다.");
				alert("해당 제품은 총 "+ stockQy +" 개 까지 구매 가능합니다.");
			}

			f_totalPrice();

		});

		$(document).on("click", ".btn-minus", function(e){
			var pObj = $(this).parents(".product-quanitem");
			var qyObj = pObj.find("input[name='ordrQy']");
			var stockQy = qyObj.data("stockQy");

			// 주문수량
			if(Number(qyObj.val()) > 1){
				qyObj.val(Number(qyObj.val()) - 1);
				pObj.find(".quantity strong").text(qyObj.val());
			} else {
				// nothing
			}
			f_totalPrice();
		});

		$(document).on("click", ".btn-delete", function(e){
			var pObj = $(this).parents(".product-quanitem");
			pObj.remove();
			f_totalPrice();
		});

	    <c:if test="${empty optnTtl[0]}">
	    // 옵션이 없는 경우 //|0|10
	    if(${gdsVO.stockQy} > 0){
		    f_baseOptnChg("|0|${gdsVO.stockQy}|BASE"); //R * 10 * DEF|1000|0|BASE
	    }
	    $(".btn-delete").remove();
	    </c:if>

	    <c:if test="${!empty optnTtl[0]}">
		// 기본 옵션 1번
		f_optnVal1('', 'BASE');
		<c:if test="${empty optnTtl[1]}">
		$(document).on("click", "#optnVal1 ul.option-items li a", function(e){
			e.preventDefault();
			const optnVal1 = $(this).data("optVal");
			//console.log(optnVal1);
			if(optnVal1 != ""){
				f_baseOptnChg(optnVal1);
			}
		});
		</c:if>
		</c:if>

		<c:if test="${!empty optnTtl[1]}">
		// 기본 옵션 2번
		$(document).on("click", "#optnVal1 ul.option-items li a", function(e){
			e.preventDefault();
			const optnVal1 = $(this).data("optVal").split("*");
			const optnTy = $(this).data("optnTy");

			//console.log("optnVal1 :", optnVal1, optnTy);

			f_optnVal2(optnVal1[0].trim(), optnTy);
		});

		<c:if test="${empty optnTtl[2]}">
		$(document).on("click", "#optnVal2 ul.option-items li a", function(e){
			e.preventDefault();

			const optnVal2 = $(this).data("optVal");//.split("*");
			const optnTy = $(this).data("optnTy");

			//console.log("optnVal2 :", optnVal2, optnTy);

			if(optnVal2 != ""){
				f_baseOptnChg(optnVal2);
			}



		});
		</c:if>

		</c:if>

		<c:if test="${!empty optnTtl[2]}">
		// 기본 옵션 3번
		$(document).on("click", "#optnVal2 ul.option-items li a", function(e){
			e.preventDefault();
			const optnVal2 = $(this).data("optVal").split("*");
			const optnTy = $(this).data("optnTy");
			//console.log("optnVal2 :", optnVal2, optnTy);
			f_optnVal3(optnVal2[0].trim() +" * " +optnVal2[1].trim(), optnTy);

		});


		$(document).on("click", "#optnVal3 ul.option-items li a", function(e){
			e.preventDefault();
			const optnVal3 = $(this).data("optVal");//.split("*");
			const optnTy = $(this).data("optnTy");
			//console.log("optnVal3 :", optnVal3, optnTy);
			if(optnVal3 != ""){
				f_baseOptnChg(optnVal3);
			}
		});
		</c:if>


		<%--추가옵션--%>
		$(document).on("click", "[id^=aditOptnVal] ul.option-items li a", function(e){
			e.preventDefault();
			const optnVal = $(this).data("optVal");
			//기본상품이 있는지 먼저 체크해야함
			if($(".product-quanitem input[name='ordrOptnTy'][value='BASE']").length > 0 && optnVal != ""){
				f_aditOptnChg(optnVal);
			}else{
				alert("기본 옵션을 먼저 선택해야 합니다.");
				$('.product-option').removeClass('is-active');
			}
		});

		// 고시정보
		let infoJson = eval('(${!empty gdsVO.ancmntInfo?gdsVO.ancmntInfo:'{}'})');
		var html = '<tr class="top-border"><td></td><td></td></tr>';
		$.each(item['${gdsVO.ancmntTy}'].article, function(key, value){
	    	html += '<tr>';
			html += '	<th scope="row"><p>'+ value[0] +'</p></th>';
			html += '	<td>';
			if(value[1] != ''){
				html += '	<p class="py-1">'+ value[1] +'</p>';
	        }
			html += '	'+ (infoJson[key]==undefined?'상세설명페이지 참고':infoJson[key]);
			html += '	</td>';
			html += '</tr>';
		});
	    html += '<tr class="bot-border"><td></td><td></td></tr>';
	    $("#ancmntTable tbody").append(html);

	});

})();
</script>
</html>