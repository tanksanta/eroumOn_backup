<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

			<jsp:include page="../layout/page_header.jsp">
				<jsp:param value="상품관리" name="pageTitle"/>
			</jsp:include>

			<!-- page content -->
            <div id="page-content">
                <form id="searchFrm" name="searchFrm" method="get" action="./list">
				<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
				<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />
                <fieldset>
                    <legend class="text-title2">상품관리 검색</legend>
                    <table class="table-detail">
                        <colgroup>
                            <col class="w-43">
                            <col>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th scope="row"><label for="search-item4">카테고리</label></th>
                                <td>
                                    <div class="form-group w-84">
                                        <select name="srchUpCtgryNo" id="srchUpCtgryNo" class="form-control w-32">
                                            <option value="0">전체</option>
                                        <c:forEach items="${gdsCtgryList}" var="ctgryList" varStatus="status" end="0">
                                        	<option value="${ctgryList.ctgryNo}" ${param.srchUpCtgryNo eq ctgryList.ctgryNo?'selected="selected"':''}>${ctgryList.ctgryNm}</option>
                                        </c:forEach>
                                        </select>
                                        <select name="srchCtgryNo" id="srchCtgryNo" class="form-control flex-1">
                                            <option value="0">전체</option>
                                        </select>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="srchGdsCd">상품코드</label></th>
                                <td><input type="text" id="srchGdsCd" name="srchGdsCd" value="${param.srchGdsCd}" class="form-control w-84"></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="srchGdsNm">상품명</label></th>
                                <td><input type="text" id="srchGdsNm" name="srchGdsNm" value="${param.srchGdsNm }" class="form-control w-full"></td>
                            </tr>
                        </tbody>
                    </table>
                </fieldset>

                <div class="btn-group mt-5">
                    <button type="submit" class="btn-primary large shadow w-52">검색</button>
                </div>
                </form>

                <div class="flex justify-between mt-13 mb-3">
                    <div class="flex items-center">
                        <button type="button" class="btn-primary shadow f_srchGds" data-bs-toggle="modal" data-bs-target="#gdsModal">상품검색</button>
                        <p class="text-sm ml-2 text-gray1">상품검색을 통해 노출할 상품을 선택할 수 있습니다.</p>
                    </div>
                    <button type="button" class="btn-primary shadow f_delete">선택삭제</button>
                </div>

                <table class="table-list">
                    <colgroup>
                        <col class="w-15">
                        <col class="w-25">
                        <col class="w-35">
                        <col class="w-45">
                        <col class="min-w-50">
                        <col class="w-32">
                        <col class="w-33">
                        <col class="w-33">
                        <col class="w-28">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="check_all" name="check_all">
                                </div>
                            </th>
                            <th scope="col">No</th>
                            <th scope="col">상품구분</th>
                            <th scope="col">상품코드</th>
                            <th scope="col">상품명</th>
                            <th scope="col">판매가</th>
                            <th scope="col">급여가</th>
                            <th scope="col">대여가</th>
                            <th scope="col">판매상태</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
                        <tr>
                            <td>
                                <div class="form-check">
                                    <input class="form-check-input"  type="checkbox" name="arrGdsNo" value="${resultList.gdsNo}">
                                </div>
                            </td>
                            <td>${listVO.startNo - status.index }</td>
                            <td>${gdsTyCode[resultList.gdsTy]}</td>
                            <td>${resultList.gdsCd}</td>
                            <td class="text-left">${resultList.gdsNm}</td>
                            <td><fmt:formatNumber value="${resultList.pc}" pattern="###,###" /></td>
                            <td><fmt:formatNumber value="${resultList.bnefPc}" pattern="###,###" /></td>
                            <td><fmt:formatNumber value="${resultList.lendPc}" pattern="###,###" /></td>
                            <td>
                            	<c:choose>
                            		<c:when test="${resultList.dspyYn eq 'Y' && resultList.stockQy > 0}">판매중</c:when>
                            		<c:when test="${resultList.dspyYn eq 'Y' && resultList.stockQy < 1}">품절</c:when>
	                            	<c:otherwise>
	                            		미판매
	                            	</c:otherwise>
                            	</c:choose>
                            </td>
                        </tr>
                        </c:forEach>
                        <c:if test="${empty listVO.listObject}">
                        <tr>
                            <td class="noresult" colspan="9">등록된 데이터가 없습니다.</td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>

                <div class="pagination mt-7">
                    <front:paging listVO="${listVO}"/>

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
            </div>
            <!-- //page content -->


			<!-- 상품검색 -->
            <div class="modal fade " id="gdsModal" tabindex="-1">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <p>상품검색</p>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
                        </div>
                        <div class="modal-body dataTables_wrapper">
                            <p class="text-title2">상품 검색</p>
                            <table class="table-detail">
                                <colgroup>
                                    <col class="w-34">
                                    <col>
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th scope="row"><label for="search-item1">상품코드</label></th>
                                        <td><input type="text" class="form-control w-61" id="modalSrchGdsCd" name="modalSrchGdsCd"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="search-item2">상품명</label></th>
                                        <td><input type="text" class="form-control w-full" id="modalSrchGdsNm" name="modalSrchGdsNm"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="search-item3">카테고리</label></th>
                                        <td>
                                            <div class="form-group w-full">
                                                <select name="modalSrchUpCtgryNo" id="modalSrchUpCtgryNo" class="form-control w-30">
                                                    <option value="0">대분류선택</option>
                                                    <c:forEach items="${gdsCtgryList}" var="ctgryList" varStatus="status">
                                          	<option value="${ctgryList.ctgryNo}">${ctgryList.ctgryNm}</option>
                                              </c:forEach>
                                                </select>
                                                <select name="modalSrchCtgryNo" id="modalSrchCtgryNo" class="form-control w-30">
                                                    <option value="0">중분류선택</option>
                                                </select>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>

                            <div class="btn-group mt-4">
                                <button type="button" class="btn-primary large shadow w-30" id="modalSrchGdsBtn">검색</button>
                            </div>

                            <p class="text-title2 mt-10">상품 목록</p>
                            <table id="gdsDataTable" class="table-list">
                                <colgroup>
                                    <col class="w-15">
                                    <col class="w-30">
                                    <col>
                                    <col class="w-25">
                                    <col class="w-25">
                                    <col class="w-25">
                                    <col class="w-20">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th scope="col">
                                        	-
                                        </th>
                                        <th scope="col">상품코드</th>
                                        <th scope="col">상품명</th>
                                        <th scope="col">판매가</th>
                                        <th scope="col">급여가</th>
                                        <th scope="col">대여가</th>
                                        <th scope="col">판매상태</th>
                                    </tr>
                                </thead>
                            </table>


							<%-- 선택된 상품 --%>
							<p class="text-title2 mt-10">선택 상품</p>
							<table id="bplcGdsDataTable" class="table-list">
                                <colgroup>
                                    <col class="w-15">
                                    <col class="w-30">
                                    <col>
                                    <col class="w-25">
                                    <col class="w-25">
                                    <col class="w-25">
                                    <col class="w-20">
                                    <col class="w-20">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th scope="col">No</th>
                                        <th scope="col">상품코드</th>
                                        <th scope="col">상품명</th>
                                        <th scope="col">판매가</th>
                                        <th scope="col">급여가</th>
                                        <th scope="col">대여가</th>
                                        <th scope="col">판매상태</th>
                                        <th scope="col">삭제</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<c:forEach items="${bplcGdsList}" var="bplcGds" varStatus="status">
									<tr>
									    <td>${status.index+1}</td>
									    <td>${bplcGds.gdsCd}</td>
									    <td class="text-left">${bplcGds.gdsNm}</td>
									    <td>${bplcGds.pc}</td>
									    <td>${bplcGds.bnefPc}</td>
									    <td>${bplcGds.lendPc}</td>
									    <td>
									    	<c:choose>
			                            		<c:when test="${bplcGds.dspyYn eq 'Y' && bplcGds.stockQy > 0}">판매중</c:when>
			                            		<c:when test="${bplcGds.dspyYn eq 'Y' && bplcGds.stockQy < 1}">품절</c:when>
				                            	<c:otherwise>
				                            		미판매
				                            	</c:otherwise>
			                            	</c:choose>
									    </td>
									    <td>
									        <button class="btn-primary shadow tiny f_del_bplcGds" data-gds-no="${bplcGds.gdsNo}">삭제</button>
									    </td>
									</tr>
                                	</c:forEach>
                                </tbody>
                            </table>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn-primary large shadow w-26 f_modalBplcGdsSave">적용</button>
                            <button type="button" class="btn-secondary large shadow w-26" data-bs-dismiss="modal" aria-label="close">취소</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- //상품검색 -->

            <script>
	            const gdsMap = new Map(); // 전체상품
	            const bplcGdsMap = new Map(); // 선택상품
	            <c:if test="${!empty bplcGdsList}">
	            <c:forEach items="${bplcGdsList}" var="bplcGds" varStatus="status">
	            	bplcGdsMap.set("${bplcGds.gdsNo}", "${bplcGds}");
	            </c:forEach>
	            </c:if>
	            const GdsDataTable = function() {
	            	var gdsSrchList;
	            	var dtCall = function(){
	            		gdsSrchList = $("#gdsDataTable").DataTable({
	            			bServerSide: true,
	            			sAjaxSource: "./gdsSearchList.json",
	            			bFilter: false,
	            			bInfo: false,
	            			bSort : false,
	            			bAutoWidth: false,
	            			bLengthChange: false,
	            			language: dt_lang,
	            			iDisplayLength : 5,
	            			aoColumns: [
	            				{ mDataProp: "gdsNo",
	            					mRender: function(oObj, dp, aDt) {
	            						var str  = '<div class="form-check">';
	            							str += '<input class="form-check-input" type="checkbox" value="'+aDt.gdsNo+'">';
	            							str += '</div>';
	            				 		return str;
	            					}
	            				},
	            				{ mDataProp: "gdsCd"},
	            				{ mDataProp: "gdsNm"},
	            				{ mDataProp: "pc"},
	            				{ mDataProp: "bnefPc"},
	            				{ mDataProp: "lendPc"},
	            				{ mDataProp: "dspyYn",
	            					mRender: function(oObj, dp, aDt) {
	            						var str='미판매';
	            						if(aDt.dspyYn == 'Y' && aDt.stockQy > 0){
	            							str = '판매중';
	            						}else if(aDt.dspyYn == 'Y' && aDt.stockQy < 1){
	            							str = '품절';
	            						}
	            						return str;
	            					}
	            				}
	            			],
	            			fnServerData: function ( sSource, aoData, fnCallback ) {
	            				var paramMap = {};
	            				for ( var i = 0; i < aoData.length; i++) {
	            	          		paramMap[aoData[i].name] = aoData[i].value;
	            				}
	            				var pageSize = paramMap.iDisplayLength;
	            				console.log()
	            				var start = paramMap.iDisplayStart;

	            				var pageNum = (start == 0) ? 1 : (start / pageSize) + 1; // pageNum is 1 based

	            				var restParams = new Array();
	            				restParams.push({name : "sEcho", value : paramMap.sEcho});
	            				restParams.push({name : "curPage", value : pageNum });
	            				restParams.push({name : "cntPerPage", value : pageSize});
	            				restParams.push({name : "srchGdsCd", value :  $("#modalSrchGdsCd").val()});
	            				restParams.push({name : "srchGdsNm", value :  $("#modalSrchGdsNm").val()});
	            				restParams.push({name : "srchUpCtgryNo", value :  $("#modalSrchUpCtgryNo").val()});
	            				restParams.push({name : "srchCtgryNo", value :  $("#modalSrchCtgryNo").val()});

	            				$.ajax({
	            	          		dataType : 'json',
	            	          	    type : "POST",
	            	          	    url : sSource,
	            	          	    data : restParams,
	            	          	    success : function(data) {
	            	          	    	fnCallback(data);
	            					}
	            				});
	            			},
	            			fnDrawCallback: function(){
	            				//console.log("drawCallback");
	            				//console.log("gdsMap: ", gdsMap);

	            				/* NO > 넘버링 */
	            				var oSettings = this.fnSettings();
	            				var startNum = oSettings.fnRecordsDisplay() - oSettings._iDisplayStart;
	            				var endNum = startNum - oSettings._iDisplayLength + 1;
	            				if(endNum < 0){ endNum = 1;}

	            				var api = this.api();
	            		       	rows = api.rows( {page:'current'} ).data();
	            		       	//console.log("rows", rows);
	            		       	for(var i=0; i < rows.length; i++){ // 호출 데이터 gdsMap에 담기
	            		       		gdsMap.set(rows[i].gdsNo, rows[i]);
	            		       	}
	            		       	//console.log("bplcGdsMap: ", bplcGdsMap);
	            		       	// 선택된 상품 체크
	            		       	bplcGdsMap.forEach((value,key)=>{
									console.log(key, value);
									$("#gdsDataTable td :checkbox[value='"+ key +"']").prop("checked", "checked");
								});

	            			}
	            		});
	            	}
	            	return {
	            		init: function(){
	            			dtCall();
	            			// 검색창 이벤트 추가
	            			$("#modalSrchGdsCd, #modalSrchGdsNm").on("keyup", function(e){
	            				if (e.keyCode == 13) {
	            					gdsSrchList.draw();
	            				}
	            			});
	            			$("#modalSrchGdsBtn").on("click", function(e){
	            				e.preventDefault();
	            				gdsSrchList.draw();
	            			});

	            			// 체크박스 클릭 이벤트 추가
	            			$(document).on("click", "#gdsDataTable td :checkbox", function(){
	            				let isChecked = $(this).is(":checked");
								if(isChecked){ // 추가
									//console.log("gdsNo", $(this).val());
									var gdsJson = gdsMap.get(parseInt($(this).val()));
									bplcGdsMap.set($(this).val(), gdsJson);
									addBplcGds(gdsJson);

								} else { // 삭제
									bplcGdsMap.delete($(this).val());
									//console.log(typeof $(this).val());
									$("button[data-gds-no='"+ $(this).val() +"']").parents("tr").remove();
									$("#gdsDataTable td :checkbox[value='"+ $(this).val() +"']").prop("checked", "");

								}

								//넘버링 var trCcount = $("#bplcGdsDataTable tbody tr").length + 1;
								$("#bplcGdsDataTable tbody tr").each(function(index){
									$(this).find('td:eq(0)').html( index + 1 );
								});
	            			});

	            			$(document).on("click", ".f_del_bplcGds", function(){
	            				//console.log("del-gds: ", $(this).data("gdsNo"));
	            				//console.log(typeof $(this).data("gdsNo"))

	            				bplcGdsMap.delete($(this).data("gdsNo").toString());
	            				$(this).parents("tr").remove();
	            				$("#gdsDataTable td :checkbox[value='"+ $(this).data("gdsNo") +"']").prop("checked", "");

	            				$("#bplcGdsDataTable tbody tr").each(function(index){
									$(this).find('td:eq(0)').html( index + 1 );
								});

	            			});

	            			$(".f_modalBplcGdsSave").on("click", function(){

	            				let arrGdsNo = [];
	            				bplcGdsMap.forEach((value,key)=>{ arrGdsNo.push(key) });
	            				console.log(arrGdsNo);
	            				var msg = "선택하신 상품을 적용 하시겠습니까?";
	            				if(arrGdsNo==null||arrGdsNo.length==0) {
	            					msg = "선택하신 상품이 없습니다\n적용 하시겠습니까?";
	            				}

	            				if(confirm(msg)){
	            					$.ajax({
	            						type : "post",
	            						url  : "./bplcGdsSave.json",
	            						data : {arrGdsNo:arrGdsNo},
	            						dataType : 'json'
	            					})
	            					.done(function(data) {
	            						if(data.result===true){
	            							alert("적용 되었습니다.");
	            							location.reload();
	            							//$(".btn-close").click();
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
	            		}
	            	};
	            }();

	            function addBplcGds(gdsJson){
					html = '';
					html += '<tr>';
					html += '    <td>-</td>';
					html += '    <td>'+ gdsJson.gdsCd +'</td>';
					html += '    <td class="text-left">'+ gdsJson.gdsNm +'</td>';
					html += '    <td>'+ gdsJson.pc +'</td>';
					html += '    <td>'+ gdsJson.bnefPc +'</td>';
					html += '    <td>'+ gdsJson.lendPc +'</td>';
					if(gdsJson.dspyYn == 'Y' && gdsJson.stockQy > 0){
						html += '    <td>판매중</td>';
					}else if(gdsJson.dspyYn == 'Y' && gdsJson.stockQy < 1){
						html += '    <td>품절</td>';
					}else{
						html += '    <td>미판매</td>';
					}
					html += '    <td>';
					html += '        <button class="btn-primary shadow tiny f_del_bplcGds" data-gds-no="'+ gdsJson.gdsNo +'">삭제</button>';
					html += '    </td>';
					html += '</tr>';

					$("#bplcGdsDataTable tbody").append(html);
	            }

                $(function(){

                	//상품 카테고리
                	$("#srchUpCtgryNo").on("change", function(){

                		const ctgryNoVal = "${param.srchCtgryNo}";

                		$("#srchCtgryNo").empty();
                		$("#srchCtgryNo").append("<option value='0'>전체</option>");

                		let srchUpCtgryNoVal = $(this).val();
                		if(srchUpCtgryNoVal > 0){ //값이 있을경우만..
                			$.ajax({
                				type : "post",
                				url  : "/members/"+"${_partnersSession.partnersId}"+"/mng/gds/getGdsCtgryListByFilter.json",
                				data : {upCtgryNo:srchUpCtgryNoVal},
                				dataType : 'json'
                			})
                			.done(function(data) {
                				for(key in data){
                					if(ctgryNoVal == key){
										$("#srchCtgryNo").append("<option value='"+ key +"' selected='selected'>"+ data[key] +"</option>");
									}else{
										$("#srchCtgryNo").append("<option value='"+ key +"'>"+ data[key] +"</option>");
									}
                				}
                			})
                			.fail(function(data, status, err) {
                				alert("카테고리 호출중 오류가 발생했습니다.");
                				console.log('error forward : ' + data);
                			});
                		}
                	}).trigger("change");


                	//상품 카테고리
                	$("#modalSrchUpCtgryNo").on("change", function(){
                		$("#modalSrchCtgryNo").empty();
                		$("#modalSrchCtgryNo").append("<option value='0'>선택</option>");

                		let modalSrchUpCtgryNoVal = $(this).val();
                		if(modalSrchUpCtgryNoVal > 0){ //값이 있을경우만..
                			$.ajax({
                				type : "post",
                				url  : "./getGdsCtgryListByFilter.json",
                				data : {upCtgryNo:modalSrchUpCtgryNoVal},
                				dataType : 'json'
                			})
                			.done(function(data) {
                				for(key in data){
                					$("#modalSrchCtgryNo").append("<option value='"+ key +"'>"+ data[key] +"</option>");
                				}
                			})
                			.fail(function(data, status, err) {
                				alert("카테고리 호출중 오류가 발생했습니다.");
                				console.log('error forward : ' + data);
                			});
                		}
                	}).trigger("change");

					// 상품검색 모달
					$(".f_srchGds").on("click", function(){
						if ( !$.fn.dataTable.isDataTable('#gdsDataTable') ) { //데이터 테이블이 있으면x
				 			GdsDataTable.init();
				 		}
					});

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

	            	$("button.f_delete").on("click",function(e){
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
            						data : {arrGdsNo:arrGdsNo},
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

                });
                </script>