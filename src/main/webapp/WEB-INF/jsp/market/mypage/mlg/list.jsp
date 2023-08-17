<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container" class="is-mypage">
	<jsp:include page="../../layout/page_header.jsp">
		<jsp:param value="나의 마일리지" name="pageTitle" />
	</jsp:include>

	<div id="page-container">

		<jsp:include page="../../layout/page_sidenav.jsp" />

		<div id="page-content">
			<jsp:include page="../../layout/mobile_userinfo.jsp" />

	        <div class="mypage-profit is-mileage">
	            <div class="profit-infomation">
	                <div class="title">
                		<p class="name ${_mbrSession.mberGrade eq 'E' ? 'text-grade1' : _mbrSession.mberGrade eq 'B' ? 'text-grade2' : _mbrSession.mberGrade eq 'S' ? 'text-grade3' : _mbrSession.mberGrade eq 'N' ? '' : ''}">
	               			${gradeCode[_mbrSession.mberGrade]}
                		</p>
						<p><strong>${_mbrSession.mbrNm}</strong> 님은<br> 현재 <strong>${gradeCode[_mbrSession.mberGrade]}</strong> 등급입니다</p>
	                </div>
	                <div class="number">
	                    <dl>
	                        <dt>이용가능</dt>
	                        <dd><strong><fmt:formatNumber value="${_mbrEtcInfoMap.totalMlg}" pattern="###,###" /></strong> M</dd>
	                    </dl>
	                </div>
	            </div>
	            <div class="profit-content">
	                <p class="text-alert is-danger">마일리지 유의사항</p>
	                <ul class="list-normal mt-1.5">
						<li>상품을 구매하는 회원에게 구매금액의 일정 비율을 마일리지로 적립하며, 주문취소 또는 반품의 경우에는 마일리지가 회수됩니다.</li>
						<li>마일리지는 적립일로부터 2년(730일)간 유효하며, 유효기간이 경과한 마일리지는 자동적으로 소멸됩니다.</li>
						<li>마일리지는 3,000원 이상부터 사용 가능합니다.<!--  당월 소멸 예정 마일리지는 1원부터 사용 가능합니다. --></li>
						<li>휴면회원, 블랙회원으로 전환되는 경우 보유중인 마일리지는 모두 소멸됩니다.</li>
	                </ul>
	                <p class="text-title2 mt-7 md:mt-9">적립/차감 마일리지</p>
	                <ul class="nav nav-tabs tabs is-small mt-4 md:mt-5" id="tabs-tab" role="tablist">
						<li><a href="${_marketPath}/mypage/mlg/list" class="tabs-link ${param.type eq null?'active':'' }">전체</a></li>
						<li><a href="${_marketPath}/mypage/mlg/list?type=A" class="tabs-link ${param.type eq 'A'?'active':'' }"</a>적립</a></li>
						<li><a href="${_marketPath}/mypage/mlg/list?type=M" class="tabs-link ${param.type eq 'M'?'active':'' }">사용</a></li>
	                </ul>
	                <div class="tab-content mt-6 space-y-2.5 md:mt-7 md:space-y-3">
						<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
                        <div class="profit-infobox">
                            <p class="date">
								<c:if test="${resultList.mlgSe eq 'A'}">
								<span class="label-primary">
									<span>적립</span>
									<i></i>
								</span>
								</c:if>
								<c:if test="${resultList.mlgSe eq 'M'}">
								<span class="label-outline-primary">
									<span>사용</span>
									<i></i>
								</span>
								</c:if>
								<c:if test="${resultList.mlgSe eq 'E'}">
								<span class="label-outline-primary">
									<span>소멸</span>
									<i></i>
								</span>
								</c:if>
								<strong>${mlgCnCode[resultList.mlgCn]}</strong>
                                <em><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd" /></em>
                            </p>
                            <p class="name">
								<c:if test="${empty resultList.ordrCd}">${mlgCnCode[resultList.mlgCn]}</c:if><c:if test="${empty resultList.ordrCd && resultList.mlgCn eq '99'  && !empty resultList.mngrMemo}">(${resultList.mngrMemo})</c:if>
								<c:if test="${!empty resultList.ordrCd}">${resultList.ordrCd}</c:if>
							</p>
                            <p class="count">
							<c:if test="${resultList.mlgSe eq 'A'}">
								<img src="/html/page/market/assets/images/ico-mypage-point.svg" alt="" class="cal">
								<span class="num"><fmt:formatNumber value="${resultList.mlg}" pattern="###,###" /></span>
							</c:if>
							<c:if test="${resultList.mlgSe ne 'A'}">
								<img src="/html/page/market/assets/images/ico-mypage-point2.svg" alt="" class="cal">
								<span class="num"><fmt:formatNumber value="${resultList.mlg}" pattern="###,###" /></span>
							</c:if>
	                            <img src="/html/page/market/assets/images/ico-mileage.svg" alt="" class="fix">
                            </p>
                        </div>
						</c:forEach>
						<c:if test="${empty listVO.listObject}">
						<div class="box-result">마일리지가 없습니다.</div>
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