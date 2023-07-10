<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:if test="${fn:indexOf(_curPath,'/main/inqry/list') > -1}">
	<header id="subject">
		<nav class="breadcrumb">
			<ul>
				<li class="home">
				<a href="${_mainPath}">홈</a></li>
				<li>제휴 / 입점문의</li>
			</ul>
		</nav>
		<h2 class="subject">제휴 / 입점문의</h2>
	</header>
</c:if>