<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		<div id="page-personal">
            <div class="personal-info ${_mbrSession.prtcrRecipterIndex > 0?'bg-color'.concat(_mbrSession.prtcrRecipterIndex):''}"">
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
                        </div>
                    </div>
                    <%--장바구니에서만 노출--%>
                    <c:if test="${fn:indexOf(_curPath, '/cart/') > -1}">
                    <button type="button" class="personal-famcart">가족계정<br>장바구니</button>
                    </c:if>
                </div>
                <div class="personal-detail personal-onlink">
                    <div class="personal-container">
                        <div class="personal-famlink2">
                            <span class="icon"></span>
                            <span class="text">LINK</span>
                        </div>
                    </div>
                </div>
                <div class="alert alert-dismissible fade" role="alert">
                    <div class="text">
                        <small>알림</small>
                        <strong>옵션이 변경되었습니다. 옵션이 변경되었습니다. 옵션이 변경되었습니다. 옵션이 변경되었습니다. 옵션이 변경되었습니다.옵션이 변경되었습니다.</strong>
                    </div>
                    <button class="close" type="button" data-bs-dismiss="alert">닫기</button>
                </div>
                <!-- $('.alert').addClass('show'); //알림 호출 -->
            </div>

            <div class="personal-layer">
                <div class="modal-content">
                    <div class="modal-arrow"></div>
                    <div class="modal-title">
                        <img src="/html/page/market/assets/images/txt-personal-link2.svg" alt="">
                        를 원하는 프로필을 선택하세요
                        <!-- <button type="button">닫기</button> -->
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
            </div>

            <div class="personal-layer2">
                <div class="modal-content">
                    <div class="modal-title">
                        <div class="container">
                            <p class="text-alert is-white">원하는 가족계정 프로필을 선택하시면 장바구니 목록을 보실 수 있습니다.</p>
                        </div>
                    </div>
                    <div class="modal-body">
                        <form id="famsFrm2" name="famsFrm2" method="post">
                        <div class="container">

                        	<c:forEach items="${_mbrSession.prtcrList}" var="prtcr" varStatus="status">
                            <label class="modal-item">
                                <input type="radio" class="input" name="fams" value="${prtcr.uniqueId}" data-count="${status.index+1}">
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
                        </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary btn-large f_fam_connect2">링크 연결하기</button>
                        <button type="button" class="btn btn-outline-primary btn-large f_fam_disconnect" data-unique-id="${_mbrSession.uniqueId }" data-count="0">연결해제</button>
                        <button type="button" class="btn btn-outline-primary btn-large">취소</button>
                    </div>
                </div>
            </div>
        </div>