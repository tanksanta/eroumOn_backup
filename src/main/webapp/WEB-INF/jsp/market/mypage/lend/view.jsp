<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container" class="is-mypage">
		<jsp:include page="../../layout/page_header.jsp">
			<jsp:param value="대여조회 상세" name="pageTitle"/>
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
            
			<div class="order-status">
				<div class="status-base">
					<dl class="number">
						<dt>주문 번호</dt>
						<dd>${ordrVO.ordrCd}</dd>
					</dl>
					<dl>
						<dt>주문 일시</dt>
						<dd><fmt:formatDate value="${ordrVO.ordrDt}" pattern="yyyy.MM.dd HH:mm:ss" /></dd>
					</dl>
				</div>
			</div>

			<h3 class="text-title mt-9 md:mt-13 lg:mt-17">결제내역</h3>
			<div id="rebill-list-wrap">
		        <div class="progress-loading is-static">
		            <div class="icon"><span></span><span></span><span></span></div>
					<p class="text">결제정보를 불러오는 중입니다.</p>
		        </div>
			</div>
		</div>
	</div>
</main>

<Script>
$(function(){
	var curPage = 1;
	var cntPerPage = 10;

	// 목록
	function f_srchList(page){
		var params = {
				curPage:page
				, cntPerPage:cntPerPage
		};

		$("#rebill-list-wrap")
			.load(
				"./${ordrVO.ordrCd}/srchList"
				, params
				, function(obj){
					$("#rebill-list-wrap").fadeIn(200);
			});
	}

	f_srchList(1);

});
</Script>