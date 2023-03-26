<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 교환접수 --%>

			<!-- 교환 접수 -->
			<form name="frmOrdrExchng" id="frmOrdrExchng" method="post" enctype="multipart/form-data">
			<input type="hidden" id="ordrDtlNo" name="ordrDtlCd" value="${ordrDtlCd}">
			<input type="hidden" id="ordrNo" name="ordrNo" value="${ordrNo}">
            <div class="modal fade modal-inner" id="ordr-exchng-modal" tabindex="-1">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <p>교환접수</p>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
                        </div>
                        <div class="modal-body">
                            <p class="text-title2 relative">
                                교환상품 선택
                                <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm">
                                    (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수선택사항입니다.)
                                </span>
                            </p>
                            <table class="table-list" id="optnTable">
                                <colgroup>
                                    <col class="w-25">
                                    <col>
                                    <col class="w-20">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th scope="col">상품구분</th>
                                        <th scope="col">주문상품/옵션정보</th>
                                        <th scope="col">수량</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<c:forEach items="${ordrDtlList}" var="ordrDtl" varStatus="status">
                                    <tr>
                                        <td class="${ordrDtl.ordrDtlCd}">
                                        	${gdsTyCode[ordrDtl.gdsTy]}
                                        </td>
                                        <td class="text-left leading-tight">
                                            <c:if test="${ordrDtl.ordrOptnTy eq 'ADIT' }"><%--추가상품--%>
                                        	<i class="ico-reply"></i>
                                        	<span class="badge">추가옵션</span>
                                        	<p class="ml-3" style="display:inline-flex;">
                                            ${ordrDtl.ordrOptn}
                                            </p>
                                        	</c:if>
                                        	<c:if test="${ordrDtl.ordrOptnTy eq 'BASE' }"><%--상품--%>
											<p>
											<span class="badge-outline-success">${ordrDtl.gdsCd}</span><br>
                                            ${ordrDtl.gdsNm}
                                            <c:if test="${!empty ordrDtl.ordrOptn}"><br>(${ordrDtl.ordrOptn})</c:if>
                                            </p>
                                        	</c:if>
                                        </td>
                                        <td class="${ordrDtl.ordrDtlCd}">${ordrDtl.ordrQy}</td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>


                            <p class="text-title2 relative mt-10">
                                교환사유
                                <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm">
                                    (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
                                </span>
                            </p>
                            <table class="table-detail">
                                <colgroup>
                                    <col class="w-36">
                                    <col>
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th scope="row"><label for="resnTy" class="require">사유</label></th>
                                        <td>
                                        	<select id="resnTy" name="resnTy" class="form-control w-full">
                                        		<option value="">사유를 선택해주세요.</option>
                                        		<c:forEach items="${ordrExchngTyCode}" var="iem">
                                        		<option value="${iem.key}">${iem.value}</option>
                                        		</c:forEach>
                                        	</select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="resn">상세사유</label></th>
                                        <td>
                                        	<textarea id="resn" name="resn" cols="10" rows="6" class="form-control w-full"></textarea>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>




                        </div>
                        <div class="modal-footer">
                            <div class="btn-group">
                                <button type="button" class="btn-primary large shadow f_ordr_exchng_save">확인</button>
                                <button type="button" class="btn-secondary large shadow" data-bs-dismiss="modal">취소</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </form>
            <!-- //교환 접수 -->


            <script>
            $(function(){

            	$('#optnTable tbody').mergeClassRowspan(0);

            	// focus
            	$("#optn-chg-modal").on("shown.bs.modal", function () {
            		$("#resnTy").focus();
            	});

            	$(".f_ordr_exchng_save").on("click", function(){
            		if($("#resnTy").val() == ""){
    					alert("교환사유를 선택하세요");
            		}else {
	           			if(confirm("선택하신 상품을 교환신청 하시겠습니까?")) {

		            		$.ajax({
		        				type : "post",
		        				url  : "./ordrExchngRcpt.json",
		        				data : {
		        					ordrNo:'${ordrDtlList[0].ordrNo}'
		        					, ordrDtlCd:'${ordrDtlList[0].ordrDtlCd}'
		        					, resnTy:$("#resnTy").val()
									, resn:$("#resn").val()
		        				},
		        				dataType : 'json'
		        			})
		        			.done(function(data) {
		        				if(data.result){
		        					console.log("success");
		        					const successHtml = '<div class="alert alert-success fade show"><p class="moji">:)</p><p class="text">교환신청이 접수되었습니다.</p><button type="button" data-bs-dismiss="alert" aria-label="close">닫기</button></div>';
		        					$(successHtml).insertAfter("#optnTable").fadeOut(1000, function(){
		        						$(".btn-reload, .modal-inner .btn-close").click();
		        						$(this).remove();
		        					});;
		        				}

		        			})
		        			.fail(function(data, status, err) {
		        				console.log('error forward : ' + data);
		        			});
	           			}
            		}
           		});

            });

            </script>