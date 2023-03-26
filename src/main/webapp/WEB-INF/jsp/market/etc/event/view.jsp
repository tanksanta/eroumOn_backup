<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<jsp:include page="../../layout/page_header.jsp" >
		<jsp:param value="이로움 이벤트" name="pageTitle"/>
	</jsp:include>

	<div id="page-container">
		<div id="page-content">
			<div class="event-slogan">
				<picture class="name">
				<source srcset="/html/page/market/assets/images/txt-event-eroum-mobile.svg" media="(max-width: 768px)">
				<source srcset="/html/page/market/assets/images/txt-event-eroum.svg">
				<img src="/html/page/market/assets/images/txt-event-eroum.svg" alt="" /> </picture>
				<img src="/html/page/market/assets/images/img-shopbag.png" alt="" class="bags">
				<p class="desc">
					즐거움이 함께하는 <br> 이로움 이벤트
				</p>
			</div>

			<c:set var="now" value="<%=new java.util.Date()%>" />
			<c:set var="pageParam" value="curPage=${param.curPage}&amp;sortVal=${param.sortVal}" />

			<!-- 이벤트 진행 중일 때 -->

			<%-- 공통 적용 --%>
			<%-- 당첨자 제외 --%>




			<div class="board-detail is-event mt-5 md:mt-10">
						<div class="detail-header">
							<div class="name">
								<strong>${eventVO.eventNm}</strong>
							</div>
							<div class="date">
								<p>
									<fmt:formatDate value="${eventVO.bgngDt}" pattern="yyyy-MM-dd" />
									~
									<fmt:formatDate value="${eventVO.endDt}" pattern="yyyy-MM-dd" />
								</p>
								<c:if test="${! empty eventVO.prsntnYmd}">
									<p>
										<strong>당첨자 발표일</strong>
										<fmt:formatDate value="${eventVO.prsntnYmd}" pattern="yyyy-MM-dd" />
									</p>
								</c:if>
							</div>
						</div>

						<div class="detail-body">${eventVO.eventCn}</div>

				<%-- 공통 적용 --%>

				<!-- 이미지 응모 -->
				<c:if test="${eventIemList[0].iemTy eq 'img'}">
				<form class="event-apply is-images" action="./action" id="appImgFrm" nam="appImgFrm" method="post">
				<input type="hidden" id="eventNo" name="eventNo" value="${eventVO.eventNo}">
				<input type="hidden" id="eventTy" name="eventTy" value="${eventVO.eventTy}" />

					<div class="apply-items">
						<c:forEach var="iemList" items="${eventVO.iemList}" varStatus="status">
							<div class="form-check iemTr">
								<input class="form-check-input" type="radio" id="iem${status.index}" name="iem" value="${iemList.orgnlFileNm}">
								<label class="form-check-label" for="iem${status.index}">
									<div class="thumb">
										<img src="/comm/getImage?srvcId=EVENT&amp;upNo=${iemList.upNo}&amp;fileTy=${iemList.fileTy}&amp;fileNo=${iemList.fileNo}"/>
									</div>
								</label>
							</div>
						</c:forEach>
					</div>

					<c:if test="${eventVO.iemList.size() ne 0 }">
						<c:choose>
							<c:when test="${eventVO.bgngDt < now && now < eventVO.endDt}">
								<button type="submit" class="apply-submit" id="applcn-btn" data-event-ty="${eventVO.eventTy}">응모하기</button>
							</c:when>
							<c:otherwise>
								<div class="apply-items">
									<span class="apply-submit disabled">종료된 이벤트입니다</span>
								</div>
							</c:otherwise>
						</c:choose>
					</c:if>
				</form>
				</c:if>
				<!-- 이미지 응모 -->

				<!--  텍스트 응모 -->
				<c:if test="${eventIemList[0].iemTy eq 'text'}">
					<form class="event-apply" action="./action" id="appFrm" name="appFrm" method="post">
					<input type="hidden" id="eventNo" name="eventNo" value="${eventVO.eventNo}">
							<div class="apply-items">
							<c:forEach var="textList" items="${eventIemList}" varStatus="status">
								<div class="form-check">
									<input class="form-check-input" type="radio" id="iemCn${status.index}" name="iemCn" value="${textList.iemNo}">
									<label class="form-check-label" for="iemCn${status.index}">${textList.iemCn}</label>
								</div>
							</c:forEach>
						</div>
						<c:choose>
							<c:when test="${(eventVO.bgngDt > now ||  now > eventVO.endDt) &&  eventVO.przwinCount < 1}">
								<div class="apply-items">
									<span class="apply-submit disabled">종료된 이벤트입니다</span>
								</div>
							</c:when>
							<c:otherwise>
								<button type="submit" class="apply-submit" id="applcn-btn" data-event-ty="${eventVO.eventTy}">응모하기</button>
							</c:otherwise>
						</c:choose>
					</form>
				</c:if>
				<!--  //텍스트 응모 -->


				<%-- 공통 적용 --%>
				<c:if test="${(now > eventVO.endDt && eventVO.eventTy eq 'A') || (now > eventVO.endDt && eventVO.eventTy eq 'F')}">
					<div class="event-apply">
						<span class="apply-submit disabled">종료된 이벤트입니다</span>
					</div>
				</c:if>
				<c:if test="${eventVO.bgngDt < now && now < eventVO.endDt && eventVO.eventTy eq 'A'}">
					<form action="./action" id="appType" name="appType" method="post">
					<input type="hidden" id="eventNo" name="eventNo" value="${eventVO.eventNo}" />
					<input type="hidden" id="eventTy" name="eventTy" value="${eventVO.eventTy }" />
						<div class="event-apply">
							<button type="submit" class="apply-submit" id="applcn-btn" data-event-ty="${eventVO.eventTy}">응모하기</button>
						</div>
					</form>
				</c:if>
				<a href="./list?${pageParam}" class="detail-golist">목록으로</a>
				<%-- //공통 적용 --%>
			</div>
			<%-- 당첨자 제외// --%>

		</div>
	</div>
</main>

<script>

$(function(){

	$("form#appFrm, form#appImgFrm, form#appType").validate({
	    ignore: "input[type='text']:hidden"
	    , submitHandler: function (frm) {

	    	if($("#applcn-btn").data("eventTy") != null && $("#applcn-btn").data("eventTy") == "S"){
	    		if($("input[type='radio']:checked").length < 1){
					alert("항목 선택 후 응모를 진행해주세요.");
					return false;
				}
	    	}

    		$.ajax({
				type : "post",
				url  : "/market/etc/event/applcnChk.json",
				data : {
					eventNo : $("#eventNo").val()
					},
				dataType : 'json'
			})
			.done(function(data) {
				if(data == 0){
					if(confirm("응모하시겠습니까?")){
			   			frm.submit();
			   		}else{
			   			return false;
			   		}
				}else if(data == 1){
					alert("회원 로그인 후 응모 가능합니다.");
					window.location="/market/login";
				}else if(data == 2){
					alert("이미 응모한 이벤트입니다. 응모해 주셔서 감사합니다.");
					return false;
				}
			})
			.fail(function(data, status, err) {
				console.log(status + ' : 응모 확인 검사 중 오류가 발생했습니다.');
			});
	    }
	});

	//체크박스 다중 선택 불가
	/*
	$("input[name='iem']").on("click",function(){
		$("input[name='iem']").prop("checked",false);
		$(this).prop("checked",true);
	});
*/
});
</script>