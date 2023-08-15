<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main id="container" class="is-mypage">
		<header id="page-title">
			<h2>
				<span>배송지 관리</span>
				<small>Shipping Addresses</small>
			</h2>
		</header>

		<jsp:include page="../../layout/page_nav.jsp" />

        <div id="page-content">

                <div class="items-center justify-between md:flex">
                    <div class="space-y-1.5 md:mr-3">
                        <p class="text-alert">자주 사용하시는 배송지를 등록해 두시면 더욱 더 편리하게 이용하실 수 있습니다.</p>
                        <p class="text-alert">배송 주소록에는 최대 10개 까지 주소등록이 가능합니다.</p>
                    </div>
                    <div class="ml-auto my-3 w-46 md:w-53">
                    	<button type="button" class="btn btn-large btn-primary w-full dlvyBtn" data-dlvy-btn="regist">배송지 등록</button>
                    </div>
                </div>

                <div class="mt-11 space-y-5 md:mt-15 md:space-y-7.5">
	               	<c:if test="${!empty resultList}">
					<c:forEach items="${resultList}" var="result" varStatus="status">
                    <div class="mypage-delivery">
                        <div class="delivery-title">
							<c:if test="${result.bassDlvyYn eq 'Y' }">
                            <span class="label-primary">
                           		<span>기본배송지</span>
                                <i></i>
                            </span>
                            </c:if>
                            <p class="name">${result.dlvyNm}</p>
                        </div>
                        <div class="delivery-content">
                            <c:if test="${result.bassDlvyYn eq 'N' }">
                            <button type="button" class="delivery-close delDlvyBtn" data-mng-no="${result.dlvyMngNo}">삭제하기</button>
                            </c:if>
                            <dl class="name">
                                <dt>받으시는 분</dt>
                                <dd>${result.nm}</dd>
                            </dl>
                            <dl class="call">
                                <dt>연락처</dt>
                                <dd>
									${result.mblTelno}<br>
									${result.telno}
								</dd>
                            </dl>
                            <dl class="addr">
                                <dt>주소</dt>
                                <dd>
	                                <strong>${result.zip}</strong>
	                                ${result.addr}</br>
	                                ${result.daddr}
                                </dd>
                            </dl>
                            <div class="delivery-button">
                                <button type="button" class="btn btn-primary btn-small dlvyBtn" data-mng-no="${result.dlvyMngNo}">수정</button>
                                <%--<c:if test="${result.bassDlvyYn eq 'N' }">
                                <button type="button" class="btn btn-secondary btn-small delDlvyBtn" data-mng-no="${result.dlvyMngNo}">삭제</button>
                                </c:if>--%>
                            </div>
                        </div>
                    </div>
					</c:forEach>
	               	</c:if>
	                <c:if test="${empty resultList}">
	                <div class="box-result is-large">아직 등록하신 배송지가 없습니다</div>
	                </c:if>
                </div>
            </div>

    </main>

    <div id="dlvyView"></div>

    <script>
    $(function(){
    	//modal callback
    	$(".dlvyBtn").on("click",function(){
    		var type = $(this).data("dlvyBtn");
    		var mngNo = $(this).data("mngNo");

    		if(type == "regist"){
    			$.ajax({
    				type : "post",
    				url  : "baseDlvyChk.json",
    				data : {paramType :type},
    				dataType : 'json'
    			})
    			.done(function(data) {
    				if(data.result == true && data.totalCount < 10){
    					$("#dlvyView").load("./dlvyMngModal"
    							, {dlvyMngNo : mngNo}
    							, function(){
    								$("#dlvyModal").addClass("fade").modal("show");
    					});
    				}else{
    					alert("배송지는 최대 10개 까지 가능합니다.");
    				}
    			})
    			.fail(function(data, status, err) {
    				alert("배송지 검사 중 오류가 발생했습니다. \n 관리자에게 문의 바랍니다.");
    				console.log('error forward : ' + data);
    			});
    		}else{
    			$("#dlvyView").load("./dlvyMngModal"
						, {dlvyMngNo : mngNo}
						, function(){
							$("#dlvyModal").addClass("fade").modal("show");
				});
    		}

    	});

    	//삭제
    	$(".delDlvyBtn").on("click",function(){
    		var mngNo = $(this).data("mngNo");
    		if(confirm("이 배송지를 삭제하시겠습니까?")){
       			$.ajax({
    				type : "post",
    				url  : "delDlvyMng.json",
    				data : {dlvyMngNo :mngNo},
    				dataType : 'json'
    			})
    			.done(function(data) {
    				if(data.result == true){
    					alert("정상적으로 삭제되었습니다.");
    					location.reload();
    				}else{
    					alert("배송지 삭제 중 오류가 발생했습니다. \n 관리자에게 문의 바랍니다.");
    				}
    			})
    			.fail(function(data, status, err) {
    				alert("배송지 삭제 중 오류가 발생했습니다. \n 관리자에게 문의 바랍니다.");
    				console.log('error forward : ' + data);
    			});
    		}else{
    			return false;
    		}
    	});
    });
    </script>
