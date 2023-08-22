<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container" class="is-mypage">
		<jsp:include page="../../layout/page_header.jsp">
			<jsp:param value="대여조회 상세" name="pageTitle"/>
		</jsp:include>

	<div id="page-container">

		<jsp:include page="../../layout/page_sidenav.jsp" />

		<div id="page-content">
			<jsp:include page="../../layout/mobile_userinfo.jsp" />

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