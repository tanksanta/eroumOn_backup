<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

				<!-- 검색영역 -->
				<form id="searchFrm" name="searchFrm" method="get" action="./list">
				<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
				<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />

				<fieldset>
                    <legend class="text-title2">상품관리 검색</legend>
                    <table class="table-detail">
                        <colgroup>
                            <col class="w-43">
                            <col>
                            <col class="w-43">
                            <col>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th scope="row"><label for="srchGdsCd">상품코드</label></th>
                                <td><input type="text" id="srchGdsCd" name="srchGdsCode" value="${param.srchGdsCode}" class="form-control w-84"></td>
                                <th scope="row"><label for="srchBnefCd">급여코드</label></th>
                                <td><input type="text" id="srchBnefCd" name="srchBnefCode" value="${param.srchBnefCode }" class="form-control w-84"></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="srchGdsTy">상품구분</label></th>
                                <td>
                                    <select name="srchGdsTy" id="srchGdsTy" class="form-control w-84">
                                        <option value="">전체</option>
                                   	<c:forEach items="${gdsTyCode}" var="iem" varStatus="status">
                                        <option value="${iem.key}" ${param.srchGdsTy eq iem.key?'selected="selected"':''}>${iem.value}</option>
                                    </c:forEach>
                                    </select>
                                </td>
                                <th scope="row"><label for="srchItemCd">품목코드</label></th>
                                <td><input type="text" id="srchItemCd" name="srchItemCd" value="${param.srchItemCd}" class="form-control w-84"></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="srchDspyYn">전시여부</label></th>
                                <td >
                                	<div class="form-check-group">
                                	<div class="form-check">
                                		<input type="radio" id="srchDspyYn" name="srchDspyYn" value="" class="form-check-input" checked="checked">
	                                	<label class="form-check-label" for="srchDspyYn">전체</label>
	                                </div>
	                                <c:forEach var="dspyYn" items="${dspyYnCode}" varStatus="status">
	                                	<div class="form-check">
	                                		<input type="radio" id="srchDspyYn${status.index}" name="srchDspyYn" value="${dspyYn.key}" class="form-check-input" <c:if test="${dspyYn.key eq param.srchDspyYn}">checked="checked"</c:if>>
	                                		<label class="form-check-label" for="srchDspyYn${status.index}">${dspyYn.value}</label>
	                                	</div>
	                                </c:forEach>
	                                </div>
                                </td>
                                <th scope="row">임시여부</th>
                                <td >
                                	<div class="form-check-group">
                                	<div class="form-check">
                                		<input type="radio" id="srchTempYn" name="srchTempYn" value="" class="form-check-input" checked="checked">
	                                	<label class="form-check-label" for="srchTempYn">전체</label>
	                                </div>
	                                <c:forEach var="tempYn" items="${useYnCode}" varStatus="status">
	                                	<div class="form-check">
	                                		<input type="radio" id="srchTempYn${status.index}" name="srchTempYn" value="${tempYn.key}" class="form-check-input" <c:if test="${tempYn.key eq param.srchTempYn}">checked="checked"</c:if>>
	                                		<label class="form-check-label" for="srchTempYn${status.index}">${tempYn.value}</label>
	                                	</div>
	                                </c:forEach>
	                                </div>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="srchGdsNm">상품명</label></th>
                                <td colspan="3"><input type="text" id="srchGdsNm" name="srchGdsNm" value="${param.srchGdsNm }" class="form-control w-full"></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="gdsTag1">상품태그</label></th>
                                <td>
	                                <input type="hidden" id="srchGdsTag" name="srchGdsTag" value="${param.srchGdsTag}">
	                            	<c:forEach items="${gdsTagCode}" var="iem" varStatus="status">
	                                    <div class="form-check mr-4">
	                                    	<input type="checkbox" class="form-check-input" name="gdsTag" id="gdsTag${status.index}" value="${iem.key}" ${fn:indexOf(param.srchGdsTag, iem.key)>-1?'checked="checked"':''}>
	                                        <label class="form-check-label" for="gdsTag${status.index}">${iem.value}</label>
	                                    </div>
	                                </c:forEach>
                                </td>
                                <th scope="row"><label for="srchUpCtgryNo">카테고리</label></th>
                                <td>
                                	<input type="hidden" id="srchCtgryNo" name="srchCtgryNo" value="${param.srchCtgryNo}" />

                                    <div class="form-group w-full">
                                        <select name="ctgryNo1" id="ctgryNo1" class="form-control w-32">
                                            <option value="0">전체</option>
                                        <c:forEach items="${gdsCtgryList}" var="ctgryList" varStatus="status">
                                        	<option value="${ctgryList.ctgryNo}" ${param.ctgryNo1 eq ctgryList.ctgryNo?'selected="selected"':''}>${ctgryList.ctgryNm}</option>
                                        </c:forEach>

                                        </select>
                                        <select name="ctgryNo2" id="ctgryNo2" class="form-control w-32">
                                            <option value="0">전체</option>
                                        </select>
                                        <select name="ctgryNo3" id="ctgryNo3" class="form-control w-32">
                                            <option value="0">전체</option>
                                        </select>
                                        <select name="ctgryNo4" id="ctgryNo4" class="form-control w-32">
                                            <option value="0">전체</option>
                                        </select>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </fieldset>

                <div class="btn-group mt-5">
                    <button type="submit" class="btn-primary large shadow w-52">검색</button>
                </div>

                <p class="text-right mt-13 mb-3">
                    <button type="button" class="btn-primary btn-excel">엑셀 다운로드</button>
                    <!-- <button type="button" class="btn-primary" onclick="alert('준비중입니다.');return false;">엑셀 다운로드</button> -->
                </p>
				</form>

				<p class="text-title2">상품관리 목록</p>
                <table class="table-list">
                    <colgroup>
                        <col class="w-15">
                        <col class="w-28">
						<col class="w-30">
                        <col class="w-32">
                        <col>
                        <col class="w-26">
						<col class="w-26">
						<col class="w-26">
                        <col class="w-23">
                        <col class="w-23">
                        <col class="w-24">
                        <col class="w-38">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="check_all" name="check_all">
                                </div>
                            </th>
                            <th scope="col">상품구분</th>
                            <th scope="col">이미지</th>
                            <th scope="col">상품코드</th>
                            <th scope="col">상품명</th>
                            <th scope="col">품목코드</th>
                            <th scope="col">판매가</th>
                            <th scope="col">급여가</th>
                            <th scope="col">전시여부</th>
                            <th scope="col">임시여부</th>
                            <th scope="col">상품 태그</th>
                            <th scope="col">등록일</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
						<c:set var="pageParam" value="gdsNo=${resultList.gdsNo}&amp;curPage=${listVO.curPage}${!empty(listVO.urlParam)? '&amp;' : ''}${listVO.urlParam}" />
                        <tr>
                            <td>
                                <div class="form-check">
                                    <input class="form-check-input"  type="checkbox" name="arrGdsNo" value="${resultList.gdsNo}">
                                </div>
                            </td>
                            <td>${gdsTyCode[resultList.gdsTy]}</td>
                            <td>
								<c:choose>
									<c:when test="${!empty resultList.thumbnailFile }">
										<%--기본 썸네일--%>
								<img src="/comm/getImage?srvcId=GDS&amp;upNo=${resultList.thumbnailFile.upNo }&amp;fileTy=${resultList.thumbnailFile.fileTy }&amp;fileNo=${resultList.thumbnailFile.fileNo }&amp;thumbYn=Y" alt="" class="rounded-md">
									</c:when>
									<c:otherwise>
										<%--default > 교체 필요 --%>
								<img src="/html/page/admin/assets/images/noimg.jpg" alt="">
									</c:otherwise>
								</c:choose>
                            </td>
                            <td>
                            	<a href="./form?${pageParam}">${resultList.gdsCd}</a>
                            </td>
                            <td class="text-left"><a href="./form?${pageParam}" >${resultList.gdsNm}</a></td>
                            <td>
                            	<c:choose>
                            		<c:when test="${empty resultList.itemCd}" >-</c:when>
                            		<c:otherwise>${resultList.itemCd}</c:otherwise>
                            	</c:choose>
                            </td>
                            <td><fmt:formatNumber value="${resultList.pc}" pattern="###,###" /></td>
                            <td><fmt:formatNumber value="${resultList.bnefPc}" pattern="###,###" /></td>
                            <td>${dspyYnCode[resultList.dspyYn]}</td>
                            <td>${useYnCode[resultList.tempYn]}</td>
                            <td>
                            	<c:if test="${!empty resultList.gdsTagVal}">
	                            	<c:forEach var="tagList" items="${fn:split(fn:replace(resultList.gdsTagVal,' ',''),',')}">
	                            		${gdsTagCode[tagList]}
	                            	</c:forEach>
                            	</c:if>
                            	<c:if test="${empty resultList.gdsTagVal}">
                            		-
                            	</c:if>
                            </td>
                            <td><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        </tr>
                        </c:forEach>
                        <c:if test="${empty listVO.listObject}">
                        <tr>
                            <td class="noresult" colspan="12">검색조건을 만족하는 결과가 없습니다.</td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>

				<div class="pagination mt-7">
                    <mngr:mngrPaging listVO="${listVO}"/>

    				<div class="sorting2">
                        <label for="countPerPage">출력</label>
                        <select name="countPerPage" id="countPerPage" class="form-control">
                            <option value="10" ${listVO.cntPerPage eq '10' ? 'selected' : '' }>10개</option>
							<option value="20" ${listVO.cntPerPage eq '20' ? 'selected' : '' }>20개</option>
							<option value="30" ${listVO.cntPerPage eq '30' ? 'selected' : '' }>30개</option>
                        </select>
                    </div>

                    <div class="counter">총 <strong>${listVO.totalCount}</strong>건, <strong>${listVO.curPage}</strong>/${listVO.totalPage} 페이지</div>
                </div>

                <!-- button -->
                <div class="btn-group right mt-8">
                    <button type="button" class="btn-primary large shadow float-left f_useYn">선택삭제</button>
                    <button type="button" class="btn-secondary large shadow f_all_read" data-bs-toggle="modal" data-bs-target="#fileModal">상품일괄등록</button>
                    <button type="button" class="btn-success large shadow f_all_sold">일괄품절</button>
                    <a href="./form" class="btn-primary large shadow">상품등록</a>
                </div>

                <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
				<!-- 후에 다운받아서 처리, 확장자 3개 테스트 -->
				<!-- 파일업로드 -->
				<div class="modal fade" id="fileModal" tabindex="-1">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<p>파일업로드</p>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
							</div>
							<div class="modal-body">
								<form action="#">
									<fieldset>
										<legend>업로드할 파일을 등록해주세요</legend>
										<table class="table-detail mt-3">
											<colgroup>
												<col class="w-34">
												<col>
											</colgroup>
											<tbody>
												<tr>
													<th scope="row"><label for="excelAttach">파일선택</label></th>
													<td>
														<input type="file" id="excelAttach" name="excelAttach" class="form-control w-full" onchange="readExcel();" onchange="fileCheck(this);">
														<i class="ico-loader loading-file" style="display:none;"></i>
													</td>
												</tr>
												<tr class="fail_view" style="display:none;">
													<th scope="row">실패건수</th>
													<td class="fail_list"></td>
												</tr>
											</tbody>
										</table>
										<div class="btn-group mt-5">
											<button type="button" class="btn-primary large shadow w-26" id="excelBtn" style="display:none;">등록</button>
											<button type="button" class="btn-success large shadow w-26" id="excelCnfm" style="display:none;">확인</button>
											<a href="/comm/SAMPLE/getFile?fileName=excel_sample.xlsx" class="btn-secondary large shadow">샘플다운로드</a>
										</div>
									</fieldset>
								</form>
							</div>
						</div>
					</div>
				</div>
				<!-- //파일업로드 -->


                <script>

              	//엑셀 파싱
              	const regExp = /[\{\}\[\]\/?;:|*~`!^\_+<>@\#$%&\\\=\'\"]/g;
              	let excelData;

               function readExcel() {
                    let input = event.target;
                    let reader = new FileReader();
                    $("#excelAttach").hide();
                    $(".loading-file").show();

                    reader.onload = function () {
                        let data = reader.result;
                        let workBook = XLSX.read(data, { type: 'binary' });
                        workBook.SheetNames.forEach(function (sheetName) {
                            console.log('SheetName: ' + sheetName);
                            if(sheetName == "상품일괄등록"){
                                let rows = XLSX.utils.sheet_to_json(workBook.Sheets[sheetName]);
                                let jsonRow = JSON.stringify(rows);

                                //console.log(JSON.stringify(rows[0]));

                                let actFlag = false;
                                let errorPlace = "";
                                let errorCnt = 0;
                                for(var i=0; i<rows.length; i++){
                                	$.each(rows[i], function(key, value){
                                    	if(regExp.test(value)){
                                    		console.log((i+2)+"행 특수문자가 포함된 값 : " + value);
                                    		actFlag = true;
                                    		errorCnt += 1;
                                    	}
                                    });
                                	errorPlace += (i+1)+"행 " + errorCnt + " 건 \n";
                                }

                                if(actFlag){
                                	alert("특수문자가 포함된 값이 존재합니다. \n" + errorPlace);
                                	console.log(errorPlace);
                                }else{
                                	$(".loading-file").hide();
                                	$("#excelAttach, #excelBtn").show();
                                	excelData = jsonRow;
                                }
                            }else{
                            	return false;
                            }
                        })
                    };
                    reader.readAsBinaryString(input.files[0]);
                }

               function f_selectedOpt(obj){
            	   let ctNum = obj.attr("id").replaceAll("ctgryNo","");

            	   if(ctNum == 1){
            		   let seNum = Number("${param.ctgryNo2}");
            		   $("#ctgryNo2 option").each(function(){
            			   if(seNum == $(this).val()){
            				   $(this).prop("selected",true).trigger("change");
            			   }
            		   });
            	   }else if(ctNum == 2){
            		   let seNum = Number("${param.ctgryNo3}");
            		   $("#ctgryNo3 option").each(function(){
            			   if(seNum == $(this).val()){
            				   $(this).prop("selected",true).trigger("change");
            			   }
            		   });
            	   }else if(ctNum == 2){
            		   let seNum = Number("${param.ctgryNo4}");
            		   $("#ctgryNo4 option").each(function(){
            			   if(seNum == $(this).val()){
            				   $(this).prop("selected",true);
            			   }
            		   });
            	   }


               }

                $(function(){

                	//상품 카테고리
                	$("#ctgryNo1, #ctgryNo2, #ctgryNo3").on("change", function(){
                		let sectionNo = $(this).attr("id").replaceAll("ctgryNo","");
                		let ctgryVal = $(this).val();

                		$("#ctgryNo"+(Number(sectionNo)+1)).empty();
                		$("#ctgryNo"+(Number(sectionNo)+1)).append("<option value='0'>전체</option>");

                		if(ctgryVal > 0){ //값이 있을경우만..
                			$.ajax({
                				type : "post",
                				url  : "/_mng/gds/ctgry/getGdsCtgryListByFilter.json",
                				data : {upCtgryNo:ctgryVal},
                				dataType : 'json'
                			})
                			.done(function(data) {
                				for(key in data){
                					if(ctgryVal == key){
                						$("#ctgryNo"+(Number(sectionNo)+1)).append("<option value='"+ key +"' selected='selected'>"+ data[key] +"</option>");
									}else{
										$("#ctgryNo"+(Number(sectionNo)+1)).append("<option value='"+ key +"'>"+ data[key] +"</option>");
									}
                				}
                				$("#srchCtgryNo").val($("#ctgryNo"+Number(sectionNo)).val());
                				f_selectedOpt($("#ctgryNo"+Number(sectionNo)));
                			})
                			.fail(function(data, status, err) {
                				alert("카테고리 호출중 오류가 발생했습니다.");
                				console.log('error forward : ' + data);
                			});
                		}
                	}).trigger("change");



                	// 상품태그 checkbox
                	$(":checkbox[name='gdsTag']").on("click", function(){
						var selCheckVal = "";
                		$(":checkbox[name='gdsTag']:checked").each(function(){
                			selCheckVal += (selCheckVal==""?$(this).val():"|"+$(this).val());
                		});
						$("#srchGdsTag").val(selCheckVal);
                	});

                	// 출력 갯수
	                $("#countPerPage").on("change", function(){
						var cntperpage = $("#countPerPage option:selected").val();
						$("#cntPerPage").val(cntperpage);
						$("#searchFrm").submit();
					});


	                const totalCnt = $(":checkbox[name='arrGdsNo']").length;
	            	//전체 선택 체크박스 클릭시
	            	$(":checkbox[name='check_all']").on("click", function(){
	            		let isChecked = $(this).is(":checked");
	            		$(":checkbox[name='arrGdsNo']").prop("checked",isChecked);
	            	});
	            	//리스트 체크박스 클릭시
	            	$(":checkbox[name='arrGdsNo']").on("click", function(){
	            		let checkedCnt = $(":checkbox[name='arrGdsNo']:checked").length;
	            		if( totalCnt==checkedCnt ){
	            			$(":checkbox[name='check_all']").prop("checked",true);
	            		}else{
	            			$(":checkbox[name='check_all']").prop("checked",false);
	            		}
	            	});


	            	$(".btn-excel").on("click", function(){
	            		$("#searchFrm").attr("action","excel").submit();
	            		$("#searchFrm").attr("action","list");
	            	});


	            	$("button.f_useYn").on("click",function(e){
	            		e.preventDefault();
	            		let arrGdsNo = $(":checkbox[name=arrGdsNo]:checked").map(function(){return $(this).val();}).get();

	            		if(arrGdsNo==null||arrGdsNo.length==0) {
	            			alert("상품을 먼저 선택해주세요");
	            			return;
	            		} else {
	            			if(confirm("선택하신 상품을 삭제하시겠습니까?")){
            					$.ajax({
            						type : "post",
            						url  : "listAction.json",
            						data : {arrGdsNo:arrGdsNo, useYn:'N'},
            						dataType : 'json'
            					})
            					.done(function(data) {
            						if(data.result===true){
            							alert("삭제되었습니다.");
            							location.reload();
            						}else{
            							alert("처리중 오류가 발생하였습니다.");
            						}
            					})
            					.fail(function(data, status, err) {
            						alert("처리중 오류가 발생하였습니다.");
            						console.log('error forward : ' + data);
            					});
	            	    	}
	            		}
	            		return;
	            	});

	            	$(".f_all_sold").on("click",function(){
	            		var chkedLen = $("input[name='arrGdsNo']:checked").length;
	            		if(chkedLen < 1){
	            			alert("상품을 선택해주세요.");
	            		}else{
	            			var arrGdsNos = [];

	            			$("input[name='arrGdsNo']:checked").each(function(){
	            				arrGdsNos.push($(this).val());
	            				console.log(arrGdsNos);
	            			});

	            			$.ajax({
        						type : "post",
        						url  : "modifyAllSold.json",
        						data : {arrGdsNo: arrGdsNos},
        						dataType : 'json',
        						traditional : true
        					})
        					.done(function(data) {
        						if(data.resultCnt=== chkedLen){
        							alert("처리 되었습니다.");
        							location.reload();
        						}else{
        							alert("처리중 오류가 발생하였습니다.");
        						}
        					})
        					.fail(function(data, status, err) {
        						alert("처리중 오류가 발생하였습니다.");
        						console.log('error forward : ' + data);
        					});
	            		}
	            	});

	            	$("#excelBtn").on("click",function(){
	            		if(confirm("등록하시겠습니까?")){
	            			  $.ajax({
                    				type : "post",
                    				url  : "/_mng/gds/gds/insertBatchGds.json",
                    				data : {gdsList : excelData},
                    				dataType : 'json'
                    			})
                    			.done(function(data) {
                    				$(".fail_view").show();
                    				var msgMap = data.msgMap;
                    				msgMap = msgMap.replaceAll('{','').replaceAll('}','');
                    				var arrMsg = msgMap.split(',');
                    				var html = "";
                    				for(var i=0; i<arrMsg.length; i++){
                    					html += arrMsg[i].replaceAll('=',' : ') + '<br>';
                    				}

                    				$(".fail_list").append(html);

                    				$("#excelCnfm").show();
                    				$("#excelBtn").hide();
                    			})
                    			.fail(function(data, status, err) {
                    				alert("상품 일괄 처리 중 오류가 발생했습니다.");
                    				console.log('error forward : ' + data);
                    			});
	            		}else{
	            			return false;
	            		}
	            	});

	            	$("#excelCnfm").on("click",function(){
	            		$(".btn-close").click();
	            		location.reload();
	            	});
                });
                </script>