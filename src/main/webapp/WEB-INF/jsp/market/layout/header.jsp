<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <header id="header">
        <div class="container">
	        <a href="${_marketPath}" class="header-toggle"><img src="/html/page/market/assets/images/btn-header-toggle.svg" alt="마켓 로고"></a>
	        <h1 class="header-logo"><a href="${_marketPath}"><img src="/html/page/market/assets/images/img-header-logo.svg" alt="이로움 마켓"></a></h1>
	        <ul class="header-menu">
	        	<c:if test="${!_mbrSession.loginCheck}">
	            <li><a href="${_membershipPath }/login?returnUrl=${_curPath}">로그인</a></li>
	            <li><a href="${_membershipPath }/registStep1">회원가입</a></li>
	            </c:if>
	            <c:if test="${_mbrSession.loginCheck}">
	            <li><a href="${_membershipPath}/logout">로그아웃</a></li>
	            <li><a href="${_marketPath }/mypage/index">마이페이지</a></li>
	            </c:if>
	            <li><a href="${_marketPath}/etc/faq/list">고객센터</a></li>
	        </ul>
        </div>
    </header>

	<c:if test="${fn:indexOf(_curPath, '/gds/') > -1}"><%-- 회원선택창은 상품*에서만 --%>
	<c:if test="${_mbrSession.loginCheck}">
	<%-- 로그인 케이스 --%>
    <!-- person -->
    <div id="personal" data-login-check="true">
        <div class="personal-info ${_mbrSession.prtcrRecipterIndex > 0?'bg-color'.concat(_mbrSession.prtcrRecipterIndex):''}">
            <div class="personal-user">
                <p class="name"><strong>${_mbrSession.prtcrRecipterInfo.mbrNm}</strong> 님</p>
                <img src="/html/page/market/assets/images/img-shopbag.png" alt="" class="bags">
                <p class="rank">
                    <small>${_mbrSession.prtcrRecipterYn eq 'Y'?'수급자회원':'일반회원'}</small>
                    <strong>
                    	<img src="/html/page/market/assets/images/img-grade${_mbrSession.prtcrRecipterInfo.mberGrade eq 'P' ? '1' : _mbrSession.prtcrRecipterInfo.mberGrade eq 'V' ? '2' : _mbrSession.prtcrRecipterInfo.mberGrade eq 'G' ? '3' : _mbrSession.prtcrRecipterInfo.mberGrade eq 'R' ? '4' : _mbrSession.prtcrRecipterInfo.mberGrade eq 'S' ? '5' : ''}.svg" alt="">
                	</strong>
                </p>
            </div>

            <div class="personal-detail personal-onbase is-active">
                <button type="button" class="personal-famlink">
                    <span class="complate"></span>
                    <span class="sr-only">가족회원 연동</span>
                </button>
                <div class="personal-container">
                    <div class="personal-family">
                        <div class="thumb">
                        	<c:if test="${!empty _mbrSession.prtcrRecipterInfo.proflImg}">
                            <img src="/comm/proflImg?fileName=${_mbrSession.prtcrRecipterInfo.proflImg}" alt="">
                            </c:if>
                        </div>
                        <%-- <c:if test="${_mbrSession.prtcrRecipterYn eq 'Y'}">
                        <dl class="cost">
                            <dt>지원금</dt>
                            <dd><fmt:formatNumber value="${_mbrEtcInfoMap.totalBnefBlce}" pattern="###,###" /><small>원</small></dd>
                        </dl>
                        </c:if> --%>
                        <dl class="mileage">
                            <dt>마일리지</dt>
                            <dd><fmt:formatNumber value="${_mbrEtcInfoMap.totalMlg}" pattern="###,###" /></dd>
                        </dl>
                        <dl class="point">
                            <dt>포인트</dt>
                            <dd><fmt:formatNumber value="${_mbrEtcInfoMap.totalPoint}" pattern="###,###" /></dd>
                        </dl>
                        <dl class="coupon">
                            <dt>쿠폰</dt>
                            <dd><fmt:formatNumber value="${_mbrEtcInfoMap.totalCoupon}" pattern="###,###" /></dd>
                        </dl>
                        <a href="${_marketPath}/mypage/index" class="link">상세 페이지</a>
                    </div>
                </div>
            </div>

            <div class="personal-detail personal-onlink">
                <div class="personal-container">
                    <div class="personal-famlink2">
                        <span class="icon"></span>
                        <span class="text">LINK</span>
                    </div>
                </div>
            </div>

            <div class="personal-detail personal-oncart">
                <div class="personal-container">
                    <div class="personal-family">
                        <div class="thumb">
                            <c:if test="${!empty _mbrSession.prtcrRecipterInfo.proflImg}">
                            <img src="/comm/proflImg?fileName=${_mbrSession.prtcrRecipterInfo.proflImg}" alt="">
                            </c:if>
                        </div>
                    </div>
                    <div class="personal-cart">
                        <a href="${_marketPath}/mypage/wish/list" class="interest">${_mbrEtcInfoMap.totalWish}</a>
                        <a href="${_marketPath}/mypage/cart/list" class="mycart">${_mbrEtcInfoMap.totalCart }</a>
                        <!-- <a href="#" class="recent">0</a> -->
                    </div>
                </div>
                <a href="#" class="personal-toggle">개인화 메뉴 펼치기/접기</a>
            </div>
            <div class="alert alert-dismissible fade" role="alert">
                <div class="text">
                    <small>알림</small>
                    <strong>-</strong>
                </div>
                <button class="close" type="button" data-bs-dismiss="alert">닫기</button>
            </div>
        </div>
        <div class="personal-layer">
            <div class="modal-content">
                <div class="modal-arrow"></div>
                <div class="modal-title">
                    <img src="/html/page/market/assets/images/txt-personal-link2.svg" alt="">
                    를 원하는 프로필을 선택하세요
                    <button type="button" id="clsLayer" data-unique-id="${_mbrSession.uniqueId}" data-prtcr-id="${_mbrSession.prtcrRecipterInfo.uniqueId}">닫기</button>
                </div>
                <form class="modal-body" id="famsFrm" name="famsFrm" method="post">
                	<c:forEach items="${_mbrSession.prtcrList}" var="prtcr" varStatus="status">
                    <label class="modal-item">
                        <input type="radio" class="input" name="fams" value="${prtcr.mbrUniqueId}" data-count="${status.index+1}" ${prtcr.mbrUniqueId eq _mbrSession.prtcrRecipterInfo.uniqueId?'checked="checked"':'' }>
                        <div class="check">
                            <span class="complate"></span>
                        </div>
                        <div class="label">
                            <div class="thumb">
                            	<c:if test="${!empty prtcr.proflImg}">
	                            <img src="/comm/proflImg?fileName=${prtcr.proflImg}" alt="">
	                            </c:if>
                            </div>
                            <div class="name">${prtcr.mbrNm} <small>${prtcr.recipterYn eq 'Y'?'수급자':'일반'} 회원</small></div>
                        </div>
                    </label>
                    </c:forEach>
                    <c:if test="${_mbrSession.prtcrList.size() < 4 }">
                    <a href="${_marketPath }/mypage/fam/list" class="modal-item">
                        <div class="label">
                            <div class="thumb add"></div>
                            <div class="name opacity-30">추가</div>
                        </div>
                    </a>
                    </c:if>
                </form>
                <div class="modal-footer">
                    <a href="#disconnect" class="link1 f_fam_disconnect" data-unique-id="${_mbrSession.uniqueId }" data-count="0">
                        <img src="/html/page/market/assets/images/ico-personal-link-off-white.svg" alt="">
                        <span>연결해제</span>
                    </a>
                    <button type="button" class="connect f_fam_connect">
                        <span>누구와 연결하시겠습니까?</span>
                    </button>
                    <a href="${_marketPath }/mypage/fam/list" class="link2">
                        <img src="/html/page/market/assets/images/ico-human2-white.svg" alt="">
                        <span>가족계정</span>
                    </a>
                </div>
            </div>
            <!-- <div class="modal-linkdesc">
                <img src="/html/page/market/assets/images/img-personal-link.png" alt="">
                <div>
                    <a href="#">
                        <small>이로움링크에 대해 알려드려요!</small>
                        <strong>링크가 뭐죠?</strong>
                    </a>
                    <a href="#">
                        <small>이렇게 활용해 보세요</small>
                        <strong>활용법 5가지</strong>
                    </a>
                </div>
            </div> -->
        </div>
    </div>
    <!-- //person -->
    </c:if>

	<c:if test="${!_mbrSession.loginCheck}">
    <%-- 로그아웃 케이스 --%>
	<%--
	<!-- person -->
    <div id="personal" data-login-check="false">
        <div class="personal-info">
            <div class="personal-user">
                <img src="/html/page/market/assets/images/img-shopbag.png" alt="" class="bags">
                <span class="logout">Easy Equity Eroum Market</span>
            </div>
            <div class="personal-detail personal-onbase is-active">
                <div class="personal-container">

                    <div class="personal-cart">
                        <a href="#" class="interest">0</a>
                        <a href="#" class="mycart">0</a>
                        <a href="#" class="recent">0</a>
                    </div>
                </div>
            </div>
            <div class="personal-detail personal-oncart">
                <div class="personal-container">
                    <div class="personal-cart">
                        <a href="#" class="interest">0</a>
                        <a href="#" class="mycart">0</a>
                        <a href="#" class="recent">0</a>
                    </div>
                </div>
                <a href="#" class="personal-toggle">개인화 메뉴 펼치기/접기</a>
            </div>
        </div>
    </div>
    <!-- //person -->
    --%>
    </c:if>
	</c:if>
