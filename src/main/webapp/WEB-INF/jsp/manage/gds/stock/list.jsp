<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<form action="./list" id="searchFrm" name="searchFrm" method="get">

	<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
	<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />

		<fieldset>
			<legend class="text-title2">상품재고 관리 검색</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="srchGdsTy">판매 여부</label></th>
						<td><select name="srchUseNdspy" id="srchUseNdspy" class="form-control w-84">
									<option value="">전체</option>
									<c:forEach items="${useYnCode}" var="iem" varStatus="status">
										<option value="${iem.key}" ${param.srchUseNdspy eq iem.key?'selected="selected"':''}>${iem.value}</option>
									</c:forEach>
								</select>
						</td>
						<th scope="row"><label for="srchBnefCode">급여 코드</label></th>
						<td><input type="text" id="srchBnefCode" name="srchBnefCode" class="form-control w-84" value="${param.srchBnefCode}"></td>
					</tr>
					<tr>
						<th scope="row"><label for="srchGdsTy">상품 구분</label></th>
						<td><select name="srchGdsTy" id="srchGdsTy" class="form-control w-84">
									<option value="">전체</option>
									<c:forEach items="${gdsTyCode}" var="iem" varStatus="status">
										<option value="${iem.key}" ${param.srchGdsTy eq iem.key?'selected="selected"':''}>${iem.value}</option>
									</c:forEach>
								</select>
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
						<td colspan="3"><input type="text" id="srchGdsNm" name="srchGdsNm" value="${param.srchGdsNm}" class="form-control w-full"></td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<div class="btn-group mt-5">
			<button type="submit" class="btn-primary large shadow w-52">검색</button>
		</div>
	</form>

	<p class="text-right mt-13 mb-3">
		<button type="button" class="btn-primary" id="mdfrStockList">전체수정</button>
		<button type="button" class="btn-primary" id="btn-excel">엑셀 다운로드</button>
	</p>

	<p class="text-title2">상품재고 관리 목록</p>
	<table class="table-list">
		<colgroup>
			<col class="w-15">
			<col class="w-27">
			<col class="w-30">
			<col class="">
			<col class="w-35">
			<col class="w-26">
			<col class="w-26">
			<col class="w-27">
			<col class="w-27">
			<col class="w-19">
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
				<th scope="col">상품명</th>
				<th scope="col">옵션항목</th>
				<th scope="col">판매가</th>
				<th scope="col">급여가</th>
				<th scope="col">재고 수량</th>
				<th scope="col">판매 여부</th>
				<th scope="col">수정</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
			<c:set var="pageParam" value="gdsNo=${resultList.gdsNo}&amp;curPage=${listVO.curPage}&amp;cntPerPage=${param.cntPerPage}&amp;srchUseNdspy=${param.srchUseNdspy}&amp;srchBnefCode=${param.srchBnefCode}&amp;srchGdsTy=${param.srchGdsTy}&amp;srchUpCtgryNo=${param.srchUpCtgryNo}&amp;srchCtgryNo=${param.srchCtgryNo}&amp;srchGdsNm=${param.srchGdsNm}" />
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
				<td><a href="/_mng/gds/gds/form?${pageParam}" class="break-all">${resultList.gdsNm}</a></td>
				<td>
					<!--<c:set var="listOptns" value="${fn:split(fn:replace(resultList.optnNm,' ',''),'*')}" />
					${listOptns[fn:length(listOptns)-1]}-->
					${resultList.optnNm}
				</td>
				<td><fmt:formatNumber value="${resultList.pc}" pattern="###,###" /></td>
				<td><fmt:formatNumber value="${resultList.bnefPc}" pattern="###,###" /></td>
				<td class="qy">
					<c:choose>
						<c:when test="${resultList.optnTy ne null}"><input type="text" class="form-control stkQy numbercheck text-center" name="stockQy" value="${resultList.optnStockQy}"/></c:when>
						<c:otherwise><input type="text" class="form-control stkQy numbercheck text-center" name="stockQy" value="${resultList.stockQy}"/></c:otherwise>
					</c:choose>
				</td>
				<td class="yn">
					<select name="useYn" class="form-control w-full">
						<c:choose>
							<c:when test="${resultList.optnTy eq null}">
								<c:forEach var="dspyYn" items="${useYnCode}">
									<option value="${dspyYn.key}" ${dspyYn.key eq resultList.dspyYn ? 'selected=selected':''}>${dspyYn.value}</option>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<c:forEach var="useYn" items="${useYnCode}">
									<option value="${useYn.key}" ${useYn.key eq resultList.useYn ? 'selected=selected':''}>${useYn.value}</option>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</select>
				</td>
				<td style="padding-right:0; padding-left:0;"><button type="button" class="btn-primary mdfrStock" data-optn-no="${resultList.gdsOptnNo}" data-optn-ty="${resultList.optnTy}" data-gds-no="${resultList.gdsNo}">수정</button></td>
			</tr>
			</c:forEach>
			<c:if test="${empty listVO.listObject}">
				<td class="noresult" colspan="9">검색조건을 만족하는 결과가 없습니다.</td>
			</c:if>
		</tbody>
	</table>

	<div class="pagination mt-7">
		<mngr:mngrPaging listVO="${listVO}" />

		<div class="sorting2">
			<label for="countPerPage">출력</label> <select name="countPerPage" id="countPerPage" class="form-control">
				<option value="10" ${listVO.cntPerPage eq '10' ? 'selected' : '' }>10개</option>
				<option value="20" ${listVO.cntPerPage eq '20' ? 'selected' : '' }>20개</option>
				<option value="30" ${listVO.cntPerPage eq '30' ? 'selected' : '' }>30개</option>
			</select>
		</div>

		<div class="counter">
			총 <strong>${listVO.totalCount}</strong>건, <strong>${listVO.curPage}</strong>/${listVO.totalPage} 페이지
		</div>
	</div>
</div>

<script>
$(function(){

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

  	// 수정 이벤트
  	$(".mdfrStock").on("click",function(){
  		const gdsOptnNo = $(this).data("optnNo");
  		const gdsNo = $(this).data("gdsNo");
  		let optnTy = $(this).data("optnTy");

  		if(optnTy == '' || optnTy == null){
  			optnTy = "none";
  		}

  		const stockQy = $(this).parent().siblings('.qy').children();
  		const yn = $(this).parent().siblings('.yn').children();

  		if(confirm("수정하시겠습니까?")){
			$.ajax({
				type : "post",
				url  : "action.json",
				data : {
					gdsOptnNo : gdsOptnNo
					, optnTy : optnTy
					, stockQy : stockQy.val()
					, yn : yn.val()
					, gdsNo : gdsNo
					},
				dataType : 'json'
			})
			.done(function(data) {
				if(data.result===true){
					alert("수정되었습니다.");
					location.reload();
				}else{
					alert("처리중 오류가 발생하였습니다.");
				}
			})
			.fail(function(data, status, err) {
				alert("처리중 오류가 발생하였습니다.");
				console.log('error forward : ' + data);
			});
  		}else{
  			return false;
  		}

  	});

  	//전체수정 이벤트
  	$("#mdfrStockList").on("click",function(){
  		let arrGdsNo = $(":checkbox[name=arrGdsNo]:checked");

		if(arrGdsNo==null||arrGdsNo.length==0) {
			alert("상품을 먼저 선택해주세요");
			return;
		} else {
			const gdsList = [];
			for (var i = 0; i < arrGdsNo.length; i++) {
				const gdsCheckBox = arrGdsNo[i];
				const gdsTrTag = $(gdsCheckBox).parent().parent().parent();
				const mdfrStockBtn = gdsTrTag.find('.mdfrStock');
				
		  		const gdsOptnNo = $(mdfrStockBtn).data("optnNo");
		  		const gdsNo = $(mdfrStockBtn).data("gdsNo");
		  		let optnTy = $(mdfrStockBtn).data("optnTy");

		  		if(optnTy == '' || optnTy == null){
		  			optnTy = "none";
		  		}

		  		const stockQy = $(mdfrStockBtn).parent().siblings('.qy').children().val();
		  		const yn = $(mdfrStockBtn).parent().siblings('.yn').children().val();
		  		
		  		gdsList.push({
		  			gdsOptnNo
		  			, gdsNo
					, optnTy
					, stockQy
					, yn
		  		});
			}
			
			const jsonData = JSON.stringify(gdsList);
			if(confirm("선택된 상품을 수정하시겠습니까?")){
				$.ajax({
					type : "post",
					url  : "list/action.json",
					data : { gdsListJson : jsonData },
					dataType : 'json'
				})
				.done(function(data) {
					if(data.result===true){
						alert("수정되었습니다.");
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
  	});
  	
  	// 엑셀 다운르도
  	$("#btn-excel").on("click",function(){
  		$("#searchFrm").attr("action","./excel");
  		$("#searchFrm").submit();
  		$("#searchFrm").attr("action","./list");
  	});

});
</script>
