<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<div class="intro-jumbotron">
		<div class="header">
			<h1 class="logo">
				<a href="/<spring:eval expression="@props['Globals.Members.path']"/>/introduce"><img src="/html/page/office/assets/images/ico-partner-logo.svg" alt=""></a>
			</h1>
			<ul class="link">
				<li><a href="./login">멤버스 로그인</a></li>
				<li><a href="./regist">멤버스 등록 신청</a></li>
			</ul>
		</div>
		<div class="container">
			<h1 class="title">
				항상 당신 곁에<br> 이로움 멤버스가 있겠습니다.
			</h1>
			<p class="desc">
				전국 약 1,600개 멤버스가 늘 당신과 함께합니다.<br>
				복지용구 판매 사업소로 등록하시려면 아래 버튼을 눌러주세요.
				<!-- 전국 <fmt:formatNumber value="${bplcCnt}" pattern="###,###" /> 멤버스가 늘 당신과 함께합니다.<br> 복지용구를 판매하시려면 아래 버튼을 눌러주세요. -->
			</p>
			<p class="btns">
				<a href="./regist">멤버스 등록 신청</a> <a href="./login">관리자 로그인</a>
			</p>
		</div>
	</div>
	<div class="intro-content">
		<div class="container">
			<dl class="image1">
				<dt>수급자와 멤버스<br> 매칭서비스</dt>
				<dd>멤버스(사업소) 주변에 위치한 수급자를 찾아 멤버스와 자동으로 매칭하는 서비스를 제공합니다.</dd>
			</dl>
			<dl class="image2">
				<dt>원스톱<br> 종합관리시스템</dt>
				<dd>수급자 계약, 관리부터 재고관리, 자동 바코드 입력, 배송 내역까지 한번에 쉽고 편한 서비스를 제공합니다.</dd>
			</dl>
			<dl class="image3">
				<dt>안정적 판매<br> 경로 제공</dt>
				<dd>제품 홍보 및 마케팅 서비스 제공하여 한정된 고객 영업 증대, 안전한 공급망을 제공합니다.</dd>
			</dl>
			<dl class="image4">
				<dt>국내 유일,<br> 업계 최초 플랫폼 제공</dt>
				<dd>복지용구는 물론 노인장기요양보험에 대한 다양한 마켓과 편의 서비스들을 제공합니다.</dd>
			</dl>
		</div>
	</div>
</main>