<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main id="container" class="is-mypage-style">
		<header id="page-title">
			<h2>
				<span>마이페이지</span>
			</h2>
		</header>

		<jsp:include page="./layout/page_nav.jsp" />

        <div id="page-content">
            <h3 class="mypage-title">나의 상담 관리</h3>
            <div class="grid grid-cols-1 gap-2.5 md:grid-cols-2 md:gap-6 lg:gap-10">
                <div class="mypage-manage1">
                    <h4 class="mypage-manage1-title">
                        <img src="/html/page/members/assets/images/ico-mypage-balloon.svg" alt="">
                        장기요양 상담신청
                        <a href="${_membershipPath}/conslt/appl/list">더보기</a>
                    </h4>
                    <ul class="mypage-manage1-items">
                    	<c:forEach var="resultList" items="${consltList}" varStatus="status" end="2">
                        <li>
                            <span class="mypage-manage1-item">
                                <span class="item-name">
									<c:choose>
										<c:when test="${resultList.consltSttus eq 'CS01'}">상담 기관 배정 중 입니다.</c:when>
										<c:when test="${resultList.consltSttus eq 'CS03' || resultList.consltSttus eq 'CS04'}">상담이 취소되었습니다.</c:when>
										<c:when test="${resultList.consltSttus eq 'CS07'}">상담 기관 재 배정 중 입니다.</c:when>
										<c:otherwise>
											<c:set var="consltSize" value="${fn:length(resultList.consltResultList)}" />
											${resultList.consltResultList[consltSize-1].bplcNm}
										</c:otherwise>
									</c:choose>
                                </span>
                                <span class="item-date"><fmt:formatDate value="${resultList.regDt }" pattern="yyyy.MM.dd" /></span>
                            </span>
                        </li>
                        </c:forEach>
                        <c:if test="${empty consltList}">
                        <li>
                            <p class="mypage-manage1-empty">장기요양 상담신청 내역이 없습니다.</p>
                        </li>
                        </c:if>
                    </ul>
                </div>
                <div class="mypage-manage1" style="display: none;">
                    <h4 class="mypage-manage1-title">
                        <img src="/html/page/members/assets/images/ico-mypage-interest-active.svg" alt="">
                        관심 멤버스 설정
                        <a href="${_membershipPath}/conslt/itrst/bplc">더보기</a>
                    </h4>
                    <ul class="mypage-manage1-items">
                    	<c:forEach var="resultList" items="${bplcList}" varStatus="status" end="2">
                        <li class="mypage-manage1-item">
                        	${resultList.bplcInfo.bplcNm}
                            <%-- <a href="/members/${resultList.bplcInfo.bplcId}" class="item-name" target="_blank">${resultList.bplcInfo.bplcNm}</a>
                            <a href="/members/${resultList.bplcInfo.bplcId}" class="item-home" target="_blank"><span>홈페이지</span></a> --%>
                        </li>
                        </c:forEach>
						<c:if test="${empty bplcList}">
                        <li class="mypage-manage1-empty">
                            관심 멤버스를 설정하세요
                            <a href="${_membershipPath}/conslt/itrst/bplc">관심 멤버스 설정하기</a>
                        </li>
                        </c:if>
                    </ul>
                </div>
            </div>

            <hr class="mypage-split">

            <h3 class="mypage-title md:mt-17 lg:mt-22">나의 정보 관리</h3>
            <div class="grid grid-cols-1 gap-2.5 md:grid-cols-3 md:gap-3 lg:gap-4">
                <a href="${_membershipPath}/info/myinfo/confirm" class="mypage-manage2">
                    <i class="mypage-manage2-icon"><img src="/html/page/members/assets/images/img-mypage-management1.svg" alt="" class="w-7"></i>
                    <strong class="mypage-manage2-name">
                        내 정보 수정
                        <small>
                            비밀번호, 휴대폰번호 등
                            내 정보를 수정하세요
                        </small>
                    </strong>
                </a>
                <a href="${_membershipPath}/info/dlvy/list" class="mypage-manage2">
                    <i class="mypage-manage2-icon"><img src="/html/page/members/assets/images/img-mypage-management2.svg" alt="" class="w-6"></i>
                    <strong class="mypage-manage2-name">
                        배송지 관리
                        <small>
                            기본주소 및 배송지를
                            관리하세요
                        </small>
                    </strong>
                </a>
                <a href="${_membershipPath}/info/whdwl/form" class="mypage-manage2">
                    <i class="mypage-manage2-icon"><img src="/html/page/members/assets/images/img-mypage-management3.svg" alt="" class="w-5"></i>
                    <strong class="mypage-manage2-name">회원 탈퇴</strong>
                </a>
            </div>
        </div>

    </main>

    <script>
    $(function(){
    });
    </script>
