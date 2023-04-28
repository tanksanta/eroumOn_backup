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
                                <th scope="row"><label for="srchUpCtgryNo">카테고리</label></th>
                                <td>
                                    <div class="form-group w-84">
                                        <select name="srchUpCtgryNo" id="srchUpCtgryNo" class="form-control w-32">
                                            <option value="0">전체</option>
                                        <c:forEach items="${gdsCtgryList}" var="ctgryList" varStatus="status">
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
                                <th scope="row"><label for="srchGdsNm">상품명</label></th>
                                <td colspan="3"><input type="text" id="srchGdsNm" name="srchGdsNm" value="${param.srchGdsNm }" class="form-control w-full"></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="gdsTag1">상품태그</label></th>
                                <td colspan="3">
                                <input type="hidden" id="srchGdsTag" name="srchGdsTag" value="${param.srchGdsTag}">
                            	<c:forEach items="${gdsTagCode}" var="iem" varStatus="status">
                                    <div class="form-check mr-4">
                                    	<input type="checkbox" class="form-check-input" name="gdsTag" id="gdsTag${status.index}" value="${iem.key}" ${fn:indexOf(param.srchGdsTag, iem.key)>-1?'checked="checked"':''}>
                                        <label class="form-check-label" for="gdsTag${status.index}">${iem.value}</label>
                                    </div>
                                </c:forEach>
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
                            	<a href="./form?${pageParam}" class="btn-outline-success shadow w-full">${resultList.gdsCd}</a>
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
                            <td class="noresult" colspan="10">검색조건을 만족하는 결과가 없습니다.</td>
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
                    <a href="#" onclick="alert('준비중입니다.');return false;" class="btn-secondary large shadow">상품일괄등록</a>
                    <a href="./form" class="btn-primary large shadow">상품등록</a>
                </div>


                <script>
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
                				url  : "/_mng/gds/ctgry/getGdsCtgryListByFilter.json",
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

                });
                </script>