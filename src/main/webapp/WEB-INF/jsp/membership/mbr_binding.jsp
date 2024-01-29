<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<main id="container">
	<header id="page-title" style="margin-bottom:0px;">
		<h2>
			<span>
				<c:choose>
					<c:when test="${tempMbrVO.joinTy eq 'E'}">
						회원가입
					</c:when>
					<c:otherwise>
						간편 회원가입
					</c:otherwise>
				</c:choose>
			</span>
			<small>Member Join</small>
		</h2>
	</header>

	<div id="page-content">
		<div class="member-join">
			<form class="member-join-content mb-13" style="border:none;">
				<div style="margin-bottom:40px; text-align:center;">
					<div style="margin-bottom:10px; font-size: 1.5rem; font-weight:bold;">
						<c:choose>
							<c:when test="${isContainNoEmlKakao}">
								이미 가입된 카카오 계정이 있어요
							</c:when>
							<c:when test="${isContainNoEmlNaver}">
								이미 가입된 네이버 계정이 있어요
							</c:when>
							<c:when test="${tempMbrVO.joinTy eq 'E'}">
								이미 가입된 소셜 계정이 있어요
							</c:when>
							<c:otherwise>
								이미 가입된 계정이 있어요
							</c:otherwise>
						</c:choose>
					</div>
					<div style="font-size: 1.2rem;">
						<c:choose>
							<c:when test="${tempMbrVO.joinTy eq 'E'}">
								이로움ON 아이디를 만들어 연결할 수 있어요
							</c:when>
							<c:when test="${tempMbrVO.joinTy eq 'K'}">
								카카오 계정도 추가로 연결할 수 있어요
							</c:when>
							<c:when test="${tempMbrVO.joinTy eq 'N'}">
								네이버 계정도 추가로 연결할 수 있어요
							</c:when>
						</c:choose>
					</div>
				</div>
			
				<c:if test="${isContainNoEmlKakao == false && isContainNoEmlNaver == false}">
					<dl class="content-auth">
						<dt>계정 정보</dt>
					</dl>
					<table class="table-detail">
						<colgroup>
							<col class="w-29 xs:w-32">
							<col>
						</colgroup>
						<tbody>
							<tr class="top-border">
								<td></td>
								<td></td>
							</tr>
						</tbody>
					</table>
				</c:if>
	
				<div class="content-auth-phone mt-4" style="display:block;">
					<c:if test="${ !empty eroumAuthInfo }">
						<div class="flex w-full mb-4">
							<img style="flex:1 1 0; border-radius:100%; width:40px; max-width:40px; height:40px;" src="/html/core/images/ico-eroum2.png">
							<div style="flex:5 5 0; line-height:40px;">이로움ON <span style="color:gray; opacity:0.6;">&nbsp;|&nbsp;</span> ${eroumAuthInfo.mbrId}</div>
							<a style="flex:1 1 0; width:100px; max-width:100px; height:40px;" href="/membership/login" class="btn btn-outline-primary">로그인</a>
						</div>
					</c:if>

					<c:if test="${ !empty kakaoAuthInfo && isContainNoEmlKakao == false }">
						<div class="flex w-full mb-4">
							<img style="flex:1 1 0; border-radius:100%; width:40px; max-width:40px; height:40px;" src="/html/core/images/ico-kakao.png">
							<div style="flex:5 5 0; line-height:40px;">카카오 <span style="color:gray; opacity:0.6;">&nbsp;|&nbsp;</span> ${!empty kakaoAuthInfo.eml ? kakaoAuthInfo.eml : kakaoAuthInfo.mblTelno }</div>
							<a style="flex:1 1 0; width:100px; max-width:100px; height:40px;" href="/membership/kakao/auth" class="btn btn-outline-primary">로그인</a>
						</div>
					</c:if>
					
					<c:if test="${ !empty naverAuthInfo && isContainNoEmlNaver == false }">
						<div class="flex w-full mb-4">
							<img style="flex:1 1 0; border-radius:100%; width:40px; max-width:40px; height:40px;" src="/html/core/images/ico-naver.png">
							<div style="flex:5 5 0; line-height:40px;">네이버 <span style="color:gray; opacity:0.6;">&nbsp;|&nbsp;</span> ${naverAuthInfo.eml}</div>
							<a style="flex:1 1 0; width:100px; max-width:100px; height:40px;" href="/membership/naver/get" class="btn btn-outline-primary">로그인</a>
						</div>
					</c:if>
				</div>
	
				<div class="content-button mt-9" style="flex-direction: column;">
					<c:choose>
						<c:when test="${tempMbrVO.joinTy eq 'E'}">
							<a class="btn btn-eroum w-full" onclick="bindMbrEroum();">
				                <span style="width:200px">이로움ON 아이디 만들기</span>
				            </a>
						</c:when>
						<c:when test="${tempMbrVO.joinTy eq 'K'}">
							<a class="btn btn-kakao w-full" onclick="bindMbrSns();">
		                    	<span style="width:200px">카카오 계정 연결하기</span>
		                    </a>
						</c:when>
						<c:when test="${tempMbrVO.joinTy eq 'N'}">
							<a class="btn btn-naver w-full" onclick="bindMbrSns();">
		                    	<span style="width:200px">네이버 계정 연결하기</span>
		                    </a>
						</c:when>
					</c:choose>
				</div>
			</form>
		</div>
	</div>

</main>

	<!-- 이로움온 회원 인증정보 저장 모달(아이디, 패스워드) -->
	<jsp:include page="/WEB-INF/jsp/common/modal/add_eroum_auth_modal.jsp" />


<script src="/html/core/script/matchingAjaxCallApi.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
<script>
	function bindMbrSns() {
		callPostAjaxIfFailOnlyMsg(
			'/membership/sns/binding.json',
			{},
			function(result) {
				location.href = '/';					
			}
		);
	}
	
	function bindMbrEroum() {
		openRegistEroumAuthModal(true);
	}
</script>