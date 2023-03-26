<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<h2 id="page-title">쿠폰존</h2>

	<div id="page-container">
		<div id="page-content">
			<c:if test="${_mbrSession.uniqueId eq null}">
				<div class="event-slogan is-coupon">
					<picture class="name">
					<source srcset="/html/page/market/assets/images/txt-event-eroum-mobile.svg" media="(max-width: 768px)">
					<source srcset="/html/page/market/assets/images/txt-event-eroum.svg">
					<img src="/html/page/market/assets/images/txt-event-eroum.svg" alt="" /> </picture>
					<img src="/html/page/market/assets/images/img-shopbag.png" alt="" class="bags">
					<p class="desc">
						아직 회원이 아니신가요?<br> 이로움 회원이 되시고 편한 삶을 누리세요 <a href="${_marketPath}/login" class="join">회원가입</a>
					</p>
				</div>
			</c:if>
			<c:if test="${empty listVO.listObject}">
				</br><div class="box-result is-large">발급된 쿠폰이 없습니다.</div>
			</c:if>


			<div class="couponzone-items">
				<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
					<div class="couponzone-item">
						<c:if test="${resultList.couponTy ne 'NOR' && resultList.couponTy ne 'FREE' }">
							<div class="coupon-item is-event md-max:coupon-item-small lg:coupon-item-large dwld${resultList.couponNo}">
						</c:if>
						<c:if test="${resultList.couponTy eq 'NOR'}">
							<div class="coupon-item is-discount md-max:coupon-item-small lg:coupon-item-large dwld${resultList.couponNo}">
						</c:if>
						<c:if test="${resultList.couponTy eq 'FREE'}">
							<div class="coupon-item is-delivery md-max:coupon-item-small lg:coupon-item-large dwld${resultList.couponNo}">
						</c:if>
							<div class="itembox">
								<div class="info">
									<c:set var="getNow" value="<%=new java.util.Date()%>" />
									<!-- 쿠폰 종류 -->
									<c:if test="${resultList.couponTy eq 'BIRTH' && resultList.dscntTy eq 'PRCS'}"><img src="/html/page/market/assets/images/img-coupon-birthday.svg" alt="생일 / 정율"></c:if>
									<c:if test="${resultList.couponTy eq 'JOIN' && resultList.dscntTy eq 'PRCS'}"><img src="/html/page/market/assets/images/img-coupon-join.svg" alt="회원가입 / 정율"></c:if>
									<c:if test="${resultList.couponTy eq 'FIRST' && resultList.dscntTy eq 'PRCS'}"><img src="/html/page/market/assets/images/img-coupon-first.svg" alt="첫구매 / 정율"></c:if>
									<c:if test="${resultList.couponTy eq 'NOR' && resultList.dscntTy eq 'PRCS' }"><img src="/html/page/market/assets/images/img-coupon-discount.svg" alt="일반 / 정율"></c:if>

									<!-- 할인 구분 -->
									<c:if test="${resultList.dscntTy eq 'PRCS'}">${resultList.dscntAmt} <small>%</small></c:if>
									<c:if test="${resultList.dscntTy eq 'SEMEN'}">${resultList.dscntAmt}<small>원</small></c:if>
								</div>

								<!-- 쿠폰 종류 -->
								<c:if test="${resultList.couponTy eq 'BIRTH'}"><p class="desc">Happy Birthday!</p></c:if>
								<c:if test="${resultList.couponTy eq 'NOR' && resultList.dscntTy eq 'PRCS'}"><p class="desc">Discount coupon</p></c:if>
								<c:if test="${resultList.dscntTy eq 'SEMEN'}"><p class="desc">할인</p></c:if>
								<c:if test="${resultList.couponTy eq 'FREE'}"><p class="desc">FREE Shipping</p></c:if>
							</div>
						</div>
						<div class="coupon-item-name">
							${resultList.couponNm }
								<strong>
								○ 발급 기간 : <fmt:formatDate value="${resultList.issuBgngDt}" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${resultList.issuEndDt}" pattern="yyyy-MM-dd" />
								</strong>
								<c:if test="${resultList.usePdTy eq 'FIX'}">
								<strong>○ 사용 기간 :
									<fmt:formatDate value="${resultList.useBgngYmd}" pattern="yyyy-MM-dd" />
									~
									<fmt:formatDate value="${resultList.useEndYmd}" pattern="yyyy-MM-dd" />
									</strong>
								</c:if>
								<c:if test="${resultList.usePdTy eq 'ADAY' && resultList.usePsbltyDaycnt ne null}">
										<strong>○ 사용 기간 : 발급일로 부터 ${resultList.usePsbltyDaycnt} 일</strong>
								</c:if>

							<small>대상 : <c:if test="${resultList.issuMbr eq 'D'}">
													<c:if test="${resultList.issuMbrTy eq 'G'}">
														일반 회원 <c:if test="${resultList.issuMbrGrad eq 'R' }">(등급 : RED)</c:if>
																	<c:if test="${resultList.issuMbrGrad eq 'S' }">(등급 : SILVER)</c:if>
																	<c:if test="${resultList.issuMbrGrad eq 'G' }">(등급 : GOLD)</c:if>
																	<c:if test="${resultList.issuMbrGrad eq 'V' }">(등급 : VIP)</c:if>
																	<c:if test="${resultList.issuMbrGrad eq 'P' }">(등급 : PLATINUM)</c:if>
													</c:if>
													<c:if test="${resultList.issuMbrTy eq 'R'}">수급자 회원</c:if>
													<c:if test="${resultList.issuMbrTy eq 'G,R'}">전체 회원</c:if>
												</c:if>
												 <!--<c:if test="${resultList.issuGds eq 'I' }">개별 회원</c:if>-->
												 <!-- 다운로드 발급은 개별 회원으로 발급 될 수 없게 설계 2022.12.29 '상품 주문 쿠폰 결제 작업 중' -->
							</small>
						</div>
						<div class="coupon-item-desc">
							<fmt:formatNumber value="${resultList.mummOrdrAmt}" pattern="###,###" />원 이상 </br> 구매시
								<c:if test="${resultList.couponTy ne 'FREE' }">
									<br> 최대 <fmt:formatNumber value="${resultList.mxmmDscntAmt}" pattern="###,###" />원 할인
								</c:if>
								<c:if test="${resultList.couponTy eq 'FREE' }">
									</br> 배송비 무료
								</c:if>
						</div>
						<!--<c:if test="${reultList.trgtCount > 0 }">--> <button type="button" class="btn" disabled>받기 완료</button><!--</c:if>-->
						<!--<c:if test="${resultList.trgtCount eq 0}">--><button type="button" class="btn dwld-btn dwldBtn${resultList.couponNo}" data-coupon-no="${resultList.couponNo}">쿠폰받기</button><!--</c:if>-->
					</div>
				</c:forEach>

			</div>
			<h3 class="text-title mt-10 md:mt-14 lg:mt-19">
				쿠폰 <strong class="text-danger">유의사항</strong>
			</h3>
			<ul class="mt-4 lg:mt-5 space-y-1 md:space-y-1.5">
				<li class="text-alert">쿠폰은 이로움마켓 ID당 1회씩 다운로드 및 사용이 가능합니다.</li>
				<li class="text-alert">발급받으신 쿠폰은 마이페이지 &gt; 쇼핑혜택 &gt; 쿠폰에서 확인 가능합니다.</li>
				<li class="text-alert">쿠폰은 적용가능 상품에 한하여 1회만 적용가능합니다. (동일 품목 2대 구매시 1개 상품만 적용)</li>
				<li class="text-alert">쿠폰은 1주문에 1상품씩 적용 가능합니다.</li>
				<li class="text-alert">특정 공급사 무료 배송비 쿠폰은 해당 공급사의 상품에만 적용되며, 일부상품에서는 제외될 수 있습니다.</li>
				<li class="text-alert">추가 구성상품, 배송비 가격은 쿠폰할인대상 금액에서 제외됩니다.</li>
				<li class="text-alert">카테고리 쿠폰은 타 쿠폰(즉시할인 쿠폰, 이벤트 쿠폰 등)과 중복 사용할 수 없습니다.</li>
				<li class="text-alert">결제 시 쿠폰을 선택하지 않으면 할인혜택을 받을 수 없습니다.</li>
				<li class="text-alert">주문 취소 시 쿠폰 유효기간이 남아있는 경우 동일한 쿠폰이 재발급되며, 일정 시간이 소요될 수 있습니다.<br> (단, 주문 취소 시점이 쿠폰 유효기간이 만료된 이후인 경우 쿠폰은 재발급되지 않습니다)
				</li>
				<li class="text-alert">부정한 방법으로 쿠폰을 사용한 경우, 해당 주문 건은 사전 고지없이 취소됩니다.</li>
				<li class="text-alert">쿠폰 제공은 당사 사정에 따라 사전 고지없이 변경/종료될 수 있습니다.</li>
			</ul>
		</div>
	</div>
</main>

<script>
$(function(){

	//쿠폰 발급 확인
	if("${_mbrSession.loginCheck}" == "true"){
		<c:forEach var="result" items="${cpnList}">
		$(".dwldBtn"+"${result.couponNo}").attr("disabled",true);
		$(".dwldBtn"+"${result.couponNo}").text("받기완료");
		$(".dwld"+"${result.couponNo}").addClass("is-disabled");
	</c:forEach>
	}



	//쿠폰 다운로드
	$(".dwld-btn").on("click",function(){

		var couponNo = $(this).data("couponNo");
    	$.ajax({
			type: 'post',
			url : 'srchCouponTarget.json',
			data: {
				couponNo : $(this).data("couponNo")
			},
			dataType: 'json'
		})
		.done(function(data){
			if(data == 0){
				alert("발급 대상회원이 아닙니다.");
				return false;
			}else if(data == 1){
				if(confirm("로그인이 필요합니다. 로그인 하시겠습니까?")){
					location.href="/market/login?returnUrl=/market/etc/coupon/list";
				}else{
					return false;
				}
			}else if(data == 2){
		    	$.ajax({
					type: 'post',
					url : 'couponDwld.json',
					data: {
						couponNo : couponNo
					},
					dataType: 'json'
				})
				.done(function(data){
					if(data == true){
						alert("쿠폰을 받았습니다.");
						$(".dwldBtn"+couponNo).attr("disabled",true);
						$(".dwldBtn"+couponNo).text("받기완료");
						$(".dwld"+couponNo).addClass("is-disabled");
					}else{
						alert("잔여 수량이 없습니다.");
					}
				})
				.fail(function(){
					alert("쿠폰을 다운로드 하는 중 에러가 발생하였습니다. /n 관리자에게 문의 바랍니다.");
				})
			}else if(data == 3){
				alert("이미 받은 쿠폰입니다.");
				return false;
			}
		})
		.fail(function(){
			alert("쿠폰내역을 조회 하는 중 에러가 발생하였습니다. /n 관리자에게 문의 바랍니다.");
		})
	});

});
</script>