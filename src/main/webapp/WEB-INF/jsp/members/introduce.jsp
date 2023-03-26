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
				당신이 어디에 있든<br> 멤버스가 항상 옆에 있습니다
			</h1>
			<p class="desc">
				전국 <fmt:formatNumber value="${bplcCnt}" pattern="###,###" /> 멤버스가 늘 당신과 함께합니다.<br> 복지용구를 판매하시려면 아래 버튼을 눌러주세요.
			</p>
			<p class="btns">
				<a href="./regist">멤버스 등록 신청</a> <a href="./login">관리자 로그인</a>
			</p>
		</div>
	</div>
	<div class="intro-content">
		<div class="container">
			<dl class="image1">
				<dt>
					수급자와 멤버스<br> 매칭서비스
				</dt>
				<dd>내 주변에 위치한 수급자를 찾아 멤버스와 자동으로 매칭하는 서비스를 제공합니다.</dd>
			</dl>
			<dl class="image2">
				<dt>
					간편한 멤버스<br> 종합관리시스템
				</dt>
				<dd>수급자 관리, 재고관리, 전자문서와 주문내역까지 한번에 관리하는 간편 서비스를 제공합니다.</dd>
			</dl>
			<dl class="image3">
				<dt>
					원터치 전자문서<br> 전자계약까지
				</dt>
				<dd>수많은 양식을 간편하게 전자문서로, 종이 없는 원터치 전자계약 솔루션을 제공합니다.</dd>
			</dl>
			<dl class="image4">
				<dt>
					완벽한 청구검증<br> 솔루션
				</dt>
				<dd>월별 청구관리 및 간평검증 기능과 실시간 수급자별 청구금액 확인 서비스를 제공합니다.</dd>
			</dl>
		</div>
	</div>
</main>