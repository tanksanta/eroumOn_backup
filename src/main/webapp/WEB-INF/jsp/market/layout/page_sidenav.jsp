<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
	상품, 마이페이지 등 nav 체크
 --%>
		<c:choose>
 			<%-- 상품목록 --%>
			<c:when test="${fn:indexOf(_curPath, '/gds/') > -1 &&  fn:indexOf(_curPath, '/list') > -1}">
			<nav id="page-sidenav">
				<form id="srchGdsFrm" name="srchGdsFrm" method="get" class="page-sidenav-container">
                    <input type="hidden" id="srchGdsTag" name="srchGdsTag" value="${param.srchGdsTag}">
                    <input type="hidden" id="srchGdsTagNI" name="srchGdsTagNI" value="${param.srchGdsTagNI}">
                    <input type="hidden" id="srchGdsTys" name="srchGdsTys" value="${param.srchGdsTys}">
                    <div class="flex-none flex pb-5 border-b border-gray2 space-x-2">
                        <button type="button" class="btn btn-primary flex-1 f_srchBtn">적용</button>
                        <button type="button" class="btn btn-refresh f_srchGdsFrmReset">새로고침</button>
                    </div>
                    <div class="page-sidenav-scrollbar">
                        <div class="page-sidenav-group">
                            <p class="title">가격대</p>
                            <div class="scroller">
                                <div class="direction">
                                    <div class="content">
                                        <div>
                                            <label for="srchMinPc" class="block mb-1 text-sm tracking-tight">최소가격</label>
                                            <div class="w-45 relative">
                                                <input type="text" class="form-control pr-6 h-10 numbercheck" id="srchMinPc" name="srchMinPc" value="${param.srchMinPc}" maxlength="10">
                                                <strong class="absolute top-1/2 right-2 -translate-y-1/2">원</strong>
                                            </div>
                                        </div>
                                        <div class="mt-2 flex">
                                            <span class="flex h-10 items-center self-end text-lg mr-2.5 ml-1">~</span>
                                            <div class="ml-auto">
                                                <label for="srchMaxPc" class="block mb-1 text-sm tracking-tight">최대가격</label>
                                                <div class="w-45 relative">
                                                    <input type="text" class="form-control pr-6 h-10 numbercheck" id="srchMaxPc" name="srchMaxPc" value="${param.srchMaxPc}" maxlength="10">
                                                    <strong class="absolute top-1/2 right-2 -translate-y-1/2">원</strong>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                            <div class="page-sidenav-group">
                            <p class="title">판매구분</p>
                            <div class="scroller">
                                <div class="direction">
                                    <div class="content space-y-4">
                                        <c:forEach items="${_gdsTyCode }" var="gdsTy" varStatus="status">
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" id="gdsTy${status.index}" value="${gdsTy.key}" ${fn:indexOf(param.srchGdsTy, gdsTy.key)>-1?'checked="checked"':''}>
                                            <label class="form-check-label" for="gdsTy${status.index}">${gdsTy.value}</label>
                                        </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="page-sidenav-group">
                            <p class="title">기타</p>
                            <div class="scroller">
                                <div class="direction">
                                    <div class="content space-y-4">

                                        <c:forEach items="${_gdsTagCode }" var="gdsTag" varStatus="status">
                                        <div class="form-check form-switch">
                                        	<c:if test="${gdsTag.key eq 'D'}">
                                            <input class="form-check-input" type="checkbox" id="gdsTag${status.index}" value="${gdsTag.key}" ${fn:indexOf(param.srchGdsTag, gdsTag.key)>-1?'checked="checked"':''} data-inc="IN">
                                            <label class="form-check-label" for="gdsTag${status.index}">${gdsTag.value}</label>
                                            </c:if>
                                            <c:if test="${gdsTag.key ne 'D'}">
                                            <input class="form-check-input" type="checkbox" id="gdsTag${status.index}" value="${gdsTag.key}" ${fn:indexOf(param.srchGdsTag, gdsTag.key)>-1?'checked="checked"':''} data-inc="NOTIN">
                                            <label class="form-check-label" for="gdsTag${status.index}">${gdsTag.value} 제외</label>
                                            </c:if>
                                        </div>
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
                            <!--  <button type="button" class="moreview">+</button>-->
                        </div>
                    </div>
            	</form>
            </nav>
 			</c:when>
 			<%-- 마이페이지 --%>
 			<c:when test="${fn:indexOf(_curPath, '/mypage/') > -1}">
			<nav id="page-sidenav">
                <div class="page-sidenav-container">
                    <div class="page-sidenav-scrollbar">
                        <div class="page-sidenav-group">
                            <p class="title">쇼핑내역</p>
                            <div class="scroller">
                                <div class="direction">
                                    <div class="content">
                                        <ul class="menulist">
                                            <li ${fn:indexOf(_curPath, '/ordr/') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/ordr/list"><span>주문 조회</span></a></li>
                                            <c:if test="${_mbrSession.recipterYn eq 'Y'}"><li ${fn:indexOf(_curPath, '/lend/') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/lend/list"><span>대여 조회</span></a></li></c:if>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="page-sidenav-group">
                            <p class="title">쇼핑혜택</p>
                            <div class="scroller">
                                <div class="direction">
                                    <div class="content">
                                        <ul class="menulist">
                                            <li ${fn:indexOf(_curPath, '/coupon/') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/coupon/list"><span>쿠폰</span></a></li>
                                            <li ${fn:indexOf(_curPath, '/point/') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/point/list"><span>포인트</span></a></li>
                                            <li ${fn:indexOf(_curPath, '/mlg/') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/mlg/list"><span>마일리지</span></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="page-sidenav-group">
                            <p class="title">쇼핑활동</p>
                            <div class="scroller">
                                <div class="direction">
                                    <div class="content">
                                        <ul class="menulist">
                                            <li ${fn:indexOf(_curPath, '/event/') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/event/list"><span>참여한 이벤트</span></a></li>
                                            <li ${fn:indexOf(_curPath, '/buy/') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/buy/list"><span>내가 구매한 상품</span></a></li>
                                            <li ${fn:indexOf(_curPath, '/review/') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/review/doList"><span>상품후기</span></a></li>
                                            <li ${fn:indexOf(_curPath, '/gdsQna/') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/gdsQna/list"><span>상품 Q&amp;A</span></a></li>
                                            <li ${fn:indexOf(_curPath, '/inqry/') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/inqry/list"><span>1:1 문의</span></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="page-sidenav-group">
                            <p class="title">회원정보</p>
                            <div class="scroller">
                                <div class="direction">
                                    <div class="content">
                                        <ul class="menulist">
                                            <li ${fn:indexOf(_curPath, '/info/') > -1?'class="is-active"':'' }><a href="/membership/mypage/list"><span>회원정보 수정</span></a></li>
                                            <li ${fn:indexOf(_curPath, '/fam/') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/fam/list"><span>가족회원 관리</span></a></li>
                                            <li ${fn:indexOf(_curPath, '/dlvy/') > -1?'class="is-active"':'' }><a href="${_marketPath }/mypage/dlvy/list"><span>배송지 관리</span></a></li>
                                            <li ${fn:indexOf(_curPath, '/whdwl/') > -1?'class="is-active"':'' }><a href="/membership/whdwl/list"><span>회원 탈퇴</span></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="page-sidenav-group">
                            <p class="title">맞춤형서비스</p>
                            <div class="scroller">
                                <div class="direction">
                                    <div class="content">
                                        <ul class="menulist">
                                            <li ${fn:indexOf(_curPath, '/bplc') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/itrst/bplc"><span>관심멤버스 설정</span></a></li>
                                            <!-- <li ${fn:indexOf(_curPath, '/ctgry') > -1?'class="is-active"':'' }><a href="${_marketPath}/mypage/itrst/ctgry"><span>관심카테고리 설정</span></a></li> -->
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </nav>
    		</c:when>

		<%-- 고객센터 --%>
		<c:when test="${fn:indexOf(_curPath, '/etc/faq/') > -1 || fn:indexOf(_curPath, '/etc/inqry/') > -1 || fn:indexOf(_curPath, '/etc/ntce/') > -1 || fn:indexOf(_curPath, '/etc/bnft/') > -1}">
			<nav id="page-sidenav">
				<div class="page-sidenav-container">
					<div class="page-sidenav-scrollbar">
						<div class="page-sidenav-group">
							<div class="scroller">
								<div class="direction">
									<div class="content">
										<ul class="menulist">
											<li ${fn:indexOf(_curPath, '/faq/') > -1?'class="is-active"':'' }><a href="${_marketPath}/etc/faq/list"><span>자주 묻는 질문</span></a></li>
											<li ${fn:indexOf(_curPath, '/inqry/') > -1?'class="is-active"':'' }><a href="${_marketPath}/etc/inqry/form"><span>1:1 문의</span></a></li>
											<li ${fn:indexOf(_curPath, '/ntce/') > -1?'class="is-active"':'' }><a href="${_marketPath}/etc/ntce/list"><span>공지사항</span></a></li>
											<li ${fn:indexOf(_curPath, '/bnft/') > -1?'class="is-active"':'' }><a href="${_marketPath}/etc/bnft/list"><span>이로움 혜택</span></a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</nav>
		</c:when>

</c:choose>