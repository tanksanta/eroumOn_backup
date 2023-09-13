<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main id="container" class="is-mypage-style">
		<header id="page-title">
			<h2>
				<span>인정등급 상담신청</span>
			</h2>
		</header>

		<jsp:include page="../../layout/page_nav.jsp" />

        <div id="page-content">

            <h3 class="mypage-title">
                인정등급 상담신청
                <button type="button" class="mypage-consult-toggle">상세검색</button>
            </h3>

            <form action="./list" method="get" id="searchFrm" name="searchFrm" class="mypage-consult-search">
                <fieldset>
                    <legend>상세 검색</legend>
                    <button type="button" class="search-close">닫기</button>
                    <dl class="search-date">
                        <dt><label for="srchRegBgng">상담 신청일</label></dt>
                        <dd>
                            <div class="form-group">
                                <input type="date" class="form-control" id="srchRegBgng" name="srchRegBgng" value="${param.srchRegBgng}">
                                <span>-</span>
                                <input type="date" class="form-control" id="srchRegEnd" name="srchRegEnd" value="${param.srchRegEnd}">
                            </div>
                            <div class="form-group-check">
                                <label class="form-check">
                                    <input type="radio" name="" value="" class="form-check-input" onclick="f_srchJoinSet('1'); return false;">
                                    <span class="form-check-label">오늘</span>
                                </label>
                                <label class="form-check">
                                    <input type="radio" name="" value="" class="form-check-input" onclick="f_srchJoinSet('2'); return false;">
                                    <span class="form-check-label">일주일</span>
                                </label>
                                <label class="form-check">
                                    <input type="radio" name="" value="" class="form-check-input" onclick="f_srchJoinSet('3'); return false;">
                                    <span class="form-check-label">15일</span>
                                </label>
                                <label class="form-check">
                                    <input type="radio" name="" value="" class="form-check-input" onclick="f_srchJoinSet('4'); return false;">
                                    <span class="form-check-label">한달</span>
                                </label>
                            </div>
                        </dd>
                    </dl>
                    <dl class="search-partner">
                        <dt><label for="srchBplcNm">상담 기관</label></dt>
                        <dd><input type="text" id="srchBplcNm" name="srchBplcNm" value="${param.srchBplcNm}" class="form-control w-full md:w-83"></dd>
                    </dl>
                    <dl class="search-current">
                        <dt><label for="srchConsltSttus">상담 접수 현황</label></dt>
                        <dd>
                            <select name="srchConsltSttus" id="srchConsltSttus" class="form-control w-full md:w-40">
                                <option value="">선택</option>
                                <option value="CS01" ${param.srchConsltSttus eq 'CS01'?'selected="selected"':''}>상담 신청 완료</option>
                                <option value="CS02" ${param.srchConsltSttus eq 'CS02'?'selected="selected"':''}>상담 기관 배정 완료</option>
                                <option value="CANCEL" ${param.srchConsltSttus eq 'CANCEL'?'selected="selected"':''}>상담 취소</option><%--상담취소 검색은 03, 04, 09가 포함되어야함 --%>
                                <%--<option value="CS03" ${param.srchConsltSttus eq 'CS03'?'selected="selected"':''}>상담 취소</option>사용자--%>
                                <%-- <option value="CS09" ${param.srchConsltSttus eq 'CS09'?'selected="selected"':''}>상담 취소</option>THKC --%>
                                <%-- <option value="CS04" ${param.srchConsltSttus eq 'CS04'?'selected="selected"':''}>상담 취소</option>사업소 --%>
                                <option value="CS05" ${param.srchConsltSttus eq 'CS05'?'selected="selected"':''}>상담 진행 중</option>
                                <option value="CS06" ${param.srchConsltSttus eq 'CS06'?'selected="selected"':''}>상담 완료</option>
                                <option value="CS07" ${param.srchConsltSttus eq 'CS07'?'selected="selected"':''}>재상담 신청 완료</option>
                                <option value="CS08" ${param.srchConsltSttus eq 'CS08'?'selected="selected"':''}>상담 기관 재배정 완료</option>
                            </select>
                        </dd>
                    </dl>
                    <button type="submit" class="btn-primary btn-animate flex mt-7 mx-auto w-full md:mt-2 md:w-43"><strong>검색</strong></button>
                </fieldset>
            </form>

            <div class="mypage-consult-desc">
                <p class="text-alert">인정등급테스트 후 1:1상담 신청한 내역을 확인하는 페이지입니다.</p>
            </div>

            <p><strong>총 ${listVO.totalCount}건</strong>의 상담신청 내역이 있습니다.</p>

            <div class="mypage-consult-items mt-3.5 md:mt-5">
                <div class="mypage-consult-item-gutter"></div>

                <c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
                <c:set var="consltSize" value="${fn:length(resultList.consltResultList)}" />
                <div class="mypage-consult-item">
                    <dl class="item-current">
                        <dt>상담진행 현황</dt>
                        <dd>
                        	<%-- 사용자/관리자 txt가 일부 달라서 코드만 동일하게 사용함 --%>
                        	<c:choose>
								<c:when test="${resultList.consltSttus eq 'CS01'}">상담 신청 완료</c:when>
								<c:when test="${resultList.consltSttus eq 'CS02'}">상담 기관 배정 완료</c:when>
								<c:when test="${resultList.consltSttus eq 'CS03'}">상담 취소</c:when>
								<c:when test="${resultList.consltSttus eq 'CS09'}">상담 취소</c:when>
								<c:when test="${resultList.consltSttus eq 'CS04'}">상담 취소</c:when>
								<c:when test="${resultList.consltSttus eq 'CS05'}">상담 진행 중</c:when>
								<c:when test="${resultList.consltSttus eq 'CS06'}">상담 완료</c:when>
								<c:when test="${resultList.consltSttus eq 'CS07'}">재상담 신청 완료</c:when>
								<c:when test="${resultList.consltSttus eq 'CS08'}">상담 기관 재배정 완료</c:when>
							</c:choose>
                        </dd>
                    </dl>
                    <dl class="item-partner">
                        <dt>상담 기관</dt>
                        <dd>
							<c:choose>
								<c:when test="${resultList.consltSttus eq 'CS01'}"><strong>상담 기관 배정 중</strong> 입니다.</c:when>
								<c:when test="${resultList.consltSttus eq 'CS03' || resultList.consltSttus eq 'CS04' || resultList.consltSttus eq 'CS09'}">상담이 취소되었습니다.</c:when>
								<c:when test="${resultList.consltSttus eq 'CS07'}"><strong>상담 기관 배정 중</strong> 입니다.
									<c:if test="${consltSize > 1 }">
									<ul class="history">
									<c:forEach items="${resultList.consltResultList}" var="consltResult" varStatus="status2">
		                                <li>
		                                    <small>${status2.index+1}차 상담</small>
		                                    <span>${consltResult.bplcNm}</span>
		                                </li>
									</c:forEach>
		                            </ul>
		                            </c:if>
								</c:when>
								<c:otherwise>
									<strong>${resultList.consltResultList[consltSize-1].bplcNm}</strong>
									<c:if test="${consltSize > 1 }">
									<ul class="history">
									<c:forEach items="${resultList.consltResultList}" begin="0" end="${consltSize-2}" var="consltResult" varStatus="status2">
		                                <li>
		                                    <small>${status2.index+1}차 상담</small>
		                                    <span>${consltResult.bplcNm}</span>
		                                </li>
									</c:forEach>
		                            </ul>
		                            </c:if>
								</c:otherwise>
							</c:choose>
                        </dd>
                    </dl>
                    <dl class="item-date">
                        <dt>상담 신청일</dt>
                        <dd><fmt:formatDate value="${resultList.regDt }" pattern="yyyy.MM.dd" /></dd>
                    </dl>
                    <%--상담 완료시 --%>
                    <c:if test="${resultList.consltSttus eq 'CS01' || resultList.consltSttus eq 'CS07'}">
                    <div class="item-request">
                    	<button type="button" class="button f_cancel" data-conslt-no="${resultList.consltNo}">상담 취소</button>
                    </div>
                    </c:if>

                    <c:if test="${resultList.consltSttus eq 'CS06'}">
                    <div class="item-request">
                    	<c:if test="${consltSize < 3}"> <%-- 상담 신청은 최대 3회 --%>
                        <button type="button" class="button f_reconslt" data-conslt-no="${resultList.consltNo}" data-bplc-unique-id="${resultList.consltResultList[consltSize-1].bplcUniqueId}" data-bplc-conslt-no="${resultList.consltResultList[consltSize-1].bplcConsltNo}">재 상담 신청</button>
						</c:if>
                        <label class="check1">
                            <input type="checkbox" name="recommend" value="${resultList.consltResultList[consltSize-1].bplcUniqueId}" ${resultList.consltResultList[consltSize-1].rcmdCnt > 0?'checked="checked"':''}>
                            <span>추천하기</span>
                        </label>
                        <label class="check2">
                            <input type="checkbox" name="itrst" value="${resultList.consltResultList[consltSize-1].bplcUniqueId}" ${resultList.consltResultList[consltSize-1].itrstCnt > 0?'checked="checked"':''}>
                            <span>관심설정</span>
                        </label>
                    </div>
                    </c:if>
                </div>
                </c:forEach>
            </div>

			<div class="pagination">
				<front:paging listVO="${listVO}" />
			</div>

            <div class="modal fade" id="reqModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog  modal-dialog-centered">
                    <form id="modalReConslt" name="modalReConslt" class="modal-content" enctype="multipart/form-data">
                    	<input type="hidden" name="consltNo" value="0">
                    	<input type="hidden" name="bplcUniqueId" value="">
                    	<input type="hidden" name="bplcConsltNo" value="0">

                        <div class="modal-header">
                            <p class="text-title">재 상담 신청 사유 입력</p>
                        </div>
                        <div class="modal-close">
                            <button type="button" data-bs-dismiss="modal">모달 닫기</button>
                        </div>
                        <div class="modal-body">
                            <p class="text-alert">재 상담 신청 사유를 입력해 주세요.</p>
                            <textarea name="reconsltResn" id="reconsltResn" cols="30" rows="10" class="form-control mt-3.5 w-full h-58"></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary btn-submit">저장하기</button>
                            <button type="button" class="btn btn-outline-primary btn-cancel" data-bs-dismiss="modal">닫기</button>
                        </div>
                    </form>
                </div>
            </div>


            <div class="modal fade" id="cancelModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog  modal-dialog-centered">
                    <form id="modalCancel" name="modalCancel" class="modal-content" enctype="multipart/form-data">
                    	<input type="hidden" name="consltNo" value="0">

                        <div class="modal-header">
                            <p class="text-title">상담 취소 사유 입력</p>
                        </div>
                        <div class="modal-close">
                            <button type="button" data-bs-dismiss="modal">모달 닫기</button>
                        </div>
                        <div class="modal-body">
                            <p class="text-alert">상담 취소 사유를 입력해 주세요.</p>
                            <textarea name="canclResn" id="canclResn" cols="30" rows="10" class="form-control mt-3.5 w-full h-58"></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary btn-cancel-submit">저장하기</button>
                            <button type="button" class="btn btn-outline-primary btn-cancel" data-bs-dismiss="modal">닫기</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </main>
	<script src="/html/core/vendor/masonry/masonry.pkgd.min.js"></script>
    <script>
    function f_srchJoinSet(ty){
    	$("#srchRegEnd").val(f_getToday());
    	if(ty == "1"){//오늘
       		$("#srchRegBgng").val(f_getToday());
    	}else if(ty == "2"){//일주일
    		$("#srchRegBgng").val(f_getDate(-7));
    	}else if(ty == "3"){//15일
    		$("#srchRegBgng").val(f_getDate(-15));
    	}else if(ty == "4"){//한달
    		$("#srchRegBgng").val(f_getDate(-30));
    	}
    }

    $(function(){
        $('.mypage-consult-items').masonry({
            itemSelector   : '.mypage-consult-item',
            gutter         : '.mypage-consult-item-gutter',
            percentPosition: true
        });

        $('.mypage-consult-toggle, .search-close').on('click', function() {
            $('body').toggleClass('overflow-hidden').find('.mypage-consult-search').toggle();
        });

        $(window).on('resize', function() {
            if(resize) $('body').removeClass('overflow-hidden').find('.mypage-consult-search').removeAttr('style');
        });

        $(".f_reconslt").on("click", function(e){
        	let consltNo = $(this).data("consltNo");
        	let bplcUniqueId = $(this).data("bplcUniqueId");
        	let bplcConsltNo = $(this).data("bplcConsltNo");
        	console.log(consltNo, bplcUniqueId, bplcConsltNo);

        	$("#modalReConslt input[name='consltNo']").val(consltNo);
        	$("#modalReConslt input[name='bplcUniqueId']").val(bplcUniqueId);
        	$("#modalReConslt input[name='bplcConsltNo']").val(bplcConsltNo);
        	$("#reqModal").modal('show');
        });


        $("#modalReConslt .btn-submit").on("click", function(){
    		$("#modalReConslt").submit();
    	});

    	$("form[name='modalReConslt']").validate({
    	    ignore: "input[type='text']:hidden, [contenteditable='true']:not([name])",
    	    rules : {
    	    	reconsltResn : { required : true}
    	    },
    	    messages : {
    	    	reconsltResn : { required : "내용을 작성해 주세요"}
    	    },
    	    submitHandler: function (frm) {

    	    	let consltNo = $("#modalReConslt input[name='consltNo']").val();
    	    	let reconsltResn = $("#modalReConslt textarea[name='reconsltResn']").val();
    	    	let bplcUniqueId = $("#modalReConslt input[name='bplcUniqueId']").val();
    	    	let bplcConsltNo = $("#modalReConslt input[name='bplcConsltNo']").val();

   	            if (confirm('해당 내역을 저장하시겠습니까?')) {
	   	            $.ajax({
	       				type : "post",
	       				url  : "./reConslt.json", //주문확인
	       				data : {
	       					consltNo:consltNo
	       					, reconsltResn:reconsltResn
	       					, bplcUniqueId:bplcUniqueId
	       					, bplcConsltNo:bplcConsltNo
	       				},
	       				dataType : 'json'
	       			})
	       			.done(function(data) {
	       				if(data.result){
	       					alert("정상적으로 저장되었습니다.");
	       					//$("#modalReConslt .btn-cancel").click();
	       					window.location.reload();
	       				}
	       			})
	       			.fail(function(data, status, err) {
	       				alert('재 상담 신청에 실패하였습니다. : ' + data);
	       			});
   	        	}else{
   	        		return false;
   	        	}
    	    }
    	});

    	// 멤버스 추가
    	$("input[name='itrst']").on("click",function(){
    		let bplcUniqueId = $(this).val();
    		let checked = $(this).is(':checked');
    		console.log(bplcUniqueId, checked);

    		var uniqueIds = [];
    		uniqueIds.push(bplcUniqueId);

    		/* 기존 관심멤서브 자원 활용 */
    		if(uniqueIds.length > 0 && checked){ //등록
   				$.ajax({
   					type : "post",
   					url  : "/membership/conslt/itrst/insertItrstBplc.json",
   					data : {
   						arrUniqueId : uniqueIds
   					},
   					traditional: true,
   					dataType : 'json'
   				}).done(function(data) {
   					if(data.result == 0){
   						$(this).prop('checked', false);
   						alert("관심 멤버스 등록에 실패했습니다. /n 관리자에게 문의바랍니다.");
   						return false;
   					}else if(data.result == 1){
   						//alert("등록되었습니다.");
   						console.log("관심 멤버스로 등록 완료");
   					}else{
   						$(this).prop('checked', false);
   						alert("관심 멤버스는 최대 5개 입니다.");
   						return false;
   					}

   				}).fail(function(data, status, err) {
   					console.log(data);
   					return false;
   				});
    		}else if(uniqueIds.length > 0 && !checked){ //삭제

    			$.ajax({
    				type : "post",
    				url  : "/membership/conslt/itrst/deleteItrstBplc.json",
    				data : {
    					uniqueId : bplcUniqueId
    				},
    				dataType : 'json'
    			})
    			.done(function(json) {
    				console.log("관심 멤버스에서 삭제 완료");
    				$(this).prop('checked', false);
    				//alert("삭제되었습니다.");
    			})
    			.fail(function(data, status, err) {
    				console.log(data);
    			});
    		}


    	});

    	$("input[name='recommend']").on("click",function(){
    		let bplcUniqueId = $(this).val();
    		let checked = $(this).is(':checked');
    		console.log(bplcUniqueId, checked);

    		if(bplcUniqueId != ""){
	    		$.ajax({
					type : "post",
					url  : "/members/bplc/rcmd/incrsAction.json",
					data : {bplcUniqueId},
					dataType : 'json'
				})
				.done(function(data) {
					console.log(data.result);
					if(data.result==="success"){
						$(this).prop('checked', false);
					}else if(data.result==="login"){
						$(this).prop('checked', false);
						alert("로그인을 해야 사용하실 수 있습니다.");
					}else if(data.result==="dislike"){
						$(this).prop('checked', false);
					/*
					}else if(data.result==="already"){
						alert("이미 '좋아요'를 하셨습니다.");
					*/
					}
				})
				.fail(function(data, status, err) {
					console.log('error forward : ' + data);
				});
    		}

    	});

    	$(".f_cancel").on("click", function(e){
        	let consltNo = $(this).data("consltNo");
        	console.log(consltNo);

        	$("#modalCancel input[name='consltNo']").val(consltNo);
        	$("#cancelModal").modal('show');
        });

    	$(".btn-cancel-submit").on("click", function(e){
    		e.preventDefault();

    		let consltNo = $("#modalCancel input[name='consltNo']").val();
    		let canclResn = $("#modalCancel textarea[name='canclResn']").val();

    		let params = {
    				consltNo:consltNo
    				, canclResn:canclResn};

    		if($("#canclResn").val() === ""){
    			alert("취소 사유를 입력해 주세요");
    			$("#canclResn").focus();
    		}else{
    			$.ajax({
    				type : "post",
    				url  : "./canclConslt.json",
    				data : params,
    				dataType : 'json'
    			})
    			.done(function(data) {
    				if(data.result){
    					alert("정상적으로 저장되었습니다.");
    				}else{
    					alert("상담 취소 처리중 에러가 발생하였습니다.");
    				}
    				location.reload();
    			})
    			.fail(function(data, status, err) {
    				console.log("ERROR : " + err);
    			});
    		}


    	});

    });
    </script>
