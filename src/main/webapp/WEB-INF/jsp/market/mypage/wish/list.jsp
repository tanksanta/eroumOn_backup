<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main id="container" class="is-mypage">
		<jsp:include page="../../layout/page_header.jsp">
			<jsp:param value="관심상품" name="pageTitle"/>
		</jsp:include>

		<div id="page-container">

			<jsp:include page="../../layout/page_sidenav.jsp" />

            <div id="page-content">
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

                <div class="items-center justify-between mb-6.5 md:flex lg:mb-8">
                    <div class="space-y-1.5 md:mr-3">
                        <p class="text-alert">고객님께서 관심 상품으로 등록한 상품 목록입니다.</p>
                        <p class="text-alert">관심 상품 담기는 로그인 후 사용 가능합니다.</p>
                        <p class="text-alert">관심 상품은 개수/보관 기간 제한이 없습니다</p>
                    </div>
                </div>

                <div class="mb-9 space-y-6 lg:mb-12 md:space-y-7.5">

                	<c:forEach items="${listVO.listObject}" var="wish" varStatus="status">
                    <div class="order-product order-wishlist">
                        <div class="form-check order-check">
                            <input class="form-check-input" type="checkbox" name="wishlistNo" value="${wish.wishlistNo}">
                        </div>
                        <button type="button" class="order-close f_deleteSel" data-wish-no="${wish.wishlistNo}">삭제</button>
                        <div class="order-body">
                            <div class="order-item">
                                <div class="order-item-thumb">
	                                <c:choose>
										<c:when test="${!empty wish.gdsInfo.thumbnailFile }">
									<img src="/comm/getImage?srvcId=GDS&amp;upNo=${wish.gdsInfo.thumbnailFile.upNo }&amp;fileTy=${wish.gdsInfo.thumbnailFile.fileTy }&amp;fileNo=${wish.gdsInfo.thumbnailFile.fileNo }&amp;thumbYn=Y" alt="">
										</c:when>
										<c:otherwise>
									<img src="/html/page/market/assets/images/noimg.jpg" alt="">
										</c:otherwise>
									</c:choose>
                                </div>
                                <div class="order-item-content">
                                    <div class="order-item-group">
                                        <div class="order-item-base">
                                            <div class="date">
                                                <small>등록일</small>
												<strong><fmt:formatDate value="${wish.regDt}" pattern="yyyy-MM-dd" /></strong>
                                            </div>
			                                <div class="name">
			                                	<c:if test="${wish.gdsInfo.useYn eq 'Y'}">
			                                	<a href="${_marketPath}/gds/${wish.gdsInfo.ctgryNo}/${wish.gdsInfo.gdsCd}">
				                                    <u>${wish.gdsInfo.gdsCd}</u>
				                                    <strong>${wish.gdsInfo.gdsNm}</strong>
			                                    </a>
			                                    </c:if>
			                                    <c:if test="${wish.gdsInfo.useYn eq 'N'}">
			                                    <a href="#" onclick="alert('판매중지 상품입니다.'); return false;">
				                                    <u>${wish.gdsInfo.gdsCd}</u>
				                                    <strong>${wish.gdsInfo.gdsNm}</strong>
			                                    </a>
			                                    </c:if>
			                                </div>
                                            <div class="cost">
												<dl>
												    <dt>배송비</dt>
												    <dd><strong><fmt:formatNumber value="${wish.gdsInfo.dlvyBassAmt}" pattern="###,###" /></strong>원</dd>
												</dl>
												<dl>
												    <dt>판매가</dt>
												    <dd><strong><fmt:formatNumber value="${wish.gdsInfo.pc}" pattern="###,###" /></strong>원</dd>
												</dl>
                                            </div>
                                        </div>
									</div>
								</div>
                        	</div>
						</div>
                        <c:if test="${wish.gdsInfo.stockQy < 1}">
                        <div class="order-disable"><p>일시품절<br> 상품입니다</p></div>
                        </c:if>
                        <c:if test="${wish.gdsInfo.useYn eq 'N'}">
                        <div class="order-disable"><p>판매중지<br> 상품입니다</p></div>
                        </c:if>
                    </div>
                    </c:forEach>

                    <c:if test="${empty listVO.listObject}">
                    <div class="box-result is-large">위시리스트에 담긴 상품이 없습니다</div>
                    </c:if>

                </div>

                <div class="flex justify-center my-9 space-x-1 lg:my-12 md:space-x-1.5">
                    <button class="btn btn-primary md:px-8.5 f_checkAll">전체선택</button>
                    <button class="btn btn-outline-primary md:px-8.5 f_delete" data-sel-ty="ALL">전체삭제</button>
                    <button class="btn btn-outline-primary md:px-8.5 f_delete" data-sel-ty="SEL">선택상품 삭제</button>
                </div>

				<div class="pagination">
					<front:paging listVO="${listVO}" />
				</div>
            </div>
        </div>

    </main>



    <script>
   	$(function(){
   	//전체선택
		$(".f_checkAll").on("click", function(){
			if(!$(":checkbox[name=wishlistNo]").is(":checked")){
				$(":checkbox[name=wishlistNo]").prop("checked",true).closest(".order-wishlist").addClass("is-active");
			}else{
				$(":checkbox[name=wishlistNo]").prop("checked",false).closest(".order-wishlist").removeClass("is-active");
			}
		})

   		//체크박스
		$(":checkbox[name=wishlistNo]").on("click", function(){
			let isChecked = $(this).is(":checked");

			$(this).prop("checked",isChecked);

			if(isChecked){
				$(this).closest(".order-wishlist").addClass("is-active");
			}else{
				$(this).closest(".order-wishlist").removeClass("is-active");
			}
		});

		// 단일 삭제 버튼
   		$(".f_deleteSel").on("click", function(){
   			let wishlistNos = [$(this).data("wishNo")];
   			let confirmMsg = "선택한 상품을 삭제 하시겠습니까?";
   			if(confirm(confirmMsg)) {
				$.ajax({
					type : "post",
					url  : "./removeWish.json",
					data : {wishlistNos:wishlistNos, selTy:"SEL"},
					dataType : 'json'
				})
				.done(function(data) {
					if(data.result){
						location.reload();
					}else{
						alert("삭제에 실패하였습니다.");
					}
				})
				.fail(function(data, status, err) {
					alert("삭제 과정에 오류가 발생했습니다.");
					console.log('error forward : ' + data);
				});
			}
   		});


   		// 선택/전체 삭제 버튼
   		$(".f_delete").on("click", function(){
   			let wishlistNos;
			let selTy = $(this).data("selTy"); // 전체/선택
			let confirmMsg = "선택한 상품을 삭제 하시겠습니까?";

			if(selTy == "ALL"){
				wishlistNos = $(":checkbox[name=wishlistNo]").map(function(){return $(this).val();}).get();
				confirmMsg = "전체 상품을 삭제 하시겠습니까?"
			}else{
				wishlistNos = $(":checkbox[name=wishlistNo]:checked").map(function(){return $(this).val();}).get();

			}


			if(wishlistNos==null||wishlistNos.length==0) {
				alert("삭제하실 상품을 먼저 선택해주세요.");
			} else if(confirm(confirmMsg)) {
				$.ajax({
					type : "post",
					url  : "./removeWish.json",
					data : {wishlistNos:wishlistNos, selTy:selTy},
					dataType : 'json'
				})
				.done(function(data) {
					if(data.result){
						if(selTy == "ALL"){
							alert("전체 삭제되었습니다.");
						} else {
							alert("삭제되었습니다.");
						}
						location.reload();
					}else{
						alert("삭제에 실패하였습니다.");
					}
				})
				.fail(function(data, status, err) {
					alert("삭제 과정에 오류가 발생했습니다.");
					console.log('error forward : ' + data);
				});

			}

   		});

   	});
    </script>