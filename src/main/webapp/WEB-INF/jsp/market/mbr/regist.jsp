<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<main id="container">
		<jsp:include page="../layout/page_header.jsp">
			<jsp:param value="회원가입" name="pageTitle"/>
		</jsp:include>

		<div id="page-container">
			<div id="page-content">
				<div class="member-join-guide">
					<div class="container">
						<div class="card"></div>
						<div class="text">
							<small>이로움만의</small> 특별함을<br> 누리세요
						</div>
					</div>
					<a href="./registStep1" class="btn btn-primary">회원 가입하기</a>
				</div>
			</div>
		</div>
	</main>