<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container" class="is-mypage">
	<jsp:include page="../../layout/page_header.jsp">
		<jsp:param value="내가 구매한 상품" name="pageTitle" />
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
            
	        <div class="items-center justify-between md:flex">
	            <div class="space-y-1.5">
	                <p class="text-alert">내가 구매한 상품을 쉽고 빠르게 확인하실 수 있습니다.</p>
	                <p class="text-alert">최근 6개월간 구매한 상품 리스트입니다.</p>
	                <p class="text-alert">현재 품절된 상품인 경우는 바로구매, 장바구니 담기가 안될 수 있습니다.</p>
	            </div>
	        </div>

            <form class="order-search mt-12 md:mt-16" id="searchFrm" name="searchFrm" action="./list">
                <p class="search-title">조회기간</p>
                <div class="form-check-group search-left">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="srchDate" id="srchDate0" value="week"  <c:if test="${param.srchDate eq 'week' }">checked="checked"</c:if>>
                        <label class="form-check-label" for="srchDate0">1주일</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="srchDate" id="srchDate1" value="month" <c:if test="${param.srchDate eq 'month' }">checked="checked"</c:if>>
                        <label class="form-check-label" for="srchDate1">한 달</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="srchDate" id="srchDate2" value="half" <c:if test="${param.srchDate eq 'half' }">checked="checked"</c:if>>
                        <label class="form-check-label" for="srchDate2">6개월</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="srchDate" id="srchDate3" value="year" <c:if test="${param.srchDate eq 'year' }">checked="checked"</c:if>>
                        <label class="form-check-label" for="srchDate3">1년</label>
                    </div>
                </div>
                <div class="search-right">
                    <input type="text" class="form-control" id="srchText" name="srchText" placeholder="상품명을 입력하세요." value="${param.srchText}"/>
                    <button type="submit" class="btn btn-primary">조회</button>
                </div>
            </form>

			<p class="text-title2 mt-11 md:mt-15">내가 구매한 상품 <strong class="text-danger">${listVO.totalCount}</strong>건</p>

           	<div class="mt-4 space-y-4 md:mt-5 md:space-y-5">
				<c:if test="${empty listVO.listObject}">
				<div class="box-result is-large">아직 구매하신 상품이 없습니다</div>
				</c:if>

				<c:forEach var="resultList" items="${listVO.listObject}">
				<c:if test="${resultList.ordrOptnTy eq 'BASE' }">

				<c:set var="spOrdrOptn" value="${fn:split(resultList.ordrOptn, '*')}" />
                <div class="order-product order-purchase">
				    <div class="order-header">
				        <dl>
				            <dt>주문일시</dt>
				            <dd><fmt:formatDate value="${resultList.ordrDt}" pattern="yyyy-MM-dd" /></dd>
				        </dl>
						<c:if test="${resultList.gdsInfo.soldoutYn eq 'Y'}">
						<span class="label-outline-danger -mr-3 ml-auto">
				            <span>품절</span>
				            <i></i>
				        </span>
						</c:if>
				    </div>
				    <div class="order-body">
				        <div class="order-item">
				            <div class="order-item-thumb">
							<c:choose>
								<c:when test="${!empty resultList.gdsInfo.thumbnailFile}">
								<a href="${_marketPath}/gds/${resultList.gdsInfo.ctgryNo}/${resultList.gdsInfo.gdsCd}"><img src="/comm/getImage?srvcId=GDS&amp;upNo=${resultList.gdsInfo.thumbnailFile.upNo }&amp;fileTy=${resultList.gdsInfo.thumbnailFile.fileTy }&amp;fileNo=${resultList.gdsInfo.thumbnailFile.fileNo }&amp;thumbYn=Y" alt=""></a>
								</c:when>
								<c:otherwise>
								<img src="/html/page/market/assets/images/noimg.jpg" alt="">
								</c:otherwise>
							</c:choose>
				            </div>
				            <div class="order-item-content">
				                <div class="order-item-group">
				                    <div class="order-item-base">
				                        <p class="code">
											<a href="${_marketPath}/gds/${resultList.gdsInfo.ctgryNo}/${resultList.gdsInfo.gdsCd}"><u>${resultList.gdsInfo.gdsCd}</u></a>
				                        </p>
				                        <div class="product">
											<p class="name">${resultList.gdsInfo.gdsNm}</p>
											<c:if test="${!empty spOrdrOptn[0]}">
	                                        <dl class="option">
	                                            <dt>옵션</dt>
	                                            <dd>
													<c:forEach items="${spOrdrOptn}" var="ordrOptn">
													<span class="label-flat">${ordrOptn}</span>
													</c:forEach>
	                                            </dd>
	                                        </dl>
                                            </c:if>
				                        </div>
				                    </div>
				                </div>
				                <div class="order-item-count">
				                    <p><strong>${resultList.ordrQy}</strong>개</p>
				                </div>
				                <p class="order-item-price">
				                	<fmt:formatNumber value="${resultList.gdsPc * resultList.ordrQy}" pattern="###,###" />원
				                </p>
				            </div>
				        </div>
				    </div>
				</div>
				</c:if>
				</c:forEach>

				<div class="pagination">
					<front:paging listVO="${listVO}" />
				</div>
           	</div>
		</div>
	</div>
</main>