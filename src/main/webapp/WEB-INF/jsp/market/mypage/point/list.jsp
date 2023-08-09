<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container" class="is-mypage">
	<jsp:include page="../../layout/page_header.jsp">
		<jsp:param value="나의 포인트" name="pageTitle" />
	</jsp:include>

	<div id="page-container">

		<jsp:include page="../../layout/page_sidenav.jsp" />

		<div id="page-content">
			<div class="global-user mb-9 ${_mbrSession.mberGrade eq 'E' ? 'is-grade1' : _mbrSession.mberGrade eq 'B' ? 'is-grade2' : _mbrSession.mberGrade eq 'S' ? 'is-grade3' : _mbrSession.mberGrade eq 'N' ? '' : ''} lg:hidden">
				<div class="user-name">
				    <strong>${_mbrSession.mbrNm} <small>님</small></strong>
					<span>${recipterYnCode[_mbrSession.recipterYn]}</span>
                       <button type="button" class="user-toggle">메뉴 열기</button>
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
            
	        <div class="mypage-profit is-point">
	            <div class="profit-infomation">
	                <div class="title">
                		<p class="name ${_mbrSession.mberGrade eq 'E' ? 'text-grade1' : _mbrSession.mberGrade eq 'B' ? 'text-grade2' : _mbrSession.mberGrade eq 'S' ? 'text-grade3' : _mbrSession.mberGrade eq 'N' ? '' : ''}">
	               			${gradeCode[_mbrSession.mberGrade]}
                		</p>
						<p><strong>${_mbrSession.mbrNm}</strong> 님은<br> 현재 <strong>${gradeCode[_mbrSession.mberGrade]}</strong> 등급입니다</p>
	                </div>
	                <div class="number">
	                    <dl>
	                        <dt>보유 마일리지</dt>
	                        <dd><strong><fmt:formatNumber value="${_mbrEtcInfoMap.totalPoint}" pattern="###,###" /></strong> P</dd>
	                    </dl>
	                </div>
	            </div>
	            <div class="profit-content">
	                <p class="text-alert is-danger">포인트 유의사항</p>
	                <ul class="list-normal mt-1.5">
	                    <li>회원가입, 추천 ID 등록<!--,  상품후기, 포토후기,  이벤트 참여-->과 같은 활동 내역에 따라 포인트를 적립해드립니다.</li>
	                    <li>포인트는 적립일 해의 마지막 날까지 유효하며, 유효기간이 경과한 포인트는 자동적으로 소멸됩니다.</li>
	                    <li>포인트는 3,000원 이상부터 사용 가능합니다 <!-- 당월 소멸 예정 포인트는 1원부터 사용 가능합니다. --></li>
	                    <li>휴면회원, 블랙회원으로 전환되는 경우 보유중인 포인트은 모두 소멸됩니다.</li>
	                </ul>
	                <ul class="nav nav-tabs tabs is-small mt-7 md:mt-9" id="tabs-tab" role="tablist">
						<li><a href="${_marketPath}/mypage/point/list" class="tabs-link ${param.type eq null?'active':'' }">전체</a></li>
						<li><a href="${_marketPath}/mypage/point/list?type=A" class="tabs-link ${param.type eq 'A'?'active':'' }">적립</a></li>
						<li><a href="${_marketPath}/mypage/point/list?type=M" class="tabs-link ${param.type eq 'M'?'active':'' }">사용</a></li>
	                </ul>
	                <div class="tab-content mt-6 space-y-2.5 md:mt-7 md:space-y-3">
						<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
	                    <div class="profit-infobox">
                            <p class="date">
								<c:if test="${resultList.pointSe eq 'A'}">
								<span class="label-primary">
									<span>적립</span>
									<i></i>
								</span>
								</c:if>
								<c:if test="${resultList.pointSe eq 'M'}">
								<span class="label-outline-primary">
									<span>사용</span>
									<i></i>
								</span>
								</c:if>
								<c:if test="${resultList.pointSe eq 'E'}">
								<span class="label-outline-primary">
									<span>소멸</span>
									<i></i>
								</span>
								</c:if>
								<strong>${pointCnCode[resultList.pointCn]}</strong>
                                <em><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd" /></em>
                            </p>
                            <p class="name">
							<c:if test="${empty resultList.ordrCd}">${pointCnCode[resultList.pointCn]}</c:if><c:if test="${empty resultList.ordrCd && resultList.pointCn eq '99'  && !empty resultList.mngrMemo}">(${resultList.mngrMemo})</c:if>
							<c:if test="${!empty resultList.ordrCd}"><a href="/market/mypage/ordr/view/${resultList.ordrCd}?curPage=1" style="text-decoration : underline;">${resultList.ordrCd}</a></c:if>
							</p>
	                        <p class="count">
								<c:if test="${resultList.pointSe eq 'A'}">
								<img src="/html/page/market/assets/images/ico-mypage-point.svg" alt="" class="cal">
	                            <span class="num"><fmt:formatNumber value="${resultList.point}" pattern="###,###" /></span>
								</c:if>
								<c:if test="${resultList.pointSe ne 'A'}">
								<img src="/html/page/market/assets/images/ico-mypage-point2.svg" alt="" class="cal">
	                            <span class="num"><fmt:formatNumber value="${resultList.point}" pattern="###,###" /></span>
								</c:if>
	                            <img src="/html/page/market/assets/images/ico-point.svg" alt="" class="fix">
	                        </p>
	                    </div>
						</c:forEach>
						<c:if test="${empty listVO.listObject}">
						<div class="box-result">포인트가 없습니다.</div>
						</c:if>
						<div class="pagination">
							<front:paging listVO="${listVO}" />
						</div>
	                </div>
	            </div>
			</div>
		</div>
	</div>
</main>