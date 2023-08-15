<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container" class="is-mypage-style">
		<header id="page-title">
			<h2>
				<span>관심 멤버스 설정</span>
				<small>Interested Members</small>
			</h2>
		</header>

		<jsp:include page="../../layout/page_nav.jsp" />

		<div id="page-content">

            <div class="items-center justify-between md:flex">
                <div class="space-y-1.5 md:mr-3">
                    <p class="text-alert">고객님의 관심 멤버스를 설정하실 수 있습니다.</p>
                    <p class="text-alert">설정하신 멤버스는 상품 구매 시 관심 사업소에 출력되어 쉽게 찾으실 수 있습니다.</p>
                    <p class="text-alert">관심 멤버스는 최대 5개 까지 설정 가능합니다.</p>
                </div>
                <div class="ml-auto my-3 w-46 md:my-0 md:w-53">
                    <button class="btn btn-large btn-primary w-full"  id="srchBplcBtn">멤버스 찾기</button>
                </div>
            </div>

            <div class="mt-11 space-y-4 md:mt-15 md:space-y-5">
                <c:if test="${empty bplcList}"><div class="box-result is-large">아직 등록된 관심멤버스가 없습니다</div></c:if>

				<c:forEach var="resultList" items="${bplcList}" varStatus="status">
                <div class="mypage-members-item ${resultList.bplcInfo.uniqueId}">
					<c:if test="${resultList.bplcInfo.proflImg ne null}">
						<img src="/comm/PROFL/getFile?fileName=${resultList.bplcInfo.proflImg}" class="item-thumb">
					</c:if>
					<c:if test="${resultList.bplcInfo.proflImg eq null}">
						<img src="/html/page/market/assets/images/partners_default.png" alt="" class="item-thumb">
					</c:if>

                    <div class="item-content">
                        <p class="name">${resultList.bplcInfo.bplcNm}</p>
                        <p class="addr">${resultList.bplcInfo.zip}&nbsp;${resultList.bplcInfo.addr}&nbsp;${resultList.bplcInfo.daddr}</p>
                        <p class="call"><a href="tel:${resultList.bplcInfo.telno}">${resultList.bplcInfo.telno}</a></p>
                        <div class="desc">
                            <div class="time">
                                <p>
                                    <small>영업시간</small>
                                    <c:if test="${resultList.bplcInfo.bsnHrBgng ne null}">${resultList.bplcInfo.bsnHrBgng} ~ ${resultList.bplcInfo.bsnHrEnd}</c:if>
                                </p>
                                <c:set var="hldys" value="${fn:split(fn:replace(resultList.bplcInfo.hldy,' ',''),',')}" />
                                <p>
                                    <small>휴무</small>
									<c:if test="${resultList.bplcInfo.hldy ne null}">
											<c:forEach var="day" items="${hldys}">
												<c:choose>
													<c:when test="${day ne 'Z'}">${bplcRstdeCode[day]}&nbsp;</c:when>
													<c:otherwise>${resultList.bplcInfo.hldyEtc }</c:otherwise>
												</c:choose>
											</c:forEach>
											&nbsp;
									</c:if>
                                </p>
                            </div>
							<a href="/members/${resultList.bplcInfo.bplcId}/gds/list" class="btn btn-primary btn-small flex-none" target="_blank">홈페이지 방문</a>
                        </div>
                    </div>
                    <button type="button" class="item-delete delBplc" data-unique-id="${resultList.bplcInfo.uniqueId}">삭제</button>
                </div>
				</c:forEach>
            </div>
		</div>

	<div id="bplcList"></div>
</main>

<script>
// 모달 창 호출
function f_bplcList(page){
	console.log("page", page);
	$("#bplcList").load(
			"/membership/conslt/itrst/searchBplcModal"
			, function(){
				$("#partnerModal").addClass("fade").modal("show");
				f_bplcDtl(page)
			}
		);
}

 // 모달 내부 리스트
 function f_bplcDtl(page){
	 $(".pd").load(
				"/membership/conslt/itrst/bplcListModal"
				, {
						curPage:page
						, sido:$("#sido").val()
						, gugun:$("#gugun").val()
						, srchText:$("#srchText").val()
				}
			);
 }


$(function(){

	var keys = "";
	var srcs = "";
	var partnerImg = "";
	var partnerName = "";
	var partnerAddrs = "";
	var partnerTel = "";

	// 멤버스 선택


	// 멤버스 찾기
	$("#srchBplcBtn").on("click",function(){
		f_bplcList(1);
	});

	// 페이징 클릭 이벤트
	$(document).on("click", ".bplc-pager a", function(){
		let pageNo = $(this).data("pageNo");
		f_bplcDtl(pageNo);
	});

	// 검색 이벤트
	$(document).on("click", "#searchBplc", function(){
		f_bplcDtl();
	});


	// 관심 멤버스 삭제
	$(".delBplc").on("click",function(){
		var uniqueId = $(this).data("uniqueId");

		if(confirm("해당 관심 멤버스를 삭제하시겠습니까?")){
			$.ajax({
				type : "post",
				url  : "./deleteItrstBplc.json",
				data : {
					uniqueId : uniqueId
				},
				dataType : 'json'
			})
			.done(function(json) {
				alert("삭제되었습니다.");
				location.reload();
			})
			.fail(function(data, status, err) {
				console.log(data);
			});
		}else{
			return false;
		}
	});

});


</script>