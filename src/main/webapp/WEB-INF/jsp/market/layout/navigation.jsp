<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav id="navigation">
	<div class="container">
		<div class="navigation-allmenu">
		<button type="button" class="allmenu-toggle">
			<i></i> <span>전체 카테고리</span>
		</button>
		<div class="allmenu-list">
			<div class="allmenu-group">
				<ul>

					<c:forEach items="${_gnbCtgry.childList}" var="ctgry">
						<%-- 1depth --%>
						<li class="allmenu-item <c:if test="${not empty ctgry.childList}">is-depth</c:if>"><a href="${_marketPath}/gds/${ctgry.ctgryNo}/list">
						<c:set var="imgNumber">
							<c:choose>
								<c:when test="${ctgry.ctgryNo eq 2}">1</c:when>
								<c:when test="${ctgry.ctgryNo eq 34}">2</c:when>
								<c:otherwise>3</c:otherwise>
							</c:choose>
						</c:set>
						<i><img src="/html/page/market/assets/images/ico-navigation-menu${imgNumber}.png" alt=""></i> ${ctgry.ctgryNm }
						</a> <c:if test="${not empty ctgry.childList}">
								<div class="allmenu-group2">
									<%-- 2depth --%>
									<ul>
										<c:forEach items="${ctgry.childList}" var="ctgry2">
											<li class="allmenu-item2 <c:if test="${not empty ctgry2.childList}">is-depth</c:if>"><a href="${_marketPath}/gds/${ctgry.ctgryNo}/${ctgry2.ctgryNo}/list">${ctgry2.ctgryNm }</a> <c:if test="${not empty ctgry2.childList}">
													<div class="allmenu-group3">
														<%-- 3depth --%>
														<ul>
															<c:forEach items="${ctgry2.childList}" var="ctgry3">
																<li class="allmenu-item3"><a href="${_marketPath}/gds/${ctgry.ctgryNo}/${ctgry2.ctgryNo}/${ctgry3.ctgryNo}/list">${ctgry3.ctgryNm}</a></li>
															</c:forEach>
														</ul>
													</div>
												</c:if></li>
										</c:forEach>
									</ul>
								</div>
							</c:if></li>
					</c:forEach>

				</ul>
			</div>
			<div class="allmenu-user">
				<c:if test="${!_mbrSession.loginCheck}">
					<a href="${_membershipPath }/login?returnUrl=${_curPath}">로그인</a>
					<a href="${_membershipPath }/registStep1">회원가입</a>
				</c:if>
				<c:if test="${!_mbrSession.loginCheck}">
					<a href="${_marketPath}/logout">로그아웃</a>
				</c:if>
				<a href="${_marketPath}/etc/faq/list">고객센터</a>
			</div>
		</div>
		</div>
		<div class="navigation-submenu">
			<ul>
				<c:forEach var="userMenu" items="${_userMenuList}" varStatus="status" begin="1">
					<li><a href="${userMenu.menuUrl}" <c:if test="${userMenu.linkTy eq 'S'}">target="_blank"</c:if>>${userMenu.menuNm}</a></li>
				</c:forEach>
			</ul>
		</div>
		<div class="navigation-search">
			<button type="button" class="search-toggle">검색 펼치기 접기</button>
				<form action="${_marketPath}/search/total" class="search-form">
					<div class="form-field">
						<legend>통합검색</legend>
						<input type="text" placeholder="검색어를 입력하세요" name="srchKwd" id="srchKwd" >
						<button type="submit">검색</button>
					</div>
					<div class="form-current">
						<p class="current-title">
							최근 검색어 <button type="button" id="all-delete">전체삭제</button>
						</p>
						<div class="current-items">
							<c:forEach items="${_cookieKwdList}" var="kwd" end="6">
							<div class="current-item">
								<a href="/market/search/total?srchKwd=${kwd}">${kwd}</a>
								<button type="button" class="deleteKwd">삭제</button>
							</div>
							</c:forEach>
						
						</div>
						<div class="current-option">
							<div class="form-check form-switch option-switch">
								<input class="form-check-input" type="checkbox" id="search-save" <c:if test="${!empty param.srchNonKwd}">checked="checked"</c:if>>
								<label class="form-check-label" for="search-save">검색어 저장 끄기 </label>
							</div>
							<button type="button" class="option-close">닫기</button>
						</div>
					</div>
				</form>
		
		</div>
		<ul class="navigation-util">
			<li><a href="${_marketPath}/mypage/index" class="util-item1">마이페이지</a></li>
			<li><a href="${_marketPath}/mypage/wish/list" class="util-item2">찜한상품</a></li>
			<li><a href="${_marketPath}/mypage/cart/list" class="util-item3">장바구니</a></li>
		</ul>
	</div>
</nav>
</div>

<script>
$(function(){
	
	$("#search-save").on("click",function(){
		if($(this).is(":checked")){
			$("#srchKwd").attr("name","srchNonKwd");
		}
	});
	
	if($("search-save").is(":checked")){
		$("#srchKwd").attr("name","srchNonKwd");
	}
	
	$("#all-delete").on("click",function(){
		$(".deleteKwd").click();
	});
	
});
</script>