<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container" class="is-product">

	<jsp:include page="../layout/page_header.jsp" />

	<div id="page-container">

		<jsp:include page="../layout/page_sidenav.jsp" />

		<div class="product-detail">
			<!-- 상품 내용 -->
			<div class="product-detail-content">
				<c:if test="${!empty gdsVO.imageFileList}">
					<!-- 상품 슬라이드 -->
					<div class="product-slider">

						<div class="swiper product-swiper">
							<div class="swiper-wrapper">
								<c:forEach var="fileList" items="${gdsVO.imageFileList }" varStatus="status">
									<div class="swiper-slide">
										<img src="/comm/getImage?srvcId=GDS&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo}" alt="">
									</div>
								</c:forEach>
								<c:if test="${!empty gdsVO.youtubeUrl}">
									<div class="swiper-slide">
										<iframe width="560" height="315" src="${gdsVO.youtubeUrl}" title="YouTube video player" frameborder="0" allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
									</div>
								</c:if>
							</div>
							<div class="swiper-button-next"></div>
							<div class="swiper-button-prev"></div>
						</div>

						<div class="swiper product-swiper-thumb">
							<div class="swiper-wrapper">
								<c:forEach var="fileList" items="${gdsVO.imageFileList }" varStatus="status">
									<div class="swiper-slide">
										<img src="/comm/getImage?srvcId=GDS&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo}" alt="">
									</div>
								</c:forEach>
								<c:if test="${!empty gdsVO.youtubeUrl}">
									<div class="swiper-slide is-video">
										<img src="https://img.youtube.com/vi/${gdsVO.youtubeImg}/0.jpg" alt="">
									</div>
								</c:if>
							</div>
						</div>
					</div>
					<!-- //상품 슬라이드  -->
				</c:if>

				<c:if test="${!empty gdsVO.gdsRelList}">
					<!-- 관련 상품 -->
					<div class="product-relgood">
						<div class="mb-3 md:mb-4 flex items-center text-lg space-x-2 md:text-xl">
							<strong>관련 상품</strong>
						</div>
						<div class="swiper product-swiper">
							<div class="swiper-wrapper">
								<%--관련상품 loop--%>
								<c:forEach items="${gdsVO.gdsRelList}" var="gdsRelList" varStatus="status">
									<c:if test="${gdsRelList.useYn eq 'Y' && gdsRelList.dspyYn eq 'Y'}">
									<div class="swiper-slide">
										<div class="product-item">
											<div class="item-thumb">
												<a href="${_marketPath}/gds/${gdsRelList.ctgryNo}/${gdsRelList.gdsCd}" class="item-content">
													<c:choose>
														<c:when test="${gdsRelList.fileNo > 0}">
															<img src="/comm/getImage?srvcId=GDS&amp;upNo=${gdsRelList.relGdsNo}&amp;fileTy=THUMB&amp;fileNo=${gdsRelList.fileNo}&amp;thumbYn=Y">
														</c:when>
														<c:otherwise>
															<img src="/html/page/market/assets/images/noimg.jpg" alt="">
														</c:otherwise>
													</c:choose>
												</a>

                                        	</div>
                                        <a href="${_marketPath}/gds/${gdsRelList.ctgryNo}/${gdsRelList.gdsCd}" class="item-content">
                                            <div class="name">
                                                <small>${gdsRelList.ctgryNm}</small>
                                                <strong>${gdsRelList.gdsNm}</strong>
                                            </div>
                                            <div class="cost">
                                            	<c:if test="${_mbrSession.loginCheck}">
                                            	<c:choose>
				                            		<c:when test="${gdsRelList.gdsTy eq 'R' || gdsRelList.gdsTy eq 'L'}"> <%--급여(판매)제품--%>
				                            	<dl class="discount">
				                                    <dt>급여가</dt>
				                                    <dd>
				                                    	<c:choose>
					                                 		<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 15 }">
					                                 	<fmt:formatNumber value="${gdsRelList.bnefPc15}" pattern="###,###" /><small>원</small>
					                                 		</c:when>
					                                 		<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 9 }">
					                                 	<fmt:formatNumber value="${gdsRelList.bnefPc9}" pattern="###,###" /><small>원</small>
					                                 		</c:when>
					                                 		<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 6 }">
					                                 	<fmt:formatNumber value="${gdsRelList.bnefPc6}" pattern="###,###" /><small>원</small>
					                                 		</c:when>
					                                 		<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 0 }">
					                                	0<small>원</small>
					                                 		</c:when>
					                                 	</c:choose>
				                                    </dd>
				                                </dl>
				                            		</c:when>
				                            		<%--급여(대여)제품--%>
				                            		<%--
				                            		<c:when test="${gdsRelList.gdsTy eq 'L'}">
												<dl class="discount">
				                                    <dt>대여가(월)</dt>
				                                    <dd>
				                                    	<fmt:formatNumber value="${gdsRelList.lendPc}" pattern="###,###" /><small>원</small>
				                                    </dd>
				                                </dl>
				                            		</c:when>
				                            		 --%>
				                            	</c:choose>
				                            	</c:if>
                                                <dl>
                                                    <dt>판매가</dt>
                                    				<dd><fmt:formatNumber value="${gdsRelList.pc}" pattern="###,###" /><small>원</small></dd>
                                                </dl>
                                                <c:if test="${gdsVO.dscntRt > 0}">
													<dl class="price2">
														<dt>할인가</dt>
														<dd>
															<em>${gdsVO.dscntRt}%</em>
															<strong><fmt:formatNumber value="${gdsVO.dscntPc}" pattern="###,###" /></strong> 원
														</dd>
													</dl>
												</c:if>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                                </c:if>
                                </c:forEach>
                            </div>
                            <div class="swiper-pagination"></div>
                        </div>
                        <button type="button" class="swiper-button-prev"><span class="sr-only">이전</span></button>
                        <button type="button" class="swiper-button-next"><span class="sr-only">다음</span></button>
                    </div>
                    <!-- //관련 상품 -->
                    </c:if>


               <!-- 가격 배너 -->
               <!--  <div class="my-12 my:mt-16"><img src="/html/page/market/assets/images/img-price-banner.jpg" alt=""></div> -->
               <!-- //가격 배너 -->

				<!-- 상세 탭 -->
				<div id="prod-tablist" class="product-tablist">
					<ul class="nav">
						<li><a class="nav-link active" href="#prod-tabcontent1">상세정보</a></li>
						<!-- <li><a class="nav-link" href="#prod-tabcontent2">상품후기 <span class="reviewCnt2">(0)</span></a></li> -->
						<li><a class="nav-link" href="#prod-tabcontent4">배송/교환/반품정보</a></li>
						<li><a class="nav-link" href="#prod-tabcontent3">상품문의 <span class="qaCnt">(0)</span></a></li>
					</ul>
				</div>
				<!-- //상세 탭 -->

				<!-- 상품 정보 -->
				<div id="prod-tabcontent1" class="product-iteminfo mt-10 md:mt-13">
					<div class="content">${gdsVO.gdsDc}</div>
					<button type="button" class="btn btn-primary btn-large">상품 상세 펼쳐보기</button>
					<p class="mt-8 mb-3 text-base font-bold md:mb-4 md:mt-12 md:text-lg">상품정보제공고시</p>

					<%-- 고시정보 script --%>
					<jsp:include page="/WEB-INF/jsp/common/ancmnt_items.jsp" />

					<table class="table-detail" id="ancmntTable">
						<colgroup>
							<col class="min-w-30 w-[30%]">
							<col>
						</colgroup>
						<tbody>
						</tbody>
					</table>

				</div>
				<!-- //상품 정보 -->

				   <!-- 상품 배송/교환/반품정보 -->
                    <div id="prod-tabcontent4" class="product-itemship mt-10 lg:mt-13">
                        <p class="mt-8 mb-3 text-base font-bold md:mb-4 md:mt-12 md:text-lg">배송</p>
                        <table class="table-detail">
                            <colgroup>
                                <col class="min-w-19 w-[16%]">
                                <col class="min-w-19 w-[14%]">
                                <col >
                            </colgroup>
                            <thead>
                                <tr class="top-border">
                                    <td colspan="2"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <th scope="col"><p class="!text-center !justify-center !py-2.5 md:!py-3.5">상품</p></th>
                                    <th scope="col"><p class="!text-center !justify-center !py-2.5 md:!py-3.5">배송비</p></th>
                                    <th scope="col"><p class="!text-center !justify-center !py-2.5 md:!py-3.5">내용</p></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th scope="row"><p>복지용구<br>(급여구매)</p></th>
                                    <th scope="row"><p>상품별 상이</p></th>
                                    <td rowspan="3">${gdsVO.dlvyDc}</td>
                                </tr>
                                <tr>
                                    <th scope="row"><p>복지용구<br>(일반구매)</p></th>
                                    <th scope="row"><p>상품별 상이</p></th>
                                </tr>
                                <tr>
                                    <th scope="row"><p>일반상품</p></th>
                                    <th scope="row"><p>상품별 상이</p></th>
                                </tr>
                                <tr class="bot-border">
                                    <td colspan="2"></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>

                        <p class="mt-8 mb-3 text-base font-bold md:mb-4 md:mt-12 md:text-lg">교환/반품 일반사항</p>
                        <table class="table-detail">
                            <colgroup>
                                <col class="min-w-19 w-[16%]">
                                <col class="min-w-19 w-[14%]">
                                <col >
                            </colgroup>
                            <tbody>
                                <tr class="top-border">
                                    <td colspan="2"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <th scope="row" colspan="2"><p>공통</p></th>
                                    <td>${gdsVO.dcCmmn}</td>
                                </tr>
                                <tr>
                                    <th scope="rowgroup" rowspan="2"><p>무료<br> 교환/반품</p></th>
                                    <th scope="row"><p>복지용구<br> (급여구매)</p></th>
                                    <td rowspan="2">${gdsVO.dcFreeSalary}</td>
                                </tr>
                                <tr>
                                    <th scope="row"><p>일반상품</p></th>
                                </tr>
                                <tr>
                                    <th scope="rowgroup" rowspan="3"><p>단순변심<br> 교환/반품</p></th>
                                    <th scope="row"><p>복지용구<br> (급여구매)</p></th>
                                    <td>
                                        ${gdsVO.dcPchrgSalary}
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><p>복지용구<br> (일반구매)</p></th>
                                    <td>
                                        ${gdsVO.dcPchrgSalaryGnrl}
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><p>일반상품</p></th>
                                    <td>
                                        ${gdsVO.dcPchrgGnrl}
                                    </td>
                                </tr>
                                <tr class="bot-border">
                                    <td colspan="2"></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- //상품 배송/교환/반품정보  -->

				<!-- 상품 후기 -->
				<!--  <div id="prod-tabcontent2" class="product-itemphoto mt-10 md:mt-13">
					<div class="article-guide">
						<div class="guide-left">
							<dl>
								<dt>
									<strong>상품만족도</strong>
									<p>
										상품후기 <span class="text-red3 reviewCnt">0</span>개 기준
									</p>
								</dt>
								<dd>
									<strong class="avrgDgstfn">0</strong>
								</dd>
							</dl>
						</div>
						<div class="guide-right">
							<dl>
								<dt>
									<p>상품후기 작성하고</p>
									<p class="text-right">포인트 적립하세요!</p>
								</dt>
								<dd>
									구매확정된 주문상품의 <strong>상품후기</strong>를 작성해주시면, <strong>포인트</strong>를 적립해 드립니다.
								</dd>
							</dl>
							<div class="guide-desc">
								<div class="desc1">
									<p>
										<strong>상품후기</strong> 작성시
									</p>
									<p>
										<img src="/html/page/market/assets/images/ico-mileage.svg" alt=""> 200 포인트 적립
									</p>
								</div>
								<div class="desc2">
									<p>
										<strong>포토후기</strong> 작성시
									</p>
									<p>
										<img src="/html/page/market/assets/images/ico-mileage.svg" alt=""> 500 포인트 적립
									</p>
								</div>
							</div>
						</div>
					</div>

					<div class="flex items-center mt-11 md:mt-14 font-bold">
						<p class="mr-4">
							총 <strong class="text-danger reviewCnt">0</strong>개의 상품후기
						</p>
						<img src="/html/page/market/assets/images/ico-image.svg" alt="" class="mr-1 h-[1em]">
						<p>
							<strong class="photoReviewCnt">0</strong> 개
						</p>
					</div>

					<%-- 포토후기 --%>
					<div id="gdsPhotoReview"></div>

					<%-- 일반후기 --%>
					<div id="gdsReview"></div>

				</div> -->
				<!-- //상품 후기 -->

				<!-- 상품 문의 -->
				<div id="prod-tabcontent3" class="product-itemrequest mt-10 md:mt-13">
					<div class="grid gap-x-5 grid-cols-2 gap-y-8 mt-5 mb-13 md:grid-cols-3 md:gap-y-10 xl:gap-y-12 xl:grid-cols-4">
	                    <div class="col-span-2 md:col-span-3 xl:col-span-4">
					        <div class="progress-loading is-static">
					            <div class="icon"><span></span><span></span><span></span></div>
								<p class="text">상품문의 데이터를 불러오는 중입니다.</p>
					        </div>
	                    </div>
					</div>
				</div>
				<!-- //상품 문의 -->

				<!-- 상품 교환정보 -->
				<!-- <div id="prod-tabcontent4" class="product-itemship mt-10 lg:mt-13"></div> -->
				<!-- //상품 교환정보 -->
			</div>
			<!-- //상품 내용 -->

			<!-- 상품 정보 -->
			<div class="product-detail-infomation">
				<!-- 상품 이름 -->
				<div class="product-subject">
					<div class="label">
						<c:forEach items="${gdsVO.gdsTag}" var="tag">
							<span class="${tag eq 'A'?'label-outline-danger':'label-outline-primary' }"> <span>${_gdsTagCode[tag]}</span><i></i>
							</span>
						</c:forEach>
					</div>
					<div class="name">
						<c:if test="${!empty gdsVO.brand}">
							<%--브랜드 : 추가정보 필요할 수 있음--%>
							<c:forEach items="${brandList}" var="brand" varStatus="status">
								<c:if test="${gdsVO.brand eq brand.brandNo}">
									<small>${brand.brandNm}</small>
								</c:if>
							</c:forEach>
						</c:if>
						<strong>${gdsVO.gdsNm}</strong>
					</div>

				</div>
				<!-- //상품 이름 -->

				<!-- 상품 재원 -->
				<div class="product-resource">
					<c:choose>
						<c:when test="${(gdsVO.gdsTy eq 'R' || gdsVO.gdsTy eq 'L') && _mbrSession.prtcrRecipterYn eq 'Y' }">
							<%--급여상품(판매)--%>
							<dl class="price1">
								<dt>판매가</dt>
								<dd>
									<strong <c:if test="${gdsVO.dscntRt > 0}">style="text-decoration : line-through"</c:if>><fmt:formatNumber value="${gdsVO.pc}" pattern="###,###" /></strong> 원
								</dd>
							</dl>
							<c:if test="${gdsVO.dscntRt > 0}">
								<dl class="price2">
									<dt>할인가</dt>
									<dd>
										<em>${gdsVO.dscntRt}%</em>
										<strong><fmt:formatNumber value="${gdsVO.dscntPc}" pattern="###,###" /></strong> 원
									</dd>
								</dl>
							</c:if>
							<%-- <dl class="price1">
								<dt>${gdsVO.gdsTy eq 'R'?'급여가':'대여가(월)'}</dt>
								<dd>
									<strong><fmt:formatNumber value="${gdsVO.bnefPc}" pattern="###,###" /></strong> 원<c:if test="${gdsVO.usePsbltyTrm > 0}"> / <strong>${gdsVO.usePsbltyTrm}</strong>년</c:if>
								</dd>
							</dl>
							<dl class="price2">
								<dt>본인부담금</dt>
								<dd>
									<em>${_mbrSession.prtcrRecipterInfo.selfBndRt }%</em>
									<c:choose>
										<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 15 }">
											<strong><fmt:formatNumber value="${gdsVO.bnefPc15}" pattern="###,###" /></strong>
										</c:when>
										<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 9 }">
											<strong><fmt:formatNumber value="${gdsVO.bnefPc9}" pattern="###,###" /></strong>
										</c:when>
										<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 6 }">
											<strong><fmt:formatNumber value="${gdsVO.bnefPc6}" pattern="###,###" /></strong>
										</c:when>
										<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 0 }">
											<strong>0</strong>
										</c:when>
									</c:choose>
									원 <button type="button" class="text-question mycost-trigger font-normal text-primary" data-bs-toggle="popover" data-bs-html="true" data-bs-placement="bottom" data-bs-content="- 수급자는 연 한도액 160만원 범위 안에서 제공받음<br>- 복지용구 구매시 공단부담금 + 본인부담금<br>- 연 한도액 초과 시 전액 본인부담<br><br>차상위 감경(9% 본인부담) : 보험료 순위 25% 초과 50%<br>차상위 감경(6% 본인부담) : 보험료 순위 25% 이하<br>기초생활수급자(본인부담금 없이 무료)<a href='#' class='close'>닫기</a>" data-bs-title="본인부담금이란?">본인부담금이란?</button>
								</dd>
							</dl> --%>
						</c:when>
						<%--급여상품(대여)--%>
						<%--
						<c:when test="${gdsVO.gdsTy eq 'L' && _mbrSession.prtcrRecipterYn eq 'Y' }">
							<dl class="price1">
								<dt>판매가</dt>
								<dd>
									<strong><fmt:formatNumber value="${gdsVO.pc}" pattern="###,###" /></strong> 원
								</dd>
							</dl>
							<dl class="price2">
								<dt>대여가(월기준)</dt>
								<dd>
									<strong><fmt:formatNumber value="${gdsVO.lendPc}" pattern="###,###" /></strong> 원
								</dd>
							</dl>
						</c:when>
						--%>
						<c:otherwise>
							<dl class="price2">
								<dt>
									<c:choose>
										<c:when test="${(gdsVO.gdsTy eq 'R' || gdsVO.gdsTy eq 'L')}">
											정가
										</c:when>
										<c:otherwise>
											판매가
										</c:otherwise>
									</c:choose>
								</dt>
								<dd <c:if test="${gdsVO.dscntRt > 0}">style="color : rgb(153 153 153/var(--tw-text-opacity));"</c:if>>
									<strong <c:if test="${gdsVO.dscntRt > 0}">style="text-decoration : line-through;"</c:if>><fmt:formatNumber value="${gdsVO.pc}" pattern="###,###" /></strong> 원
								</dd>
							</dl>
							<c:if test="${gdsVO.dscntRt > 0}">
								<dl class="price2">
									<dt>할인가</dt>
									<dd>
										<em>${gdsVO.dscntRt}%</em>
										<strong><fmt:formatNumber value="${gdsVO.dscntPc}" pattern="###,###" /></strong> 원
									</dd>
								</dl>
							</c:if>
						</c:otherwise>
					</c:choose>

					<dl class="border-top border-bottom">
						<dt>상품코드</dt>
						<dd class="text-lg">${gdsVO.gdsCd}</dd>
					</dl>
					<%-- <c:if test="${!empty gdsVO.bnefCd}">
					<dl>
						<dt>급여코드</dt>
						<dd class="text-lg">${gdsVO.bnefCd}</dd>
						<input type="hidden" id="bnefCd" name="bnefCd" value="${gdsVO.bnefCd}" />
					</dl>
					</c:if> --%>

					<c:if test="${!empty gdsVO.mtrqlt}">
					<dl>
						<dt>재질</dt>
						<dd>${gdsVO.mtrqlt}</dd>
					</dl>
					</c:if>
					<c:if test="${!empty gdsVO.wt}">
					<dl>
						<dt>중량</dt>
						<dd>${gdsVO.wt}</dd>
					</dl>
					</c:if>
					<c:if test="${!empty gdsVO.size}">
					<dl>
						<dt>사이즈</dt>
						<dd>${gdsVO.size}</dd>
					</dl>
					</c:if>
					<c:if test="${!empty gdsVO.stndrd}">
					<dl>
						<dt>규격</dt>
						<dd>${gdsVO.stndrd}</dd>
					</dl>
					</c:if>

					<!--
					<c:if test="${gdsVO.mlgPvsnYn eq 'Y'}"><%-- 마일리지 제공 상품 --%>
					<dl class="border-top border-bottom">
						<dt>마일리지</dt>
						<dd>
							<img src="/html/page/market/assets/images/ico-mileage.svg" alt="">
							<span class="mlg">
								<c:if test="${empty _mileagePercent }">
								0.1~0.5% 적립
								</c:if>
								<c:if test="${!empty _mileagePercent }">
								${_mileagePercent}% 적립
								<%-- <fmt:formatNumber value="${gdsVO.pc * (_mileagePercent/100)}" pattern="###,###" /> --%>
								</c:if>
							</span>
						</dd>
					</dl>
					</c:if>
					 -->

					 <dl class="border-top border-bottom">
						<dt>배송비</dt>
						<c:if test="${gdsVO.dlvyCtTy eq 'FREE'}">
							<dd>무료</dd>
						</c:if>
						<c:if test="${gdsVO.dlvyCtTy ne 'FREE'}">
							<dd class="flex flex-col gap-2">
								<p>
									<strong><fmt:formatNumber value="${gdsVO.dlvyBassAmt}" pattern="###,###" />원</strong>
									<c:if test="${dlvyPayTyCode2[gdsVO.dlvyCtStlm] ne null}">
										(${dlvyPayTyCode2[gdsVO.dlvyCtStlm]})
									</c:if>
								</p>

								<c:choose>
									<c:when test="${gdsVO.dlvyCtTy eq 'PERCOUNT'}"><p class="icon-child">상품 <fmt:formatNumber value="${gdsVO.dlvyCtCnd}" pattern="###,###" />개마다 배송비 부과</p></c:when>
									<c:when test="${gdsVO.dlvyCtTy eq 'OVERMONEY'}"><p class="icon-child"><fmt:formatNumber value="${gdsVO.dlvyCtCnd}" pattern="###,###" />원 이상 구매 시 무료</p></c:when>
								</c:choose>

								<%-- 추가 배송비 -> 도서산간비용, 노출x--%>
								<c:if test="${gdsVO.dlvyAditAmt > 0}">
								<p class="icon-child">제주/도서산간지역 <fmt:formatNumber value="${gdsVO.dlvyAditAmt}" pattern="###,###" />원 추가</p>
								</c:if>
								
							</dd>
						</c:if>
						
					</dl>

					<dl class="border-bottom">
						<dt>배송 유형</dt>
						<dd>
							${dlvyCostTyCode[gdsVO.dlvyCtTy]}배송
							<c:if test="${gdsVO.dlvyCtTy eq 'PAY'}">
                               	&nbsp;(${dlvyPayTyCode[gdsVO.dlvyCtStlm]})
                               	</c:if>
						</dd>
					</dl>
					<c:if test="${gdsVO.dlvyCtTy eq 'PAY'}">
					<dl class="border-bottom">
						<dt>배송비</dt>
						<dd>
							<fmt:formatNumber value="${gdsVO.dlvyBassAmt}" pattern="###,###" />
						</dd>
					</dl>
					</c:if>

					<%-- 추가 배송비 -> 도서산간비용, 노출x
					<c:if test="${gdsVO.dlvyAditAmt > 0}">
					<dl>
						<dt>추가 배송비</dt>
						<dd>
							<fmt:formatNumber value="${gdsVO.dlvyAditAmt}" pattern="###,###" />
						</dd>
					</dl>
					</c:if> --%>
					
					<!--복지용구일때만 나오는 영역-->
					<c:if test="${(gdsVO.gdsTy eq 'R' || gdsVO.gdsTy eq 'L')}">
						<div class="flex flex-col gap-4 bg-gray2 rounded-md p-4 my-10">
							<ul class="text-sm flex flex-col gap-4">
								<li>본인부담율에 따라 <strong>85~94%</strong> 지원금을 받을 수 있습니다.(기초수급자의 경우 <strong>100%</strong> 지원)</li>
								<li>원하시는 분은 <strong>복지용구 지원금 상담받기</strong>를 눌러 상담을 신청해 주세요. 
									<ul class="list-dot mt-4 ml-5">
										<li>장기요양 인정등급 보유자는 상담 전 ‘개인별장기요양이용계획서’를 미리 준비해 주시면 좋아요.</li>
										<li>장기요양 인정등급이 없으실 경우 발급을 도와드리고 있어요.</li>
									</ul>
								</li>
							</ul>
							<a href="https://docs.google.com/forms/d/1SI7z69RkUkqJDW9-i3lFC5GcGu7d8uSrF7h4yIBP0yI/viewform?edit_requested=true" target="_blank" class="btn btn-danger btn-animate w-full">
								<strong>복지용구 지원금 상담하기</strong>
							</a>
						</div>
					</c:if>
				</div>
				<!-- //상품 재원 -->

				<!-- 상품 결제 -->
				<div class="product-payment">
					<!-- 상품 결제 토글 모바일 -->
					<button type="button" class="payment-toggle is-active"></button>
					<!-- //상품 결제 토글 모바일 -->

					<%--from start--%>
					<form id="frmOrdr" name="frmOrdr" method="post" enctype="multipart/form-data">
						<!-- 구매 조건 선택 -->
                       	<c:choose>
							<c:when test="${gdsVO.gdsTy eq 'R' && _mbrSession.prtcrRecipterYn eq 'Y' }"> <%-- 급여 & 수급자--%>
							<div class="payment-type-select" style="display:none;">
	                            <%-- <label for="ordrTy1" class="select-item1">
	                                <input type="radio" name="ordrTy" value="R" id="ordrTy1" checked="checked" > R or L
	                                <span>급여 구매</span>
	                            </label> --%>
	                            <label for="ordrTy2" class="select-item2">
	                                <input type="radio" name="ordrTy" value="N" id="ordrTy2">
	                                <span>바로 구매</span>
	                            </label>
							</div>
                            </c:when>
                            <c:when test="${gdsVO.gdsTy eq 'L' && _mbrSession.prtcrRecipterYn eq 'Y' }"> <%-- 대여 & 수급자--%>
							<div class="payment-type-select">
	                            <label for="ordrTy1" class="select-item1">
	                                <input type="radio" name="ordrTy" value="L" id="ordrTy1" checked="checked" >
	                                <span>급여 구매</span>
	                            </label>
	                        </div>
                            </c:when>
							<c:otherwise> <%-- 비급여 > 판매가 구매 --%>
							<input type="hidden" name="ordrTy" value="N">
							</c:otherwise>
						</c:choose>
						<!-- //구매 조건 선택 -->

						<div class="payment-type-content1 is-active"> <%--고정--%>

	                        <div class="payment-scroller is-active">
	                            <c:if test="${(gdsVO.gdsTy eq 'R' || gdsVO.gdsTy eq 'L') && _mbrSession.prtcrRecipterYn eq 'Y' }">
		                        <div class="space-y-1 payment-guide">
		                        	<p class="text-alert">급여제품은 멤버스 <strong>승인완료 후 결제</strong>가 진행됩니다.</p>
		                            <p class="text-question underline"><a href="#modal-steps" data-bs-toggle="modal" data-bs-target="#modal-steps">급여제품 구매절차 안내</a></p>
		                        </div>
	                            </c:if>

								<%-- 급여상품일 경우만 선택 --%>
								<c:if test="${(gdsVO.gdsTy eq 'R' || gdsVO.gdsTy eq 'L') && _mbrSession.prtcrRecipterYn eq 'Y' }">
	                            <!-- 멤버스 선택 -->
	                            <div class="payment-partners">
	                            	<!-- <input type="hidden" id="bplcUniqueId" name="bplcUniqueId" value="${ordrDtlVO.bplcUniqueId }">
	                                <p class="text-desc">이로움ON 멤버스(사업소) 선택 </p>

									<div class="box-result noSelect" ${empty ordrDtlVO.bplcInfo ? '' : 'style="display:none;"'}>선택된 멤버스가 없습니다.</div>


	                             	<div class="product-partners selectPart" ${empty ordrDtlVO.bplcInfo ? 'style="display:none;" ' : ''}>
	                             		<c:if test="${ordrDtlVO.bplcInfo.proflImg ne null}">
	                                    	<img src="/comm/PROFL/getFile?fileName=${ordrDtlVO.bplcInfo.proflImg}" alt="" id="pImg">
	                                    </c:if>
	                                    <c:if test="${ordrDtlVO.bplcInfo.proflImg eq null}">
	                                    	<img src="/html/page/market/assets/images/partners_default.png" alt="" id="pImg">
	                                    </c:if>
	                                    <dl>
	                                        <dt id="pName">${ordrDtlVO.bplcInfo.bplcNm}</dt>
	                                        <dd class="info">
	                                            <p class="addr pAddrs">${ordrDtlVO.bplcInfo.addr}&nbsp;${ordrDtlVO.bplcInfo.daddr}</p>
	                                            <p class="call"><a href="tel:${ordrDtlVO.bplcInfo.telno}" class="pTel">${ordrDtlVO.bplcInfo.telno}</a></p>
	                                        </dd>
	                                    </dl>
	                                </div>
	                                <p class="text-alert mt-1.5">이 전에 구매하신 멤버스가 기본으로 선택됩니다.</p>

	                                <button type="button"  class="btn btn-primary w-full mt-2" id="srchGdsBplc">멤버스 선택</button> -->
	                                <input type="hidden" id="bplcUniqueId" name="bplcUniqueId" value="${bplcVO.uniqueId }">

	                             	<div class="product-partners selectPart">
	                             		<c:if test="${bplcVO.proflImg ne null}">
	                                    	<img src="/comm/PROFL/getFile?fileName=${bplcVO.proflImg}" alt="" id="pImg">
	                                    </c:if>
	                                    <c:if test="${bplcVO.proflImg eq null}">
	                                    	<img src="/html/page/market/assets/images/partners_default.png" alt="" id="pImg">
	                                    </c:if>
	                                    <dl>
	                                        <dt id="pName">${bplcVO.bplcNm}</dt>
	                                        <dd class="info">
	                                            <p class="addr pAddrs">${bplcVO.addr}&nbsp;${bplcVO.daddr}</p>
	                                            <p class="call"><a href="tel:${bplcVO.telno}" class="pTel">${bplcVO.telno}</a></p>
	                                        </dd>
	                                    </dl>
	                                </div>

	                            </div>
	                            <!-- //멤버스 선택 -->
	                            </c:if>

	                            <!-- 상품 옵션 -->
	                            <div class="payment-option">
	                                <!-- <p class="option-title">필수옵션</p> -->

									<c:set var="optnTtl" value="${fn:split(gdsVO.optnTtl, '|')}" />
	                                <c:set var="optnVal" value="${fn:split(gdsVO.optnVal, '|')}" />

									<c:if test="${!empty optnTtl[0]}">
	                                <div class="product-option" id="optnVal1">
	                                    <button type="button" class="option-toggle" disabled="true">
	                                        <small>필수</small>
	                                        <strong>${optnTtl[0]} 선택</strong>
	                                    </button>
	                                    <ul class="option-items">
	                                    </ul>
	                                </div>
	                                </c:if>
									<c:if test="${!empty optnTtl[1]}">
	                                <div class="product-option" id="optnVal2">
	                                    <button type="button" class="option-toggle" disabled="true">
	                                        <small>필수</small>
	                                        <strong>${optnTtl[1]} 선택</strong>
	                                    </button>
	                                    <ul class="option-items">
	                                    </ul>
	                                </div>
	                                </c:if>
	                                <c:if test="${!empty optnTtl[2]}">
	                                <div class="product-option" id="optnVal3">
	                                    <button type="button" class="option-toggle" disabled="true">
	                                        <small>필수</small>
	                                        <strong>${optnTtl[2]} 선택</strong>
	                                    </button>
	                                    <ul class="option-items">
	                                    </ul>
	                                </div>
	                                </c:if>

	                                <c:if test="${!empty gdsVO.aditOptnTtl}">
									<c:set var="aditOptnTtl" value="${fn:split(gdsVO.aditOptnTtl, '|')}" />
	                                <!-- <p class="option-title">추가옵션</p> -->
									<c:forEach var="aditOptn" items="${aditOptnTtl}" varStatus="status">
	                                <div class="product-option" id="aditOptnVal${status.index }">
	                                    <button type="button" class="option-toggle">
	                                        <small>추가</small>
	                                        <strong>추가 ${aditOptn} 선택</strong>
	                                    </button>
	                                    <ul class="option-items">
	                                    <c:forEach var="aditOptnList" items="${gdsVO.aditOptnList}" varStatus="status">
	                                    <input type="hidden" name="aditGdsOptnNo" value="${aditOptnList.gdsOptnNo}" />
		                                <c:set var="spAditOptnTtl" value="${fn:split(aditOptnList.optnNm, '*')}" />
	                                    <c:if test="${fn:trim(aditOptn) eq fn:trim(spAditOptnTtl[0])}">
											<li><a href="#" data-optn-ty="ADIT"' data-opt-val="${aditOptnList.optnNm}|${aditOptnList.optnPc}|${aditOptnList.optnStockQy}|ADIT">${spAditOptnTtl[1]}</a></li>
	                               		</c:if>
	                               		</c:forEach>
	                                    </ul>
	                                </div>
	                                </c:forEach>
	                                </c:if>

								</div>
								<!-- //상품 옵션 -->

								<!-- 구매 금액 -->

								<div class="payment-price with-total">
									<span class="font-bold">총 상품금액</span>
									<div class="pay-amount text-price">
                                        <p class="text-gray5">주문수량<span id="totalQy">0</span>개 |</p>
                                        <strong  id="totalPrice">0</strong>
                                        <span>원</span>
                                    </div>

								</div>

								<!-- //구매 금액 -->

							</div>

							<!-- 구매 버튼 -->
							<div class="payment-button">
								<c:if test="${_mbrSession.loginCheck}">
									<%-- <c:if test="${_mbrSession.recipterYn eq 'Y' }">
										<button type="button" class="btn btn-danger btn-large btn-trigger recpBtn f_buy" >구매신청</button>
									</c:if>
									<c:if test="${_mbrSession.recipterYn eq 'N' }"> --%>
										<c:choose>
											<c:when test="${(gdsVO.gdsTy eq 'R' || gdsVO.gdsTy eq 'L')}">
												<button type="button" class="btn btn-primary btn-large btn-trigger f_buy">정가구매하기</button>
											</c:when>
											<c:otherwise>
												<button type="button" class="btn btn-primary btn-large btn-trigger f_buy">구매하기</button>
											</c:otherwise>
										</c:choose>
									<%-- </c:if> --%>
									<button type="button" class="btn btn-outline-primary btn-large f_cart">장바구니</button>
									<button type="button" class="btn btn-love btn-large f_wish ${gdsVO.wishYn>0?'is-active':'' }" data-gds-no="${gdsVO.gdsNo}" data-wish-yn="${gdsVO.wishYn>0?'Y':'N'}">상품찜하기</button>
								</c:if>
								<c:if test="${!_mbrSession.loginCheck}">
									<c:choose>
										<c:when test="${(gdsVO.gdsTy eq 'R' || gdsVO.gdsTy eq 'L')}">
											<button type="button" class="btn btn-primary btn-large btn-trigger f_loginCheck">정가구매하기</button>
										</c:when>
										<c:otherwise>
											<button type="button" class="btn btn-primary btn-large btn-trigger f_loginCheck">구매하기</button>
										</c:otherwise>
									</c:choose>
									<button type="button" class="btn btn-outline-primary btn-large f_loginCheck">장바구니</button>
									<button type="button" class="btn btn-love btn-large f_loginCheck">상품찜하기</button>
								</c:if>
							</div>
							<!-- //구매 버튼 -->

						</div>

					</form>
					<%--//from--%>
				</div>
				<!-- //상품 결제 -->
			</div>
			<!-- //상품 정보 -->
		</div>



		<!-- 멤버스 선택 -->
		<div id="bplcList"></div>
		<!-- //멤버스 선택 -->

		<!-- 포토 상품후기 -->
		<jsp:include page="./include/modal_photo.jsp" />
		<!-- //포토 상품후기 -->

		<!-- 상품문의 -->
		<jsp:include page="./include/modal_qa.jsp" />
		<!-- //상품문의 -->

		<!-- 구매절차 안내 -->
		<jsp:include page="./include/modal_steps.jsp" />
		<!-- //구매절차 안내 -->


	</div>

	<textarea class="gdsVOString" style="display: none;">
		${gdsVOJson}
	</textarea>

	
</main>

<script type="text/javascript" src="/html/page/market/assets/script/JsMarketGdsView.js?v=<spring:eval expression="@version['assets.version']"/>"></script>

<script>
	var jsMarketGdsView = null;
	$(document).ready(function() {
		var path = {_membershipPath:"${_membershipPath}", _marketPath:"${_marketPath}"};

		jsMarketGdsView = new JsMarketGdsView(path, ${_mbrSession.loginCheck}, $("textarea.gdsVOString").val())
	});



var Goods = (function(){

	var gdsPc = ${gdsVO.pc};
	var gdsDscntPc = ${gdsVO.dscntPc};
	var ordrTy = $("input[name='ordrTy']:checked").val() === undefined?"N":$("input[name='ordrTy']:checked").val(); //R / L / N

	if(ordrTy === "R" || ordrTy === "L"){
		<c:choose>
			<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 15 }">
			gdsPc = ${gdsVO.bnefPc15};
			</c:when>
			<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 9 }">
			gdsPc = ${gdsVO.bnefPc9};
			</c:when>
			<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 6 }">
			gdsPc = ${gdsVO.bnefPc6};
			</c:when>
			<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 0 }">
			gdsPc = 0;
			</c:when>
		</c:choose>
	//}else if(ordrTy === "L"){
	//	gdsPc = ${gdsVO.lendPc};
	}

	//멤버스 모달
	function f_gdsBplc(page, param){
		$("#bplcList").load(
				"${_marketPath}/gds/choicePartners"
				, {params : param
					, curPage : page}
				, function(){
					$("#modal-partner").addClass("fade").modal("show");
					f_gdsBplcList(param, page)
					//isAllow = searchGps();
				}
			);
	}

	//멤버스 모달 리스트
	function f_gdsBplcList(param, page){
		$("#listView").load(
				"${_marketPath}/gds/choicePartnersList"
				, {params : param
					, curPage : page}
			);
	}

	function f_buy(){

		if($(window).outerWidth() < 1041 && !$(this).closest('.product-payment').hasClass('is-active')) {
            $(this).closest('.product-payment').addClass('is-active');
        }

	       // 대여상품은 1건씩 주문
	        if(ordrTy == "L" && $(".product-quanitem").length > 1){
	        	alert("급여상품의 대여 주문은 한품목의 상품만 주문 가능합니다.");
	        	return false;
	        }else if((ordrTy == "R" || ordrTy == "L") && $("#bplcUniqueId").val() == "" ){
				alert("급여상품은 멤버스(사업소)를 선택해야 합니다.");
				return false;
	        // 주문
	        <c:if test="${empty optnTtl[0]}">
	        // 옵션이 없는 경우 //|0|10
	        }else if(${gdsVO.stockQy} < 1){
				alert("선택하신 상품은 품절입니다.");
				return false;
	        </c:if>
	        }else if($(".product-quanitem").length < 1){
	        	alert("필수 옵션을 선택하세요");
				$('.payment-type-content1 .payment-scroller').addClass('is-active');
	        	return false;
	        }else{
		        var actionUrl = "${_marketPath}/ordr/ordrRqst"; //주문확인
				if(ordrTy == "N"){
					actionUrl = "${_marketPath}/ordr/ordrPay"; //주문진행
				}
	        	$("#frmOrdr").attr("action", actionUrl);
	        	$("#frmOrdr").submit();
	        }

    }

	function f_buyClick(){
		var tagList = [];
		let skip = true;
		// 이로움1.0 상품 조회

		if("${gdsVO.gdsTagVal}" != null && "${gdsVO.gdsTagVal}" != ''){
			var tagVal = "${gdsVO.gdsTagVal}";
			tagVal = tagVal.replaceAll(' ','').split(',');
			if(tagVal.indexOf("A") > -1){
				alert("선택하신 옵션은 품절상태입니다.");
				skip = false;
			}else if(tagVal.indexOf("B") > -1){
				//alert("선택하신 옵션은 일부옵션품절상태입니다.");
				//console.log(skip);
				//skip = false;
			}else if(tagVal.indexOf("C") > -1){
				alert("선택하신 옵션은 일시품절상태입니다.");
				skip = false;
			}
		}

		if(skip){
			if($("#bnefCd").val() != null && $("#bnefCd").val() != '' ){
				tagList.push($("#bnefCd").val());

				let params = new Map();
				params.set("bnefList",tagList);
				params.set("method", f_buy);
				f_itemChk(params);
			}else{
				f_buy();
			}
		}

	}

	$(function(){

		// 멤버스 찾기
		$("#srchGdsBplc").on("click",function(){
			var param = "itrst";
			f_gdsBplc(1, param);
		});

		

		$("input[name='ordrTy']").on("change", function(){ //구매형태 변경
			ordrTy = $("input[name='ordrTy']:checked").val();
			console.log(ordrTy);

			if(ordrTy == "R" || ordrTy == "L"){
				$(".recpBtn").removeClass("btn-primary").addClass("btn-danger")
				<c:choose>
					<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 15 }">
					gdsPc = ${gdsVO.bnefPc15};
					</c:when>
					<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 9 }">
					gdsPc = ${gdsVO.bnefPc9};
					</c:when>
					<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 6 }">
					gdsPc = ${gdsVO.bnefPc6};
					</c:when>
					<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 0 }">
					gdsPc = 0;
					</c:when>
				</c:choose>
				$(".payment-partners, .payment-guide").show();
			//}else if(ordrTy == "L"){
			//	gdsPc = ${gdsVO.lendPc};
			//	$(".payment-partners, .payment-guide").show();
			}else{
				if(${gdsVO.dscntRt} > 0){
					gdsPc = ${gdsVO.dscntPc}
				}else{
					gdsPc = ${gdsVO.pc};
				}
				$(".payment-partners, .payment-guide").hide();
				$(".recpBtn").removeClass("btn-danger").addClass("btn-primary");
			}
			<c:if test="${!empty optnTtl[0]}">
			$(".product-quanitem").remove();
			</c:if>
		    <c:if test="${empty optnTtl[0]}">
		    // 옵션이 없는 경우 //|0|10
		    if(${gdsVO.stockQy} > 0){
		    	$(".product-quanitem").remove();
			    jsMarketGdsView.f_baseOptnChg("|0|${gdsVO.stockQy}|BASE"); //R * 10 * DEF|1000|0|BASE
		    }
		    $(".btn-delete").remove();
		    </c:if>

			jsMarketGdsView.f_totalPrice();
		});

	    <c:if test="${empty optnTtl[0]}">
	    // 옵션이 없는 경우 //|0|10
	    if(${gdsVO.stockQy} > 0){
		    jsMarketGdsView.f_baseOptnChg("|0|${gdsVO.stockQy}|BASE"); //R * 10 * DEF|1000|0|BASE
	    }
	    $(".btn-delete").remove();
	    </c:if>

	    <c:if test="${!empty optnTtl[0]}">
		// 기본 옵션 1번
		jsMarketGdsView.f_optnVal1('', 'BASE');
		<c:if test="${empty optnTtl[1]}">
		$(document).on("click", "#optnVal1 ul.option-items li a", function(e){
			e.preventDefault();
			const optnVal1 = $(this).data("optVal");
			//console.log(optnVal1);
			if(optnVal1 != ""){
				jsMarketGdsView.f_baseOptnChg(optnVal1);
			}

			$(this).parent().parent().hide();
		});
		</c:if>
		</c:if>

		<c:if test="${!empty optnTtl[1]}">
		// 기본 옵션 2번
		$(document).on("click", "#optnVal1 ul.option-items li a", function(e){
			e.preventDefault();
			const optnVal1 = $(this).data("optVal").split("*");
			const optnTy = $(this).data("optnTy");

			//console.log("optnVal1 :", optnVal1, optnTy);

			jsMarketGdsView.f_optnVal2(optnVal1[0].trim(), optnTy);

			$(this).parent().parent().hide();
		});

		<c:if test="${empty optnTtl[2]}">
		$(document).on("click", "#optnVal2 ul.option-items li a", function(e){
			e.preventDefault();

			const optnVal2 = $(this).data("optVal");//.split("*");
			const optnTy = $(this).data("optnTy");

			//console.log("optnVal2 :", optnVal2, optnTy);

			if(optnVal2 != ""){
				jsMarketGdsView.f_baseOptnChg(optnVal2);
			}

			$(this).parent().parent().hide();
		});
		</c:if>

		</c:if>

		<c:if test="${!empty optnTtl[2]}">
		// 기본 옵션 3번
		$(document).on("click", "#optnVal2 ul.option-items li a", function(e){
			e.preventDefault();
			const optnVal2 = $(this).data("optVal").split("*");
			const optnTy = $(this).data("optnTy");
			//console.log("optnVal2 :", optnVal2, optnTy);
			jsMarketGdsView.f_optnVal3(optnVal2[0].trim() +" * " +optnVal2[1].trim(), optnTy);

			$(this).parent().parent().hide();
		});


		$(document).on("click", "#optnVal3 ul.option-items li a", function(e){
			e.preventDefault();
			const optnVal3 = $(this).data("optVal");//.split("*");
			const optnTy = $(this).data("optnTy");
			//console.log("optnVal3 :", optnVal3, optnTy);
			if(optnVal3 != ""){
				jsMarketGdsView.f_baseOptnChg(optnVal3);
			}

			$(this).parent().parent().hide();
		});
		</c:if>


		<%--추가옵션--%>
		$(document).on("click", "[id^=aditOptnVal] ul.option-items li a", function(e){
			e.preventDefault();
			const optnVal = $(this).data("optVal");
			//기본상품이 있는지 먼저 체크해야함
			if($(".product-quanitem input[name='ordrOptnTy'][value='BASE']").length > 0 && optnVal != ""){
				jsMarketGdsView.f_aditOptnChg(optnVal);
			}else{
				alert("기본 옵션을 먼저 선택해야 합니다.");
				$('.product-option').removeClass('is-active');
			}

			$(this).parent().parent().hide();
		});


		// 구매 버튼
		$('.payment-button .f_buy').on('click', function() {
			f_buyClick();
		});


		// 장바구니 버튼
		$(".payment-button .f_cart").on("click", function(){

	        if((ordrTy == "R" || ordrTy == "L") && $("#bplcUniqueId").val() == "" ){
				alert("급여상품 구입은 멤버스(사업소)를 선택해야 합니다.");
				return false;
	        }else if($(".product-quanitem").length < 1){
	        	alert("필수 옵션을 선택하세요");
				$('.payment-type-content1 .payment-scroller').addClass('is-active');
	        	return false;
	        }else{
	        	var formData = $("#frmOrdr").serialize();
				$.ajax({
					type : "post",
					url  : "${_marketPath}/mypage/cart/putCart.json",
					data : formData,
					dataType : 'json'
				})
				.done(function(json) {
					if(json.result){
						//console.log("resultMsg: ", json.resultMsg);
						if(json.resultMsg == "ALREADY"){
							alert("장바구니에 담겨있는 상품입니다.");
						}else{
							$('.navigation-util .util-item3 i').text(Number($('.navigation-util .util-item3 i').text()) + 1);
							if (confirm("장바구니에 상품을 담았습니다.\n장바구니로 이동하시겠습니까?")){
								window.location.href = "${_marketPath}/mypage/cart/list";
							}
						}
					}else{
						alert("장바구니 담기에 실패하였습니다.\n잠시후 다시 시도해 주시기 바랍니다.")
					}
				})
				.fail(function(data, status, err) {
					console.log('error forward : ' + data);
				});

	        }

		});

		$('.f_loginCheck').on('click', function(){
			if(confirm('회원만 사용가능합니다. 로그인하시겠습니까?')){
				location.href='${_membershipPath}/login?returnUrl=${_curPath}';
			}
		});

		// 고시정보
		let infoJson = eval('(${!empty gdsVO.ancmntInfo?gdsVO.ancmntInfo:'{}'})');
		var html = '<tr class="top-border"><td></td><td></td></tr>';
		$.each(item['${gdsVO.ancmntTy}'].article, function(key, value){
	    	html += '<tr>';
			html += '	<th scope="row"><p>'+ value[0] +'</p></th>';
			html += '	<td>';
			if(value[1] != ''){
				html += '	<p class="py-1">'+ value[1] +'</p>';
	        }
			html += '	'+ (infoJson[key]==undefined?'상세설명페이지 참고':infoJson[key]);
			html += '	</td>';
			html += '</tr>';
		});
	    html += '<tr class="bot-border"><td></td><td></td></tr>';
	    $("#ancmntTable tbody").append(html);

	    // TODO : 급여 구매 신청 시 제거
	    $("#ordrTy2").click();
	    $("#ordrTy2").hide();
	});

})();

// 상품문의 START
var Goods_QA = (function(){

	function f_gdsQaList(page){
		$("#prod-tabcontent3").load(
			"${_marketPath}/gds/qa/list"
			, {curPage:page, cntPerPage:5, srchGdsCd:"${gdsVO.gdsCd}"}
			, function(){
				$(".qaCnt").text("("+$("#qaListCnt").val()+")");
			}
		);
	}

    f_gdsQaList(1);
	$(document).on("click", ".qa-pager a", function(){
		let pageNo = $(this).data("pageNo");
		if(pageNo > 0){
			f_gdsQaList(pageNo);
		}
	});

	$(document).on("click", ".f_qa_modify", function(){
		var qaNo = $(this).data("qaNo");
		$.ajax({
			type : "post",
			url  : "${_marketPath}/gds/qa/getQa.json",
			data : { qaNo:qaNo },
			dataType : 'json'
		})
		.done(function(data) {
			$("form[name='frmGdsQa']")[0].reset();
			$("#frmGdsQa input[name='crud']").val("CREATE");
			$("#frmGdsQa input[name='qaNo']").val(0);
			if(data.rtnMsg == "success"){
				if(typeof data.vo != "undefined"){
					$("#frmGdsQa input[name='crud']").val("UPDATE");
					$("#frmGdsQa input[name='qaNo']").val(data.vo.qaNo);
					$("#frmGdsQa textarea[name='qestnCn']").val(data.vo.qestnCn);
					if(data.vo.secretYn == "Y"){
						$("#frmGdsQa input[name='secretYn']").prop("checked", true);
					}else{
						$("#frmGdsQa input[name='secretYn']").prop("checked", false);
					}

					$("#modal-request").modal("show");
				}
			}else if(data.rtnMsg == "denied"){
				alert("본인이 작성한 상품문의만 수정할 수 있습니다.");
			}
		})
		.fail(function(data, status, err) {
			alert('상품문의 데이터 호출에 실패하였습니다. : ' + data);
		});

	});

	$(document).on("click", ".f_qa_del", function(){
		var qaNo = $(this).data("qaNo");
		$.ajax({
			type : "post",
			url  : "${_marketPath}/gds/qa/rmQa.json",
			data : { qaNo:qaNo },
			dataType : 'json'
		})
		.done(function(data) {
			if(data.rtnMsg == "success"){
				$("form[name='frmGdsQa']")[0].reset();
				$("#frmGdsQa input[name='crud']").val("CREATE");
				$("#frmGdsQa input[name='qaNo']").val(0);
				f_gdsQaList(1);
			}else if(data.rtnMsg == "denied"){
				alert("본인이 작성한 상품문의만 삭제할 수 있습니다.");
			}else{
				alert("삭제에 실패하였습니다.");
			}
		})
		.fail(function(data, status, err) {
			alert('데이터 삭제에 실패하였습니다. : ' + data);
		});
	});

	$("#frmGdsQa .btn-cancel, #frmGdsQa .modal-close button").on("click", function(){
		$("form[name='frmGdsQa']")[0].reset();
		$("#frmGdsQa input[name='crud']").val("CREATE");
		$("#frmGdsQa input[name='qaNo']").val(0);
		$("#modal-request").modal("hide");
	});
	$("#frmGdsQa .btn-submit").on("click", function(){
		$("#frmGdsQa").submit();
	});
	$("form[name='frmGdsQa']").validate({
	    ignore: "input[type='text']:hidden, [contenteditable='true']:not([name])",
	    rules : {
	    	qestnCn	: { required : true}
	    },
	    messages : {
	    	qestnCn : { required : "상품문의 내용을 작성해 주세요"}
	    },
	    submitHandler: function (frm) {

	    	var qaNo = $("#frmGdsQa input[name='qaNo']").val();
	    	var crud = $("#frmGdsQa input[name='crud']").val();
	    	var qestnCn = $("#frmGdsQa textarea[name='qestnCn']").val();
	    	var secretYn = $("#frmGdsQa input[name='secretYn']").is(":checked")?'Y':'N';

	            if (confirm('상품문의 내용을 저장 하시겠습니까?')) {
	            	$.ajax({
    				type : "post",
    				url  : "${_marketPath}/gds/qa/action.json", //주문확인
    				data : {
    					crud:crud
    					, qaNo:qaNo
    					, gdsNo:'${gdsVO.gdsNo}'
    					, gdsCd:'${gdsVO.gdsCd}'
    					, qestnCn:qestnCn
    					, secretYn:secretYn
    				},
    				dataType : 'json'
    			})
    			.done(function(data) {
    				if(data.result){
    					f_gdsQaList(1);
    					$("form[name='frmGdsQa']")[0].reset();
    					$("#frmGdsQa input[name='crud']").val("CREATE");
    					$("#frmGdsQa input[name='qaNo']").val(0);
    					$("#modal-request .btn-cancel").click();
    				}
    			})
    			.fail(function(data, status, err) {
    				alert('상품문의 등록에 실패하였습니다. : ' + data);
    			});
	        	}else{
	        		return false;
	        	}
	    }
	});
})();
// END 상품문의


// 상품후기 START
var Goods_Review = (function(){

	//포토후기
	function f_gdsPhotoReviewList(page){
		$("#gdsPhotoReview").load(
			"${_marketPath}/gds/review/photoList"
			, {curPage:page, cntPerPage:5, srchGdsCd:"${gdsVO.gdsCd}"}
			, function(){
				const reviewCnt = Number($("#reviewListCnt").val()) + Number($("#photoReviewListCnt").val());
				const avrgDgstfn = Number($("#sumDgstfn").val()) + Number($("#sumPhotoDgstfn").val());

				$(".photoReviewCnt").text($("#photoReviewListCnt").val());
				$(".reviewCnt").text(reviewCnt);
				$(".reviewCnt2").text("("+reviewCnt+")");

				$(".avrgDgstfn").text(reviewCnt>0?(avrgDgstfn / reviewCnt).toFixed(1):"0");
			}
		);
	}
	f_gdsPhotoReviewList(1);
	$(document).on("click", ".photo-review-pager a", function(){
		let pageNo = $(this).data("pageNo");
		if(pageNo > 0){
			f_gdsPhotoReviewList(pageNo);
		}
	});

	//일반 후기
	function f_gdsReviewList(page){
		$("#gdsReview").load(
			"${_marketPath}/gds/review/list"
			, {curPage:page, cntPerPage:5, srchGdsCd:"${gdsVO.gdsCd}"}
			, function(){
				const reviewCnt = Number($("#reviewListCnt").val()) + Number($("#photoReviewListCnt").val());
				const avrgDgstfn = Number($("#sumDgstfn").val()) + Number($("#sumPhotoDgstfn").val());

				$(".reviewCnt").text(reviewCnt);
				$(".reviewCnt2").text("("+reviewCnt+")");
				$(".avrgDgstfn").text(reviewCnt>0?(avrgDgstfn / reviewCnt).toFixed(1):"0");
			}
		);
	}
	f_gdsReviewList(1);
	$(document).on("click", ".review-pager a", function(){
		let pageNo = $(this).data("pageNo");
		if(pageNo > 0){
			f_gdsReviewList(pageNo);
		}
	});

	$(document).on("click", ".f_review_show", function(){
		var reviewNo = $(this).data("reviewNo");
		$.ajax({
			type : "post",
			url  : "${_marketPath}/gds/review/getReview.json",
			data : { gdsReviewNo:reviewNo},
			dataType : 'json'
		})
		.done(function(data) {
			if(data.rtnMsg == "success"){
				if(typeof data.vo != "undefined"){
					var proflImgSrc = "/html/page/market/assets/images/dummy/img-dummy-partners.png"; //TO-DO : default
					if(data.vo.proflImg != null){
						$("#modal-review .layer-user img").attr("src", "/comm/proflImg?fileName="+data.vo.proflImg);
					}

					$("#modal-review .name strong").text(data.vo.regId);
					$("#modal-review .name span").text(f_dateFormat(data.vo.regDt));

					$("#modal-review .layer-content").html(data.vo.cn);

					if(data.vo.imgUseYn == "Y"){
						var imgHtml = '<img src="/comm/getImage?srvcId=REVIEW&amp;upNo='+ data.vo.imgFile.upNo +'&amp;fileTy='+ data.vo.imgFile.fileTy +'&amp;fileNo='+ data.vo.imgFile.fileNo +'" alt="">';
						$("#modal-review .swiper-slide").html(imgHtml);
					}else{
						$("#modal-review .swiper-slide").html("");
					}


					$("#modal-review").modal("show");
				}
			} else {
				alert("상품후기 데이터 호출에 실패하였습니다");
			}
		})
		.fail(function(data, status, err) {
			alert('상품후기 데이터 호출에 실패하였습니다. : ' + data);
		});

	});
})();
</script>