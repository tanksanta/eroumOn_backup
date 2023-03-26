<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 주문 > 멤버스 선택 > 멤버스 찾기 > 검색시 내부 리스트용 -->
<c:forEach var="search" items="${listVO.listObject}">
	<div class="product-partners" data-unique-id="${search.uniqueId}">
		<c:if test="${!empty search.proflImg}">
			<img src="/comm/PROFL/getFile?fileName=${search.proflImg}">
		</c:if>
		<c:if test="${empty search.proflImg}">
			<img src="/html/page/market/assets/images/partners_default.png" alt="">
		</c:if>
		<dl>
			<dt>${search.bplcNm}</dt>
			<dd class="info">
				<p class="addr">${search.zip}&nbsp;${search.addr}&nbsp;${search.daddr}</p>
				<p class="call">
					<a href="tel:${search.telno}">${search.telno}</a>
				</p>
			</dd>
			<dd class="desc">
				<div class="time">
					<c:set var="hldys" value="${fn:split(fn:replace(search.hldy,' ',''),',')}" />
					<p>
						<small>영업시간</small>
						<c:if test="${search.bsnHrBgng ne null}">${search.bsnHrBgng} ~ ${search.bsnHrEnd}</c:if>
					</p>
					<p>
						<small>휴무</small>
						<c:if test="${search.hldy ne null}">
							<c:forEach var="day" items="${hldys}">
								<c:choose>
									<c:when test="${day ne 'Z'}">${bplcRstdeCode[day]}&nbsp;</c:when>
									<c:otherwise>${search.hldyEtc }</c:otherwise>
								</c:choose>
							</c:forEach>
											&nbsp;
									</c:if>
					</p>
				</div>
				<a href="/members/${search.bplcId}/gds/list" class="btn btn-primary btn-small flex-none" target="_blank">홈페이지 방문</a>
			</dd>
		</dl>
		<label class="partners-select"> <input type="radio" name="itrstClick"> <span>선택</span>
		</label>
	</div>
</c:forEach>&nbsp;
<c:if test="${empty listVO.listObject}"><div class="box-result">검색하신 조건을 만족하는 멤버스가 없습니다.</div></c:if>
<div class="pagination">
	<front:jsPaging listVO="${listVO}" targetObject="dtl-pager" />
</div>

<script>
$(function(){
	// 페이징 클릭 이벤트
	$(document).on("click", ".dtl-pager a", function(e){
		let pageNo = $(this).data("pageNo");
		var params = {
				pageType : "search"
				, sido : $("#sido").val()
				, gugun : $("#gugun").val()
				, text : $("#srchText").val()
				}

		f_DtlList(params, pageNo);
		e.preventDefault();
	});
});
</script>