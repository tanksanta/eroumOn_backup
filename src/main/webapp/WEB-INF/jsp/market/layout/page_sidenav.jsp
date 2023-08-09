<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
	상품, 마이페이지 등 nav 체크
 --%>
		<c:choose>

 			<%-- 상품목록 --%>
			<c:when test="${fn:indexOf(_curPath, '/gds/') > -1 && fn:indexOf(_curPath, '/list') > -1}">
			<nav id="page-sidenav">
				<form id="srchGdsFrm" name="srchGdsFrm" method="get" class="page-sidenav-menu">
                    <input type="hidden" id="srchGdsTag" name="srchGdsTag" value="${param.srchGdsTag}">
                    <input type="hidden" id="srchGdsTagNI" name="srchGdsTagNI" value="${param.srchGdsTagNI}">
                    <input type="hidden" id="srchGdsTys" name="srchGdsTys" value="${param.srchGdsTys}">

                    <div class="flex-none flex pb-5 border-b border-gray2 space-x-2">
                        <button type="button" class="btn btn-primary flex-1 f_srchBtn">적용</button>
                        <button type="button" class="btn btn-refresh f_srchGdsFrmReset">새로고침</button>
                    </div>

                    <div class="menu-scrollbar">
                        <div class="menu-group">
                            <p class="title">가격대</p>
                            <div class="content">
                                <div>
                                    <label for="srchMinPc" class="block mb-1 text-sm tracking-tight">최소가격</label>
                                    <div class="w-45 relative">
                                        <input type="text" class="form-control pr-6 h-10 numbercheck" id="srchMinPc" name="srchMinPc" value="${param.srchMinPc}" maxlength="10" onchange="f_toComma(this); return false;">
                                        <strong class="absolute top-1/2 right-2 -translate-y-1/2">원</strong>
                                    </div>
                                </div>
                                <div class="mt-2 flex">
                                    <span class="flex h-10 items-center self-end text-lg mr-2.5 ml-1">~</span>
                                    <div class="ml-auto">
                                        <label for="srchMaxPc" class="block mb-1 text-sm tracking-tight">최대가격</label>
                                        <div class="w-45 relative">
                                            <input type="text" class="form-control pr-6 h-10 numbercheck" id="srchMaxPc" name="srchMaxPc" value="${param.srchMaxPc}" maxlength="10" onchange="f_toComma(this); return false;">
                                            <strong class="absolute top-1/2 right-2 -translate-y-1/2">원</strong>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%--카테고리 : 복지용구 일때만 출력 --%>
                        <c:if test="${fn:indexOf(_curPath,'/gds/2/') > -1}">
	                        <div class="menu-group">
	                            <p class="title">판매구분</p>
                                <div class="content space-y-4">
                                    <c:forEach items="${_gdsTyCode }" var="gdsTy" varStatus="status">
                                    <div class="form-check form-switch">
                                        <input class="form-check-input" type="checkbox" id="gdsTy${status.index}" value="${gdsTy.key}" ${fn:indexOf(param.srchGdsTy, gdsTy.key)>-1?'checked="checked"':''}>
                                        <label class="form-check-label" for="gdsTy${status.index}">${gdsTy.value}</label>
                                    </div>
                                    </c:forEach>
                                </div>
	                        </div>
                        </c:if>

                        <div class="menu-group">
                            <p class="title">기타</p>
                            <div class="content space-y-4">
                                <c:forEach items="${_gdsTagCode }" var="gdsTag" varStatus="status">
                                <c:if test="${gdsTag.key ne 'D'}" >
                                 <div class="form-check form-switch">
                                 	<%--<c:if test="${gdsTag.key eq 'D'}">
                                     <input class="form-check-input" type="checkbox" id="gdsTag${status.index}" value="${gdsTag.key}" ${fn:indexOf(param.srchGdsTag, gdsTag.key)>-1?'checked="checked"':''} data-inc="IN">
                                     <label class="form-check-label" for="gdsTag${status.index}">${gdsTag.value}</label>
                                     </c:if> --%>
                                     <input class="form-check-input" type="checkbox" name="gdsEtc" id="gdsTag${status.index}" value="${gdsTag.key}" ${fn:indexOf(param.srchGdsTag, gdsTag.key)>-1?'checked="checked"':''} data-inc="NOTIN">
                                     <label class="form-check-label" for="gdsTag${status.index}">${gdsTag.value} 제외</label>
                                 </div>
                                </c:if>
                                </c:forEach>
                                <%--

                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="gdsTag0" value="A" ${param.srchGdsTag eq 'A'?'checked="checked"':''}>
                                    <label class="form-check-label" for="gdsTag0">품절 제외</label>
                                </div>

                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="gdsTag1" value="B" ${param.srchGdsTag eq 'B'?'checked="checked"':''}>
                                    <label class="form-check-label" for="gdsTag1">일부옵션품절 제외</label>
                                </div>

								<div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="gdsTag2" value="C" ${param.srchGdsTag eq 'C'?'checked="checked"':''}>
                                    <label class="form-check-label" for="gdsTag2">일시품절 제외</label>
                                </div>

								<div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="gdsTags" value="D" ${param.srchGdsTag eq 'D'?'checked="checked"':''}>
                                    <label class="form-check-label" for="gdsTags">설치</label>
                                </div>
                                --%>
                            </div>
                        </div>
                    </div>

            	</form>

            </nav>
 			</c:when>

 			<%-- 마이페이지 --%>
 			<c:when test="${fn:indexOf(_curPath, '/mypage/') > -1}">
			<nav id="page-sidenav">
                <div class="page-sidenav-header">
					<c:choose>
						<c:when test="${_mbrSession.loginCheck}">
                    		<ul class="header-link">
                        		<li><a href="${_marketPath}/logout">로그아웃</a></li>
							</ul>
						</c:when>
						<c:otherwise>
                    		<ul class="header-link">
								<li><a href="${_membershipPath}/login">로그인</a></li>
								<li><a href="${_membershipPath}/regist">회원가입</a></li>
							</ul>
						</c:otherwise>
					</c:choose>
                    <button type="button" class="header-close">닫기</button>
                </div>
                <div class="page-sidenav-menu lg-max:pt-0">
					<c:if test="${_mbrSession.loginCheck}">
	                <div class="global-user flex-none ${_mbrSession.mberGrade eq 'E' ? 'is-grade1' : _mbrSession.mberGrade eq 'B' ? 'is-grade2' : _mbrSession.mberGrade eq 'S' ? 'is-grade3' : _mbrSession.mberGrade eq 'N' ? '' : ''}">
	                    <div class="user-name">
	                        <strong>${_mbrSession.mbrNm} <small>님</small></strong>
	                        <span>${recipterYnCode[_mbrSession.recipterYn]}</span>
	                    </div>
	                    <div class="user-info">
	                        <div class="grade">
	                            <strong>${gradeCode[_mbrSession.mberGrade]}</strong>
	                        	<a href="${_marketPath}/etc/bnft/list">등급별혜택</a>
	                        </div>
							<div class="point">
							    <dl>
							        <dt>쿠폰</dt>
							        <dd>
							        	<a href="${_marketPath}/mypage/coupon/list">
                                   			<strong>11</strong> 장
								   		</a>
								 	</dd>
								</dl>
								<dl>
								    <dt>포인트</dt>
								    <dd>
								   		<a href="${_marketPath}/mypage/point/list">
                                    		<strong>11</strong>
											<img src="/html/page/members/assets/images/txt-point-white.svg" alt="포인트">
										</a>
									</dd>
			                    </dl>
			                    <dl>
			                        <dt>마일리지</dt>
			                        <dd>
			                        	<a href="${_marketPath}/mypage/mlg/list">
                                    		<strong>11</strong>
											<img src="/html/page/members/assets/images/txt-mileage-white.svg" alt="마일리지">
										</a>
									</dd>
			                    </dl>
			                </div>
	                    </div>
	                </div>
	                </c:if>
	                <div class="menu-group">
	                    <p class="title">쇼핑내역</p>
	                    <div class="content">
	                        <ul class="menulist">
	                            <li ${fn:indexOf(_curPath, '/ordr/') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/ordr/list"><span>주문 조회</span></a></li>
	                            <c:if test="${_mbrSession.recipterYn eq 'Y'}"><li ${fn:indexOf(_curPath, '/lend/') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/lend/list"><span>대여 조회</span></a></li></c:if>
	                        </ul>
	                    </div>
	                </div>
	                <div class="menu-group">
	                    <p class="title">쇼핑혜택</p>
	                    <div class="content">
	                        <ul class="menulist">
	                            <li ${fn:indexOf(_curPath, '/coupon/') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/coupon/list"><span>쿠폰</span></a></li>
	                            <li ${fn:indexOf(_curPath, '/point/') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/point/list"><span>포인트</span></a></li>
	                            <li ${fn:indexOf(_curPath, '/mlg/') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/mlg/list"><span>마일리지</span></a></li>
	                        </ul>
	                    </div>
	                </div>
	                <div class="menu-group">
	                    <p class="title">쇼핑활동</p>
	                    <div class="content">
	                        <ul class="menulist">
	                            <li ${fn:indexOf(_curPath, '/event/') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/event/list"><span>참여한 이벤트</span></a></li>
	                            <li ${fn:indexOf(_curPath, '/buy/') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/buy/list"><span>내가 구매한 상품</span></a></li>
	                            <!-- <li ${fn:indexOf(_curPath, '/review/') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/review/doList"><span>상품후기</span></a></li> -->
	                            <li ${fn:indexOf(_curPath, '/gdsQna/') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/gdsQna/list"><span>상품 Q&amp;A</span></a></li>
	                            <li ${fn:indexOf(_curPath, '/inqry/') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/inqry/list"><span>1:1 문의</span></a></li>
	                        </ul>
	                    </div>
	                </div>
	                <div class="menu-group">
	                    <p class="title">회원정보</p>
	                    <div class="content">
	                        <ul class="menulist">
	                            <li ${fn:indexOf(_curPath, '/info/') > -1?'class="is-active"':'' }><a href="/membership/mypage/list?returnUrl=/market"><span>회원정보 수정</span></a></li>
	                            <li ${fn:indexOf(_curPath, '/dlvy/') > -1?'class="is-active"':'' }><a href="${_marketPath }/mypage/dlvy/list"><span>배송지 관리</span></a></li>
	                            <li ${fn:indexOf(_curPath, '/whdwl/') > -1?'class="is-active"':'' }><a href="/membership/whdwl/list"><span>회원 탈퇴</span></a></li>
	                        </ul>
	                    </div>
	                </div>
	                <div class="menu-group">
	                    <p class="title">맞춤형서비스</p>
	                    <div class="content">
	                        <ul class="menulist">
	                            <li ${fn:indexOf(_curPath, '/bplc') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/itrst/bplc"><span>관심멤버스 설정</span></a></li>
	                            <!-- <li ${fn:indexOf(_curPath, '/ctgry') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/itrst/ctgry"><span>관심카테고리 설정</span></a></li> -->
	                        </ul>
	                    </div>
	                </div>
				</div>
            </nav>
    		</c:when>

			<%-- 고객센터 --%>
			<c:when test="${fn:indexOf(_curPath, '/etc/faq/') > -1 || fn:indexOf(_curPath, '/etc/inqry/') > -1 || fn:indexOf(_curPath, '/etc/ntce/') > -1 || fn:indexOf(_curPath, '/etc/bnft/') > -1}">
			<nav id="page-sidenav">
				<div class="page-sidenav-menu">
					<div class="menu-scrollbar">
						<div class="menu-group">
							<div class="content">
								<ul class="menulist">
									<li ${fn:indexOf(_curPath, '/faq/') > -1?'class="is-active"':'' }><a href="${_marketPath}/etc/faq/list"><span>자주 묻는 질문</span></a></li>
									<li ${fn:indexOf(_curPath, '/inqry/') > -1?'class="is-active"':'' }><a href="${_marketPath}/etc/inqry/form"><span>1:1 문의</span></a></li>
									<li ${fn:indexOf(_curPath, '/ntce/') > -1?'class="is-active"':'' }><a href="${_marketPath}/etc/ntce/list"><span>공지사항</span></a></li>
									<li ${fn:indexOf(_curPath, '/bnft/') > -1?'class="is-active"':'' }><a href="${_marketPath}/etc/bnft/list"><span>이로움ON 혜택</span></a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</nav>
			</c:when>
	
	</c:choose>

<script>

function f_toComma(obj){
	obj.value = comma(obj.value);
}

</script>