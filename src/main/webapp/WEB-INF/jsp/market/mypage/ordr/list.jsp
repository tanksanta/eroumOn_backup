<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main id="container" class="is-mypage">
		<jsp:include page="../../layout/page_header.jsp">
			<jsp:param value="주문결제" name="pageTitle"/>
		</jsp:include>

        <div id="page-container">

            <jsp:include page="../../layout/page_sidenav.jsp" />

            <div id="page-content">
				<jsp:include page="../../layout/mobile_userinfo.jsp" />

            	<c:if test="${_mbrSession.recipterYn eq 'Y'}">
                <!-- 수급자 -->
                <ul class="order-sequence">
                    <!-- <li class="seq1">
                        <p>
                            멤버스<br>
                            <em>승인대기</em>
                        </p>
                        <strong>${ordrSttsTyCntMap.or01}</strong>
                    </li>
                    <li class="seq2">
                        <p>
                            멤버스<br>
                            <em>승인완료/반려</em>
                        </p>
                        <strong>${ordrSttsTyCntMap.or02 + ordrSttsTyCntMap.or03}</strong>
                    </li> -->
                    <li class="seq3">
                        결제<em>대기</em>
                        <strong>${ordrSttsTyCntMap.or04}</strong>
                    </li>
                    <li class="seq4">
                        <p>
                            결제<em>완료</em>
                        </p>
                        <strong>${ordrSttsTyCntMap.or05}</strong>
                    </li>
                    <li class="seq5">
                        <p>
                            배송<br>
                            <em>준비중</em>
                        </p>
                        <strong>${ordrSttsTyCntMap.or06}</strong>
                    </li>
                    <li class="seq6">
                        <p>
                            <em>배송중</em>
                        </p>
                        <strong>${ordrSttsTyCntMap.or07}</strong>
                    </li>
                    <li class="seq7">
                        <p><em>배송완료</em></p>
                        <strong>${ordrSttsTyCntMap.or08}</strong>
                    </li>
                </ul>
                <!-- //수급자 -->
				</c:if>
				<c:if test="${_mbrSession.recipterYn eq 'N'}">
                <!-- 일반 -->
                <ul class="order-sequence">
                    <li class="seq3">
                        결제<em>대기</em>
                        <strong>${ordrSttsTyCntMap.or04}</strong>
                    </li>
                    <li class="seq4">
                        <p>
                            결제<em>완료</em>
                        </p>
                        <strong>${ordrSttsTyCntMap.or05}</strong>
                    </li>
                    <li class="seq5">
                        <p>
                            배송<br>
                            <em>준비중</em>
                        </p>
                        <strong>${ordrSttsTyCntMap.or06}</strong>
                    </li>
                    <li class="seq6">
                        <p>
                            <em>배송중</em>
                        </p>
                        <strong>${ordrSttsTyCntMap.or07}</strong>
                    </li>
                    <li class="seq7">
                        <p><em>배송완료</em></p>
                        <strong>${ordrSttsTyCntMap.or08}</strong>
                    </li>
                </ul>
                <!-- //일반 -->
                </c:if>

                <!-- 검색 -->
                <form id="searchFrm" name="searchFrm" method="get" action="./list" class="order-search mt-7.5 md:mt-9">
                    <div class="search-group">
                    	<p class="search-title">조회기간</p>
						<div class="search-group1">
	                        <div class="form-check">
	                            <input class="form-check-input" type="radio" name="selPeriod" id="selPeriod1" value="1" <c:if test="${param.selPeriod eq '1' }">checked="checked"</c:if>>
	                            <label class="form-check-label" for="selPeriod1">최대(5년)</label>
	                        </div>
	                        <div class="form-check">
	                            <input class="form-check-input" type="radio" name="selPeriod" id="selPeriod2" value="2" <c:if test="${param.selPeriod eq '2' }">checked="checked"</c:if>>
	                            <label class="form-check-label" for="selPeriod2">1개월</label>
	                        </div>
	                        <div class="form-check">
	                            <input class="form-check-input" type="radio" name="selPeriod" id="selPeriod3" value="3" <c:if test="${param.selPeriod eq '3' }">checked="checked"</c:if>>
	                            <label class="form-check-label" for="selPeriod3">3개월</label>
	                        </div>
	                        <div class="form-check">
	                            <input class="form-check-input" type="radio" name="selPeriod" id="selPeriod4" value="4" <c:if test="${param.selPeriod eq '4' }">checked="checked"</c:if>>
	                            <label class="form-check-label" for="selPeriod4">6개월</label>
	                        </div>
	                    </div>
                        <div class="search-group2">
	                        <input type="date" class="form-control form-calendar" id="srchOrdrYmdBgng" name="srchOrdrYmdBgng" value="${param.srchOrdrYmdBgng}">
	                        <i>-</i>
	                        <input type="date" class="form-control form-calendar" id="srchOrdrYmdEnd" name="srchOrdrYmdEnd" value="${param.srchOrdrYmdEnd}">
	                    </div>
                    </div>
                    <div class="search-group">
                        <p class="search-title">검색항목</p>
                        <div class="search-group3">
                            <select name="srchOrdrSttsTy" id="srchOrdrSttsTy" class="form-control">
                                <option value="" ${empty param.srchOrdrSttsTy?'selected="selected"':''}>주문내역 선택하세요</option>
                                <option value="OR04" ${param.srchOrdrSttsTy eq 'OR04'?'selected="selected"':''}>결제대기</option>
                                <option value="OR05" ${param.srchOrdrSttsTy eq 'OR05'?'selected="selected"':''}>결제완료</option>
                                <option value="OR06" ${param.srchOrdrSttsTy eq 'OR06'?'selected="selected"':''}>배송준비중</option>
                                <option value="OR07" ${param.srchOrdrSttsTy eq 'OR07'?'selected="selected"':''}>상품준비완료, 배송중</option>
                                <option value="OR08" ${param.srchOrdrSttsTy eq 'OR08'?'selected="selected"':''}>배송완료</option>
                            </select>
							<input type="text" class="form-control" id="srchGdsNm" name="srchGdsNm" placeholder="상품명을 입력하세요." value="${param.srchGdsNm}"/>
                            <button type="submit" class="btn btn-primary">조회</button>
                        </div>
                    </div>
                </form>
                <!-- //검색 -->

                <!-- 목록 -->
                <div class="mt-12 space-y-6 md:mt-16 md:space-y-7.5">
               		<c:if test="${empty listVO.listObject}">
                    <p class="box-result">
                    	<c:choose>
                    		<c:when test="${param.selPeriod eq '1'}">최근 1주일간</c:when>
                    		<c:when test="${param.selPeriod eq '2'}">최근 한 달간</c:when>
                    		<c:when test="${param.selPeriod eq '3'}">최근 6개월간</c:when>
                    		<c:when test="${param.selPeriod eq '4'}">최근 1년간</c:when>
                    		<c:otherwise>검색하신 기간에</c:otherwise>
                    	</c:choose>
                    	주문 내역이 없습니다
                    </p>
                	</c:if>


					<c:forEach items="${listVO.listObject}" var="ordrDtl" varStatus="status">
					<c:set var="pageParam" value="curPage=${listVO.curPage}${!empty(listVO.urlParam)? '&amp;' : ''}${listVO.urlParam}" />

					<c:set var="spOrdrOptn" value="${fn:split(ordrDtl.ordrOptn, '*')}" />

					<c:if test="${ordrDtl.ordrOptnTy eq 'BASE'}">

					<c:set var="sumOrdrPc" value="${ordrDtl.ordrPc }" />
					<c:set var="totalGdsPc" value="${ordrDtl.gdsPc * ordrDtl.ordrQy}" />
					<c:set var="ordrQy" value="${ordrDtl.ordrQy }" />

					<%-- 통합 주문 번호 --%>
					<c:if test="${status.first}">

                    <div class="order-product order-product-mypage">
                        <div class="order-header">
                            <div class="flex flex-col w-full gap-3">
                                <!--2023-12-27:사업소명-->
                                <dl class="order-item-business">
                                    <dt><span>사업소</span> <span>행복한 시니어</span></dt>
                                </dl>
                                <!--//2023-12-27:사업소명-->

                                <c:if test="${ordrDtl.ordrTy eq 'R' || ordrDtl.ordrTy eq 'L'}">
                                    <%-- 급여구매일 경우만 경우만 멤버스(사업소) 있음 --%>
                                    <c:if test="${!empty ordrDtl.bplcInfo}">
                                        <dl class="large">
                                            <dt>멤버스</dt>
                                            <dd>${ordrDtl.bplcInfo.bplcNm}</dd>
                                        </dl>
                                    </c:if>
                                </c:if>
                                <div class="flex items-center w-full">
                                    <dl>
                                        <dt>주문번호</dt>
                                        <dd><strong><a href="./view/${ordrDtl.ordrCd}?${pageParam}">${ordrDtl.ordrCd}</a></strong></dd>
                                    </dl>
                                    <dl>
                                        <dt>주문일시</dt><%--주문/취소 --%>
                                        <dd><fmt:formatDate value="${ordrDtl.ordrDt}" pattern="yyyy.MM.dd HH:mm:ss" /></dd>
                                    </dl>
                                </div>
                            </div>
                            <!-- <button type="button" class="f_all_rtrcn">전체취소</button> -->
                        </div>
                        <div class="order-body">
                        	<c:if test="${!empty ordrDtl.recipterUniqueId }">
							<%-- 베네핏 바이어 --%>
                            <div class="order-buyer">
                            	<c:if test="${ordrDtl.regUniqueId ne ordrDtl.recipterUniqueId}">
	                            	<c:if test="${!empty ordrDtl.recipterInfo.proflImg}">
		                            <img src="/comm/proflImg?fileName=${ordrDtl.recipterInfo.proflImg}" alt="">
		                            </c:if>
                                	<strong>${ordrDtl.recipterInfo.mbrNm}</strong>
                                </c:if>
                            </div>
                            </c:if>
					</c:if>
					<%-- 통합 주문 번호 --%>


                            <div class="order-item order-item-mypage">
                                <div class="order-item-thumb">
                                    <c:choose>
										<c:when test="${!empty ordrDtl.gdsInfo.thumbnailFile }">
									<a href="${_marketPath}/gds/${ordrDtl.gdsInfo.ctgryNo}/${ordrDtl.gdsInfo.gdsCd}"><img src="/comm/getImage?srvcId=GDS&amp;upNo=${ordrDtl.gdsInfo.thumbnailFile.upNo }&amp;fileTy=${ordrDtl.gdsInfo.thumbnailFile.fileTy }&amp;fileNo=${ordrDtl.gdsInfo.thumbnailFile.fileNo }&amp;thumbYn=Y" alt=""></a>
										</c:when>
										<c:otherwise>
									<img src="/html/page/market/assets/images/noimg.jpg" alt="">
										</c:otherwise>
									</c:choose>
                                </div>
                                <div class="order-item-content">
                                    <div class="flex items-start w-full">
                                        <div class="order-item-group">
                                        <div class="order-item-base">
                                            <p class="code">
                                                <span class="label-primary">
                                                    <span>${gdsTyCode[ordrDtl.gdsInfo.gdsTy]}</span>
                                                    <i></i>
                                                </span>
                                                <u>${ordrDtl.gdsInfo.gdsCd }</u>
                                            </p>
                                            <div class="product">
                                                <p class="name">${ordrDtl.gdsInfo.gdsNm }</p>
                                                <c:if test="${!empty spOrdrOptn[0]}">
                                                <dl class="option">
                                                    <%-- <dt>옵션</dt> --%>
                                                    <dd>
                                                        <c:forEach items="${spOrdrOptn}" var="ordrOptn">
		                                                <span class="label-flat">${ordrOptn}</span>
		                                                </c:forEach>
                                                    </dd>
                                                </dl>
                                                </c:if>
                                            </div>
                                        </div>
                                    
                    </c:if>
					<c:if test="${ordrDtl.ordrOptnTy eq 'ADIT'}">

					<c:set var="sumOrdrPc" value="${sumOrdrPc + ordrDtl.ordrPc}" />
					<c:set var="totalGdsPc" value="${totalGdsPc + (ordrDtl.ordrOptnPc * ordrDtl.ordrQy) }" />
                                        <div class="order-item-add">
                                            <span class="label-outline-primary">
                                                <span>${spOrdrOptn[0]}</span>
                                                <i><img src="/html/page/market/assets/images/ico-plus-white.svg" alt=""></i>
                                            </span>
                                            <div class="name">
                                                <p><strong>${spOrdrOptn[1]}</strong></p>
	                                            <p>수량 ${ordrDtl.ordrQy}개 (+<fmt:formatNumber value="${ordrDtl.ordrPc}" pattern="###,###" />원)</p>
                                            </div>
                                        </div>
					</c:if>

					<c:if test="${listVO.listObject[status.index+1].ordrOptnTy eq 'BASE' || status.last}">
                                    </div>
                                    <div class="order-item-count">
                                        <p><strong>${ordrQy}</strong>개</p>
                                        <%-- 배송 준비전 --%>
                                        <%--
                                        <c:if test="${ordrDtl.sttsTy eq 'OR01' || ordrDtl.sttsTy eq 'OR04'}">
                                        <button type="button" class="btn btn-primary btn-small f_optn_chg" data-gds-no="${ordrDtl.gdsNo}" data-dtl-no="${ordrDtl.ordrDtlNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}">변경</button>
                                        </c:if>
                                         --%>
                                    </div>
                                    <p class="order-item-price"><span class="text-primary"><fmt:formatNumber value="${totalGdsPc}" pattern="###,###" />원</span></p>
                                </div>    
                                    <div class="order-item-info">
                                        <%-- 이전배송비 백업 --%>
                                        <%-- <div class="payment">
                                            <dl>
                                                <dt>배송비</dt>
                                                <dd>
                                                	<c:if test="${ordrDtl.gdsInfo.dlvyCtTy eq 'FREE'}">
                                                	무료배송
                                                	</c:if>
                                                	<c:if test="${ordrDtl.gdsInfo.dlvyCtTy ne 'FREE'}">
                                                	<fmt:formatNumber value="${ordrDtl.gdsInfo.dlvyBassAmt}" pattern="###,###" />원
                                                	</c:if>
                                                </dd>
                                            </dl>
                                            <!-- <c:if test="${ordrDtl.gdsInfo.dlvyAditAmt > 0}">
                                            <dl>
                                                <dt>추가 배송비</dt>
                                                <dd><fmt:formatNumber value="${ordrDtl.gdsInfo.dlvyAditAmt}" pattern="###,###" />원</dd>
                                            </dl>
                                            </c:if> -->
                                        </div> --%>
                                        <div class="status">
                                       	<%-- TO-DO : 주문상태에 따라 다름 --%>
                                       	<c:choose>
											<c:when test="${ordrDtl.sttsTy eq 'OR02'}"> <%-- 멤버스 승인완료 --%>
                                       		<div class="box-gradient">
                                                <div class="content">
                                                    <p class="flex-1">멤버스<br> 승인완료</p>
                                                    <div class="multibtn">
                                                        <a href="./view/${ordrDtl.ordrCd}?${pageParam}" class="btn btn-primary btn-small">결제진행</a>
                                                        <%-- <button type="button" class="btn btn-outline-primary btn-small f_ordr_rtrcn" data-ordr-cd="${ordrDtl.ordrCd}">주문취소</button> --%>
                                                    </div>
                                                </div>
                                            </div>
                                       		</c:when>
                                       		<c:when test="${ordrDtl.sttsTy eq 'OR03'}"> <%-- 멤버스 승인반려 --%>
                                       		<div class="box-gradient">
                                                <div class="content">
                                                    <p class="flex-1">멤버스<br> 승인반려</p>
                                                    <div class="multibtn">
                                                    	<button type="button" class="btn btn-primary btn-small f_partners_msg" data-ordr-no="${ordrDtl.ordrNo}" data-dtl-no="${ordrDtl.ordrDtlNo}">사유확인</button>
                                                    </div>
                                                </div>
                                            </div>
                                       		</c:when>
                                       		<c:when test="${ordrDtl.sttsTy eq 'OR04'}"> <%-- 결제대기 --%>
                                       		<div class="box-gray">
                                                <p class="flex-1">결제대기</p>
                                                <c:if test="${ordrTy eq 'R'}"><%-- 급여주문 --%>
                                                <div class="multibtn">
                                                    <a href="./view/${ordrDtl.ordrCd}?${pageParam}" class="btn btn-primary btn-small">결제진행</a>
                                                    <%-- <button type="button" class="btn btn-outline-primary btn-small f_ordr_rtrcn" data-ordr-cd="${ordrDtl.ordrCd}">주문취소</button> --%>
                                                </div>
                                                </c:if>
                                            </div>
                                       		</c:when>
                                       		<c:when test="${ordrDtl.sttsTy eq 'OR05'}"> <%-- 결제완료 --%>
                                       		<div class="box-gray">
                                                <p class="flex-1">결제완료</p>
                                                <%-- <div class="multibtn">
                                                    <button type="button" class="btn btn-outline-primary btn-small f_ordr_rtrcn" data-ordr-cd="${ordrDtl.ordrCd}">주문취소</button>
                                                </div> --%>
                                            </div>
                                       		</c:when>
                                       		<c:when test="${ordrDtl.sttsTy eq 'OR07'}"> <%-- 배송중 --%>
                                            <dl>
                                                <dt>배송중</dt>
                                                <dd><fmt:formatDate value="${ordrDtl.sndngDt}" pattern="yyyy-MM-dd" /></dd>
                                            </dl>

											<c:set var="dlvyUrl" value="#" />
                                            <c:forEach items="${dlvyCoList}" var="dlvyCoInfo">
                                            	<c:if test="${dlvyCoInfo.coNo eq ordrDtl.dlvyCoNo}">
                                            	<c:set var="dlvyUrl" value="${dlvyCoInfo.dlvyUrl}" />
                                            	</c:if>
                                            </c:forEach>

                                            <a href="${dlvyUrl}${ordrDtl.dlvyInvcNo}" target="_blank" class="btn btn-delivery">
                                                <span class="name">
                                                    <img src="/html/page/market/assets/images/ico-delivery.svg" alt="">
                                                    ${ordrDtl.dlvyCoNm}
                                                </span>
                                                <span class="underline">${ordrDtl.dlvyInvcNo}</span>
                                            </a>
                                       		</c:when>
                                       		<c:when test="${ordrDtl.sttsTy eq 'OR08'}"> <%-- 배송완료 --%>
                                       		<div class="box-gray">
                                                <p class="flex-1">배송완료</p>
                                                <div class="multibtn">
                                                	<button type="button" class="btn btn-primary btn-small f_ordr_done" data-ordr-no="${ordrDtl.ordrNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}" data-stts-ty="OR09" data-resn-ty="", data-resn="상품 구매확정" data-msg="마일리지가 적립됩니다.구매확정 처리하시겠습니까?">구매확정</button>
                                                    <button type="button" class="btn btn-outline-primary btn-small f_gds_exchng" data-dtl-cd="${ordrDtl.ordrDtlCd}" data-ordr-no="${ordrDtl.ordrNo}" >교환신청</button>
                                                </div>
                                            </div>
                                       		</c:when>
                                       		<c:when test="${ordrDtl.sttsTy eq 'CA01' || ordrDtl.sttsTy eq 'CA02'}"> <%-- 취소접수 & 취소완료 --%>
                                       		<div class="box-gray">
                                                <p class="flex-1">${ordrSttsCode[ordrDtl.sttsTy]}</p>
                                                <div class="multibtn">
                                                	<button type="button" class="btn btn-primary btn-small f_rtrcn_msg" data-ordr-no="${ordrDtl.ordrNo}" data-dtl-no="${ordrDtl.ordrDtlNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}">취소 상세정보</button>
                                                </div>
                                            </div>
                                       		</c:when>
                                       		<c:when test="${ordrDtl.sttsTy eq 'EX01' || ordrDtl.sttsTy eq 'EX02' || ordrDtl.sttsTy eq 'EX03'}"> <%-- 교환 --%>
                                       		<div class="box-gray">
                                                <p class="flex-1">${ordrSttsCode[ordrDtl.sttsTy]}</p>
                                                <div class="multibtn">
                                                	<button type="button" class="btn btn-primary btn-small f_exchng_msg" data-ordr-no="${ordrDtl.ordrNo}" data-dtl-no="${ordrDtl.ordrDtlNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}">교환 상세정보</button>
                                                </div>
                                            </div>
                                       		</c:when>
                                       		<c:when test="${ordrDtl.sttsTy eq 'RE01' || ordrDtl.sttsTy eq 'RE02' || ordrDtl.sttsTy eq 'RE03'}"> <%-- 반품 --%>
                                       		<div class="box-gray">
                                                <p class="flex-1">${ordrSttsCode[ordrDtl.sttsTy]}</p>
                                                <div class="multibtn">
                                                	<button type="button" class="btn btn-primary btn-small f_return_msg" data-ordr-no="${ordrDtl.ordrNo}" data-dtl-no="${ordrDtl.ordrDtlNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}">반품 상세정보</button>
                                                </div>
                                            </div>
                                       		</c:when>
                                       		<c:otherwise>
                                       		<div class="box-gray">
                                                <p class="flex-1">${ordrSttsCode[ordrDtl.sttsTy]}</p>
                                            </div>
                                       		</c:otherwise>
                                       	</c:choose>
                                        </div>
                                    </div>
                                </div>
                                
                            </div>

                            <!--20231227:배송비 이동 : 기획안 확인해야 함 -->
                            <div class="payment">
                                <dl class="order-item-payment">
                                    <dd>배송비</dd>
                                    <dt class="delivery-charge">
                                        <c:if test="${ordrDtl.gdsInfo.dlvyCtTy eq 'FREE'}">
                                        무료배송
                                        </c:if>
                                        <c:if test="${ordrDtl.gdsInfo.dlvyCtTy ne 'FREE'}">
                                        <fmt:formatNumber value="${ordrDtl.gdsInfo.dlvyBassAmt}" pattern="###,###" />원
                                        </c:if>
                                    </dt>
                                </dl>
                            </div>


                    <%-- 통합 주문 번호 --%>
					<c:if test="${status.last || (ordrDtl.ordrCd ne listVO.listObject[status.index+1].ordrCd )}">
                        </div>

						<c:set var="ordrCancelBtn" value="false" />
						<c:if test="${ordrDtl.cancelBtn > 0}">
						<c:set var="ordrCancelBtn" value="true" />
						</c:if>
                        <c:if test="${(ordrCancelBtn || ordrDtl.returnBtn > 0)}">
                        <div class="order-footer">
                        	<c:if test="${ordrCancelBtn}">
                        	<button type="button" class="btn btn-outline-primary btn-small f_ordr_rtrcn" data-ordr-cd="${ordrDtl.ordrCd}">주문취소</button>
                        	</c:if>
                        	<c:if test="${ordrDtl.returnBtn > 0}">
                            <button type="button" class="btn btn-outline-primary btn-small f_ordr_return" data-ordr-cd="${ordrDtl.ordrCd}">반품신청</button>
                            </c:if>
                        </div>
                        </c:if>

                    </div>
                    </c:if>
                    <c:if test="${!status.last && ordrDtl.ordrCd ne listVO.listObject[status.index+1].ordrCd}">

                    <div class="order-product order-product-mypage">
                        <div class="order-header">
                            <div class="flex flex-col w-full gap-3">
                                <!--2023-12-27:사업소명-->
                                <dl class="order-item-business">
                                    <dt><span>사업소</span> <span>행복한 시니어</span></dt>
                                </dl>
								<c:if test="${listVO.listObject[status.index+1].ordrTy eq 'R' || listVO.listObject[status.index+1].ordrTy eq 'L'}">
									<%-- 급여구매일 경우만 경우만 멤버스(사업소) 있음 --%>
									<c:if test="${!empty listVO.listObject[status.index+1].bplcInfo}">
										<dl class="large">
											<dt>멤버스</dt>
											<dd>${listVO.listObject[status.index+1].bplcInfo.bplcNm}</dd>
										</dl>
									</c:if>
								</c:if>
                            <div class="flex items-center w-full">
								<dl>
                                    <dt>주문번호</dt>
                                    <dd><strong><a href="./view/${listVO.listObject[status.index+1].ordrCd}?${pageParam}">${listVO.listObject[status.index+1].ordrCd}</a></strong></dd>
                                </dl>
                                <dl>
                                    <dt>주문일시</dt><%--주문/취소 --%>
                                    <dd><fmt:formatDate value="${listVO.listObject[status.index+1].ordrDt}" pattern="yyyy.MM.dd HH:mm:ss" /><br></dd>
                                </dl>
                            </div>
                        </div>
                            <!-- <button type="button" class="f_all_rtrcn">전체취소</button> -->
                        </div>
                        <div class="order-body">
                        	<c:if test="${!empty listVO.listObject[status.index+1].recipterUniqueId }">
                        	<%-- 베네핏 바이어 --%>
                            <div class="order-buyer">
                            	<c:if test="${listVO.listObject[status.index+1].regUniqueId ne listVO.listObject[status.index+1].recipterUniqueId }">
	                                <c:if test="${!empty listVO.listObject[status.index+1].recipterInfo.proflImg}">
		                            <img src="/comm/proflImg?fileName=${listVO.listObject[status.index+1].recipterInfo.proflImg}" alt="">
		                            </c:if>
                                	<strong>${listVO.listObject[status.index+1].recipterInfo.mbrNm}</strong>
                                </c:if>
                            </div>
                            </c:if>
					</c:if>
                    <%-- 통합 주문 번호 --%>
                    </c:if>
					</c:forEach>

                </div>

                <div class="pagination">
                    <front:paging listVO="${listVO}" />
                </div>
                <!-- //목록 -->

                <!-- 주의사항 -->
                <ul class="mt-10 md:mt-12 space-y-1 md:space-y-1.5">
                    <li class="text-alert">최근 6개월 간 이로움ON 마켓에서 주문하신 내역 입니다.</li>
                    <li class="text-alert">[주문번호]를 클릭하시면 주문상세내역 및 배송조회를 확인할 수 있습니다.</li>
                    <li class="text-alert">주문취소/반품접수/교환접수는 주문상세정보 페이지에서 이용하실 수 있습니다.</li>
                </ul>
                <!-- //주의사항 -->

                <!-- 주문/배송 안내 -->
                <p class="text-lg font-bold mt-18 md:mt-25 md:text-xl">주문/배송 안내</p>
                <div class="order-delivery-sequence">
                    <div class="sequence-container">
                    	<c:if test="${_mbrSession.recipterYn eq 'Y'}">
                        <dl class="seq1">
                            <dt>
                                멤버스<br>
                                <strong>승인대기</strong>
                            </dt>
                            <dd>상품주문 후 주문한 멤버스에서 주문자 정보 및 계약서 확인을 진행합니다.</dd>
                        </dl>
                        <dl class="seq2">
                            <dt>
                                멤버스<br>
                                <strong>승인완료/반려</strong>
                            </dt>
                            <dd>주문자 정보 및 계약서가 정상적으로 확인 완료 또는 반려 되었습니다.</dd>
                        </dl>
                        </c:if>

                        <dl class="seq3">
                            <dt>결제<strong>대기</strong></dt>
                            <dd>입금및 결제가 아직 이뤄지지 않은 단계이며, 3일 이내 미 결제시 자동 주문 취소됩니다.</dd>
                        </dl>
                        <dl class="seq4">
                            <dt>결제<strong>완료</strong></dt>
                            <dd>카드결제 및 입금확인이 완료되었습니다.</dd>
                        </dl>
                        <div class="desc is-gradient"><p>주문취소 / 옵션변경 / 배송지 변경 가능</p></div>
                    </div>
                    <div class="sequence-container">
                        <dl class="seq5">
                            <dt>배송<strong>준비중</strong></dt>
                            <dd>고객님께 발송할 상품을 준비하고 있습니다.</dd>
                        </dl>
                        <dl class="seq6">
                            <dt>
                                상품<strong>준비완료</strong><br>
                                <strong>배송중</strong>
                            </dt>
                            <dd>택배사로 상품이 전달되어 배송이 시작되어 보통 1~2일 이내 도착합니다.</dd>
                        </dl>
                        <div class="desc"><p>주문취소 / 옵션변경 / 배송지 변경 <strong class="text-danger">불가능</strong></p></div>
                    </div>
                    <div class="sequence-container">
                        <dl class="seq7">
                            <dt><strong>배송완료</strong></dt>
                            <dd>
                                고객님께 상품이 배송되었습니다.<br>
                                배송완료 7일 후 자동으로 구매확정 처리됩니다.
                            </dd>
                        </dl>
                        <div class="desc"><p>교환/반품 가능</p></div>
                    </div>
                </div>
                <!-- //주문/배송 안내 -->


                <%-- 취소 --%><%--
                <!-- 주의사항 -->
 				<ul class="mt-10 md:mt-12 space-y-1 md:space-y-1.5">
                    <li class="text-alert">최근 6개월 간 이로움ON 마켓에서 취소하신 내역 입니다.</li>
                    <li class="text-alert">
                        주문취소는 주문상세에서 가능합니다.<br>
                        배송준비중일 경우에는 <a href="${_marketPath}/etc/faq/list" class="font-bold underline">고객센터</a> 또는 <a href="${_marketPath}/etc/inqry/form" class="font-bold underline">1:1문의</a>를 통해 취소가 가능하며, 출고여부를 확인후에 취소여부를 안내해 드립니다.
                    </li>
                    <li class="text-alert">주문취소를 하시면 전체주문이 즉시 취소되며, 주문상품 중 일부만 취소하실 경우 주문취소 후 재주문 하시기 바랍니다.</li>
                    <li class="text-alert">이미 출고된 상품이 있는 경우 주문을 취소할 수 없습니다. 반품 메뉴를 이용하시기 바랍니다.</li>
                </ul>
                <!-- //주의사항 --> --%>

				<p class="text-lg font-bold mt-16 md:mt-21 md:text-xl">주문취소 안내</p>
                <table class="table-detail">
                    <colgroup>
                        <col class="w-30 md:w-40">
                        <col >
                    </colgroup>
                    <tbody>
                        <tr class="top-border">
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <th scope="row"><p>취소 가능</p></th>
                            <td>
                                <div class="p-2 leading-relaxed space-y-1.5">
                                    <p><strong>승인대기(급여상품일 경우)</strong> : 주문취소가 가능합니다.</p>
                                    <p><strong>승인완료/반려(급여상품일 경우)</strong> : 주문취소가 가능합니다.</p>
                                    <p><strong>입금대기</strong> : 주문취소가 가능합니다.</p>
                                    <p><strong>결제완료</strong> : 주문취소가 가능합니다. 결제수단별 환불안내를 확인해주시기 바랍니다.</p>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><p>취소 불가</p></th>
                            <td>
                                <div class="p-2 leading-relaxed space-y-1.5">
                                    <p>
                                        <strong>배송준비중</strong>: 배송을 위하여 주문정보가 전달되어 주문취소가 불가능합니다.<br>
                                        <a href="${_marketPath}/etc/faq/list" class="font-bold underline">고객센터</a> 또는 <a href="${_marketPath}/etc/inqry/form" class="font-bold underline">1:1문의</a>를 통해 취소가 가능하며, 출고여부를 확인후에 취소여부를 안내해 드립니다.
                                    </p>
                                    <p><strong>배송중</strong> : 택배사가 배송을 시작하여 주문취소가 불가능합니다.</p>
                                    <p><strong>배송완료</strong> : 배송이 완료된 상태이므로 반품 메뉴를 이용하시기 바랍니다.</p>
                                </div>
                            </td>
                        </tr>
                        <tr class="bot-border">
                            <td></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>

                <p class="text-lg font-bold mt-24 md:mt-32 md:text-xl">결제수단별 환불안내</p>
                <table class="table-detail">
                    <colgroup>
                        <col class="w-30 md:w-40">
                        <col >
                    </colgroup>
                    <tbody>
                        <tr class="top-border">
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <th scope="row"><p>신용카드</p></th>
                            <td>
                                <div class="p-2 leading-relaxed space-y-1.5">
                                    <p><strong>승인취소</strong> : 신용카드 승인취소는 매입(카드사로 결제정보가 넘어가기 전)인 경우에는 취소 승인한 당일 취소됩니다.</p>
                                    <p>
                                        <strong>매입취소</strong> : 카드사로 결제정보가 넘어간 후에는 카드사에서 취소처리를 하는데 1~2주 정도 소요 됩니다.<br>
                                        (카드사별 취소 반영이 차이가 있습니다. 각 카드사 홈페이지에서 확인 가능합니다.)
                                    </p>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><p>실시간 계좌이체</p></th>
                            <td>
                                <div class="p-2 leading-relaxed space-y-1.5">
                                    <p>취소신청 완료 후 익일에 실시간 계좌이체가 진행된 고객님의 계좌로 직접 환불됩니다.</p>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><p>무통장 입금</p></th>
                            <td>
                                <div class="p-2 leading-relaxed space-y-1.5">고객님의 취소신청 시 입력된 환불계좌로 2~3일 이내 환불됩니다.</div>
                            </td>
                        </tr>
                        <tr class="bot-border">
                            <td></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>


                <%-- 교환 --%>
                <%--
                <ul class="mt-10 md:mt-12 space-y-1 md:space-y-1.5">
                    <li class="text-alert">최근 6개월 간 교환 내역 입니다.</li>
                    <li class="text-alert">교환신청은 배송완료 이후에 주문상세 에서 가능하며, 배송중일 경우에는 <a href="${_marketPath}/etc/faq/list" class="font-bold underline">고객센터</a> 또는 <a href="${_marketPath}/etc/inqry/form" class="font-bold underline">1:1문의</a>를 통해 교환여부를 안내해 드립니다.</li>
                    <li class="text-alert">교환은 상품별로 신청가능하며, 이미 출고된 상품이 있는 경우 교환신청이 불가능하며, 반품메뉴를 이용하시기 바랍니다.</li>
                </ul> --%>

                <p class="text-lg font-bold mt-16 md:mt-21 md:text-xl">교환 절차 안내</p>
                <ol class="payment-sequence mt-4 lg:mt-5">
                    <li class="seq1">
                        <dl>
                            <dt>교환<strong>신청</strong></dt>
                        </dl>
                    </li>
                    <li class="seq2">
                        <dl>
                            <dt>교환<strong>접수승인</strong></dt>
                            <dd>교환신청이 정상적으로 접수되었습니다.</dd>
                        </dl>
                    </li>
                    <li class="seq3">
                        <dl>
                            <dt>교환<strong>진행중</strong></dt>
                            <dd>상품이 회수 중이거나 상품을 확인 중입니다.</dd>
                        </dl>
                    </li>
                    <li class="seq4">
                        <dl>
                            <dt>교환<strong>완료</strong></dt>
                            <dd>상품회수가 정상적으로 처리되어 새로운 상품을 발송하였습니다.</dd>
                        </dl>
                    </li>
                </ol>

                <p class="text-alert mt-3 md:mt-4">교환 배송비는 상품하자나 불량으로 귀책사유가 당사에 있을 경우를 제외하고 고객변심일 경우 고객님께서 부담하셔야 합니다.</p>
                <dl class="text-alert is-danger mt-4 md:mt-5">
                    <dt><strong>교환이 불가능한 경우</strong></dt>
                    <dd class="text-black2 mt-1.5">
                        <ul class="list-normal">
                            <li>제품이 사용되었거나 훼손된 경우</li>
                            <li>제품에 부착되어 있는 상품 택(TAG)을 제거 또는 상품 개봉으로 상품 가치가 훼손된 경우</li>
                            <li>상품설명에 기재한 사용시 주의사항을 지키지 않은 경우</li>
                        </ul>
                    </dd>
                </dl>

                <%-- 반품 --%>
                <%--
                <ul class="mt-10 md:mt-12 space-y-1 md:space-y-1.5">
                    <li class="text-alert">최근 6개월 간 반품 내역 입니다.</li>
                    <li class="text-alert">반품신청은 배송완료 이후에 주문상세 에서 가능하며, 배송중일 경우에는 <a href="${_marketPath}/etc/faq/list" class="font-bold underline">고객센터</a> 또는 <a href="${_marketPath}/etc/inqry/form" class="font-bold underline">1:1문의</a>를 통해 반품여부를 안내해 드립니다.</li>
                    <li class="text-alert">주문 상품 중 일부만 반품할 경우에는 배송상태에 따라 재결제가 필요한 경우가 존재하며, 재결제를 완료해야 나머지 상품에 대해 반품이 완료됩니다.</li>
                </ul>
 --%>
                <p class="text-lg font-bold mt-16 md:mt-21 md:text-xl">반품 절차 안내</p>
                <ol class="payment-sequence mt-4 lg:mt-5">
                    <li class="seq1">
                        <dl>
                            <dt>반품<strong>신청</strong></dt>
                        </dl>
                    </li>
                    <li class="seq2">
                        <dl>
                            <dt>반품<strong>접수승인</strong></dt>
                            <dd>반품신청이 정상적으로 접수되었습니다.</dd>
                        </dl>
                    </li>
                    <li class="seq5">
                        <dl>
                            <dt>반품<strong>진행중</strong></dt>
                            <dd>상품이 회수 중이거나 상품을 확인 중입니다.</dd>
                        </dl>
                    </li>
                    <li class="seq6">
                        <dl>
                            <dt>반품<strong>완료</strong></dt>
                            <dd>반품된 상품확인 후 결제취소 또는 환불을 해드립니다.</dd>
                        </dl>
                    </li>
                </ol>

                <p class="text-alert mt-3 md:mt-4">반품 배송비는 상품하자나 불량으로 귀책사유가 당사에 있을 경우를 제외하고 고객변심일 경우 고객님께서 부담하셔야 합니다.</p>
                <dl class="text-alert is-danger mt-4 md:mt-5">
                    <dt><strong>반품이 불가능한 경우</strong></dt>
                    <dd class="text-black2 mt-1.5">
                        <ul class="list-normal">
                            <li>제품이 사용되었거나 훼손된 경우(단, 내용 확인을 위한 포장 개봉의 경우는 예외)</li>
                            <li>제품에 부착되어있는 상품 택(TAG)을 제거 또는 상품 개봉으로 상품 가치가 훼손된 경우</li>
                            <li>상품설명에 기재한 사용시 주의사항을 지키지 않은 경우</li>
                            <li>환불은 현금 결제일 경우 제품 회수 확인 후 3일 이내에 환불처리됩니다.</li>
                        </ul>
                    </dd>
                </dl>

            </div>
        </div>

        <!-- 주문취소 -->
        <div id="ordr-rtrcn"></div>
        <!-- 멤버스 반려 -->
        <div id="ordr-partners-msg"></div>
        <!-- 교환신청 -->
        <div id="ordr-exchng"></div>
        <!-- 반품신청 -->
        <div id="ordr-return"></div>
        <!-- 수량변경 -->
        <div id="ordr-optn-chg"></div>
        <!-- 취소/교환/반품 사유 -->
        <div id="ordr-rtrcn-msg"></div>
        <div id="ordr-exchng-msg"></div>
        <div id="ordr-return-msg"></div>

    </main>



    <script>
    	$(function(){

    		$("input[name='selPeriod']").on("click, change", function(){
    			//console.log("v", $(this).val());
    			const v = $(this).val();
    			$("#srchOrdrYmdEnd").val(f_getToday());
    			if(v == "1"){//5년
            		$("#srchOrdrYmdBgng").val(f_getDate(-365 * 5));
            	}else if(v == "2"){//1개월
            		$("#srchOrdrYmdBgng").val(f_getDate(-30));
            	}else if(v == "3"){//3개월
            		$("#srchOrdrYmdBgng").val(f_getDate(-30 * 3));
            	}else if(v== "4"){//6개월
               		$("#srchOrdrYmdBgng").val(f_getDate(-30 * 6));
            	}
    		});


    		$("#srchOrdrYmdBgng, #srchOrdrYmdEnd").on("click", function(){
    			$("input[name='selPeriod']").prop("checked", false);
    		});

    		// 주문취소 모달
    		$(document).on("click", ".f_ordr_rtrcn", function(){
    			const ordrCd = $(this).data("ordrCd");
        		$("#ordr-rtrcn").load("${_marketPath}/mypage/ordr/ordrRtrcn",
       				{ordrCd:ordrCd
        			}, function(){
            			$("#ordr-rtrcn-modal").modal('show');
        			});
        	});

    		//옵션변경 모달
        	$(document).on("click", ".f_optn_chg", function(){
        		const gdsNo = $(this).data("gdsNo");
        		const ordrDtlNo = $(this).data("dtlNo");
        		const ordrDtlCd = $(this).data("dtlCd");
        		$("#ordr-optn-chg").load("${_marketPath}/mypage/ordr/optnChg",
       				{ordrDtlNo:ordrDtlNo
            			, gdsNo:gdsNo
            			, ordrDtlCd:ordrDtlCd
        			}, function(){
            			$("#optn-chg-modal").modal('show');
        			});
        	});

        	// 구매확정 처리
			$(".f_ordr_done").on("click", function(e){
				e.preventDefault();
				var ordrNo = $(this).data("ordrNo");
				var dtlCd = $(this).data("dtlCd");
				var msg = $(this).data("msg");
				var resn = $(this).data("resn");

				if(confirm("구매확정 처리하시겠습니까?")){
					$.ajax({
	       				type : "post",
	       				url  : "${_marketPath}/mypage/ordr/ordrDone.json",
	       				data : {
	       					ordrNo:ordrNo
	       					, ordrDtlCd:dtlCd
	       					, resn:resn
	       				},
	       				dataType : 'json'
	       			})
	       			.done(function(data) {
	       				if(data.result){
	       					console.log("상태변경 : success");
	       					location.reload();
	       				}
	       			})
	       			.fail(function(data, status, err) {
	       				console.log('상태변경 : error forward : ' + data);
	       			});
				}
			});

    		// 교환신청
    		$(document).on("click", ".f_gds_exchng", function(){
    			const ordrNo = $(this).data("ordrNo");
        		const ordrDtlCd = $(this).data("dtlCd");
        		$("#ordr-exchng").load("${_marketPath}/mypage/ordr/ordrExchng",
        			{ordrNo:ordrNo, ordrDtlCd:ordrDtlCd
        			}, function(){
            			$("#ordr-exchng-modal").modal('show');
        			});
        	});

    		// 반품신청
    		$(document).on("click", ".f_ordr_return", function(){
    			const ordrCd = $(this).data("ordrCd");
        		$("#ordr-return").load("${_marketPath}/mypage/ordr/ordrReturn",
       				{ordrCd:ordrCd
        			}, function(){
            			$("#ordr-return-modal").modal('show');
        			});
        	});


    		// 승인반려 메세지
    		$(document).on("click", ".f_partners_msg", function(){
    			const ordrNo = $(this).data("ordrNo");
        		const ordrDtlNo = $(this).data("dtlNo");
        		$("#ordr-partners-msg").load("${_marketPath}/mypage/ordr/partnersMsg",
        			{ordrNo:ordrNo, ordrDtlNo:ordrDtlNo
        			}, function(){
            			$("#partners-msg").modal('show');
        			});
        	});

    		// 취소사유 메세지
    		$(document).on("click", ".f_rtrcn_msg", function(){
    			const ordrNo = $(this).data("ordrNo");
        		const ordrDtlNo = $(this).data("dtlNo");
        		const ordrDtlCd = $(this).data("dtlCd");
        		$("#ordr-rtrcn-msg").load("${_marketPath}/mypage/ordr/rtrcnMsg",
        			{ordrNo:ordrNo, ordrDtlNo:ordrDtlNo, ordrDtlCd:ordrDtlCd
        			}, function(){
            			$("#rtrcn-msg").modal('show');
        			});
        	});

    		// 교환사유 메세지
    		$(document).on("click", ".f_exchng_msg", function(){
    			const ordrNo = $(this).data("ordrNo");
        		const ordrDtlNo = $(this).data("dtlNo");
        		const ordrDtlCd = $(this).data("dtlCd");
        		$("#ordr-exchng-msg").load("${_marketPath}/mypage/ordr/exchngMsg",
        			{ordrNo:ordrNo, ordrDtlNo:ordrDtlNo, ordrDtlCd:ordrDtlCd
        			}, function(){
            			$("#exchng-msg").modal('show');
        			});
        	});

    		// 반품 메세지
    		$(document).on("click", ".f_return_msg", function(){
    			const ordrNo = $(this).data("ordrNo");
        		const ordrDtlNo = $(this).data("dtlNo");
        		const ordrDtlCd = $(this).data("dtlCd");
        		$("#ordr-return-msg").load("${_marketPath}/mypage/ordr/returnMsg",
        			{ordrNo:ordrNo, ordrDtlNo:ordrDtlNo, ordrDtlCd:ordrDtlCd
        			}, function(){
            			$("#return-msg").modal('show');
        			});
        	});

        	$("form[name='searchFrm']").validate({
        	    ignore: "input[type='text']:hidden, [contenteditable='true']:not([name])",
        	    submitHandler: function (frm) {
        	    	if($("#srchOrdrYmdBgng").val() > $("#srchOrdrYmdEnd").val()){
        	    		alert("기간을 확인해주세요");
        	    		return false;
        	    	}else{
        	    		frm.submit();
        	    	}
        	    }
        	});
    	});
    </script>