<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 옵션변경 --%>

			<!-- 옵션 변경 -->
			<form name="frmOrdrChg" id="frmOrdrChg" method="post" enctype="multipart/form-data">
            <div class="modal fade modal-inner" id="optn-chg-modal" tabindex="-1">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <p>옵션/수량 변경</p>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
                        </div>
                        <div class="modal-body">
                            <%--상품소개 --%>
                            <table class="table-detail">
                            	<colgroup>
                                    <col class="w-50">
                                    <col>
                                </colgroup>
                                <tbody>
	                            	<tr>
	                            		<td style="padding:10px;">
											<c:if test="${not empty gdsVO.thumbnailFile.fileNo}">
											<img src="/comm/getImage?srvcId=GDS&amp;upNo=${gdsVO.thumbnailFile.upNo}&amp;fileTy=${gdsVO.thumbnailFile.fileTy }&amp;fileNo=${gdsVO.thumbnailFile.fileNo}&amp;thumbYn=Y" alt="썸네일 이미지" class="w-50" />
											</c:if>
											<c:if test="${empty gdsVO.thumbnailFile.fileNo}">
											<img src="/html/page/market/assets/images/noimg.jpg" alt="">
											</c:if>
	                            		</td>
	                            		<td>
											<table class="table-detail">
				                            	<colgroup>
				                                    <col class="w-32">
				                                    <col>
				                                </colgroup>
				                                <tbody>
				                                	<tr>
					                            		<th>상품유형</th>
					                            		<td>${gdsTyCode[gdsVO.gdsTy]}</td>
					                            	</tr>
					                            	<tr>
					                            		<th>상품코드</th>
					                            		<td><span class="badge-outline-success">${gdsVO.gdsCd }</span></td>
					                            	</tr>
					                            	<tr>
					                            		<th>판매가</th>
					                            		<td><fmt:formatNumber value="${gdsVO.pc}" pattern="###,###" /></td>
					                            	</tr>
					                            	<tr>
					                            		<th>급여가</th>
					                            		<td>
					                            			<fmt:formatNumber value="${gdsVO.bnefPc}" pattern="###,###" /> <br>
					                            			(15%: <fmt:formatNumber value="${gdsVO.bnefPc15}" pattern="###,###" /> / 9%: <fmt:formatNumber value="${gdsVO.bnefPc9}" pattern="###,###" /> / 6%: <fmt:formatNumber value="${gdsVO.bnefPc6}" pattern="###,###" />)
					                            		</td>
					                            	</tr>
					                            	<tr>
					                            		<th>대여가(월)</th>
					                            		<td><fmt:formatNumber value="${gdsVO.lendPc }" pattern="###,###" /></td>
					                            	</tr>
				                            	</tbody>
				                            </table>
	                            		</td>
	                            	</tr>
                            	</tbody>
                            </table>
                            <table class="table-detail mt-10 optn-table">
                                <colgroup>
                                    <col class="w-32">
                                    <col>
                                </colgroup>
                                <tbody>
                                	<%-- 기본옵션 --%>
                                	<c:set var="optnTtl" value="${fn:split(gdsVO.optnTtl, '|')}" />
                                	<c:set var="optnVal" value="${fn:split(gdsVO.optnVal, '|')}" />
                                	<c:if test="${!empty optnTtl[0]}">
                                    <tr>
                                        <th scope="row">${optnTtl[0]} / ${optnVal[0]}</th>
                                        <td>
                                            <select name="optnVal1" id="optnVal1" class="form-control w-full" data-optn-ty="BASE">
                                                <option value="">${optnTtl[0]} 선택</option>
                                            </select>
                                        </td>
                                    </tr>
                                    </c:if>
                                    <c:if test="${!empty optnTtl[1]}">
                                    <tr>
                                        <th scope="row">${optnTtl[1]} / ${optnVal[1]}</th>
                                        <td>
                                            <select name="optnVal2" id="optnVal2" class="form-control w-full" data-optn-ty="BASE" disabled="disabled">
                                                <option value="">${optnTtl[1]} 선택</option>
                                            </select>
                                        </td>
                                    </tr>
                                    </c:if>
                                    <c:if test="${!empty optnTtl[2]}">
                                    <tr>
                                        <th scope="row">${optnTtl[2]} / ${optnVal[2]}</th>
                                        <td>
                                            <select name="optnVal3" id="optnVal3" class="form-control w-full" data-optn-ty="BASE" disabled="disabled">
                                                <option value="">${optnTtl[2]} 선택</option>
                                            </select>
                                        </td>
                                    </tr>
                                    </c:if>

									<c:if test="${!empty gdsVO.aditOptnTtl}">
									<c:set var="aditOptnTtl" value="${fn:split(gdsVO.aditOptnTtl, '|')}" />
									<c:forEach var="aditOptn" items="${aditOptnTtl}" varStatus="status">
                                    <!-- 추가옵션 -->
	                                <tr>
	                                	<th scope="row">${aditOptn}</th>
	                                	<td>
	                                		<select name="aditOptnVal" id="aditOptnVal${status.index }" class="form-control w-full" data-optn-ty="ADIT">
                                                <option value="">${aditOptn} 선택</option>
			                                    <c:forEach var="aditOptnList" items="${gdsVO.aditOptnList}" varStatus="status">
				                                <c:set var="spAditOptnTtl" value="${fn:split(aditOptnList.optnNm, '*')}" />
			                                    <c:if test="${fn:trim(aditOptn) eq fn:trim(spAditOptnTtl[0])}">

	                                                <option value="${aditOptnList.optnNm}|${aditOptnList.optnPc}|${aditOptnList.optnStockQy}">${spAditOptnTtl[1]}</option>

		                                		</c:if>
		                                		</c:forEach>
                                            </select>
	                                	</td>
	                                </tr>
	                                </c:forEach>
	                                </c:if>
                                </tbody>
                            </table>

							<%-- 선택옵션정보 --%>
                            <table class="table-list mt-10 ordr-dtl-chg-list">
                                <colgroup>
                                    <col class="w-28">
                                    <col>
                                    <col class="w-35">
                                    <col class="w-25">
                                    <col class="w-20">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th scope="col">옵션</th>
                                        <th scope="col">상품/옵션정보</th>
                                        <th scope="col">상품가격</th>
                                        <th scope="col">수량</th>
                                        <th scope="col">관리</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<c:forEach items="${ordrDtlList}" var="ordrDtl" varStatus="status">
                                    <tr class="tr_${ordrDtl.ordrDtlNo} optn_${ordrDtl.ordrOptnTy}">
                                        <td>
                                        	<%-- ${gdsTyCode[ordrDtl.gdsTy]} --%>
                                        	<c:if test="${ordrDtl.ordrOptnTy eq 'BASE' }">
                                        		선택옵션
                                        	</c:if>
                                        	<c:if test="${ordrDtl.ordrOptnTy eq 'ADIT' }">
                                        		추가옵션
                                        	</c:if>

											<input type="hidden" name="ordrNo" value="${ordrDtl.ordrNo}">
											<input type="hidden" name="ordrCd" value="${ordrDtl.ordrCd}">
											<input type="hidden" name="ordrDtlNo" value="${ordrDtl.ordrDtlNo}">
											<input type="hidden" name="ordrDtlCd" value="${ordrDtl.ordrDtlCd}">
											<input type="hidden" name="gdsNo" value="${ordrDtl.gdsNo}">
											<input type="hidden" name="gdsCd" value="${ordrDtl.gdsCd}">
											<input type="hidden" name="bnefCd" value="${ordrDtl.bnefCd}">
											<input type="hidden" name="gdsNm" value="${ordrDtl.gdsNm}">
											<input type="hidden" name="gdsPc" value="${ordrDtl.gdsPc}">

                                        	<input type="hidden" name="ordrOptnTy" value="${ordrDtl.ordrOptnTy}">
                                        	<input type="hidden" name="ordrOptn" value="${ordrDtl.ordrOptn}">
                                        	<input type="hidden" name="ordrOptnPc" value="${ordrDtl.ordrOptnPc}">

                                        	<input type="hidden" name="recipterUniqueId" value="${ordrDtl.recipterUniqueId}">
                                        	<input type="hidden" name="bplcUniqueId" value="${ordrDtl.bplcUniqueId}">

                                        	<input type="hidden" name="sttsTy" value="${ordrDtl.sttsTy}">
                                        </td>
                                        <td class="text-left leading-tight">
                                        	<c:if test="${ordrDtl.ordrOptnTy eq 'ADIT' }"><%--추가상품--%>
                                        	<i class="ico-reply"></i> <span class="badge">추가옵션</span>
                                        	<p class="ml-3" style="display:inline-flex;">
                                            ${ordrDtl.ordrOptn}
                                            </p>
                                        	</c:if>
                                        	<c:if test="${ordrDtl.ordrOptnTy eq 'BASE' }"><%--상품--%>
											<p>
											<span class="badge-outline-success">${ordrDtl.gdsCd}</span><br>
                                            ${ordrDtl.gdsNm}<br>
                                            (<span class="ordrOptn">${ordrDtl.ordrOptn}</span>)
                                            </p>
                                        	</c:if>
                                        </td>
                                        <td>
                                        	<c:if test="${ordrDtl.ordrOptnTy eq 'BASE'}">
                                        	<fmt:formatNumber value="${ordrDtl.gdsPc}" pattern="###,###" />
                                        	<br>(<span class="ordrOptnPc">+<fmt:formatNumber value="${ordrDtl.ordrOptnPc}" pattern="###,###" /></span>)
                                        	</c:if>
                                        	<c:if test="${ordrDtl.ordrOptnTy eq 'ADIT'}"><span class="ordrOptnPc">
                                        	+<fmt:formatNumber value="${ordrDtl.ordrOptnPc}" pattern="###,###" /></span>
                                        	</c:if>
                                        </td>
                                        <td>
                                        	<input type="number" name="ordrQy" class="form-control tiny numbercheck" value="${ordrDtl.ordrQy }" min="1" max="9999">
                                        </td>
                                        <td>
                                        	<c:if test="${ordrDtl.ordrOptnTy eq 'BASE' }">
                                        	-
                                        	</c:if>
                                        	<c:if test="${ordrDtl.ordrOptnTy eq 'ADIT' }">
                                        	<button type="button" class="btn-danger tiny shadow" onclick="f_ordr_dtl_del(this); return false;" data-dtl-no="${ordrDtl.ordrDtlNo}">삭제</button>
                                        	</c:if>
                                        </td>
                                    </tr>
                                    </c:forEach>

                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn-primary large shadow w-26 f_ordrdtl_optn_chg">확인</button>
                            <button type="button" class="btn-secondary large shadow w-26" data-bs-dismiss="modal" aria-label="close">취소</button>
                        </div>
                    </div>
                </div>
            </div>

            <input type="hidden" id="delOrdrDtlNo" name="delOrdrDtlNo" value="" />
            </form>

            <script>
            function f_optnVal1(optnVal, optnTy){
            	$("#optnVal1 option[value!='']").remove();

           		$.ajax({
       				type : "post",
       				url  : "/_mng/gds/optn/getOptnInfo.json",
       				data : {
       					gdsNo:'${gdsVO.gdsNo}'
       					, optnTy:optnTy
       					, optnVal:optnVal
       				},
       				dataType : 'json'
       			})
       			.done(function(json) {
       				if(json.result){
       					$("#optnVal1").prop("disabled", false);
        				var oldOptnNm = "";
       					$.each(json.optnList, function(index, data){
        					var optnNm = data.optnNm.split("*");
        					if(oldOptnNm != optnNm[0]){
	        					if(optnNm.length < 2){
	        						var optnPc = "";
	        						var optnSoldout = "";
	        						if(data.optnPc > 0){ optnPc = " + " + data.optnPc +"원"; }
	        						if(data.optnStockQy < 1){ optnSoldout = " [품절]"; }
	        						$("#optnVal1").append("<option value='"+ data.optnNm +"|"+ data.optnPc +"|"+ data.optnStockQy +"'>"+ optnNm[0] + optnPc + optnSoldout +"</option>");
	        					}else{
	        						$("#optnVal1").append("<option value='"+ data.optnNm +"'>"+ optnNm[0] +"</option>");
	        					}
	        					oldOptnNm = optnNm[0];
        					}
       	                });
       				}else{
       					$("#optnVal1").prop("disabled", true);
       				}

       			})
       			.fail(function(data, status, err) {
       				console.log('error forward : ' + data);
       			});
            }

            function f_optnVal2(optnVal1, optnTy){ // 추후 사용자에서도 사용할 예정
            	$("#optnVal2 option[value!='']").remove();
            	$("#optnVal3 option[value!='']").remove();
        		if(optnVal1!=""){
            		$.ajax({
        				type : "post",
        				url  : "/_mng/gds/optn/getOptnInfo.json",
        				data : {
        					gdsNo:'${gdsVO.gdsNo}'
        					, optnTy:optnTy
        					, optnVal:optnVal1
        				},
        				dataType : 'json'
        			})
        			.done(function(json) {
        				if(json.result){
        					$("#optnVal2").prop("disabled", false);
	        				var oldOptnNm = "";
        					$.each(json.optnList, function(index, data){
	        					var optnNm = data.optnNm.split("*");
	        					if(oldOptnNm != optnNm[1]){
		        					if(optnNm.length < 3){
		        						var optnPc = "";
		        						var optnSoldout = "";
		        						if(data.optnPc > 0){ optnPc = " + " + data.optnPc +"원"; }
		        						if(data.optnStockQy < 1){ optnSoldout = " [품절]"; }
		        						$("#optnVal2").append("<option value='"+ data.optnNm+"|"+ data.optnPc +"|"+ data.optnStockQy +"'>"+ optnNm[1] + optnPc + optnSoldout +"</option>");
		        					}else{
		        						$("#optnVal2").append("<option value='"+ data.optnNm +"'>"+ optnNm[1] +"</option>");
		        					}
		        					oldOptnNm = optnNm[1];
	        					}
        	                });
        				}else{
        					$("#optnVal2").prop("disabled", true);
        				}

        			})
        			.fail(function(data, status, err) {
        				console.log('error forward : ' + data);
        			});
        		}else{
        			$("#optnVal2").prop("disabled", true);

        			// 3번 옵션도
        			$("#optnVal3").prop("disabled", true);
        		}
            }

            function f_optnVal3(optnVal2, optnTy){ // 추후 사용자에서도 사용할 예정
            	$("#optnVal3 option[value!='']").remove();
        		if(optnVal2!=""){
            		$.ajax({
        				type : "post",
        				url  : "/_mng/gds/optn/getOptnInfo.json",
        				data : {
        					gdsNo:'${gdsVO.gdsNo}'
        					, optnTy:optnTy
        					, optnVal:optnVal2
        				},
        				dataType : 'json'
        			})
        			.done(function(json) {
        				if(json.result){
        					$("#optnVal3").prop("disabled", false);
	        				var oldOptnNm = "";
        					$.each(json.optnList, function(index, data){
	        					var optnNm = data.optnNm.split("*");
        						var optnPc = "";
        						var optnSoldout = "";
        						if(data.optnPc > 0){ optnPc = " + " + data.optnPc +"원"; }
        						if(data.optnStockQy < 1){ optnSoldout = " [품절]"; }
        						$("#optnVal3").append("<option value='"+ data.optnNm+"|"+ data.optnPc +"|"+ data.optnStockQy +"'>"+ optnNm[2] + optnPc + optnSoldout +"</option>");
        	                });
        				}else{
        					$("#optnVal3").prop("disabled", true);
        				}

        			})
        			.fail(function(data, status, err) {
        				console.log('error forward : ' + data);
        			});
        		}else{
        			$("#optnVal2").prop("disabled", true);
        		}
            }

            function f_ordr_dtl_del(obj) {
				//console.log($(obj).data("dtlNo"));
				if($("#delOrdrDtlNo").val()==""){
    				$("#delOrdrDtlNo").val($(obj).data("dtlNo"));
    			}else{
    				$("#delOrdrDtlNo").val($("#delOrdrDtlNo").val()+","+$(obj).data("dtlNo"));
    			}
				$(obj).parents("tr").remove();

            }



            function f_baseOptnChg(optnVal){
            	var spOptnVal = optnVal.split("|");
				console.log($(".ordr-dtl-chg-list tbody input[name='ordrOptn'][value='"+spOptnVal[0]+"']").length);

				if($(".ordr-dtl-chg-list tbody .optn_BASE input[name='ordrOptn']").val().trim() == spOptnVal[0].trim()){
					alert("["+spOptnVal[0] + "]은(는) 이미 추가된 옵션상품입니다.");
				}else{
					$(".ordr-dtl-chg-list tbody .optn_BASE").find("input[name='ordrOptn']").val(spOptnVal[0]);
					$(".ordr-dtl-chg-list tbody .optn_BASE").find("input[name='ordrOptnPc']").val(spOptnVal[1]);
					$(".ordr-dtl-chg-list tbody .optn_BASE").find("span.ordrOptn").text(spOptnVal[0]);
					$(".ordr-dtl-chg-list tbody .optn_BASE").find("span.ordrOptnPc").text("+"+spOptnVal[1]);
				}
            }

            $(function(){

            	//$('.ordr-dtl-chg-list tbody').mergeClassRowspan(0);

            	// foucs
            	$("#optn-chg-modal").on("shown.bs.modal", function () {
            		$("#optnVal1").focus();
            	});

            	<c:if test="${!empty optnTtl[0]}">
            	// 기본 옵션 1번
				f_optnVal1('', 'BASE');
				<c:if test="${empty optnTtl[1]}">
				$("#optnVal1").on("change", function(){
					const optnVal1 = $(this).val();
					if(optnVal1 != ""){
						f_baseOptnChg(optnVal1);
					}
				});
				</c:if>
            	</c:if>

            	<c:if test="${!empty optnTtl[1]}">
            	// 기본 옵션 2번
            	$("#optnVal1").on("change", function(){
            		const optnVal1 = $(this).val().split("*");
            		const optnTy = $(this).data("optnTy");
            		f_optnVal2(optnVal1[0].trim(), optnTy);
            	});

            	<c:if test="${empty optnTtl[2]}">
				$("#optnVal2").on("change", function(){
					const optnVal2 = $(this).val();
					if(optnVal2 != ""){
						f_baseOptnChg(optnVal2);
					}
				});
				</c:if>

            	</c:if>

            	<c:if test="${!empty optnTtl[2]}">
            	// 기본 옵션 3번
            	$("#optnVal2").on("change", function(){
            		const optnVal2 = $(this).val().split("*");
            		const optnTy = $(this).data("optnTy");
            		f_optnVal3(optnVal2[0].trim() +" * " +optnVal2[1].trim(), optnTy);
            	});

            	$("#optnVal3").on("change", function(){
					const optnVal = $(this).val();
					if(optnVal != ""){
						f_baseOptnChg(optnVal);
					}
				});
            	</c:if>


            	// 추가옵션
            	$(".optn-table select[name='aditOptnVal']").on("change", function(){
            		// check
            		if($(this).val() != ""){
	            		var spAditOptnVal = $(this).val().split("|");
	            		var skipIt = false;
	            		if($(".ordr-dtl-chg-list tbody .optn_ADIT input[name='ordrOptn']").length > 0){
	            			skipIt = true;
	            		}

            			if(skipIt && ($(".ordr-dtl-chg-list tbody .optn_ADIT input[name='ordrOptn']").val().trim() == spAditOptnVal[0].trim())){
	            			alert("["+spAditOptnVal[0] + "]은(는) 이미 추가된 옵션상품입니다.");
	            			return;
	            		} else {
	            			var gdsHtml = '';
							gdsHtml += '';
							gdsHtml += '<tr class="tr_${ordrDtlNo} optn_ADIT">';
							gdsHtml += '	<td class="${ordrDtlCd}">추가옵션';
							gdsHtml += '		<input type="hidden" name="ordrNo" value="${ordrDtlList[0].ordrNo}">';
							gdsHtml += '		<input type="hidden" name="ordrCd" value="${ordrDtlList[0].ordrCd}">';
							gdsHtml += '		<input type="hidden" name="ordrDtlNo" value="0">';
							gdsHtml += '		<input type="hidden" name="ordrDtlCd" value="${ordrDtlList[0].ordrDtlCd}">';
							gdsHtml += '		<input type="hidden" name="gdsNo" value="${ordrDtlList[0].gdsNo}">';
							gdsHtml += '		<input type="hidden" name="gdsCd" value="${ordrDtlList[0].gdsCd}">';
							gdsHtml += '		<input type="hidden" name="bnefCd" value="${ordrDtlList[0].bnefCd}">';
							gdsHtml += '		<input type="hidden" name="gdsNm" value="${ordrDtlList[0].gdsNm}">';
							gdsHtml += '		<input type="hidden" name="gdsPc" value="0">';
							gdsHtml += '		<input type="hidden" name="ordrOptnTy" value="ADIT">';
							gdsHtml += '		<input type="hidden" name="ordrOptn" value="'+spAditOptnVal[0]+'">';
							gdsHtml += '		<input type="hidden" name="ordrOptnPc" value="'+spAditOptnVal[1]+'">';
							gdsHtml += '		<input type="hidden" name="recipterUniqueId" value="${ordrDtlList[0].recipterUniqueId}">';
							gdsHtml += '		<input type="hidden" name="bplcUniqueId" value="${ordrDtlList[0].bplcUniqueId}">';
							gdsHtml += '		<input type="hidden" name="sttsTy" value="${ordrDtlList[0].sttsTy}">';
							gdsHtml += '	</td>';
							gdsHtml += '	<td class="text-left leading-tight"><i class="ico-reply"></i> <span class="badge">추가옵션</span>';
							gdsHtml += '	<p class="ml-3" style="display:inline-flex;">'+ spAditOptnVal[0] +'</p></td>';
							gdsHtml += '	<td>+'+ spAditOptnVal[1] +'</td>';
							gdsHtml += '	<td><input type="number" class="form-control tiny numbercheck" name="ordrQy" value="1" min="1" max="9999"></td>';
							gdsHtml += '	<td><button type="button" class="btn-danger tiny shadow" onclick="f_ordr_dtl_del(this); return false;" data-dtl-cd="${ordrDtlCd}" data-dtl-no="0" data-optn-ty="ADIT">삭제</button></td>';
							gdsHtml += '</tr>';

							$(".ordr-dtl-chg-list tbody").append(gdsHtml);
	            		}
            		}
            	});


            	$(".f_ordrdtl_optn_chg").on("click", function(){
					var formData = $("#frmOrdrChg").serialize();

					$.ajax({
        				type : "post",
        				url  : "/_mng/ordr/optnChgSave.json",
        				data : formData,
        				dataType : 'json'
        			})
        			.done(function(data) {
        				if(data.result){
        					const successHtml = '<div class="alert alert-success fade show"><p class="moji">:)</p><p class="text">옵션 정보가 변경되었습니다.</p><button type="button" data-bs-dismiss="alert" aria-label="close">닫기</button></div>';
        					$(successHtml).insertAfter(".ordr-dtl-chg-list").fadeOut(500, function(){
        						$(this).remove();
        						$(".btn-reload, .modal-inner .btn-close").click();
        					});
        					console.log("success");
        				}else{
        					alert("옵션수정 중 오류가 발생하였습니다.");
        				}

        			})
        			.fail(function(data, status, err) {
        				alert("옵션수정 중 오류가 발생하였습니다.");
        				$(".btn-reload, .modal-inner .btn-close").click();
        				console.log('error forward : ' + data);
        			});

            	});

            });

            </script>