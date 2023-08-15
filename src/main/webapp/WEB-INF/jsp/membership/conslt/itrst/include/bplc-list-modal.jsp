<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
<div class="mypage-members-item bplcList bplc${status.index}" data-unique-id="${resultList.uniqueId}">
<c:if test="${resultList.proflImg eq null }">
	<img src="/html/page/market/assets/images/partners_default.png" alt="" class="item-thumb">
</c:if>
<c:if test="${resultList.proflImg ne null}">
	<img src="/comm/PROFL/getFile?fileName=${resultList.proflImg}" class="item-thumb">
</c:if>
    <div class="item-content">
        <p class="name">${resultList.bplcNm}</p>
        <p class="addr">${resultList.zip}&nbsp;${resultList.addr}&nbsp;${resultList.daddr}</p>
        <p class="call"><a href="tel:${resultList.telno}">${resultList.telno}</a></p>
        <div class="desc">
            <div class="time">
                <p>
                    <small>영업시간</small>
                    <c:if test="${resultList.bsnHrBgng ne null }">${resultList.bsnHrBgng} ~ ${resultList.bsnHrEnd}</c:if>
                </p>
                <c:set var="hldys" value="${fn:split(fn:replace(resultList.hldy,' ',''),',')}" />
					<p>
						<small>휴무</small>
						<c:if test="${resultList.hldy ne null}">
							<c:forEach var="day" items="${hldys}">
								<c:choose>
									<c:when test="${day ne 'Z'}">${bplcRstdeCode[day]}&nbsp;</c:when>
									<c:otherwise>${resultList.hldyEtc }</c:otherwise>
								</c:choose>
							</c:forEach>
									&nbsp;
							</c:if>
					</p>
				</div>
			<a href="/members/${resultList.bplcId}/gds/list" class="btn btn-primary btn-small flex-none" target="_blank">홈페이지 방문</a>
        </div>
    </div>
    <label class="item-love">
		<input type="checkbox" name="">
        <span>선택</span>
    </label>
</div>
</c:forEach>
<c:if test="${empty listVO.listObject}">
	<div class="box-result mt-4.5">검색하신 조건을 만족하는 멤버스가 없습니다.</div>
</c:if>

<div class="pagination">
	<front:jsPaging listVO="${listVO}" targetObject="bplc-pager" />
</div>

<script>
$(function(){

	const ownList = [];

	// 모달 체크
	<c:forEach var="result" items="${listVO.listObject}" varStatus="status">
		<c:forEach var="item" items="${itemList}">
			if($(".bplc"+"${status.index}").data("uniqueId") == "${item.bplcUniqueId}"){
				$(".bplc"+"${status.index}").addClass("is-active");
				ownList.push("${item.bplcUniqueId}");
			}
		</c:forEach>
	</c:forEach>

	// 관심 클릭 이벤트
	$(document).on("click",".bplcList", function(e){
		var thisData = $(this).data("uniqueId");

		if($(this).hasClass("is-active")){
			$(this).removeClass("is-active");
			uniqueIds = uniqueIds.filter((element) => element !== $(this).data("uniqueId"));
		}else{
			// 최대 5개
			if(uniqueIds.length > 4){
				alert("관심멤버스는 최대 5개까지 가능합니다.");
				return false;
			}else{
				// 중복 검사
				if(!ownList.includes(thisData)){
					uniqueIds.push(thisData);
				}
				$(this).addClass("is-active");

			}
		}

	});


})
</script>