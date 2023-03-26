<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 주문내역 -->
<div class="modal fade" id="itemModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<p class="text-title">주문 내역</p>
			</div>
			<div class="modal-close">
				<button data-bs-dismiss="modal" id="clsModal">모달 닫기</button>
			</div>

			<div id="listView">
				<div class="modal-body">
				<c:if test="${empty listVO.listObject}"><div class="box-result is-large">최근 6개월간 주문 내역이 없습니다.</div></c:if>

				<c:forEach items="${listVO.listObject}" var="ordrDtl" varStatus="status">
					<c:set var="pageParam" value="curPage=${listVO.curPage}${!empty(listVO.urlParam)? '&amp;' : ''}${listVO.urlParam}" />

					<c:set var="spOrdrOptn" value="${fn:split(ordrDtl.ordrOptn, '*')}" />

					<c:if test="${ordrDtl.ordrOptnTy eq 'BASE'}">

						<c:set var="sumOrdrPc" value="${ordrDtl.ordrPc }" />
						<c:set var="ordrQy" value="${ordrDtl.ordrQy }" />

						<%-- 통합 주문 번호 --%>
						<c:if test="${status.first}">

							<div class="order-product" data-ordr-cd="${ordrDtl.ordrCd}">
								<div class="order-header">
									<dl>
										<dt>주문번호</dt>
										<dd>
											<strong><a href="./view/${ordrDtl.ordrCd}?${pageParam}">${ordrDtl.ordrCd}</a></strong>
										</dd>
									</dl>
									<dl>
										<dt>주문일시</dt>
										<%--주문/취소 --%>
										<dd>
											<fmt:formatDate value="${ordrDtl.ordrDt}" pattern="yyyy.MM.dd HH:mm:ss" />
										</dd>
									</dl>
									<!-- <button type="button" class="f_all_rtrcn">전체취소</button> -->
								</div>
								<div class="order-body">
						</c:if>
						<%-- 통합 주문 번호 --%>


						<div class="order-item">
							<div class="order-item-thumb">
								<c:choose>
									<c:when test="${!empty ordrDtl.gdsInfo.thumbnailFile }">
										<img src="/comm/getImage?srvcId=GDS&amp;upNo=${ordrDtl.gdsInfo.thumbnailFile.upNo }&amp;fileTy=${ordrDtl.gdsInfo.thumbnailFile.fileTy }&amp;fileNo=${ordrDtl.gdsInfo.thumbnailFile.fileNo }&amp;thumbYn=Y" alt="">
									</c:when>
									<c:otherwise>
										<img src="/html/page/market/assets/images/noimg.jpg" alt="">
									</c:otherwise>
								</c:choose>
							</div>
							<div class="order-item-content">
								<div class="order-item-group" style="min-height: 160px;">
									<div class="order-item-base">
										<p class="code">
											<span class="label-primary"> <span>${gdsTyCode[ordrDtl.gdsInfo.gdsTy]}</span> <i></i>
											</span> <u>${ordrDtl.gdsInfo.gdsCd }</u>
										</p>
										<div class="product">
											<p class="name">${ordrDtl.gdsInfo.gdsNm }</p>
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
					</c:if>
					<c:if test="${ordrDtl.ordrOptnTy eq 'ADIT'}">

						<c:set var="sumOrdrPc" value="${sumOrdrPc + ordrDtl.ordrPc}" />
						<div class="order-item-add">
							<span class="label-outline-primary"> <span>${spOrdrOptn[0]}</span> <i><img src="/html/page/market/assets/images/ico-plus-white.svg" alt=""></i>
							</span>
							<div class="name">
								<p>
									<strong>${spOrdrOptn[1]}</strong>
								</p>
								<p>
									수량 ${ordrDtl.ordrQy}개 (+
									<fmt:formatNumber value="${ordrDtl.ordrPc}" pattern="###,###" />
									원)
								</p>
							</div>
						</div>
					</c:if>

					<c:if test="${listVO.listObject[status.index+1].ordrOptnTy eq 'BASE' || status.last}">
			</div>
			<div class="order-item-count">
				<p>
					<strong>${ordrQy}</strong>개
				</p>
			</div>
			<p class="order-item-price">
				<fmt:formatNumber value="${sumOrdrPc}" pattern="###,###" />
				원
			</p>
		</div>
	</div>

	<%-- 통합 주문 번호 --%>
	<c:if test="${!status.last && ordrDtl.ordrCd ne listVO.listObject[status.index+1].ordrCd}">

		<div class="order-product">
			<div class="order-header">
				<dl>
					<dt>주문번호</dt>
					<dd>
						<strong><a href="./view/${listVO.listObject[status.index+1].ordrCd}?${pageParam}">${listVO.listObject[status.index+1].ordrCd}</a></strong>
					</dd>
				</dl>
				<dl>
					<dt>주문일시</dt>
					<%--주문/취소 --%>
					<dd>
						<fmt:formatDate value="${listVO.listObject[status.index+1].ordrDt}" pattern="yyyy.MM.dd HH:mm:ss" />
						<br>
					</dd>
				</dl>
				<!-- <button type="button" class="f_all_rtrcn">전체취소</button> -->
			</div>
			<div class="order-body">
				<c:if test="${!empty listVO.listObject[status.index+1].recipterUniqueId }">
					<%-- 베네핏 바이어 --%>
					<div class="order-buyer">
						<c:if test="${!empty listVO.listObject[status.index+1].recipterInfo.proflImg}">
							<img src="/comm/proflImg?fileName=${listVO.listObject[status.index+1].recipterInfo.proflImg}" alt="">
						</c:if>
						<strong>${listVO.listObject[status.index+1].recipterInfo.mbrNm}</strong>
					</div>
				</c:if>
	</c:if>
	<%-- 통합 주문 번호 --%>
	</c:if>
	</c:forEach>
	</div>
	<c:if test="${!empty listVO.listObject}"><label class="order-select"> <input type="radio" name=""> <span>선택</span>
	</label></c:if>

</div>
<c:if test="${!empty listVO.listObject}">
	<div class="pagination">
		<front:jsPaging listVO="${listVO}" targetObject="ordr-pager" />
	</div>
</c:if>


<div class="modal-footer">
	<button type="button" class="btn btn-primary btn-submit" data-ordr-cd="" id="ordr-btn">확인</button>
	<button type="button" class="btn btn-outline-primary btn-cancel" data-bs-dismiss="modal">닫기</button>
</div>

</div>
</div>
<!-- //주문내역 -->

<script>
	$(function() {
		var values="";

		// 페이징 클릭 이벤트
		$(document).on("click", ".ordr-pager a", function(e) {
			const totalPage = "${listVO.totalPage}";
			let pageNo = $(this).data("pageNo");
			if(pageNo != 0){
				f_ordrListModal(pageNo);
			}else{
				alert("마지막 페이지 입니다.");
			}
			e.preventDefault();
		});

		// active event
		$(document).on("click", ".order-product", function(e) {
			if ($(this).hasClass("is-active")) {
				$("#ordr-btn").data("ordrCd", '');
				$(this).removeClass("is-active");
				values="";
			} else {
				$("#ordr-btn").data("ordrCd", $(this).val());
				$(this).addClass("is-active");
				values=$(this).data("ordrCd");
			}
			e.preventDefault();
		});

		// ordrCd insert
		$(document).on("click", "#ordr-btn", function(e) {
			$("#ordrCd").val(values);
			$("#clsModal").click();
			e.preventDefault();
		});

	});
</script>